# UberStrike Unity 6 Reborn (4.8.6)

A Unity 6 restoration of UberStrike, the 2014 Cmune-developed FPS that lived on Steam as version 4.7.1. This repository contains decompiled and recovered C# source, Unity 6 (`6000.0.56f1`) project assets, a local HTTP proxy, and a curated set of restoration patches that make the client buildable, runnable, and visually correct against community or private backends.

> **Status:** Playable in the Unity Editor. Boots through GlobalScene into Menu and into match flow against a local UberStrok backend. Most maps render. A handful of cross-platform shaders and a few map-specific particle effects are still being restored. See [Known Issues](#known-issues) below.


## Credits and attribution

* **Original game:** UberStrike, © Cmune Ltd. (2010 to 2018). Original Unity client and game design are Cmune's intellectual property. This repository preserves a 2014 Steam release for educational and preservation purposes.
* **Decompilation source:** Cmune's UberStrike 4.7.1 Steam Windows client.
* **Asset migration tooling:** [ForgeRipper](https://github.com/constripacity/ForgeRipper) extracts assets from the Unity 4.6 AssetBundles into a Unity 6 project structure.
* **Backend protocol reference:** community fork of UberStrok by `xavgru12` / `HaZardousss`, branch `v4.8.6`. That fork ships the WebServices and Photon plugins this client expects on the network side.

The restoration patches in this repository (everything in commit history beyond the initial ForgeRipper import) are released under the [MIT License](LICENSE). The underlying game art, models, audio, and original Cmune C# source code remain © Cmune. Nothing in this README is intended to license them.


## Repository layout

```
uber-4-8-6/
├── Assets/                          Unity project assets
│   ├── Scenes/                      Bootstrap, HUD, GlobalScene
│   ├── MapsBuiltIn/Menu/            Lobby (Menu.unity)
│   ├── ArtTools/Maps/               19 gameplay map scenes
│   ├── Scripts/Assembly-CSharp/     Game logic
│   ├── Plugins/Assembly-CSharp-firstpass/   Web service clients
│   ├── Resources/                   Runtime-loaded items, weapons, gear
│   ├── Material/                    Shared material library
│   ├── Mesh/                        Static map meshes
│   ├── AnimationClip/               Animation clips
│   ├── Shader/                      Custom and restored shaders
│   ├── AnimatorController/          Mecanim controllers
│   └── Imported/JumpPadsFrom438/    Reference assets from the 4.3.8 Unity 2022 community port
├── Packages/                        Unity package manifest
├── ProjectSettings/                 Unity project config
├── http_proxy.js                    Local HTTP proxy (Node.js)
├── steam_appid.txt                  Steamworks AppID for Steam SDK init
├── LICENSE                          MIT license for restoration patches
├── README.md                        This file
└── .gitignore                       Unity-standard ignore list
```


## Quick start

### Prerequisites

* **Unity Editor 6000.0.56f1** (Unity 6.0). Older Unity 6 patch versions may work but are untested. Newer versions should be fine.
* **Node.js 18+** for the HTTP proxy. The proxy uses only Node's built-in `http` module with zero npm dependencies.
* **An UberStrok v4.8.6 backend** to point at. Run the open-source server stack locally for development, or point the proxy at a community server you have permission to use.

### Open the project

1. Clone or download this repository.
2. Launch Unity Hub, click **Add project from disk**, and select the `uber-4-8-6` folder.
3. Open the project in Unity Editor 6000.0.56f1.
4. Wait for Unity to finish importing assets. First import takes 5 to 15 minutes depending on disk speed.

### Which scene to open

Open **`Assets/Scenes/GlobalScene.unity`** to run the game. This is the bootstrap scene. It sets up the global managers (auth, prefab manager, dynamics, etc.) and then transitions to the lobby (`Assets/MapsBuiltIn/Menu/Menu.unity`).

`GlobalScene.unity` is also entry index `0` in `ProjectSettings/EditorBuildSettings.asset`, so it is what a built player would launch into. Do not open `Menu.unity` or any map scene directly. They depend on the global managers that GlobalScene creates.

### Start the proxy

The Unity client points its WebServices base URL at `http://127.0.0.1:8888/2.0/`. The HTTP proxy listens on that address and forwards every request to your actual backend.

```bash
# defaults: forward 127.0.0.1:8888 to 127.0.0.1:5000
node http_proxy.js

# point at a different upstream via env vars:
set UBERSTRIKE_UPSTREAM_HOST=127.0.0.1
set UBERSTRIKE_UPSTREAM_PORT=5000
set PROXY_LISTEN_PORT=8888
node http_proxy.js
```

If you are running the UberStrok community server stack locally, it usually listens on `127.0.0.1:5000` out of the box, so the defaults work without configuration. You will see proxy logs like:

```
[PROXY] Listening on http://127.0.0.1:8888
[PROXY] Forwarding to http://127.0.0.1:5000
[PROXY] POST /2.0/ApplicationWebService
[PROXY]   -> 200
```

> The file is named `http_proxy.js`. It does not terminate TLS. Both client to proxy and proxy to upstream legs are plaintext HTTP. Earlier commits called it `tls_proxy.js`, the rename happened during the audit pass.

### Hit Play

Once GlobalScene is open and the proxy is running:

1. Press **Play** in the Unity Editor.
2. The bootstrap loads, hands off to the lobby, and tries to authenticate.
3. If the backend is reachable, the lobby UI populates with shop, inventory, and loadout data, and you see your avatar.
4. If the backend is not reachable, the client falls back to the offline editor bypass mode described below.

### Offline editor bypass

When `SteamManager.Initialized == false` (Editor without a real Steam ticket), the client returns a hardcoded fallback Steam ID `76561197960287930` (the canonical "no Steam ID" placeholder) and `AuthenticationManager.LoginByChannel` routes into `StartOfflineLogin()`. This:

* Skips the SOAP authentication chain entirely.
* Loads a hardcoded fallback map list when `GetMaps` fails.
* Sets minimal stub state so the menu UI can paint without a backend.
* Lets you load gameplay scenes for testing and iteration without auth.

This bypass is editor-only by virtue of `SteamManager.Initialized` being false in the Editor. In a built player with Steamworks initialized, the real Steam path runs. To disable the bypass entirely (for a release build), wrap `StartOfflineLogin` with `#if !UNITY_EDITOR` or check `Application.isEditor`.


## Known issues

Known issues, fixes, and design notes are tracked in the [Issues tab](https://github.com/TeamUberStrike/uber-4-8-6/issues) instead of in this file.

* **Open issues** carry a severity label: `severity: high` (gameplay-blocking), `severity: medium` (visually wrong or noisy, the game still runs), or `severity: low` (cosmetic or cleanup debt).
* **Fixed issues** from the restoration pass are filed and closed, so the record of what was repaired is still there.
* **Design notes** describe intentional behavior rather than bugs. They are closed issues tagged `documentation`.

If you run into something that is not already tracked, open a new issue.


## Building a player

This project has not been verified outside the Editor. To build:

1. **File** > **Build Settings**
2. Confirm the scene order matches `ProjectSettings/EditorBuildSettings.asset` (GlobalScene must be index 0).
3. **Build**.

You will likely need to:

* Provide a `steam_appid.txt` next to the player executable.
* Decide whether to keep the offline-editor bypass enabled in non-Editor builds.
* Bundle the proxy alongside the player or hard-code your backend's address into `ApplicationDataManager`.


## Contributing

This is a restoration project for a discontinued game. Pull requests that improve fidelity to the original 2014 client, restore broken shaders, fix migration artifacts, or improve documentation are welcome. PRs that introduce new game content or rebrand the project will be closed.


## Disclaimer

This repository exists for educational and preservation purposes. UberStrike's original assets, models, audio, and game design are © Cmune. The restoration patches in commit history (everything beyond the initial ForgeRipper import) are MIT-licensed (see `LICENSE`), but that license does not extend to the underlying Cmune-owned assets. If you are a current rights holder and want this repository taken down, open an issue or contact the maintainer and it will be removed.
