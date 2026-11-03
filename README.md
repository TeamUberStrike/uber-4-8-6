# UberStrike 4.7.1 - `patcher-qa-extras`

[`patcher-qa`](../../tree/patcher-qa) (= the test patcher.zip) + **our additions**. A build of this branch is the QA
client tested on 2026-11-03 (constripacity/UberSteam-client-4-7-1 `patcher` 4fe21870 = uber-4-8-6 `unity465` ad73fc6e,
same game, UberClient layout).

## Commits on top of `patcher-qa`

| Commit | What |
|---|---|
| v4.8.6 | UberClient v4.8.6 889d3fc parts newer than the patcher: IP check (#18), updater on GitHub, steam-qa for both address branches |
| avatar | ManualArmIK (shop pose = Steam), Explore/Training swim keeps the weapon pose |
| skins | 270 weapon skins 2010-2280 from `Assets/Resources/weaponskins`, shop skin rows, AA option, lobby avatar after a match (server: xavgru12/UberServer PR #85) |
| maps | bundle maps from the built-in scenes; runtime Normal/Bluebox (MapTextureVariant) on CuberStrike and Spaceport Alpha |
| fix: quick-item icon | first quick-item icon visible before first use (bug also in the Steam client) |
| fix: heatwave | round explosion ripple instead of 4 boxes |

Same layout and use as `original` (see its README and [SETUP.md](SETUP.md)).
