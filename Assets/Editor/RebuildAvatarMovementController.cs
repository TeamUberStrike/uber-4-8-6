// RebuildAvatarMovementController.cs
// -----------------------------------------------------------------------------
// Unity 4.6.5f1 EDITOR SCRIPT (UnityEditorInternal AnimatorController API, pre-Unity-5).
//
// PURPOSE
//   The AssetRipper-exported AvatarMovement.controller is NON-NATIVE: its 27 states
//   are EXTERNAL .state assets whose m_ParentStateMachine is {fileID: 0} (null), and
//   its transitions are written in a YAML form the 4.6.5 importer cannot fully read.
//   Two build defects result:
//     (1) only ~5-6 of 50 transitions survive a build, and
//     (2) every state's uniqueName bakes UN-qualified ("Gun Aimed" instead of
//         "Sniper.Gun Aimed"), so the 3 distinct "Gun Aimed" / 3 "Shooting" instances
//         collapse into one flat name each -> wrong weapon/shop-GUI hold poses.
//   (The sub-state-machine NESTING itself imports fine and the 3 blend-tree instances
//   ARE distinct on disk; the collapse happens only at build, from the null parent.)
//
//   This script makes the controller NATIVE so both defects vanish:
//     * VERIFIES the imported 3-layer / 8-SM / 27-state structure, ABORTS loudly
//       (writing nothing) if it does not match.
//     * Captures each state's exact motion (incl. the 12 per-instance blend trees),
//       tag and flags from the external .state assets.
//     * Removes the external states and RE-CREATES them with StateMachine.AddState,
//       which OWNS them under their SM (sets m_ParentStateMachine) -> qualified
//       uniqueNames bake at build. Re-attaches the captured motion (blend trees via
//       reflected State.SetMotionInternal, since 4.6.5 has no public SetMotion(Motion))
//       and tag/flags, verifying nothing is lost.
//     * Rebuilds all 50 transitions (6 AnyState + 44 state) with exact conditions /
//       durations / offsets / atomic flags.
//   Unity then re-serializes the controller with EMBEDDED states + native transitions.
//
//   The simplified graph spec is lossy on per-instance tag/motion (e.g. the melee
//   "Shooting" is tagged Melee, the shop rest "Idle" is ShopIdle with no motion, and
//   the 3 "Gun Aimed" use 3 different blend trees), so per-instance data is taken from
//   the imported assets, never from the spec.
//
// USAGE
//   Menu:  UberStrike / Avatar / Rebuild AvatarMovement Controller
//   (Editor only. Does not enter Play mode, so the editor Mecanim crash guard in
//    AvatarAnimationController.cs is irrelevant here -- do NOT touch that file.)
//
// NOTE ON NAMESPACING
//   Wrapped in its own namespace with explicit type aliases because this project
//   declares a GLOBAL `class StateMachine` that would otherwise shadow / clash
//   with UnityEditorInternal.StateMachine.
//
// The transition table below was generated 1:1 from the source .controller YAML
// (id-matched), not from the simplified graph spec. Counts are asserted at runtime.
// -----------------------------------------------------------------------------

namespace UberStrikeEditorTools
{
    using System;
    using System.Collections.Generic;
    using System.Reflection;
    using UnityEngine;
    using UnityEditor;
    using AnimatorController = UnityEditorInternal.AnimatorController;
    using StateMachine = UnityEditorInternal.StateMachine;
    using State = UnityEditorInternal.State;
    using Transition = UnityEditorInternal.Transition;
    using AnimatorCondition = UnityEditorInternal.AnimatorCondition;
    using AnimatorControllerParameter = UnityEditorInternal.AnimatorControllerParameter;
    using M = UnityEditorInternal.TransitionConditionMode;      // If=1 IfNot=2 Greater=3 Less=4 ExitTime=5 Equals=6 NotEqual=7
    using PType = UnityEditorInternal.AnimatorControllerParameterType; // Float=1 Int=3 Bool=4 Trigger=9

    public static class RebuildAvatarMovementController
    {
        const string kPath = "Assets/AnimatorController/AvatarMovement.controller";

        // ---- runtime state (populated per run) ----
        static AnimatorController _ctrl;
        static Dictionary<string, StateMachine> _sm;                       // smName -> StateMachine
        static Dictionary<string, Dictionary<string, State>> _st;          // smName -> (stateName -> State)
        static Dictionary<string, Cap> _cap;                               // "smstate" -> captured motion/tag/props
        static MethodInfo _setMotion;                                      // State.SetMotionInternal(Motion) - reflected (no public setter)
        static int _added;
        static int _embedded;
        static int _stripped;                                              // seeded default Exit-Time conditions removed
        static bool _abort;

        sealed class Cond { public M mode; public string param; public float thr; public float exit; }

        // Captured per-state data harvested from the imported external .state assets
        // BEFORE they are removed, so the re-created NATIVE (embedded) states keep the
        // exact per-instance motion (incl. the 12 blend trees), tag and flags.
        sealed class Cap { public UnityEngine.Motion motion; public bool hadMotion; public string tag; public bool ik; public bool mirror; public float speed; }

