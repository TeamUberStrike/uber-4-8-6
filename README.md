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

The list below is the full set of known issues across visuals, gameplay, networking, and migration drift, classified by severity and the file path where the bug lives.

Severity definitions:

* **High:** gameplay-blocking or playthrough-affecting
* **Med:** visually wrong or noisy in console but the game still progresses
* **Low:** cosmetic, minor, or cleanup debt
* **Info:** design intent or pre-existing inherited behavior, no action required

### Open issues

| ID | Severity | Category | Description | Repro / Pointer |
|---|---|---|---|---|
| KI-001 | High | Visuals | 102 of 106 `DummyShaderTextExporter` shader stubs still in the project. ForgeRipper migration exported property declarations correctly but left bodies as `surf Lambert` opaque placeholders. This session restored 4 (Diffuse-Static, DiffuseDetail, DoubleDiffuse, Rock-Static) and wrote 2 new (FX-Water-Transparent, FX-Additive-Particle). Most map props that look flat or wrong-colored trace back here. | `Assets/Shader/*.shader`, `Assets/Resources/**/*.shader`, grep for `DummyShaderTextExporter` |
| KI-002 | High | Visuals | 126 materials still reference `fileID 210` zero-guid (the broken built-in Particles/Additive ref). Includes some genuine particles AND map props AND decals AND skybox bits. **Do NOT bulk-replace.** The fileID 210 bucket is a catch-all unresolved-shader bucket, not a particles bucket. Fix individual user-visible breakage, never sweep all 126 at once. | `Assets/Material/**/*.mat`, grep for `fileID: 210, guid: 0000000000000000f000000000000000` |
| KI-003 | High | Visuals | Sunset background on every map. `SunnySummerDay.cs` is correctly scoped to the lobby via the 20-name `GameplayMapScenes` HashSet, but the procedural skybox material it created during a lobby visit gets assigned to `RenderSettings.skybox` and persists across scene loads via `DontDestroyOnLoad`. The defensive cleanup destroys the manager GO but does not reset `RenderSettings.skybox`. Two-line fix: also set `RenderSettings.skybox = null` and call `DynamicGI.UpdateEnvironment()` in the cleanup branch. | `Assets/Scripts/Assembly-CSharp/SunnySummerDay.cs:42-50` |
| KI-004 | High | Map / Collision | Catalyst wall noclip. VIFS wall MeshColliders are at world `X=-143` instead of Steam's `X=-47`. Walking through certain Catalyst walls works because Unity 6's static batching re-anchored the wrong way at scene load. The `FloorFix_VIFS011` BoxCollider injection prevents falling through the floor, but lateral wall collisions through specific VIFS panels are still broken. | `Assets/ArtTools/Maps/catalyst/Catalyst.unity`, see `FloorFix_VIFS011` GO |
| KI-005 | High | Avatar / Animation | Lobby avatar holds the Unity 4.3 stance instead of the proper hip-shift breathing idle. `LobbyChillPose.cs` hard-disables the Mecanim Animator on every frame (`_animator.enabled = false`) and uses a Legacy Animation component to play clips that do not exist in the imported FBX (`HomeNoWeaponIdle`, `ShopLargeGunAimIdle`, etc.). Result: avatar holds whatever the FBX bind pose is. The Shop sub-state-machine in `AvatarMovement.controller` was repaired this session (m_States populated with Idle.state) but `LobbyChillPose` still wins by re-disabling the Animator each LateUpdate. Real fix needs either restoring the Mecanim path fully or porting the missing clip names into the FBX. | `Assets/Scripts/Assembly-CSharp/LobbyChillPose.cs:69, 104` |
| KI-006 | Med | Avatar / Animation | `AvatarMovement.controller` has 6 empty `m_States: []` sub-state-machines. This session repaired only the Shop layer (lobby idle). Sniper, Melee Weapon, Heavy Weapon, ShotGun, and the Swim sub-state-machine inside Base layer still have no states, so weapon-class-specific avatar animations are silent during gameplay. | `Assets/AnimatorController/AvatarMovement.controller` |
| KI-007 | Med | Map / Particles | JumpPad and Accelerator Pad particle effects missing. Pad bodies render correctly via `JumpPadBase.mat` (Diffuse), but the animated glow on top is gone. The `JumpPad` child GO has an Animation component with 0 clip references and a MeshRenderer pointing at `JumpPadBase.mat` instead of `JumpPadParticles.mat`. The 4.3.8 reference assets are imported under `Assets/Imported/JumpPadsFrom438/` for the future fix (4 prefabs, 11 materials, 4 FBX, 4 animations). | `Assets/ArtTools/Maps/lostparadise2/LostParadise2.unity` GOs `527`, `531`, `535`. Reference assets at `Assets/Imported/JumpPadsFrom438/` |
| KI-008 | Med | Visuals (SkyGarden) | SkyGarden props look flat. The 4 Static cross-platform shaders are restored, but SkyGarden also relies on `Cross Platform Shaders/Self-Illumin/Diffuse` (InsideBlue and InsideRed glow panels), `/Particles/Alpha Blended` (Fence), `/Particles/Additive` (GlowBorder), and `/Particles/Alpha Blended Cull Back` (TransparencyGround). All still stubs. | `Assets/Shader/Illumin-Diffuse*.shader`, `ParticleBlend*.shader`, `ParticleAdd*.shader` |
| KI-009 | Med | Visuals (MonkeyIsland) | MonkeyIsland CaseFirePot chain renders flat. Uses `Cross Platform Shaders/Cutout Diffuse Double Sided` which is still a stub. Other MonkeyIsland surfaces (terrain main, rocks, cave walls, Monkey Tower, water rocks) now render correctly via the restored Rock-Static, DiffuseDetail, and DoubleDiffuse shaders. | `Assets/Shader/CutoutDoubleSided*.shader` (or similar) |
| KI-010 | Med | Network | `GetMaps SOAP error: DictionaryProxy: refusing to allocate 1124076288 entries`. WebServices `/GetMaps` returns a payload the deserializer cannot parse, reads 4 garbage bytes as a dictionary count, and aborts with a sanity-check exception. The hardcoded fallback map list kicks in so all 19 maps are still selectable, but the error suggests a server-side protocol mismatch. Logged once per launch. | Server-side. Client side is `Assets/Plugins/Assembly-CSharp-firstpass/UberStrike/WebService/Unity/SoapClient.cs:135`, `AuthenticationManager.cs:235` |
| KI-011 | Med | Map (TempleOfTheRaven) | `TempleTeleporter.Awake` NullReferenceException at line 35. The teleporter MonoBehaviour dereferences something in `Awake()` that is not initialized yet. Map still loads, the exception is caught by Unity's per-component error wall, but the teleporter does not function. | `Assets/Scripts/Assembly-CSharp/TempleTeleporter.cs:35` |
| KI-012 | Med | Map (TempleOfTheRaven) | `Material 'CenterRoomReflection' with Shader 'Standard' doesn't have a texture property '_ReflectionTex'`. `ReflectionFx.cs:35` tries to set a render texture on a material whose shader was migrated to Unity Standard during ForgeRipper conversion and lost the original water reflection slot. Fires once per scene load. Cosmetic. The center room shows no reflection but renders. | `Assets/Scripts/Assembly-CSharp/ReflectionFx.cs:35`, `Assets/Material/CenterRoomReflection.mat` |
| KI-013 | Med | Map (TheHangar) | 180 missing non-identity rotations vs the Steam client snapshot. ForgeRipper migration wiped per-instance rotations on certain prop GOs. Visible as props (lights, fixtures, signs) facing wrong directions. | `Assets/ArtTools/Maps/thehangar/TheHangar.unity` |
| KI-014 | Med | Map (TheHangar) | Fog mode set to ExponentialSquared in port vs Exponential in Steam scrape. One-line YAML fix in the scene's `RenderSettings` block. | `Assets/ArtTools/Maps/thehangar/TheHangar.unity` `m_FogMode: 2` to `0` |
| KI-015 | Med | Map (TempleOfTheRaven) | Port has 2 directional lights, Steam has 1. The extra light makes the cave brighter than intended. Need to disable or remove one. | `Assets/ArtTools/Maps/templeoftheraven/TempleOfTheRaven.unity` |
| KI-016 | Med | Visuals (4 indoor maps) | `TheWarehouse`, `FortWinter`, `UberZone`, `AqualabResearchHub` have no skybox. Intentional indoor maps. They show whatever `RenderSettings.skybox` was last set to, which after a lobby visit is the SunnySummerDay procedural sunset (see KI-003). Resolves automatically when KI-003 is fixed. | scene RenderSettings blocks |
| KI-017 | Med | Network / Photon | `PeerStatusCallback SendError` x 19 during launch. Photon Realtime layer connection churn while reconnecting to Comm and Game servers. Expected during local connect / disconnect cycles, not blocking. | Photon Realtime DLL, generated at runtime |
| KI-018 | Med | Avatar / IMGUI | Lobby player name can clip on the right edge. `AvatarHudInformation.SetAvatarLabel` measures with `BlueStonez.label_interparkbold_13pt` whose glyph metrics did not survive Unity 4.6 to 6 import. Defensive fallback widens the rect via `GUI.skin.label.CalcSize` and enforces an 80px min plus 12px right pad. Works for short names, may still clip very long ones. | `Assets/Scripts/Assembly-CSharp/AvatarHudInformation.cs` `SetAvatarLabel` |
| KI-019 | Low | Map (Volley) | Volley Floor_A rotation patch from this morning was wrong (placed a vertical wall in the middle of the map). Reverted. If a vertical building re-appears in the middle of Volley's sky, that patch leaked back in. Run `git checkout` on the scene file. | `Assets/ArtTools/Maps/volley/Volley.unity` |
| KI-020 | Low | NGUI / IMGUI | `AtlasHUD` mesh `(-inf, ..., NaN)` warnings, 6 to 8 per HUD-visible frame. NGUI sprite atlas has at least one sprite with a 0-width or 0-height inner / outer rect, producing NaN UV math during dynamic mesh build. Pre-existing migration artifact. No rendering impact on other sprites. | `Assets/GameObject/AtlasHUD.prefab` |
| KI-021 | Low | Engine warnings | `PrefabManager.Awake` and `SoundEffects.Awake` log "DontDestroyOnLoad only works for root GameObjects". Both call `DontDestroyOnLoad` on non-root GOs, which Unity 6 turned from silent into a warning. Cosmetic. | `Assets/Scripts/Assembly-CSharp/PrefabManager.cs:67`, `SoundEffects.cs:16` |
| KI-022 | Low | Underwater | `UnderWaterEffect` post-processing is added at runtime by `RenderSettingsController.OnEnable` but its shader (`CMune/Under Water Effect`) may be a stub. Underwater rendering on TempleOfTheRaven and MonkeyIsland will be flat instead of refracted. | `Assets/Scripts/Assembly-CSharp/RenderSettingsController.cs:91-97` |
| KI-023 | Low | Migration debt | Hundreds of `_0`, `_1`, `_2`, `_3` suffixed duplicate shader, material, and animation files. ForgeRipper's dedupe-on-import created multiple variants whenever it found the same logical asset under different bundle paths. Some maps reference one variant, others reference different ones. Cleanup would require hundreds of file deletions plus scene-level GUID re-binding. | `Assets/Shader/*_[0-9].shader`, `Assets/Material/*_[0-9].mat`, `Assets/AnimationClip/*_[0-9].anim` |
| KI-024 | Low | Migration debt | No baked lightmaps. None of the 19 maps have lightmap data. ForgeRipper migration did not carry the bake. All lighting is real-time directional plus ambient. Maps look flat compared to the original Steam build's pre-baked lighting. | `Assets/ArtTools/Maps/**/Lightmap-*.exr` (absent) |
| KI-025 | Low | Migration debt | 20 TODO, FIXME, and HACK comments in `Assets/Scripts/Assembly-CSharp/`. Most are inherited from Cmune's decompile, a few are session workarounds. | `grep -rinE "TODO\|FIXME\|HACK" Assets/Scripts/Assembly-CSharp/` |
| KI-026 | Low | Game logic | Offline shop bypass purchases do not persist. `BuyPanelGUI` simulation marks items "owned" client-side but does not update the local server's inventory. Items disappear between launches in offline mode. Online mode (with a real backend) works. | `Assets/Scripts/Assembly-CSharp/BuyPanelGUI.cs:119-146` |
| KI-027 | Low | Network | `ChatManager` reconnects forever in offline mode. Generates periodic Comm-server connection warnings. Non-blocking. | `Assets/Scripts/Assembly-CSharp/ChatManager.cs` |
| KI-028 | Low | NGUI fonts | NGUI atlas font shaders are still dummy stubs (`GUI - Text Shader (AlphaClip)`, `Unlit - Dynamic Font`, `Unlit - Premultiplied Colored`, etc.). The lobby UI renders because Unity falls back to the default font shader. Text looks slightly off (no SDF) but is fully readable. | `Assets/Resources/shaders/*.shader` |
| KI-029 | Info | Imported assets | `Assets/Imported/JumpPadsFrom438/` is 22 MB and 68 files of 4.3.8 reference assets sitting unreferenced. Kept in the repo as the working set for the future JumpPad reconstruction (KI-007). Non-blocking. | `Assets/Imported/JumpPadsFrom438/` |

