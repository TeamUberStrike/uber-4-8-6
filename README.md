# UberStrike 4.7.1 - `original`

The Unity 4.6.5 reconstruction of the UberStrike 4.7.1 Steam client, taken through **HaZard's two-step plan** so that
a player built from this project can replace the patcher and join the team's **QA server**:

- C# = the 2016 Steam client (`Assembly-CSharp.dll` sha256 `9aef3003...`, `Assembly-CSharp-firstpass.dll` `f6a393d3...`),
  decompiled with ILSpy (`ilspycmd -lv CSharp4`).
- Assets fixed so a build looks and plays like the Steam client.
- The patch (team client v4.8.6, server address, skins, patcher files) is the branch [`patcher-qa`](../../tree/patcher-qa).

## Layout (same as xavgru12/UberClient v4.8.6)

```
Client.sln                      builds both DLLs into build/Release
Assembly-CSharp/                game code (+ .csproj)
Assembly-CSharp-firstpass/      web service / realtime code (+ .csproj)
UnityDependencies/              UnityEngine.dll etc. (= the Steam client's)
copyToLocalUberStrikeInstallation.cmd, deployToUberUpdates.cmd, deploy-base.cmd
Assets/ ProjectSettings/        Unity project; Assets/Scripts/Assembly-CSharp and
                                Assets/Plugins/Assembly-CSharp-firstpass are junctions to the folders above
tools/                          setup-links.bat, open-project.bat, build-player.bat, ...
```

## Use

1. Unity 4.6.5f1: TeamUberStrike/unity-4-6-5f1-portable (INSTALL.bat). Details: [SETUP.md](SETUP.md).
2. `tools\setup-links.bat` (open-project.bat and build-player.bat run it).
3. DLLs only: build `Client.sln` (Release), then `copyToLocalUberStrikeInstallation.cmd`.
4. Whole game: `tools\build-player.bat`.

The address is the original `ws.uberstrike.com` (offline). To play, use `patcher-qa`.

## Changes on top of the Steam code (all make the rebuilt project match the Steam client)

| Commit | What |
|---|---|
| **Step 1 — code = plain Steam client** | ✅ Done and proven: `Assembly-CSharp`, `Assembly-CSharp-firstpass`, and the image effects now use the original UnityScript DLL (see below). |
| **Step 2 — code = team client v4.8.6 + QA server address** | ✅ Code applied, built and proven against a build of `v4.8.6` (see below). |
| Connecting to the QA server | ✅ **Logs in** (2026-10-24 night): Steam login → QA web service → lobby with the account's QA data. QA's Photon CommServer (UDP 5055) did not answer yet and QA returned 500 for the IP check (the client continues) — waiting on the server owner. |
| Steam login | Stays as it is — the client logs in with a Steam auth ticket, Steam must be running. Moving the ~5,000 registered players to another login is a separate, later migration. |

## Proof

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

## Step 2 — the team client v4.8.6 for the QA server

**Source:** [`xavgru12/UberClient`](https://github.com/xavgru12/UberClient), branch **`v4.8.6`** — the C# source the
patcher's DLLs are built from (team client v4.8.3 → v4.8.6 on top of the 2016 code: anti-cheat, IP-reputation
check, updater, custom bundle maps, knockback/low-gravity flags, `SeloTron.ogg` home music, …). HaZard: *"v4.8.6 is
the version, I'm just changing URLs there. Take the branch 4.8.6 and put your URL in."* The `dev_server`, `qa_server`
and `live_steam_version` branches differ from it only in `ApplicationDataManager` (server address, version) and
`WindowsUpdater`.

**What was done** (source commit `889d3fc`, "add specific info for IP reputation error")