        // ---- expected structure (ground truth from source .controller + baseline) ----
        static readonly string[] kLayers = { "Base", "Weapons", "Shop" };

        sealed class SMDef { public string name; public string def; public string[] states; }
        static readonly SMDef[] kSMs =
        {
            new SMDef{ name="Base", def="Locomotion",
                       states=new[]{"Locomotion","Crouch","TurnR45","TurnL45","JumpIdle","JumpIdleFall","CrouchingIdle"} },
            new SMDef{ name="Swim", def="SwimIdle", states=new[]{"SwimIdle"} },
            new SMDef{ name="Weapons", def="No Weapons", states=new[]{"No Weapons"} },
            new SMDef{ name="Sniper", def="ShopSmallGunTakeOut",
                       states=new[]{"ShopSmallGunTakeOut","Shooting","Gun Aimed"} },
            new SMDef{ name="Melee Weapon", def="Melee",
                       states=new[]{"Melee","ShopMeleeTakeOut","Shooting"} },
            new SMDef{ name="Heavy Weapon", def="ShopLargeGunTakeOut",
                       states=new[]{"ShopLargeGunTakeOut","Shooting","Gun Aimed"} },
            new SMDef{ name="ShotGun", def="ShopShotGunTakeOut",
                       states=new[]{"ShopShotGunTakeOut","Shooting","Gun Aimed"} },
            new SMDef{ name="Shop", def="Idle",
                       states=new[]{"Idle","ShopNewGloves","ShopNewUpperBody","ShopNewBoots","ShopNewLowerBody","ShopNewHead"} },
        };

        // ---- parameters (name, type, defaults) - matches source m_AnimatorParameters ----
        sealed class PDef { public string name; public PType type; public float f; public int i; public bool b; }
        static readonly PDef[] kParams =
        {
            new PDef{ name="SpeedZ",         type=PType.Float },
            new PDef{ name="SpeedX",         type=PType.Float },
            new PDef{ name="IsSquatting",    type=PType.Bool  },
            new PDef{ name="IsPaused",       type=PType.Bool  },
            new PDef{ name="WalkingSpeed",   type=PType.Float },
            new PDef{ name="TurnAround",     type=PType.Float },
            new PDef{ name="IsSwimming",     type=PType.Bool  },
            new PDef{ name="IsWalking",      type=PType.Bool  },
            new PDef{ name="IsJumping",      type=PType.Bool  },
            new PDef{ name="IsGrounded",     type=PType.Bool  },
            new PDef{ name="Direction",      type=PType.Float },
            new PDef{ name="IsShooting",     type=PType.Bool  },
            new PDef{ name="WeaponClass",    type=PType.Int   },
            new PDef{ name="IsTurningLeft",  type=PType.Bool  },
            new PDef{ name="IsTurningRight", type=PType.Bool  },
            new PDef{ name="Random",         type=PType.Float, f=1f },
            new PDef{ name="GearType",       type=PType.Int,   i=1  },
            new PDef{ name="IsDance",        type=PType.Bool  },
            new PDef{ name="WeaponSwitch",   type=PType.Bool  },
        };

