# UberStrike 4.7.1 — `patcher` branch

The Unity 4.6.5 reconstruction of the UberStrike 4.7.1 Steam client, taken through **HaZard's two-step plan** so that
a player built from this project can replace the patcher and join the team's **dev server**:

> **Step 1** — Steam client and Unity project identical.
> **Step 2** — apply the patcher's changes as code changes.
> *"First step must work first. If you can prove the first step, then go with the second step."*

Setup (Unity 4.6.5, server, build scripts): see [SETUP.md](SETUP.md) — the same guide as on
[`uber471-unity465`](../../tree/uber471-unity465), whose README describes the visual reconstruction (maps, shaders,
UI) this branch builds on.

## Status

| | State |
|---|---|
| **Step 1 — code = plain Steam client** | ✅ Done and proven: `Assembly-CSharp`, `Assembly-CSharp-firstpass`, and the image effects now use the original UnityScript DLL (see below). |
| **Step 2 — code = team client v4.8.6 + dev server address** | ⏳ Next. |
| Connecting to the dev server | Not tried yet. Needs the server version the dev server expects (see step 2). |
| Steam login | Stays as it is — the client logs in with a Steam auth ticket, Steam must be running. Moving the ~5,000 registered players to another login is a separate, later migration. |

## Step 1 — identical to the plain Steam client

**Reference:** the 2016 Steam client as installed from Steam, before any patcher:
`Assembly-CSharp.dll` (sha256 `9aef3003…`) and `Assembly-CSharp-firstpass.dll` (`f6a393d3…`).

**Method**

1. Decompile both DLLs with ILSpy (`ilspycmd -lv CSharp4`, C# 4 so Unity 4.6.5's compiler can build it).
2. Apply them to the project file by file, keeping every script's `.meta` GUID (scenes and prefabs stay linked):
   306 files replaced, 1,168 were already identical.
3. Remove what the original does not have: weapon skins, holo/Uberverse effects, `UberKill`, `ManualArmIK`,
   `MapTextureVariant`, a test harness, daily-bonus/box-type types and `PlayerFiles/SeloTron.ogg`. All of it is kept
   on [`save/rc6-parity-2026-10-24`](../../tree/save/rc6-parity-2026-10-24).
4. Fix the few places where ILSpy wrote C# that means the same IL but does not compile under .NET 3.5
   (`Dictionary.GetValueOrDefault` → `TryGetValue`, a missing `(int)` cast) and restore two empty static
   constructors ILSpy dropped.

**Proof** — build the player, decompile its DLLs and compare with the 2016 DLLs:

| Check (built player vs 2016 Steam DLL) | Result |
|---|---|
| String literals, per type | identical (all 322 types in `Assembly-CSharp`) |
| Float constants, per type | identical, except fields our compiler initialises with an explicit `0` |
| Types, fields (type, name, attributes) and method signatures | identical outside compiler-generated closure/iterator helpers, and except the image-effect references below |
| Decompiled source files | `Assembly-CSharp` 496/726 and firstpass 713/748 text-identical; the rest differ only in how the two compilers lay out the same code (flipped `?:`, `foreach` temporaries, written-out default arguments, attribute order, object initialisers) |

Byte-identical DLLs are not possible: Cmune compiled with Microsoft's C# compiler, Unity 4.6.5 compiles with Mono's.

### Image effects — the original DLL itself

The original ships its camera image effects (Bloom, SunShafts, ColorCorrectionCurves, GlobalFog, Vignetting, … 37
classes) in a separate **UnityScript** assembly. Our 37 C# rebuilds are gone; the project now uses the **original
`Assembly-UnityScript-firstpass.dll` itself** (byte-identical, sha256 `8a5ae8b6`) as a precompiled plugin:

* The file is named `Assets/Plugins/UnityScriptFirstpass.dll`: under its original file name Unity 4.6.5 mistakes it for
  its own UnityScript compile target and stops compiling. The assembly inside keeps its original identity.
* The 28 scene references (15 scenes) were re-pointed from the old script GUIDs to the DLL classes
  (`fileID` = Unity's MD4 hash of namespace + class name; the algorithm was checked against Unity 4.6's known
  `UnityEngine.UI` IDs). All 37 classes have the same serialized fields as our rebuilds had.
* **Proof:** in the built player, all 28 image-effect components on every map have the same class, enabled state and
  settings bytes as the 2016 original, and all 109 shader/texture references resolve to the same objects
  (e.g. Bloom → `Hidden/LensFlareCreate`, `Hidden/BlendForBloom`, `VignetteMask`). `Assembly-CSharp-firstpass` now
  has exactly the original's classes and fields (881 / 3,755).

## Step 2 — the team client v4.8.6 for the dev server

**Source:** [`xavgru12/UberClient`](https://github.com/xavgru12/UberClient), branch **`v4.8.6`** — the C# source the
patcher's DLLs are built from (team client v4.8.3 → v4.8.6 on top of the 2016 code: anti-cheat, IP-reputation
check, updater, custom bundle maps, knockback/low-gravity flags, `SeloTron.ogg` home music, …). HaZard: *"v4.8.6 is
the version, I'm just changing URLs there. Take the branch 4.8.6 and put your URL in."* The `dev_server`, `qa_server`
and `live_steam_version` branches differ from it only in `ApplicationDataManager` (server address, version) and
`WindowsUpdater`.

**Plan**

1. Build `v4.8.6` as the team does (C# 8, .NET 3.5), decompile with `-lv CSharp4`, and apply it to this project the
   same way as step 1.
2. Set the server address to the **dev server** (no composite-hash check there, per HaZard) and the version string
   the dev server expects — to be confirmed with HaZard (`dev_server` uses `4.8.6`, `v4.8.6` now says `4.8.11`).
3. Proof: the same comparison as step 1, against a build of `v4.8.6`.
4. Parts that are not code (map bundles, native plugins such as `uberbeat.dll`): reverse-engineer and port
   separately, as HaZard described.

## Rules for this branch

* No connection to any live or production UberStrike server without the owner's explicit go-ahead.
* Step 1 builds point at the original `ws.uberstrike.com` address and are not launched.
* Steam login stays.

## Credits and disclaimer

UberStrike and all of its art, audio, levels and original code are © Cmune. Team client code by xavgru12, HaZard and
the TeamUberStrike community. Private preservation and restoration project; no licence to Cmune's content is granted.
