# Setup guide — UberStrike 4.7.1, Unity 4.6.5

Everything needed to go from a clean Windows PC to building and playing this project. The scripts in
[`tools/`](tools) do the repetitive parts; every script can be double-clicked and works on any machine (paths come
from [`tools/config.bat`](tools/config.bat), not from this PC).

| Step | What | Script |
|---|---|---|
| 1 | Install the prerequisites | — |
| 2 | Install and activate Unity 4.6.5f1 | `tools\setup-unity-4.6.5.bat` |
| 3 | Open the project | `tools\open-project.bat` |
| 4 | Run a local server | (server repo) + `tools\start-proxy.bat` |
| 5 | Build the game | `tools\build-player.bat` |
| 6 | Play | `tools\launch-client.bat` |
| 7 | Optional: ForgeRipper MCP for Claude Code | `tools\setup-mcp.bat` |

---

## 1. Prerequisites

* **Windows 10 or 11** (the Unity 4 editor is 32-bit Windows only), about 15 GB free for the editor, project and
  `Library` cache.
* **Steam**, logged into an account that **owns UberStrike** (free on Steam, app id 291210). The built client
  logs in through Steam and uses `uberdaemon.exe` from the Steam install.
* **Git** — https://git-scm.com/download/win
* **Node.js 18+** — https://nodejs.org (for the local proxy)
* For the server: the **.NET 6 SDK** and **MongoDB** (see step 4).
* Optional, for step 7: **Python 3.11+** and the **.NET 8 SDK**.

## 2. Install and activate Unity 4.6.5f1

Run **`tools\setup-unity-4.6.5.bat`**. It:

1. checks that Unity is installed at `%USERPROFILE%\Unity4.6.5\Unity.exe` — if not, it opens Unity's download
   archive: download **Unity 4.6.5** for Windows, install it to `%USERPROFILE%\Unity4.6.5`, and run the script again
   (another location works too: `set UNITY465_EXE=...` before running the scripts);
2. downloads the public kit [constripacity/unity-4.6.5f1](https://github.com/constripacity/unity-4.6.5f1) to
   `%USERPROFILE%\unity-4.6.5f1`;
3. starts the kit's `setup.cmd` (asks for administrator rights). The kit installs current root certificates into
   Unity's Mono trust store (the 2014 editor cannot validate today's servers and quits otherwise), imports editor
   preferences, and walks you through **activating your own free Unity Personal licence** with your Unity ID.
   Read the kit's README for what each step changes on your PC; `restore`/undo steps are included.

**Good to know**

* Every editor start may show **"Unity license has expired"** with *Re-activate* / *Quit*. Click **Re-activate** —
  it does not ask for anything and the editor continues.
* **Render textures are a Unity 4 Pro feature.** With a Personal licence the editor and builds have no render
  textures, so water reflections and post-processing effects will be missing or simplified compared with the Steam
  client. Matching the Steam client exactly needs a Unity 4 Pro licence.
* The kit blocks `license.unity3d.com` in the hosts file so Unity uses your offline licence file. If a modern
  **Unity Hub** on the same PC has trouble signing in, pause the block as the kit's README explains.

## 3. Open the project

```
git clone https://github.com/TeamUberStrike/uber-4-8-6
cd uber-4-8-6
git checkout original        (or patcher-qa)
```

The code lives at the repo root like xavgru12/UberClient v4.8.6 (`Assembly-CSharp/`, `Assembly-CSharp-firstpass/`).
**`tools\setup-links.bat`** links both folders into `Assets/` so Unity compiles them; `open-project.bat` and
`build-player.bat` run it first. Do not open the project in Unity before the links exist (a dialog warns you).

Run **`tools\open-project.bat`**. The first import takes 20–60 minutes (it fills `Library/`). Then open
**`Assets/Scenes/GlobalScene.unity`** and press **Play** to run in the editor — never start from a map scene; maps
depend on the managers `GlobalScene` creates.

Do not edit project files with other tools while the editor is open: Unity only notices on refresh and stale imports
cost a lot of time. Close the editor, edit, reopen (or use *Assets > Refresh*).

## 4. Run a local server