        [MenuItem("UberStrike/Avatar/Rebuild AvatarMovement Controller")]
        public static void Rebuild()
        {
            _abort = false;
            _added = 0;
            _embedded = 0;
            _ctrl = null;

            _ctrl = AssetDatabase.LoadAssetAtPath(kPath, typeof(AnimatorController)) as AnimatorController;
            if (_ctrl == null)
            {
                Debug.LogError("[RebuildAM] Could not load AnimatorController at '" + kPath + "'. Aborting; nothing changed.");
                return;
            }

            // Reflected assign-motion (no public State.SetMotion(Motion); only SetAnimationClip(clip)).
            // Validate up-front, BEFORE any mutation, so we never half-build if it is missing.
            _setMotion = typeof(State).GetMethod("SetMotionInternal",
                BindingFlags.Instance | BindingFlags.NonPublic, null,
                new Type[] { typeof(UnityEngine.Motion) }, null);
            if (_setMotion == null)
            {
                Debug.LogError("[RebuildAM] Could not bind State.SetMotionInternal(Motion) via reflection. " +
                               "Cannot re-attach blend-tree motions to embedded states. Aborting; nothing changed.");
                return;
            }

            // Unity 4.x AddTransition()/AddAnyStateTransition() SEEDS every new transition with a default
            // "Has Exit Time" condition. The shipped controller's parameter transitions carry NO exit-time,
            // so StripSeededConditions() (below) removes that seed before blueprint conditions are added
            // (else e.g. the one-frame WeaponSwitch AnyState take-out transitions only evaluate at loop
            // boundaries and never fire -> the shop avatar stays in its idle hold instead of aiming).
            // The 4.6.5 API is public and index-based: conditionCount / GetCondition(i) / RemoveCondition(i)
            // (verified via mono-api-info against Data/Managed/UnityEditor.dll) -> no reflection needed.
            _stripped = 0;

            try
            {
                // 1) collect every state machine (walk layers, recurse child SMs)
                _sm = new Dictionary<string, StateMachine>();
                for (int li = 0; li < _ctrl.layerCount; li++)
                    CollectSM(_ctrl.GetLayer(li).stateMachine);

                // 2) verify imported structure matches the known graph (else abort - no writes)
                if (!VerifyStructure())
                {
                    Debug.LogError("[RebuildAM] ABORT: the imported controller structure does not match the expected " +
                                   "AvatarMovement graph (see issues above). NOTHING was written. " +
                                   "If sub-state-machines were flattened on import, the source YAML nesting must be fixed first.");
                    return;
                }

                int beforeTr = CountAllTransitions();
                int beforeStates = CountAllStates();
                Debug.Log("[RebuildAM] Loaded. Before: states=" + beforeStates + " transitions=" + beforeTr +
                          " stateMachines=" + _sm.Count + " parameters=" + _ctrl.parameterCount);

                // 3) ensure all 19 parameters exist (conditions reference them by name)
                EnsureParameters();
                if (_abort) { Revert("parameter setup"); return; }

                // 4) capture each state's motion/tag/flags from the imported EXTERNAL .state
                //    assets, then clear transitions (they reference states) before touching states.
                CaptureStates();
                if (_abort) { Revert("capture"); return; }

                foreach (KeyValuePair<string, StateMachine> kv in _sm)
                    ClearTransitions(kv.Value);
                int afterClear = CountAllTransitions();
                if (afterClear != 0)
                {
                    Debug.LogError("[RebuildAM] ABORT: failed to clear existing transitions (remaining=" + afterClear + ").");
                    Revert("clear");
                    return;
                }

                // 5) NATIVE-EMBED FIX (the shop/weapon-pose fix): the imported states are EXTERNAL
                //    .state assets with m_ParentStateMachine = 0, so at build time their uniqueName
                //    is un-qualified and the 3 "Gun Aimed" / 3 "Shooting" collide. Remove them and
                //    re-create with AddState (which OWNS them under the SM and sets the parent),
                //    re-attaching the captured motion (incl. blend trees) + tag. Repopulates _st.
                RemoveAllStates();
                if (_abort) { Revert("remove states"); return; }
                RebuildStatesNative();
                if (_abort) { Revert("state re-embed (embedded " + _embedded + " before failure)"); return; }

                // 5b) diagnostic: log the resulting uniqueNames (qualification is already guaranteed
                //     structurally by the per-state parent-pointer check in RebuildStatesNative).
                LogQualifiedNames();

                // 6) assert default states (now pointing at the embedded states)
                foreach (SMDef d in kSMs)
                {
                    State s = FindState(d.name, d.def);
                    if (s == null) { Fail("default state missing: " + d.name + "/" + d.def); }
                    else _sm[d.name].defaultState = s;
                }
                if (_abort) { Revert("default states"); return; }

                // 7) rebuild all 50 transitions (order preserved => Mecanim evaluation priority preserved)
                BuildTransitions();
                if (_abort) { Revert("transition build (added " + _added + " before failure)"); return; }

                LogBreakdown("after build");

                int afterTr = CountAllTransitions();
                if (afterTr != 50 || _added != 50)
                {
                    Debug.LogError("[RebuildAM] ABORT: transition count mismatch (built=" + _added +
                                   ", counted=" + afterTr + ", expected 50).");
                    Revert("count check");
                    return;
                }

                // 8) persist - Unity re-serializes the controller natively (embedded states +
                //    fixed m_OrderedTransitions)
                EditorUtility.SetDirty(_ctrl);
                AssetDatabase.SaveAssets();
                AssetDatabase.ImportAsset(kPath, ImportAssetOptions.ForceUpdate);
                AssetDatabase.Refresh();

                Debug.Log(string.Format(
                    "[RebuildAM] SUCCESS. Embedded {0} native states (target 27). Transitions {1} -> {2} (target 50). " +
                    "States {3} (target 27). StateMachines {4} (target 8). AnyState {5} (target 6). " +
                    "Stripped {7} seeded Exit-Time conditions (expect ~50, one per transition). Saved + reimported '{6}'. " +
                    "Now Build the player and verify sharedassets0 path_id 751 (TOS 267 / 50 transitions / QUALIFIED names / " +
                    "NO stray exit-time on parameter transitions -> shop avatar aims).",
                    _embedded, beforeTr, afterTr, CountAllStates(), _sm.Count, CountAnyState(), kPath, _stripped));
            }
            catch (Exception ex)
            {
                Debug.LogError("[RebuildAM] EXCEPTION - reverting from disk, nothing saved.\n" + ex);
                Revert("exception");
            }
        }

        // ---------------------------------------------------------------------
        // structure discovery / verification
        // ---------------------------------------------------------------------
        static void CollectSM(StateMachine sm)
        {
            if (sm == null) return;
            string nm = sm.name;
            if (!string.IsNullOrEmpty(nm) && !_sm.ContainsKey(nm)) _sm[nm] = sm;
            for (int i = 0; i < sm.stateMachineCount; i++)
                CollectSM(sm.GetStateMachine(i));
        }

