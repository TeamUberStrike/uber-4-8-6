# UberStrike 4.7.1 - `patcher-qa`

[`original`](../../tree/original) + **everything in the test server's patcher.zip**, as code and assets in this project.
A build of this branch is the QA client (Steam login -> `steam-qa.uberstrike.com`).

Same layout and use as `original` (see its README and [SETUP.md](SETUP.md)): code at the root like xavgru12/UberClient
v4.8.6, `Client.sln` builds the DLLs into `build/Release`, `tools\build-player.bat` builds the whole game.

## What the patch adds (commits on top of `original`)

| Commit | What |
|---|---|
| patch: team client v4.8.6 | All C# from xavgru12/UberClient v4.8.6 (889d3fc), address `steam-qa.uberstrike.com`, version 4.8.11; `PlayerFiles/devx` stops WindowsUpdater from replacing the DLLs; Hazardous Shotgun skin embedded like UberClient |
| docs | QA login verified |
| fix: quick-item icon; sharedassets7 | First quick-item icon visible (bug also in the Steam client); `build-player.bat` writes sharedassets7.normal/.bluebox for BoxLoader |
| skins | 66 + 204 weapon skins (2010-2280) with shop skin rows; AA option applied; lobby avatar after a match |
| patch: bundle maps + bluebox | Spaceport Alpha / Space City / UberZone / Sky Garden from the built-in scenes; Normal/Bluebox texture switch |
| feat(avatar) | Explore/Training swim keeps the weapon pose like matches |
| patch: Bluebox option | Bluebox toggle on CuberStrike and Spaceport Alpha only |
| fix: explosion heatwave | Round ripple instead of 4 boxes (improvement over the Steam client) |

The server side of the skins is xavgru12/UberServer PR #85 (shop rows 2077-2280).

## Proof

- Same game as the QA-approved build (constripacity/UberSteam-client-4-7-1 `patcher` 4fe21870 = uber-4-8-6 `unity465`
  ad73fc6e). Assets identical apart from the folder layout.
- No-op changes removed from the diff: 205 C# files where the v4.8.6 decompile only differs from the Steam decompile in
  compiler output (same code) use `original`'s text. Proof: both branches built with the same compiler (MSBuild) and
  decompiled; per file, every difference is a no-op form (temporaries, array copies before foreach, string.Concat vs +,
  ToString(), (bool) casts, x += y, empty static constructors). Re-check after the change: 1,506 types, 0 real differences.
- Build: IL facts vs that QA build equal except the reverted no-op forms (empty static constructor of SteamAPI,
  `dir + '\0'` vs `dir + "\0"` in gameserveritem_t).

## Production

`patcher-prod` comes later. The production patcher.zip has the same 13 asset files as the test one; only
`Assembly-CSharp.dll` / `Assembly-CSharp-firstpass.dll` differ (production address, 1 embedded skin instead of 66).
