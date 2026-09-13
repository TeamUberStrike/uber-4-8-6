# Arc — locked visual, draft technical review

The owner approved this exact anatomical sculpt and explicitly instructed that it must not change. This is a new Arc avatar derived from project-owned Rust anatomical topology and the unchanged shipped skeleton; it does not overwrite Rust.

## Measured result

- ID 1056; PrefabName `Holo_Arc`; ItemType 3 / ItemClass 23.
- 10,992 triangles; 5,494 source vertices; 8,552 serialized vertices after UV/normal splits.
- World-space width/height/depth: 1.559903 / 1.940377 / 0.651948 metres. Floor zero. All within the measured seven-holo envelope.
- One closed mesh. UVs and triangle areas valid. 1024 x 1024 DMA/NM.
- One opaque Reflect-BumpSpec material on the game renderer. No transparent pass; the blue spikes' glass-like look is a Blender preview effect. Bright veins are baked into diffuse; no added shader emission channel.
- Exact Rust bind matrices, bone hashes, 24-bone renderer order, 15 gameplay bone entries, attachment/IK/hitbox transforms, animator link and ragdoll physics components retained.
- Geometry and serialized Unity skinning agree with Blender in bind, T, portrait, aim and crouch probes (maximum absolute error below 0.0000004 metres).
- Worst probe edge-stretch p99 is 1.3424; individual short edges reach 6.226 in the aim probe. These are diagnostics, not a guarantee of good gameplay animation. Inspect joint membranes and contacts during real playback.

## Unresolved gates — do not mark release-ready

The fixed six-view 96 px mean-IoU silhouette cutoff was < 0.532303. Arc scores 0.811059 against Rust and fails that cutoff. The visual approval does not turn this measurement into a pass. The owner has locked the shape; any alternative silhouette criterion or waiver belongs to the maintainer review. Inter-holo comparisons must be rerun once the other designs stabilize.

Run actual run/aim/death clips, ragdoll playback, attachment/IK checks and collision inspection. Source horns are bound to Head, the back fan to Chest, and forearm growths to the corresponding ForeArm. The final remesh uses interpolated/smoothed skin weights: inspect the baked result, not just source assignments. See appendage_weight_spotchecks.json.

Validate the exact shipped shader in Unity 4.6.5 hangar/game lighting and the holo studio; Blender is an approximation. The shop icon and static T/portrait OBJ exports are supplied. No Unity rebuild or deploy was performed.

## Review files

The branch contains only the new `Assets/Resources/items/gear/holo_arc/` folder and Arc's single registry line. `delivery/Arc_locked_review.zip` in the shared gpt6-holos workspace contains the locked Blender sculpt, static pose exports, textures, native Unity folder, catalog row and validation reports. The high sculpt is retained, hidden, inside the source Blender file; the game mesh is the rigged `Arc` object.

Canonical catalog target: `UberServer/src/UberStrok.WebServices.AspNetCore/assets/configs/game/items.json`. Arc's row is supplied as a handoff; no source or live-served catalog, binaries, or server version settings were modified. ID 1058 already belongs to Default Face; Seraph was reassigned to 1061 by the owner. Cinder 1057, Spectre 1059, Rime 1060 reserved.

Arc's approved source asset hashes are recorded in `art/approved/ARC_LOCK.json` and checked before/after packaging. The older Arc_first_review.zip is superseded and must not be used.
