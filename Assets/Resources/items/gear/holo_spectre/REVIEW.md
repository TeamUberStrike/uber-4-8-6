Hooded spectral figure with a featureless violet-blue head matching the body texture, matching asymmetric front drape and one soft crossover fold. The owner-approved hood/cape construction and worn fabric are preserved, including geometric tears and the frayed hem. Padded chest bands and the rectangular lower panel have been removed. Limited thigh weighting provides gentle gait-driven hem movement; no new cloth physics or runtime code.

Adds `Holo_Spectre` as item 1059 (GearHolo, ItemType 3 / ItemClass 23), with its own prefab trio, mesh, rig, one themed material, 1024 DMA/NM, icon and registry line. Shipped skeleton, attachments, hitboxes, IK and ragdoll components are retained.

Validation: 10,994 triangles; W/H/D 1.559978 / 1.888920 / 0.688694 m. Structural mesh and native serialization checks pass. Five Blender/serialized-Unity pose probes agree within 0.0000004 m. Worst edge-stretch p99 1.2699; individual short edges reach 3.1518x and require motion inspection.

Unresolved acceptance: the fixed local silhouette cutoff <0.532303 is not met (largest overlap 0.651976 against Nitric). This draft preserves that failure; it does not claim release readiness. Owner review of the final candidate, Unity 4.6.5 import, real run/aim/death clips, ragdoll/contact checks, exact shader lighting and studio preview remain pending.

The shared workspace `gpt6-holos/delivery/Holos_Final_Review.zip` contains source Blender files, static pose meshes, catalog rows and validation. The catalog patch targets only `UberServer/src/UberStrok.WebServices.AspNetCore/assets/configs/game/items.json`; it is handed off, not applied. Default Face 1058 is preserved; Seraph uses 1061. No rebuild or deploy.