        static bool VerifyStructure()
        {
            _st = new Dictionary<string, Dictionary<string, State>>();
            List<string> problems = new List<string>();

            List<string> layerNames = new List<string>();
            for (int i = 0; i < _ctrl.layerCount; i++) layerNames.Add(_ctrl.GetLayer(i).name);
            foreach (string ln in kLayers)
                if (!layerNames.Contains(ln)) problems.Add("missing layer '" + ln + "'");
            if (_ctrl.layerCount != 3)
                problems.Add("expected 3 layers, found " + _ctrl.layerCount);

            foreach (SMDef d in kSMs)
            {
                if (!_sm.ContainsKey(d.name)) { problems.Add("missing state machine '" + d.name + "'"); continue; }
                StateMachine sm = _sm[d.name];

                Dictionary<string, State> map = new Dictionary<string, State>();
                List<string> actual = new List<string>();
                for (int i = 0; i < sm.stateCount; i++)
                {
                    State s = sm.GetState(i);
                    if (s == null) { problems.Add("SM '" + d.name + "' has a null state at index " + i); continue; }
                    if (!map.ContainsKey(s.name)) map[s.name] = s;
                    actual.Add(s.name);
                }
                _st[d.name] = map;

                foreach (string want in d.states)
                    if (!map.ContainsKey(want)) problems.Add("SM '" + d.name + "' MISSING state '" + want + "'");
                foreach (string got in actual)
                    if (Array.IndexOf(d.states, got) < 0) problems.Add("SM '" + d.name + "' has UNEXPECTED state '" + got + "'");
            }

            if (problems.Count > 0)
            {
                Debug.LogError("[RebuildAM] Structure verification FAILED (" + problems.Count + " issue(s)):\n - " +
                               string.Join("\n - ", problems.ToArray()));
                return false;
            }
            return true;
        }

        // ---------------------------------------------------------------------
        // NATIVE re-embed of states (the shop/weapon-pose fix)
        // ---------------------------------------------------------------------
        static string Key(string sm, string st) { return sm + " :: " + st; }

        // Harvest motion/tag/flags from the imported (external) states before removal.
        static void CaptureStates()
        {
            _cap = new Dictionary<string, Cap>();
            foreach (SMDef d in kSMs)
            {
                foreach (string sn in d.states)
                {
                    State s = FindState(d.name, sn);
                    if (s == null) { Fail("capture: state not found " + d.name + "/" + sn); return; }
                    Cap c = new Cap();
                    UnityEngine.Motion mo = s.GetMotion();
                    c.motion = mo;
                    c.hadMotion = (mo != null);
                    c.tag = s.tag;
                    c.ik = s.iKOnFeet;
                    c.mirror = s.mirror;
                    c.speed = s.speed;
                    _cap[Key(d.name, sn)] = c;
                }
            }
            Debug.Log("[RebuildAM] Captured " + _cap.Count + " states (motion+tag+flags) from external .state assets.");
        }

        // Remove every direct state from all 8 SMs (child sub-SM objects are untouched).
        static void RemoveAllStates()
        {
            foreach (KeyValuePair<string, StateMachine> kv in _sm)
            {
                StateMachine sm = kv.Value;
                List<State> existing = new List<State>();
                for (int i = 0; i < sm.stateCount; i++) existing.Add(sm.GetState(i));
                for (int i = 0; i < existing.Count; i++)
                    if (existing[i] != null) sm.RemoveState(existing[i]);
            }
        }

        // Re-create each state via AddState (embedded, native, parent set) and re-attach
        // the captured motion (incl. blend trees, via reflected SetMotionInternal) + tag/flags.
        static void RebuildStatesNative()
        {
            _st = new Dictionary<string, Dictionary<string, State>>();
            foreach (SMDef d in kSMs)
            {
                StateMachine sm = _sm[d.name];
                Dictionary<string, State> map = new Dictionary<string, State>();
                foreach (string sn in d.states)
                {
                    State ns = sm.AddState(sn);
                    if (ns == null) { Fail("re-embed: AddState returned null for " + d.name + "/" + sn); return; }
                    if (ns.name != sn)
                    {
                        Fail("re-embed: AddState renamed '" + sn + "' to '" + ns.name + "' in SM '" + d.name +
                             "' (name collision?). Aborting to avoid a mislabeled state.");
                        return;
                    }
                    // The correctness guard for the qualified-name fix: the new state must be OWNED
                    // by this SM (parent pointer set). This is what makes the build bake
                    // "Sniper.Gun Aimed" instead of a colliding bare "Gun Aimed". Timing-independent
                    // (set by AddState), unlike the uniqueName string.
                    if (ns.stateMachine != sm)
                    {
                        Fail("re-embed: new state '" + d.name + "/" + sn + "' is not owned by its state machine " +
                             "(parent pointer not set) - qualified names would not bake. Aborting.");
                        return;
                    }

                    Cap c;
                    if (!_cap.TryGetValue(Key(d.name, sn), out c)) { Fail("re-embed: no capture for " + d.name + "/" + sn); return; }

                    if (c.hadMotion)
                    {
                        try { _setMotion.Invoke(ns, new object[] { c.motion }); }
                        catch (Exception e) { Fail("re-embed: SetMotionInternal threw for " + d.name + "/" + sn + ": " + e.Message); return; }
                        if (ns.GetMotion() == null)
                        {
                            Fail("re-embed: motion LOST for " + d.name + "/" + sn + " (blend tree not re-attached). Aborting.");
                            return;
                        }
                    }

                    ns.tag = c.tag;
                    ns.iKOnFeet = c.ik;
                    ns.mirror = c.mirror;
                    ns.speed = c.speed;

                    map[sn] = ns;
                    _embedded++;
                }
                _st[d.name] = map;
            }
            Debug.Log("[RebuildAM] Re-embedded " + _embedded + " native states with preserved motion/tag.");
        }

