# UberStrike 4.7.1 - `patcher-qa`

[`original`](../../tree/original) + **the test server's patcher.zip**, as code and files in this project.
Same layout and use as `original` (see its README and [SETUP.md](SETUP.md)).

## Commits on top of `original`

| Commit | What |
|---|---|
| patch: test patcher code without skins | C# of the patcher's `Assembly-CSharp*.dll` (UberClient `all_skins` bca2890 + QA updater urls): v4.8.6 protocol, updater, UberBeat, bundle-map loader, BoxLoader. Release address `steam-qa.uberstrike.com`, debug `127.0.0.1`. No IP check, no ManualArmIK (the patcher has neither). `PlayerFiles/devx` keeps the updater from replacing built DLLs |
| patch: patcher data files | 6 map bundles + `SeloTron.ogg` (= patcher files, copied by `build-player.bat`); `sharedassets7.normal/.bluebox` for BoxLoader made from this build by `tools/MakeBluebox.cs` (same edit as the patcher's file: bluebox `InsideGrayAlt 1`, no `Tiling_SandDetail 2`) |
| skins | 66 weapon skins: `WeaponSkinHelper` + effects, 3 hooks (Avatar, WeaponSlot, ProxyItem), 180 embedded art files |

Not here because they are the same as `original`: the patcher's `level3`, `level13`, `uberbeat.dll`, and `UnityEngine.dll`
(only attribute order differs).

## Proof

- Code: `Client.sln` build decompiled = patcher DLLs decompiled, every type; left are compiler-only differences
  (temporaries, local names). 180 embedded files byte-identical. One down-level for Unity 4.6.5: `GameState` uses
  `TryGetValue` where the patcher calls `GetValueOrDefault` (same result).
- Unity build: same classes as the patcher DLLs; map bundles, `SeloTron.ogg`, `uberbeat.dll` byte-identical.
- No-op changes removed: where the v4.8.6 decompile only differs from the Steam decompile in compiler output, the file or
  hunk keeps `original`'s text (checked by building and decompiling both).

Our own additions (204 more skins, heatwave, swim pose, AA, lobby avatar, quick-item icon, scene maps + runtime
bluebox, ManualArmIK) are the branch `patcher-qa-extras`.