1. Built `v4.8.6` the way the team does (`Client.sln`, MSBuild, C# 8, .NET 3.5 — compiled against Unity 4.6.5's own
   Mono 2.0 libraries), decompiled it with `-lv CSharp4` and applied it file by file: 379 files changed, 32 added
   (`UberKill`, `UberBeat`, `CustomBundleMapManager`, `WindowsUpdater`, `AvatarConfigAsync`, `UserInputt`, the skin
   system, weekend-challenge popup, IP-reputation and daily-bonus types), 3 removed (`UserInput`, `DailyPointsView` +
   proxy). Three decompiler artefacts written back in their source form (`TryGetValue`, an `(int)` cast, a generic
   `val.Draw(...)` call that ILSpy showed as a C# 7 `ref` local).
2. **Server address** (the only intended code change): `ApplicationDataManager` → `steam-qa.uberstrike.com/2.0/` and
   `/images/` — the QA server (HaZard: "use qa"; the dev server returned Cloudflare 522). `Version` stays `"4.8.11"` as in `v4.8.6`;
   which matches the `qa_server` branch (`"4.8.11"`).
3. **Updater:** `WindowsUpdater` downloads and overwrites every file whose MD5 differs from the patcher's list, then
   restarts — it would replace our build with the patcher's DLLs. HaZard's own developer switch is used: an empty
   `devx` file next to `UberStrike.exe` makes it skip (`NoUpdate()`). It ships in [`PlayerFiles/`](PlayerFiles).
4. **Embedded skin art:** `WeaponSkinHelper` reads the Hazardous Shotgun skin from resources inside
   `Assembly-CSharp.dll`; Unity cannot embed resources when it compiles scripts. The 3 files (byte-identical to the
   team source) are in [`EmbeddedResources/Assembly-CSharp/`](EmbeddedResources/Assembly-CSharp) and
   [`tools/EmbedResources.cs`](tools/EmbedResources.cs) adds them after the build (Mono.Cecil from the Unity install,
   compiled on first use by `tools\build-player.bat`). Embedding changes no code (IL checked before/after).
5. **Assets and natives:** `PlayerFiles/UberStrike_Data/SeloTron.ogg` (home music loaded by `UberKill`),
   `Assets/Plugins/uberbeat.dll` (anti-cheat, same file as the patcher's) and `uberheartbeat.dll` (Cmune original,
   used for the server's heartbeat challenge) are in place.

**Proof** — our build vs the DLLs built from `v4.8.6` (Roslyn vs Mono compiler, so compiler-generated helpers are
folded into their owning class before comparing):

| Check | Result |
|---|---|
| String literals per class (310 + 89 classes) | identical except the server address; Roslyn's `""` vs Mono's `string.Empty` (4 classes); single-letter chat commands (`m`, `g`, `u`, `k`) that Roslyn compares as characters |
| Float constants per class | identical |
| Real fields and method signatures (12,716 / 7,541) | identical except access modifiers on compiler-generated generic closure classes and an `[opt]` flag on a delegate |
| Embedded resources | same 3 names and sizes as the team build |

6. **`sharedassets7` safety:** `UberKill.BoxLoader` (called for CuberStrike when a room or menu training starts) deletes
   `UberStrike_Data/sharedassets7.assets` and copies `sharedassets7.normal`/`.bluebox` over it - the patcher ships those
   files, a plain build did not, so the first CuberStrike match left the game without that file. `toolsuild-player.bat`
   now writes both as copies of the build's own file (CuberStrike's shared assets). Tested in game: BoxLoader ran, the
   file hash was identical before and after, CuberStrike loaded. A real BlueBox variant needs its own build of those assets.
7. **Bug fix (not in v4.8.6 / the Steam client):** the first quick-item icon (e.g. a spring grenade in slot 1) was
   invisible until first use - `HUDDesktopQuickItems.Start` replayed the cooldown event's default (slot 0, progress 0)
   after setting the real state. The two registrations are swapped; tested in game.

**Still open:** the map bundles and `sharedassets7` normal/bluebox files the patcher also ships (HaZard: some
"need to be reverse engineered"); `CustomBundleMapManager` loads its bundles from disk.

## Rules for this branch

* No connection to any live or production UberStrike server without the owner's explicit go-ahead.
* Step 1 builds point at the original `ws.uberstrike.com` address and are not launched.
* Steam login stays.

## Credits and disclaimer

UberStrike and all of its art, audio, levels and original code are © Cmune. Team client code by xavgru12, HaZard and
the TeamUberStrike community. Private preservation and restoration project; no licence to Cmune's content is granted.