        // Diagnostic only (correctness is enforced by the parent-pointer check in RebuildStatesNative):
        // log each embedded state's uniqueName + how many are distinct, so qualification is visible
        // in the Console pre-build. In-editor uniqueName may be lazy, so this NEVER aborts.
        static void LogQualifiedNames()
        {
            HashSet<string> seen = new HashSet<string>();
            int qualified = 0;
            string dump = "[RebuildAM] embedded-state uniqueNames (want qualified + distinct):";
            foreach (SMDef d in kSMs)
            {
                foreach (string sn in d.states)
                {
                    string un = _st[d.name][sn].uniqueName;
                    dump += "\n   " + d.name + "/" + sn + " -> '" + un + "'";
                    seen.Add(un);
                    if (!string.IsNullOrEmpty(un) && un != sn && un.EndsWith("." + sn)) qualified++;
                }
            }
            Debug.Log(dump);
            Debug.Log("[RebuildAM] uniqueNames: " + qualified + "/27 look qualified, " + seen.Count +
                      "/27 distinct (parent pointers already verified, so the build will bake qualified names).");
        }

        // ---------------------------------------------------------------------
        // parameters
        // ---------------------------------------------------------------------
        static void EnsureParameters()
        {
            Dictionary<string, AnimatorControllerParameter> have = new Dictionary<string, AnimatorControllerParameter>();
            for (int i = 0; i < _ctrl.parameterCount; i++)
            {
                AnimatorControllerParameter p = _ctrl.GetParameter(i);
                if (p != null && !have.ContainsKey(p.name)) have[p.name] = p;
            }
            foreach (PDef pd in kParams)
            {
                if (have.ContainsKey(pd.name)) continue;
                AnimatorControllerParameter np = _ctrl.AddParameter(pd.name, pd.type);
                if (np == null) { Fail("could not add parameter '" + pd.name + "'"); return; }
                np.defaultFloat = pd.f;
                np.defaultInt = pd.i;
                np.defaultBool = pd.b;
                Debug.LogWarning("[RebuildAM] Added missing parameter '" + pd.name + "' (" + pd.type + ").");
            }
        }

        // ---------------------------------------------------------------------
        // transition clearing / counting (PUBLIC API only)
        //   GetTransitionsFromState(state) -> that state's outgoing transitions
        //   GetTransitionsFromState(null)  -> AnyState transitions (Unity's own
        //                                     StateMachine.transitions getter does this)
        //
        // IMPORTANT: GetTransitionsFromState(null) on a NESTED sub-SM returns the
        // SAME AnyState transition objects INHERITED from its ancestor SMs. So the
        // 6 real AnyState objects (1 in Base, 5 in Weapons) are visible from Base+Swim
        // and from Weapons+its 4 children respectively. Every count/collect below
        // therefore dedupes by GetInstanceID() so each !u!1101 object is tallied ONCE
        // (matching the baseline's "count each transition once" definition = 50).
        // RemoveTransition is idempotent on an already-removed object, so clearing an
        // inherited transition twice is harmless.
        // ---------------------------------------------------------------------
        static void ClearTransitions(StateMachine sm)
        {
            for (int i = 0; i < sm.stateCount; i++)
            {
                Transition[] arr = sm.GetTransitionsFromState(sm.GetState(i));
                if (arr != null)
                    for (int j = 0; j < arr.Length; j++) sm.RemoveTransition(arr[j]);
            }
            Transition[] any = sm.GetTransitionsFromState(null);
            if (any != null)
                for (int j = 0; j < any.Length; j++) sm.RemoveTransition(any[j]);
        }

        // Distinct transition instances across every SM (dedupes inherited AnyState).
        static int CountAllTransitions()
        {
            HashSet<int> seen = new HashSet<int>();
            foreach (KeyValuePair<string, StateMachine> kv in _sm)
            {
                StateMachine sm = kv.Value;
                for (int i = 0; i < sm.stateCount; i++)
                {
                    Transition[] arr = sm.GetTransitionsFromState(sm.GetState(i));
                    if (arr != null)
                        for (int j = 0; j < arr.Length; j++)
                            if (arr[j] != null) seen.Add(arr[j].GetInstanceID());
                }
                Transition[] any = sm.GetTransitionsFromState(null);
                if (any != null)
                    for (int j = 0; j < any.Length; j++)
                        if (any[j] != null) seen.Add(any[j].GetInstanceID());
            }
            return seen.Count;
        }

