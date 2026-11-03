# UberStrike 4.7.1 - `original`

Unity 4.6.5f1 project of the UberStrike 4.7.1 Steam client **without the patch**.

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
| layout (2) | UberClient folder layout, Client.sln, junctions |
| fix(volley) x3 | DangerZone tower materials/frames like retail (Unity 6 fix f4ed6479) |
| fix(spaceportalpha) x3 | Jump/accelerator pads match the map bundle |
| fix(textures) x3 | Texture import settings: 2278/2278 baked textures = Steam (mips, NPOT size, format, aniso, alpha, sprite mode) |
| port(spacecity) | Space City scene 1:1 with the retail bundle |
| fix: shop aim pose | `ManualArmIK`: native hand IK is a no-op in this project |
| fix(avatar): swim | Weapons layer upper-body AvatarMask like the Steam client |
| fix: UberZone + tracer | UberZone preview spawn; MG/shotgun tracer texture without mips |

## Proof

- IL of the built DLLs vs the 2016 DLLs (`stage_proof_il.py`): identical apart from `ManualArmIK`,
  `AvatarAnimationController.LateUpdate` (its hook) and compiler-generated helper names.
- Baked textures vs the Steam client (UnityPy): 2278/2278 paired textures match (size, mips, format, filter, wrap,
  aniso); pixels mean diff 0.035/255.