### Fixed in the initial restoration pass

| ID | Description | Fix |
|---|---|---|
| KF-001 | Catalyst noclip. Player fell through the floor on every map after the first scene transition. | `PrefabManager.Awake()` was missing `Object.DontDestroyOnLoad(gameObject)`. PrefabManager.Instance became null after GlobalScene unload and the lazy `GameState.Player` getter silently returned null. One-line fix in `PrefabManager.cs:67`. |
| KF-002 | Catalyst floor missing. VIFS011 mesh has exact-zero Y thickness, Unity 6 PhysX rejects degenerate meshes. | Injected `FloorFix_VIFS011` BoxCollider GameObject into Catalyst.unity at the same world position with proper Y=0.5 thickness. |
| KF-003 | Lobby player name clipped to half. | `AvatarHudInformation.SetAvatarLabel` falls back to `GUI.skin.label.CalcSize` when `BlueStonez.label_interparkbold_13pt` under-measures, then enforces 80px min plus 12px right-pad. |
| KF-004 | ESC pause causes the character to fly around the map. | `CharacterMoveController.UpdatePlayerMovement` early-returns when `PlayerData.Is(PlayerStates.Paused)`. Root cause: `PushState(Paused)` does not fire `OnExit` on `PlayerPlayingState`, so the OnFixedUpdate subscription stays live and gravity keeps the CharacterController moving. |
| KF-005 | Avatar missing on lobby return after the first match. | `HomePageScene.OnLoad` calls `AvatarBuilder.CreateLocalAvatar()` as fallback when `GameState.Current.Avatar.Decorator == null`. The Decorator is destroyed during match to lobby transition. The original code only repositioned an existing Decorator. |
| KF-006 | `SunnySummerDay` was overriding every gameplay map's RenderSettings. | Added a 20-scene gameplay map blacklist (`GameplayMapScenes` HashSet) plus a check on `scene.name` from the `OnSceneLoaded` parameter (not `GetActiveScene()` which lags behind async transitions). Lobby (Menu) still gets the procedural sunny look. Note: the procedural skybox material assignment still leaks. See KI-003. |
| KF-007 | LP2 RayOfGod 3 plane GOs rendered as opaque squares. | New `FX-Additive-Particle.shader` plus redirected `RayOfLight.mat` and `Rainbow.mat` to it. |
| KF-008 | GhostIsland PFX_SoulsEscapeTomb, Rays, and PFX_SoulsEscape rendered as opaque squares. | Same `FX-Additive-Particle.shader` plus redirected `CFX2_Faded Ray.mat`, `Cloud2.mat`, and `CFX2-Glow.mat` to it. |
| KF-009 | Map water (LostParadise2, MonkeyIsland, TempleOfTheRaven) was an opaque mirror. | New `FX-Water-Transparent.shader` (cubemap env reflection plus fresnel plus scrolling bump plus transparent blend) plus redirected the 5 `Water4*.mat` materials. |
| KF-010 | SkyGarden and MonkeyIsland map prop materials rendered flat. | Restored 4 Cross Platform Shader stubs to real bodies: `Diffuse-Static.shader` (Diffuse plus _Color tint), `DiffuseDetail.shader` (2x detail blend), `DoubleDiffuse.shader` (lerp by _Fade), `Rock-Static.shader` (world-normal moss blend). |
| KF-011 | Lobby Animator Shop sub-state-machine had empty `m_States: []`. | Added `Idle.state` reference to Shop layer's `m_States` in `AvatarMovement.controller`. (LobbyChillPose still overrides it via Animator disable. See KI-005.) |
| KF-012 | `AuthToken` and `MagicHash` logged to player.log on every successful login. | Removed the two `Debug.LogWarning` lines in `AuthenticationManager.cs`. |
| KF-013 | Vestigial `UberDaemon.cs` shipped as a helper-binary launcher with command-injection surface. | Deleted the file. Replaced its single call site in `AuthenticationManager.cs` with `PlayerDataManager.MagicHash = string.Empty`. |
| KF-014 | SteamID logged plaintext in 8+ places. | All `Debug.Log` and `Debug.LogWarning` calls referencing SteamID wrapped in `#if UNITY_EDITOR ... #endif`. |
| KF-015 | LAN IPs `192.168.0.116/.111` baked into source as default connection strings. | Replaced with `127.0.0.1` in `CommServerConnection.cs`, `GameServerConnection.cs`, and `GlobalScene.unity`. |
| KF-016 | `crzyfish@nate.com` Korean support email inherited from Cmune 2014 retail. | Replaced with `support@uberstrike.invalid` placeholder in `strings.ko_KR.ko_kr`. |
| KF-017 | `tls_proxy.js` upstream hardcoded to `85.215.170.157`, misleading TLS name. | Renamed to `http_proxy.js`, made `UPSTREAM_HOST/PORT` and `LISTEN_PORT` env-var driven, added explicit "not TLS" note in header. |