        // Distinct AnyState transition instances across every SM (dedupes inheritance).
        static int CountAnyState()
        {
            HashSet<int> seen = new HashSet<int>();
            foreach (KeyValuePair<string, StateMachine> kv in _sm)
            {
                Transition[] any = kv.Value.GetTransitionsFromState(null);
                if (any != null)
                    for (int j = 0; j < any.Length; j++)
                        if (any[j] != null) seen.Add(any[j].GetInstanceID());
            }
            return seen.Count;
        }

        // Diagnostic: raw per-SM GetTransitionsFromState counts (shows the inherited
        // AnyState over-report) alongside the deduped totals.
        static void LogBreakdown(string phase)
        {
            string msg = "[RebuildAM] Per-SM breakdown (" + phase + "), RAW GetTransitionsFromState counts:";
            foreach (SMDef d in kSMs)
            {
                StateMachine sm = _sm[d.name];
                int st = 0;
                for (int i = 0; i < sm.stateCount; i++)
                {
                    Transition[] a = sm.GetTransitionsFromState(sm.GetState(i));
                    if (a != null) st += a.Length;
                }
                Transition[] any = sm.GetTransitionsFromState(null);
                int an = (any != null) ? any.Length : 0;
                msg += "\n   " + d.name + ": stateTr=" + st + " anyStateRaw=" + an + " (raw=" + (st + an) + ")";
            }
            msg += "\n   => DEDUPED distinct transitions=" + CountAllTransitions() + " (target 50)" +
                   ", DEDUPED AnyState=" + CountAnyState() + " (target 6)";
            Debug.Log(msg);
        }

        static int CountAllStates()
        {
            int n = 0;
            foreach (KeyValuePair<string, StateMachine> kv in _sm) n += kv.Value.stateCount;
            return n;
        }

        // ---------------------------------------------------------------------
        // transition construction
        // ---------------------------------------------------------------------
        static StateMachine GetSM(string name)
        {
            return (_sm != null && _sm.ContainsKey(name)) ? _sm[name] : null;
        }

        static State FindState(string smName, string stateName)
        {
            if (_st != null && _st.ContainsKey(smName) && _st[smName].ContainsKey(stateName))
                return _st[smName][stateName];
            return null;
        }

        static Cond C(M mode, string param, float thr, float exit)
        {
            Cond c = new Cond();
            c.mode = mode; c.param = param; c.thr = thr; c.exit = exit;
            return c;
        }

        // srcState == null  =>  AnyState transition
        static void Tr(string srcSM, string srcState, string dstSM, string dstState,
                       float dur, float off, bool atom, params Cond[] conds)
        {
            if (_abort) return;

            StateMachine ssm = GetSM(srcSM);
            State dst = FindState(dstSM, dstState);
            if (ssm == null) { Fail("Tr: source SM '" + srcSM + "' not found"); return; }
            if (dst == null) { Fail("Tr: destination state '" + dstSM + "/" + dstState + "' not found"); return; }

            Transition t;
            if (srcState == null)
            {
                t = ssm.AddAnyStateTransition(dst);
            }
            else
            {
                State src = FindState(srcSM, srcState);
                if (src == null) { Fail("Tr: source state '" + srcSM + "/" + srcState + "' not found"); return; }
                t = ssm.AddTransition(src, dst);
            }
            if (t == null)
            {
                Fail("Tr: Add(AnyState)Transition returned null for " + srcSM + " " +
                     (srcState == null ? "ANY" : srcState) + " -> " + dstSM + "/" + dstState);
                return;
            }

            t.duration = dur;
            t.offset = off;
            t.atomic = atom;
            t.solo = false;
            t.mute = false;
            t.canTransitionToSelf = true;

            // Remove Unity's seeded default Exit-Time condition BEFORE adding the blueprint's,
            // so the baked m_ConditionConstantArray matches the shipped controller exactly.
            StripSeededConditions(t, srcSM, srcState, dstState);
            if (_abort) return;

            for (int i = 0; i < conds.Length; i++)
            {
                Cond c = conds[i];
                AnimatorCondition ac = t.AddCondition();
                if (ac == null) { Fail("Tr: AddCondition returned null on " + srcSM + " -> " + dstState); return; }
                ac.mode = c.mode;
                ac.parameter = c.param;
                ac.threshold = c.thr;
                ac.exitTime = c.exit;
            }

            _added++;
        }

        // Strip whatever conditions Unity seeded onto a freshly-created transition (normally a single
        // default Exit-Time condition). Uses the public 4.6.5 index API: RemoveCondition(0) removes the
        // first condition and shifts the rest down, so repeating until conditionCount==0 clears them all.
        // Guarded against an infinite loop; asserts the strip took effect (aborts rather than bake stray
        // exit-times).
        static void StripSeededConditions(Transition t, string srcSM, string srcState, string dstState)
        {
            int guard = 0;
            while (t.conditionCount > 0 && guard < 32)
            {
                t.RemoveCondition(0);
                _stripped++;
                guard++;
            }
            if (t.conditionCount != 0)
                Fail("StripSeededConditions: " + srcSM + "/" + (srcState ?? "ANY") + " -> " + dstState +
                     " still has " + t.conditionCount + " seeded condition(s) after strip.");
        }

