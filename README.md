# UberStrike 4.7.1 — Unity 4.6.5 reconstruction

A rebuild of Cmune's **UberStrike 4.7.1 Steam client** (2014) in its original engine, **Unity 4.6.5f1**, made from
the Steam client's own files. The goal is a project that builds a player **identical to the Steam client** — same
maps, shaders, UI and code — that we can maintain and extend.

**Status:** release candidate **RC6** (`rc/4.7.1-rc6-2026-10-24`). Side-by-side playtests against the Steam client
found no visible differences on any map, in the lobby, shop or HUD, except the deliberate ones listed below.

---

## Branches in this repository

| Branch | What it is |
|---|---|
| **`uber471-unity465`** (this one) | The Unity 4.6.5 reconstruction, release line. Fast-forwarded from `dev/tour`. |
| `dev/tour` | Day-to-day work on the same project; local verification tooling lives beside it (not committed). |
| [`patcher`](../../tree/patcher) | Code made identical to the plain Steam client, then to the team's v4.8.6 client for the **dev server** (HaZard's two-step plan). |
| `save/rc6-parity-2026-10-24` | Frozen copy of RC6 before the `patcher` work started. |
| `main` | The earlier **Unity 6** port (ForgeRipper import). Separate history; continued in `TeamUberStrike/uber-4-8-6`. |
| `finalize/*`, `holos/*` | Older finalize and holo-avatar work, kept for reference. |

## Requirements

> **Setting up a new PC?** [SETUP.md](SETUP.md) walks through everything step by step — installing and activating
> Unity 4.6.5, the local server, building, playing and the optional ForgeRipper MCP — with double-click scripts in
> [`tools/`](tools) (`setup-unity-4.6.5.bat`, `open-project.bat`, `build-player.bat`, `start-proxy.bat`,
> `launch-client.bat`, `setup-mcp.bat`). The summary below is for people who know the stack.

* **Windows** and **Unity 4.6.5f1**. The editor needs a licence; open the project with the GUI editor.
* **Steam** running, logged into an account that owns UberStrike (`steam_appid.txt` = 291210 is in the repo root).
* A **local UberStrike server stack** — the community UberStrok v4.8.6 server (`xavgru12/UberServer`):
  web services on `127.0.0.1:5000`, Photon realtime **CommServer `:5055`** and **GameServer `:5056`**, MongoDB.
  Without the CommServer the client logs in but loadout changes go out of sync.
* **Node.js** for `svc_proxy.js`.

## Open, build and run

1. Open the project folder in Unity 4.6.5f1 and let it import (first import takes a while).
2. Build with `tools\build-player.bat` (steps 3 and 4 are then done for you), or by hand: **File > Build Settings**,
   `Assets/Scenes/GlobalScene.unity` must stay scene **0**, then `Menu`, `DesktopHUD` and the maps; target
   **PC, Windows, x86**; Build.
3. Next to the built `UberStrike.exe`, copy `steam_api.dll` and `steam_appid.txt` from the repo root, and
   `uberdaemon.exe` from your Steam UberStrike folder.
4. Copy everything under `PlayerFiles/` into the build, keeping the folder layout
   (`PlayerFiles/UberStrike_Data/SeloTron.ogg` -> `<build>/UberStrike_Data/SeloTron.ogg`, the home-screen music).
5. Start the server stack, then the proxy: `node svc_proxy.js` (listens on `127.0.0.1:8888`, forwards to `:5000` and
   rewrites the original Cmune service paths). The client's `ApplicationDataManager` points at
   `http://127.0.0.1:8888/2.0/`, version `4.8.6`.
6. Launch `UberStrike.exe` with Steam running (`tools\launch-client.bat`). Launch it from Explorer, PowerShell or cmd — **not from Git Bash**:
   its MSYS environment leaks into Steam's helper and the login hangs.

The client shares its settings (Windows registry, `Cmune` key) with the Steam install.

## How "identical" was checked

* **Screenshots:** a scripted tour flies both clients to the same spots on every map, the lobby, shop and HUD,
  with the same settings (post-processing pinned), and compares the captures pixel by pixel.
* **Shaders:** every project shader was compared with the Steam client's own ShaderLab text. 22 hand
  reconstructions were replaced by the original compiled text (Temple of the Raven went from 32 to 3 brightness
  levels off). Three water shaders stay reconstructed on purpose; they were verified separately.
* **Code:** the built `Assembly-CSharp.dll` was decompiled and compared with the 2016 Steam DLL, the team client and
  HaZard's production patcher DLL. The code is not byte-identical (the team builds use a newer compiler), but it
  matches in behaviour apart from the list below.
* **Maps:** materials, lightmap offsets and scene objects were compared with the original level files (for example
  Space Port Alpha's floor and Sky Garden's pickups).

## Deliberate differences from the Steam client

* **Kept from the team / production client:** end-of-round input lock, empty-gun click on full-auto weapons, muzzle
  effect resets, chat backtick filter, faster Comm reconnect, FOV Mode tick box, knockback room flag, shop tooltip
  values with green stat bars, armor bar 0 guard, Steam icon for old portal accounts, `SeloTron.ogg` home music.
* **Kept because ours is better:** the post-processing setting is applied at launch (the lobby used to show
  effects with the option off); Temple of the Raven's torch flames animate; Sky Garden stays the original level
  (the patcher's rebuilt bundle has no pickups and different lighting).
* **Not included (need the team's server or native parts):** UberBeat anti-cheat, the updater, the IP-reputation
  login check, the team's own login screen, daily-bonus and weekend-challenge popups, custom bundle maps.
  These belong to the [`patcher`](../../tree/patcher) work.

## Release candidates

| Tag | Adds |
|---|---|
| `rc/4.7.1-rc1-2026-10-24` | Premultiplied UI atlases (text and XP bar brightness), original crosshair path, scope parity |
| `rc/4.7.1-rc2-2026-10-24` | FOV Mode tick box, Space Port Alpha floor, Monkey Island terrain, 22 original shader texts |
| `rc/4.7.1-rc3-2026-10-24` | Underwater colour ramp back where the original keeps it (no blue bloom) |
| `rc/4.7.1-rc4-2026-10-24` | Post-processing setting applied to the lobby at launch |
| `rc/4.7.1-rc5-2026-10-24` | Shop tooltip values and green bars, armor bar guard, portal icon |
| `rc/4.7.1-rc6-2026-10-24` | `SeloTron.ogg` home music |

## Still open

* A two-client multiplayer test on this build.
* Default knockback values (waiting on the server owner).
* The team-only features above, through the `patcher` branch.

## Credits and disclaimer

UberStrike and all of its art, audio, levels and original code are © Cmune. This repository is a private
preservation and restoration project for the community server; it does not grant any licence to Cmune's content.
Built with help from the TeamUberStrike community (HaZard, xavgru12 and others).