### Design intent (not bugs)

| ID | Description |
|---|---|
| KI-D1 | Offline editor bypass is on by default. When `SteamManager.Initialized == false` (Editor without a real Steam ticket), the client falls back to SteamID `76561197960287930` and routes through `StartOfflineLogin()`. This is the design. Disable for release builds by wrapping `StartOfflineLogin` with `#if !UNITY_EDITOR`. |
| KI-D2 | Photon Bootstrap License caps localhost Photon at 20 concurrent connections, no expiry. For local testing this is effectively unlimited. |
| KI-D3 | NullCryptographyPolicy wraps the inherited Cmune `RijndaelEncrypt(..., "h&dk2Ks901HenM", "huSj39Dl)2kJ4nat")` and returns input unchanged. The hardcoded "key" is a no-op anti-tamper artifact, not a real secret. Already public since 2014. |
| KI-D4 | `SunnySummerDay.cs` is intentionally lobby-scoped to the 20-scene `GameplayMapScenes` blacklist. If you add a new gameplay map, add its scene name to that blacklist or it will inherit the sunny lobby preset and stomp its own RenderSettings. (See KI-003 for the related skybox-material persistence issue.) |
| KI-D5 | `LobbyChillPose.cs` disables the Mecanim Animator. It was a workaround for the broken Mecanim controller (now partially fixed in KF-011). Still overrides because removing it caused the lobby avatar to T-pose and fall through the floor (a different bug). Tracked as KI-005. |


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