        static void BuildTransitions()
        {
            // ---- Base ---- (18)
            Tr("Base", null, "Base", "JumpIdle", 0.009307321f, 0.0f, true, C(M.If, "IsJumping", 0.0f, 0.0f));
            Tr("Base", "Locomotion", "Base", "TurnR45", 0.038342405f, 0.0f, false, C(M.If, "IsTurningRight", 0.0f, 0.0f));
            Tr("Base", "Locomotion", "Base", "TurnL45", 0.03717339f, 0.0f, false, C(M.If, "IsTurningLeft", 0.0f, 0.0f));
            Tr("Base", "Locomotion", "Swim", "SwimIdle", 0.12773721f, 0.0f, true, C(M.If, "IsSwimming", 0.0f, 0.0f));
            Tr("Base", "Locomotion", "Base", "Crouch", 0.011577468f, 0.0f, false, C(M.If, "IsSquatting", 0.0f, 0.0f), C(M.If, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "Locomotion", "Base", "CrouchingIdle", 0.01660721f, 0.0f, false, C(M.If, "IsSquatting", 0.0f, 0.0f), C(M.IfNot, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "Crouch", "Base", "Locomotion", 0.06079725f, 1.43050585e-08f, false, C(M.IfNot, "IsSquatting", 0.0f, 0.0f));
            Tr("Base", "Crouch", "Swim", "SwimIdle", 0.21802326f, 0.0f, true, C(M.If, "IsSwimming", 0.0f, 0.0f));
            Tr("Base", "Crouch", "Base", "CrouchingIdle", 0.25f, 0.0f, true, C(M.IfNot, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "TurnR45", "Base", "Locomotion", 0.125f, 0.0f, true, C(M.ExitTime, "", 0.0f, 0.875f));
            Tr("Base", "TurnR45", "Base", "Locomotion", 0.14524442f, 0.0f, true, C(M.If, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "TurnL45", "Base", "Locomotion", 0.21428572f, 0.0f, true, C(M.ExitTime, "", 0.0f, 0.78571427f));
            Tr("Base", "TurnL45", "Base", "Locomotion", 0.17528293f, 0.0f, true, C(M.If, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "JumpIdle", "Base", "JumpIdleFall", 0.18619166f, 0.39572278f, false, C(M.ExitTime, "", 0.0f, 0.73978907f));
            Tr("Base", "JumpIdleFall", "Base", "Locomotion", 0.034495126f, 0.0f, false, C(M.If, "IsGrounded", 0.0f, 0.0f));
            Tr("Base", "CrouchingIdle", "Base", "Locomotion", 0.10273972f, 0.0f, false, C(M.IfNot, "IsSquatting", 0.0f, 0.0f));
            Tr("Base", "CrouchingIdle", "Base", "Crouch", 0.10273972f, 0.0f, false, C(M.If, "IsWalking", 0.0f, 0.0f));
            Tr("Base", "CrouchingIdle", "Swim", "SwimIdle", 0.10273972f, 0.0f, false, C(M.If, "IsSwimming", 0.0f, 0.0f));

            // ---- Swim ---- (1)
            Tr("Swim", "SwimIdle", "Base", "Locomotion", 0.03679016f, 0.015485563f, true, C(M.IfNot, "IsSwimming", 0.0f, 0.0f));

            // ---- Weapons ---- (5 AnyState)
            Tr("Weapons", null, "Melee Weapon", "ShopMeleeTakeOut", 0.1f, 0.0f, false, C(M.Equals, "WeaponClass", 1.0f, 0.0f), C(M.If, "WeaponSwitch", 0.0f, 0.0f));
            Tr("Weapons", null, "ShotGun", "ShopShotGunTakeOut", 0.049166657f, 0.0f, false, C(M.If, "WeaponSwitch", 0.0f, 0.0f), C(M.Equals, "WeaponClass", 4.0f, 0.0f));
            Tr("Weapons", null, "Heavy Weapon", "ShopLargeGunTakeOut", 0.04437832f, 0.046653964f, false, C(M.If, "WeaponSwitch", 0.0f, 0.0f), C(M.Equals, "WeaponClass", 3.0f, 0.0f));
            Tr("Weapons", null, "Sniper", "ShopSmallGunTakeOut", 0.025753854f, 0.0f, false, C(M.If, "WeaponSwitch", 0.0f, 0.0f), C(M.Equals, "WeaponClass", 2.0f, 0.0f));
            Tr("Weapons", null, "Weapons", "No Weapons", 0.1f, 0.0f, true, C(M.If, "WeaponSwitch", 0.0f, 0.0f), C(M.Equals, "WeaponClass", 0.0f, 0.0f));

            // ---- Sniper ---- (4)
            Tr("Sniper", "ShopSmallGunTakeOut", "Sniper", "Shooting", 0.011751919f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));
            Tr("Sniper", "ShopSmallGunTakeOut", "Sniper", "Gun Aimed", 0.35857147f, 0.0f, false, C(M.ExitTime, "", 0.0f, 0.5943312f));
            Tr("Sniper", "Shooting", "Sniper", "Gun Aimed", 0.20853676f, 1.0f, false, C(M.ExitTime, "", 0.0f, 0.45651525f));
            Tr("Sniper", "Gun Aimed", "Sniper", "Shooting", 0.38486692f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));

            // ---- Melee Weapon ---- (4)
            Tr("Melee Weapon", "Melee", "Melee Weapon", "Shooting", 0.055955242f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));
            Tr("Melee Weapon", "ShopMeleeTakeOut", "Melee Weapon", "Shooting", 0.625f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));
            Tr("Melee Weapon", "ShopMeleeTakeOut", "Melee Weapon", "Melee", 0.22521582f, 0.0f, false, C(M.ExitTime, "", 0.0f, 0.0f));
            Tr("Melee Weapon", "Shooting", "Melee Weapon", "Melee", 0.22061808f, 0.007669248f, true, C(M.ExitTime, "", 0.0f, 0.62119204f));

            // ---- Heavy Weapon ---- (4)
            Tr("Heavy Weapon", "ShopLargeGunTakeOut", "Heavy Weapon", "Shooting", 0.01610054f, 0.32801804f, true, C(M.If, "IsShooting", 0.0f, 0.0f));
            Tr("Heavy Weapon", "ShopLargeGunTakeOut", "Heavy Weapon", "Gun Aimed", 0.11531653f, 0.0f, false, C(M.ExitTime, "", 0.0f, 0.5012773f));
            Tr("Heavy Weapon", "Shooting", "Heavy Weapon", "Gun Aimed", 0.35515743f, 0.34696567f, true, C(M.IfNot, "IsShooting", 0.0f, 0.0f));
            Tr("Heavy Weapon", "Gun Aimed", "Heavy Weapon", "Shooting", 0.06438475f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));

            // ---- ShotGun ---- (4)
            Tr("ShotGun", "ShopShotGunTakeOut", "ShotGun", "Shooting", 0.02447725f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));
            Tr("ShotGun", "ShopShotGunTakeOut", "ShotGun", "Gun Aimed", 0.17651215f, 0.010692238f, false, C(M.ExitTime, "", 0.0f, 0.6341579f));
            Tr("ShotGun", "Shooting", "ShotGun", "Gun Aimed", 0.12798636f, 0.0f, true, C(M.ExitTime, "", 0.0f, 0.8720136f));
            Tr("ShotGun", "Gun Aimed", "ShotGun", "Shooting", 0.0f, 0.0f, true, C(M.If, "IsShooting", 0.0f, 0.0f));

