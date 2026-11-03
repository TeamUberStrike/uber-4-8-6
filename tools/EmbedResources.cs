using System;
using System.IO;
using Mono.Cecil;

// Post-build: Unity cannot embed resources when it compiles scripts, the team's v4.8.6 build does
// (WeaponSkinHelper.ReadEmbedded). Adds every file in <dir> to <assembly> as an embedded resource whose
// manifest name is the file name, e.g. "WeaponSkins.2010_HazardousShotgun.jpg".
// Build: tools\build-player.bat compiles this with the .NET Framework csc against Unity 4.6.5's Mono.Cecil.dll.
static class EmbedResources
{
	static int Main(string[] args)
	{
		if (args.Length < 2)
		{
			Console.Error.WriteLine("usage: EmbedResources <Assembly-CSharp.dll> <resource dir> | --list <assembly>");
			return 2;
		}
		if (args[0] == "--list")
		{
			AssemblyDefinition listed = AssemblyDefinition.ReadAssembly(args[1]);
			foreach (Resource r in listed.MainModule.Resources)
			{
				EmbeddedResource e = r as EmbeddedResource;
				Console.WriteLine(r.Name + (e != null ? " " + e.GetResourceData().Length + " bytes" : ""));
			}
			return 0;
		}
		string dll = args[0];
		DefaultAssemblyResolver resolver = new DefaultAssemblyResolver();
		resolver.AddSearchDirectory(Path.GetDirectoryName(Path.GetFullPath(dll)));
		AssemblyDefinition asm = AssemblyDefinition.ReadAssembly(new MemoryStream(File.ReadAllBytes(dll)), new ReaderParameters { AssemblyResolver = resolver });
		foreach (string file in Directory.GetFiles(args[1]))
		{
			string name = Path.GetFileName(file);
			for (int i = asm.MainModule.Resources.Count - 1; i >= 0; i--)
			{
				if (asm.MainModule.Resources[i].Name == name)
				{
					asm.MainModule.Resources.RemoveAt(i);
				}
			}
			asm.MainModule.Resources.Add(new EmbeddedResource(name, ManifestResourceAttributes.Public, File.ReadAllBytes(file)));
			Console.WriteLine("embedded " + name);
		}
		asm.Write(dll);
		return 0;
	}
}