The client talks to the community UberStrok **v4.8.6** server stack — the private repo
[`xavgru12/UberServer`](https://github.com/xavgru12/UberServer) (branch `v4.8.6`, TeamUberStrike access). Follow its
README. What this client expects:

| Service | Address |
|---|---|
| Web services (ASP.NET Core, .NET 6) | `127.0.0.1:5000` |
| Photon realtime **CommServer** (lobby, chat, loadout sync) | `127.0.0.1:5055` |
| Photon realtime **GameServer** (matches) | `127.0.0.1:5056` |
| MongoDB | `127.0.0.1:27017` |

Without the CommServer you can log in, but loadout changes go out of sync.

Then run **`tools\start-proxy.bat`** and keep its window open. The client posts to `http://127.0.0.1:8888/2.0/`
with the original Cmune service paths; [`svc_proxy.js`](svc_proxy.js) rewrites them and forwards to `:5000`.

Keep everything on `127.0.0.1`; nothing here needs to be reachable from outside your PC.

## 5. Build the game

Close the editor, then run **`tools\build-player.bat`** (optionally with an output folder:
`tools\build-player.bat D:\Builds\UberStrike`). Default output: `Build\UberStrike-4.7.1\` (git-ignored).

The script starts the editor with [`Assets/Editor/ReleaseBuild.cs`](Assets/Editor/ReleaseBuild.cs), which builds all
scenes enabled in *Build Settings* for **Windows x86** and closes the editor. The editor window is visible meanwhile
— click *Re-activate* if the licence popup appears. After scripts were added or removed, the first editor start only
re-imports; the script then starts it a second time automatically. Finally it copies next to `UberStrike.exe`:

* `steam_appid.txt` and `steam_api.dll` from the repo root,
* everything in `PlayerFiles/` (e.g. `UberStrike_Data/SeloTron.ogg`, the home-screen music),
* `uberdaemon.exe` from your Steam UberStrike folder (found through the registry; set `UBERSTRIKE_STEAM_DIR` if your
  game is in another Steam library).

A failed build leaves `Build\build.log` — search it for `error CS`.

You can also build by hand: *File > Build Settings*, keep `GlobalScene` as scene 0, target *PC, Mac & Linux
Standalone → Windows, x86*, *Build*, then copy the files above yourself.

## 6. Play

Start Steam (logged in), the server stack and `tools\start-proxy.bat`, then run **`tools\launch-client.bat`**
(or `tools\launch-client.bat D:\Builds\UberStrike`).

Start the game from Explorer, cmd or PowerShell — **not from Git Bash**: its MSYS environment leaks into Steam's
`uberdaemon` helper and the login hangs.

The client stores its settings in the registry under `HKCU\Software\Cmune\UberStrike`, shared with the Steam install
of the game.

## 7. Optional: ForgeRipper MCP for Claude Code

[ForgeRipper](https://github.com/constripacity/ForgeRipper) (private) wraps AssetRipper and exposes it to Claude Code
as MCP tools: load a Unity game folder (for example your Steam UberStrike install), scan its assets and export them.
It is how original shaders, materials and textures were compared with this project.

Run **`tools\setup-mcp.bat`**: it clones ForgeRipper to `%USERPROFILE%\ForgeRipper` (needs repo access), installs
it with `pip`, and writes a machine-specific `.mcp.json` in the repo root (git-ignored). Restart Claude Code in the
repo folder and approve the `forgeripper` server. Start AssetRipper and the bridge as described in ForgeRipper's
README.

AssetRipper's API uses **port 5000**, the same as the UberStrike web services — run one or the other.

## Troubleshooting

| Problem | Fix |
|---|---|
| Unity quits at start with "Peer certificate cannot be authenticated" | Re-run `tools\setup-unity-4.6.5.bat` (Mono certificates). |
| "Unity license has expired" | Click *Re-activate*. |
| Build fails with `could not be found` errors | Run `tools\build-player.bat` again (stale file list after scripts were added/removed). |
| Login hangs | Started from Git Bash? Use `tools\launch-client.bat`. Steam running? Proxy window open? |
| Logged in, but loadout/equip goes out of sync | The Photon CommServer (`:5055`) is not running. |
| Water looks flat, no post-processing | Personal licence: no render textures (see step 2). |
| Unity Hub cannot sign in | Pause the licence hosts block (see the unity-4.6.5f1 kit's README). |

## Script reference

| Script | Does |
|---|---|
| `tools\config.bat` | Shared paths. Override with environment variables: `UNITY465_EXE`, `BUILD_DIR`, `UNITY465_KIT`, `UBERSTRIKE_STEAM_DIR`, `FORGERIPPER_DIR`. |
| `tools\setup-unity-4.6.5.bat` | Checks the Unity install, fetches the unity-4.6.5f1 kit, runs its setup. |
| `tools\open-project.bat` | Opens this project in Unity 4.6.5. |
| `tools\build-player.bat [dir]` | Builds the Windows player and copies its runtime files. |
| `tools\start-proxy.bat` | Runs `svc_proxy.js` (`:8888` → `:5000`). |
| `tools\launch-client.bat [dir]` | Starts the built client the safe way. |
| `tools\setup-mcp.bat` | Installs ForgeRipper and writes `.mcp.json`. |