            // ---- Shop ---- (10)
            Tr("Shop", "Idle", "Shop", "ShopNewGloves", 0.11027796f, 0.0f, true, C(M.Equals, "GearType", 2.0f, 0.0f));
            Tr("Shop", "Idle", "Shop", "ShopNewUpperBody", 0.044921294f, 0.0f, true, C(M.Equals, "GearType", 3.0f, 0.0f));
            Tr("Shop", "Idle", "Shop", "ShopNewBoots", 0.036898904f, 0.0f, true, C(M.Equals, "GearType", 5.0f, 0.0f));
            Tr("Shop", "Idle", "Shop", "ShopNewLowerBody", 0.07303191f, 0.0f, true, C(M.Equals, "GearType", 4.0f, 0.0f));
            Tr("Shop", "Idle", "Shop", "ShopNewHead", 0.04744006f, 0.0f, true, C(M.Equals, "GearType", 1.0f, 0.0f));
            Tr("Shop", "ShopNewGloves", "Shop", "Idle", 0.103310816f, 0.082905084f, true, C(M.ExitTime, "", 0.0f, 0.43493822f));
            Tr("Shop", "ShopNewUpperBody", "Shop", "Idle", 0.12361071f, 0.022381501f, true, C(M.ExitTime, "", 0.0f, 0.6657658f));
            Tr("Shop", "ShopNewBoots", "Shop", "Idle", 1.0f, 0.0f, true, C(M.ExitTime, "", 0.0f, 0.27513015f));
            Tr("Shop", "ShopNewLowerBody", "Shop", "Idle", 0.07911392f, 0.0f, true, C(M.ExitTime, "", 0.0f, 0.9208861f));
            Tr("Shop", "ShopNewHead", "Shop", "Idle", 0.46389008f, 0.14672492f, true, C(M.ExitTime, "", 0.0f, 0.7807905f));
        }

        // ---------------------------------------------------------------------
        static void Fail(string msg)
        {
            _abort = true;
            Debug.LogError("[RebuildAM] " + msg);
        }

        // Discard in-memory edits by re-importing the untouched asset from disk.
        static void Revert(string where)
        {
            Debug.LogError("[RebuildAM] ABORT during " + where + ". Reverting controller from disk; NOTHING saved.");
            try { AssetDatabase.ImportAsset(kPath, ImportAssetOptions.ForceUpdate); }
            catch (Exception e) { Debug.LogError("[RebuildAM] revert reimport failed: " + e.Message); }
        }
    }
}
