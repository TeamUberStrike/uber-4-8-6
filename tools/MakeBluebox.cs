// sharedassets7.bluebox from this build's sharedassets7.assets, same edit as the test patcher:
// "InsideGrayAlt 1" gets the bluebox image, "Tiling_SandDetail 2" is removed.
// usage: MakeBluebox.exe <sharedassets7.assets> <bluebox image> <out>
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

static class MakeBluebox
{
	class Entry { public int Pos; public int PathId; public uint Start; public uint Size; public ushort ClassId; public string Name; }

	static byte[] f;

	static uint BE(int o) { return (uint)(f[o] << 24 | f[o + 1] << 16 | f[o + 2] << 8 | f[o + 3]); }
	static int LE(int o) { return BitConverter.ToInt32(f, o); }
	static void PutBE(byte[] b, int o, uint v) { b[o] = (byte)(v >> 24); b[o + 1] = (byte)(v >> 16); b[o + 2] = (byte)(v >> 8); b[o + 3] = (byte)v; }

	static int SkipString(int p) { while (f[p] != 0) p++; return p + 1; }

	static int SkipNode(int p)
	{
		p = SkipString(p);
		p = SkipString(p);
		p += 4 * 5;
		int children = LE(p);
		p += 4;
		for (int i = 0; i < children; i++) p = SkipNode(p);
		return p;
	}

	static int Fail(string m) { Console.WriteLine("MakeBluebox: " + m); return 1; }

	static int Main(string[] args)
	{
		if (args.Length != 3) return Fail("usage: MakeBluebox <sharedassets7.assets> <bluebox image> <out>");
		f = File.ReadAllBytes(args[0]);
		byte[] img = File.ReadAllBytes(args[1]);
		uint metaSize = BE(0), fileSize = BE(4), version = BE(8), dataOffset = BE(12);
		if (version != 9 || f[16] != 0 || fileSize != f.Length) return Fail("not a Unity 4 little-endian serialized file");

		int p = SkipString(20) + 4;
		int types = LE(p);
		p += 4;
		for (int i = 0; i < types; i++) p = SkipNode(p + 4);
		if (LE(p) != 0) return Fail("big path ids not supported");
		p += 4;
		int count = LE(p);
		int tableStart = p + 4;
		var list = new List<Entry>();
		for (int i = 0; i < count; i++)
		{
			int q = tableStart + i * 20;
			var e = new Entry { Pos = q, PathId = LE(q), Start = (uint)LE(q + 4), Size = (uint)LE(q + 8), ClassId = BitConverter.ToUInt16(f, q + 16) };
			if (e.ClassId == 28)
			{
				int o = (int)(dataOffset + e.Start);
				e.Name = Encoding.UTF8.GetString(f, o + 4, LE(o));
			}
			list.Add(e);
		}
		int tableEnd = tableStart + count * 20;

		Entry tex = list.Find(e => e.Name == "InsideGrayAlt 1");
		Entry detail = list.Find(e => e.Name == "Tiling_SandDetail 2");
		if (tex == null || detail == null) return Fail("textures not found");
		int texEnd = (int)(dataOffset + tex.Start + tex.Size);
		if (LE(texEnd - img.Length - 4) != img.Length) return Fail("bluebox image size does not match InsideGrayAlt 1");
		uint span = (detail.Size + 7) & ~7u;
		Entry next = null;
		foreach (var e in list) if (e.Start > detail.Start && (next == null || e.Start < next.Start)) next = e;
		if (next != null && next.Start != detail.Start + span) return Fail("unexpected data layout after Tiling_SandDetail 2");

		Buffer.BlockCopy(img, 0, f, texEnd - img.Length, img.Length);

		var meta = new MemoryStream();
		meta.Write(f, 20, tableStart - 4 - 20);
		meta.Write(BitConverter.GetBytes(count - 1), 0, 4);
		foreach (var e in list)
		{
			if (e == detail) continue;
			byte[] row = new byte[20];
			Buffer.BlockCopy(f, e.Pos, row, 0, 20);
			if (e.Start > detail.Start) Buffer.BlockCopy(BitConverter.GetBytes(e.Start - span), 0, row, 4, 4);
			meta.Write(row, 0, 20);
		}
		meta.Write(f, tableEnd, (int)(20 + metaSize) - tableEnd);
		if (20 + meta.Length > dataOffset) return Fail("metadata does not fit");

		int cut = (int)(dataOffset + detail.Start);
		var outp = new byte[f.Length - span];
		Buffer.BlockCopy(f, 0, outp, 0, 20);
		meta.ToArray().CopyTo(outp, 20);
		Buffer.BlockCopy(f, (int)dataOffset, outp, (int)dataOffset, cut - (int)dataOffset);
		Buffer.BlockCopy(f, cut + (int)span, outp, cut, f.Length - cut - (int)span);
		PutBE(outp, 0, (uint)meta.Length);
		PutBE(outp, 4, (uint)outp.Length);
		File.WriteAllBytes(args[2], outp);
		Console.WriteLine("bluebox written: " + args[2]);
		return 0;
	}
}
