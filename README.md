# UberStrike 4.7.1 Reborn (Unity 4.6.5f1)

A Unity 4.6.5f1 restoration of UberStrike, the 2014 Cmune-developed FPS that lived on Steam as version 4.7.1. This branch contains decompiled and recovered C# source, Unity project assets reconstructed from the original 2015-era Steam Windows client, and a curated set of restoration patches that make the client buildable, runnable, and visually correct against community or private backends.

Sibling of [`main`](https://github.com/TeamUberStrike/uber-4-8-6/tree/main) (the Unity 6 / 4.8.6 reborn). This branch lives on its own orphan history because the two projects share no engine state or source layout they target different Unity major versions and different server-side protocol revisions.

> **Status:** Plays in the Unity Editor against the community UberStrok backend. Authentication and the gameplay loop work. Comm-server (lobby chat) is currently unreachable from this build, which is being tracked as a known issue. See [Known limits](#known-limits) below.


## Credits and attribution

* **Original game:** UberStrike, © Cmune Ltd. (2010 to 2018). Original Unity client and game design are Cmune's intellectual property. This branch preserves the 2014 Steam release for educational and preservation purposes.
* **Decompilation source:** Cmune's UberStrike 4.7.1 Steam Windows client (the actual 2015-shipped Unity 4.6.5f1 build).
* **Asset migration tooling:** [AssetRipper](https://github.com/AssetRipper/AssetRipper) used to extract scenes, prefabs, and meshes from the original Unity 4.6 player into an editable project structure.
* **Backend protocol reference:** community fork of UberStrok by `xavgru12` / `HaZardousss`. Their WebServices and Photon plugins are what this client expects on the network side. The protocol version this branch targets is 4.7.1, the matching server-side branch is the `v4.7.1` / pre-4.8 line.

The restoration patches in this branch (everything beyond the initial publish commit) are released under the [MIT License](LICENSE). The underlying game art, models, audio, and original Cmune C# source code remain © Cmune. Nothing in this README is intended to license them.


## Why a Unity 4.6.5f1 sibling project at all

The Unity 6 sibling on `main` is a forward-port targeting modern tooling. This branch goes the other direction: it stays on the exact engine version Cmune shipped, `4.6.5f1`. The reasons are:

* **Visual parity comes for free.** The original game's shaders, particle systems, lightmaps, NGUI atlases, and animation rigs were all authored against Unity 4.6's renderer. Running them on the same engine version avoids the long tail of cross-version regressions that the Unity 6 port has to chase down.
* **The 2015-shipped binary is the reference.** Side-by-side behavior comparisons against the original Steam client are exact when the engine versions match.
* **Easier source of truth for the Unity 6 port.** When something in the Unity 6 sibling looks off, this branch is the "is it like this in the real game" oracle.

The trade-off is that Unity 4.6 is a discontinued, unsupported engine. Free license restrictions (no RenderTexture, no post-processing image effects) limit what is achievable without a Pro license seat.


## Repository layout

```
uber471-unity465/
├── Assets/                          Unity project assets
│   ├── Scenes/                      GlobalScene (boot), DesktopHUD
│   ├── MapsBuiltIn/Menu/            Lobby (Menu.unity)
│   ├── ArtTools/Maps/               19 gameplay map scenes (apextwin,
│   │                                aqualabresearchhub, catalyst,
│   │                                cuberspace, cuberstrike, fortwinter,
│   │                                ghostisland, gideonstower,
│   │                                lostparadise2, monkeyisland, skygarden,
│   │                                spaceportalpha, superprismreactor,
│   │                                templeoftheraven, thehangar,
│   │                                thewarehouse, uberzone, volley)
│   ├── Scripts/Assembly-CSharp/     Game logic
│   ├── Resources/                   Runtime-loaded items, weapons, gear
│   ├── Material/                    Shared material library
│   ├── Mesh/                        Static map meshes
│   ├── AnimationClip/               Animation clips
│   ├── AnimatorController/          Mecanim controllers
│   ├── Shader/                      Custom and restored shaders
│   ├── Avatar/                      Player avatar rigs
│   ├── Cubemap/                     Skybox / reflection cubemaps
│   ├── AudioClip/                   In-game audio
│   ├── BlendTree/                   Animator blend trees
│   ├── Flare/                       Light flares
│   └── Editor/                      Editor-only utilities (bot tooling, etc.)
├── Packages/                        Unity package manifest
├── ProjectSettings/                 Unity 4.6.5f1 project config
├── steam_api.dll                    Steamworks redistributable
├── steam_appid.txt                  Steamworks AppID for SDK init
└── .gitignore                       Unity 4.6 appropriate ignore list
```


## Quick start

### Prerequisites

* **Unity Editor 4.6.5f1.** This is a discontinued version no longer distributed by Unity. The version is locked in `ProjectSettings/ProjectVersion.txt`. Opening with a newer Unity will trigger an irreversible upgrade back up first if you need to do that.
* **An UberStrok 4.7.1-protocol backend** to point at, or HaZard's community `ws-dev.uberforever.eu` server with permission to use it.
* **Node.js 18+** if you need a local TLS proxy (Unity 4.6's bundled Mono cannot complete TLS 1.2 handshakes against modern servers — see below).

### Open the project

1. Clone this branch:
   ```bash
   git clone --branch uber471-unity465 https://github.com/TeamUberStrike/uber-4-8-6.git uber471-unity465
   ```
2. Launch Unity 4.6.5f1, open the cloned folder as a project.
3. Wait for asset import. First import takes 3 to 8 minutes depending on disk speed.

### Which scene to open

Open **`Assets/Scenes/GlobalScene.unity`** to run the game. This is the bootstrap scene  it sets up the global managers (auth, prefab manager, dynamics, etc.) and transitions to the lobby (`Assets/MapsBuiltIn/Menu/Menu.unity`).

`DesktopHUD.unity` is the heads-up display scene loaded additively during gameplay. Do not open it directly.

### TLS proxy (only if connecting to a remote HTTPS backend)

Unity 4.6.5f1's bundled Mono ships with a `mscorlib.dll` that does not implement TLS 1.2. Any direct HTTPS request to a modern server fails the handshake. Two ways around it:

1. **Point at a local plaintext backend.** If you run the community UberStrok server stack on `127.0.0.1:5000`, edit `Assets/Resources` configuration (or the runtime `UberStrike.xml` for a built player) to point `WebServiceBaseUrl` at `http://127.0.0.1:5000/` and skip the proxy entirely.
2. **Run a local HTTP-to-HTTPS proxy.** Node.js script that listens on `127.0.0.1:8888` (HTTP) and forwards to `https://ws-dev.uberforever.eu` (HTTPS), terminating TLS in Node. The Unity client connects to the proxy in plaintext and never sees the TLS layer.

The Editor reads its configuration from `EditorConfiguration.xml` at the project root (not checked in — per-developer). Standalone builds read from `<build>_Data/UberStrike.xml` next to the executable.


## Known limits

Carried forward at first-publish time. Each is being worked separately on the private development branch and will land here when fixed.

* **Lobby chat unreachable.** The Comm-server Photon peer (which carries chat and presence) fails the handshake against `ws-dev.uberforever.eu` from this build. Symptoms: "server not reachable" on the chat panel. Game peer is unaffected — matches play fine.
* **Real-auth pipeline pending.** Editor and Standalone currently use the offline-bypass path via the `OFFLINE_STEAMID = 76561197960287930` sentinel and `StartOfflineLogin()`. The full Rijndael request-crypto and four client-proxy rewrites needed to round-trip a real Steam ticket are scoped as multi-hour work and not yet shipped.
* **T-pose avatar on first spawn.** Bind-pose mismatch between AssetRipper-emitted skeleton and the original animation clips. Needs Editor rig retargeting.
* **22 stub shaders still ported.** 15 post-FX shaders that depended on Unity 4.6 Pro's `RenderTexture` and 7 map-affecting shaders are placeholders. Visual regressions on a handful of maps follow.
* **Lobby water flat / non-reflective.** Same Pro-license-only `RenderTexture` constraint.

Open a new issue if you hit something not listed here.


## Offline-bypass editor mode

When `SteamManager.Initialized == false` (Editor with no real Steam ticket, or DLL load failure), `PlayerDataManager.SteamId` returns the hardcoded sentinel `76561197960287930` (the canonical "no Steam ID" placeholder). `AuthenticationManager.LoginByChannel` detects this exact string and routes into `StartOfflineLogin()`, which:

* Skips the SOAP authentication chain entirely.
* Loads a hardcoded fallback map list when `GetMaps` fails.
* Sets minimal stub state so the menu UI can paint without a backend.
* Lets you load gameplay scenes for testing and iteration without auth.

This bypass is Editor-only by virtue of `SteamManager.Initialized` being false in the Editor. In a built player with Steamworks initialized, the real Steam path runs. To disable the bypass entirely for a release build, wrap `StartOfflineLogin` with `#if !UNITY_EDITOR` or check `Application.isEditor`.


## Building a standalone player

This branch has not been verified outside the Editor on the public-release toolchain. To build:

1. **File** > **Build Settings**.
2. Confirm `GlobalScene` is scene index 0.
3. **Build** for Standalone Windows.
4. Copy `steam_api.dll` and `steam_appid.txt` next to the resulting `.exe`.
5. Drop an `UberStrike.xml` configuration into `<build>_Data/` with the right `WebServiceBaseUrl` / `ContentBaseUrl` for the target backend.


## Contributing

This is a restoration project for a discontinued game. Pull requests that improve fidelity to the original 2014 client, restore broken shaders, fix migration artifacts, or improve documentation are welcome. PRs that introduce new game content or rebrand the project will be closed.


## Disclaimer

This branch exists for educational and preservation purposes. UberStrike's original assets, models, audio, and game design are © Cmune. The restoration patches in commit history (everything beyond the initial publish commit) are MIT-licensed (see `LICENSE`), but that license does not extend to the underlying Cmune-owned assets. If you are a current rights holder and want this branch taken down, open an issue or contact the maintainer and it will be removed.
