#pragma once

/**
	Skills: the skill tree (points -> active skill), what each active skill
	does, and the values of a few skills kept in their own tables.
	Layouts from ezemania2/mhf-file-editor; counts, ends and values checked on
	the ZZ JP and EN files (213 trees, 382 effect rows, 28 vampirism rows; the
	tables end at zero padding). Active skill ids are those of mhfpac.bin.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Skill tree (header 0xEC): ends at a tree id of -1
// =======================

struct SkillTreeLevel {
    s16 points;
    s16 skill               [[comment("Active skill id (mhfpac)")]];
};

// The first 3 levels are the negative side (points <= their points), the last
// 5 the positive one (points >= theirs); a tree with fewer repeats a level.
struct SkillTree {
    s16 tree;
    SkillTreeLevel levels[8];
} [[name(std::format("Tree {}", tree))]];

SkillTree skillTree[while(std::mem::read_signed($, 2) != -1)]
    @ header.ptrs.skillTree
    [[name("Skill Tree")]];

// =======================
// Effects of the active skills (header 0x594), u16 count at +2 of the block
// header 0x988 points to. The client indexes them by skill id (ids below
// 0x217): the rows of a skill must follow each other.
// =======================

struct SkillEffect {
    u32 skill               [[comment("Active skill id (mhfpac)")]];
    u32 type;
    u32 effect;
    s32 value;
    s32 min;
    s32 max;
    u32 unused;
} [[name(std::format("Skill {}", skill))]];

SkillEffect skillEffects[std::mem::read_unsigned(header.ptrs.skillCounts + 2, 2)]
    @ header.ptrs.skillEffects
    [[name("Skill Effects")]];

// =======================
// Vampirism (header 0x7A0): row = weapon class * 2 + tier, u16 count at +4 of
// the block header 0x988 points to
// =======================

struct VampirismRow {
    u8 heal                 [[comment("Percent")]];
    u8 chance               [[comment("Percent")]];
};

VampirismRow vampirism[std::mem::read_unsigned(header.ptrs.skillCounts + 4, 2)]
    @ header.ptrs.vampirism
    [[name("Vampirism")]];

// =======================
// Crit Conversion: the first 8 bytes of the block header 0xA1C points to (the
// rest belongs to other systems)
// =======================

struct CritConversion {
    u16 rate[2];
    u16 affinity[2];
};

CritConversion critConversion @ header.ptrs.critConversion [[name("Crit Conversion")]];

// =======================
// Rush (skill 516): the gauge thresholds at +0x64 of the block header 0x648
// points to; Rush UP's stage 3 behind the pointer at +4 of the cell header
// 0xB94 points to
// =======================

s32 rushThresholds[2] @ header.ptrs.skillParams + 0x64 [[name("Rush Gauge Thresholds")]];

struct RushUpStage3 {
    s16 bonus;
    padding[2];
    s32 threshold;
    float timer;
};

RushUpStage3 rushUpStage3 @ std::mem::read_unsigned(header.ptrs.skillCells + 4, 4) [[name("Rush UP Stage 3")]];

// =======================
// Obscurity (skill 514, header 0xAA0) and Obscurity UP, its Zenith version
// (header 0xB78): values per weapon class. Obscurity UP's stack values hold
// the attack of each stack of each class, one class after the other (as many
// as its most stacks); the most stacks add up to 48 on ZZ, the room the list
// has. The Obscurity block also holds the Switch Axe F guard sigil (0x61,
// value 2): a wider guard angle, and a heal of the guarded damage x 0.001
// with a minimum.
// =======================

struct PerClass {
    s16 values[14];
};

struct Obscurity {
    PerClass *attackPerStack : u32;
    PerClass *maxStacks : u32;
    s16 stackDelay;
    s16 unk0A;
    u16 safGuardAngleBonus;
    s16 safGuardHealPermille;
    s16 safGuardHealMin;
    s16 unk12;
};

Obscurity obscurity @ header.ptrs.obscurity [[name("Obscurity")]];

fn sumOfMaxStacks(u32 at) {
    s32 total = 0;
    u32 i = 0;
    while (i < 14) {
        total += std::mem::read_signed(at + i * 2, 2);
        i += 1;
    }
    return total;
};

s16 obscurityUpStackValues[sumOfMaxStacks(std::mem::read_unsigned(header.ptrs.obscurityUp + 4, 4))]
    @ std::mem::read_unsigned(header.ptrs.obscurityUp, 4)
    [[name("Obscurity UP Stack Values")]];
PerClass obscurityUpMaxStacks @ std::mem::read_unsigned(header.ptrs.obscurityUp + 4, 4) [[name("Obscurity UP Max Stacks")]];
PerClass obscurityUpSharpness @ std::mem::read_unsigned(header.ptrs.obscurityUp + 8, 4) [[name("Obscurity UP Sharpness")]];
PerClass obscurityUpSharpnessAlt @ std::mem::read_unsigned(header.ptrs.obscurityUp + 12, 4) [[name("Obscurity UP Sharpness (alt)")]];

// =======================
// Furious (skill 529): behind the pointer at +0 of the cell header 0xB94
// points to. The bonuses of stages 1 to 3, the gauge thresholds of stages 0
// to 3 (the last is the cap), the attack gauge scale per weapon class and
// what an evade or a guard adds (3 tables, picked by the caller).
// =======================

struct FuriousStagesI16 {
    s16 stages[3];
};

struct FuriousStagesF32 {
    float stages[3];
};

struct FuriousThresholds {
    s32 stages[4];
};

struct Furious {
    FuriousStagesI16 *attack : u32;
    FuriousStagesI16 *affinity : u32 [[comment("Percent")]];
    FuriousStagesF32 *elementMultiplier : u32;
    FuriousStagesF32 *statusMultiplier : u32;
    FuriousThresholds *attackGaugeThresholds : u32;
    FuriousThresholds *evadeGuardGaugeThresholds : u32;
    PerClass *attackGaugeScale : u32;
    PerClass *evadeGuardGain0 : u32;
    PerClass *evadeGuardGain1 : u32;
    PerClass *evadeGuardGain2 : u32;
    float *unk28[8] : u32;
    s16 maxStage;
    s16 unk2E;
    s32 unk30;
    s32 unk34                   [[comment("A minimum attack gauge gain for weapon classes 1 and 5")]];
};

Furious furious @ std::mem::read_unsigned(header.ptrs.skillCells, 4) [[name("Furious")]];

// Skill bonus values (header 0xAA4). "Zenith effect N" = the player has a
// zenith skill whose mhfdat 0xAB0 rows hold effect type N
// (skill_is_granted_by_equipped_gear). Frames are at 30 per second.
struct SkillBonusValues {
	u16 *vampirismAttackGain[14] : u32 [[comment("Vampirism proc: attack added per weapon class (skill_vampirism_apply_attack_buff)")]];
	u16 vampirismAttackCap [[comment("cap of that attack stack; the proc effect turns red at it")]];
	u16 incitementAttack [[comment("Incitement (skill 0x1D7) active: attack added (player_recalc_attack_power_full)")]];
	u16 critConversionUp1Scale [[comment("zenith effect 7 (C. Conversion Up+1): x 0.001 x sqrt(affinity) attack")]];
	u16 critConversionUp2Scale [[comment("zenith effect 8 (C. Conversion Up+2)")]];
	u16 stylishAssaultUp1AttackPerStack [[comment("zenith effect 9 (S. Assault Up+1): attack per stack above the first")]];
	u16 stylishAssaultUp1StackLimit [[comment("zenith effect 9: stacks cap at this + 1")]];
	u16 stylishAssaultUp2AttackPerStack [[comment("zenith effect 10 (S. Assault Up+2)")]];
	u16 stylishAssaultUp2StackLimit [[comment("zenith effect 10: stacks cap at this + 1")]];
	u16 dissolverUpThresholdCut [[comment("zenith effect 11 (Dissolver Up): lowers the elemental exploit threshold (player unique param +0x10)")]];
	u16 thunderCladUp1Frames [[comment("zenith effect 12 (Thunder Clad Up+1): frames added")]];
	u16 thunderCladUp2Frames [[comment("zenith effect 13 (Thunder Clad Up+2)")]];
	u16 iceAgeUp1Frames [[comment("zenith effect 14 (Ice Age Up): frames added")]];
	u16 iceAgeUp2Frames [[comment("zenith effect 15 (Ice Age Up, second)")]];
	u8  vampirismUpHealChance [[comment("zenith effect 16 (Vampirism Up+1 / +2): heal chance percent added (player_lifesteal_on_hit)")]];
	u8  unk1F;
	float safChargeMoveScale [[comment("SAF sigil 0x61 value 3: root motion scale while charging (motions 0x5D1, 0x428)")]];
};

SkillBonusValues skillBonusValues @ header.ptrs.skillBonusValues [[name("Skill Bonus Values")]];

// Header 0xB88: two pointers. The first goes to the Spacing gauge parameters
// (skill_spacing_accumulate_gauge, FUN_101C5300, FUN_101C5680, FUN_101C5900;
// nested pointer tables, not typed yet). The second to 4 values:
// - soulAttack: attack added with zenith effect 26 (Soul Up) and Red Soul
//   (skill 0x1CA), or with render slot status bit 0x800000
//   (player_recalc_attack_power_basic / _full);
// - soulDefense: defense added with Blue Soul (skill 0x1CB)
//   (player_recalc_defense_value_basic / _full);
// - autoRecoverySeconds: with render slot status bit 0x400000, the auto
//   recovery timer is set to this x 30 frames (player_entity_tick_hp_regen);
// - unk06: read by FUN_101C5B70 after a distance check between two players.
struct SoulValues {
	s16 soulAttack;
	s16 soulDefense;
	s16 autoRecoverySeconds;
	s16 unk06;
};

struct SpacingAndSoulValues {
	u32 spacingParams;
	SoulValues *soulValues : u32;
};

SpacingAndSoulValues spacingAndSoulValues @ header.ptrs.spacingAndSoulValues [[name("Spacing And Soul Values")]];

// Header 0x9B0: parameters of skills 0x1EE-0x1F1 (Thunder Clad, Status
// Pursuit, Drawing Arts+1 / +2). Tables "by class" have one u16 per weapon
// class (player +0x03). Skill id lists end on 0x217.
// - Thunder Clad: the gauge (SkillWork +0x544) fills on hits (hitGain x
//   FUN_10A66980, on_hit_effects_dispatch), when a hit is evaded (evadeGain,
//   hit iframe flag 0x08, skill_thunder_clad_evade_gain), and while the
//   player moves outside the listed actions
//   (moveGain, skill_thunder_clad_move_gain); at gaugeMax it activates (flag 4) for
//   durationSeconds x 30 frames plus the zenith frames
//   (zenith_thunder_clad_frames_add). While active: the attack reach bonus is
//   at least activeReachBonus (player_attack_reach_bonus_max), the listed
//   skills count as active (player_buff_id_is_active), and each hit adds
//   statusGaugeAdd to the three status gauges (skill 0x1EE branch of
//   player_trigger_status_pursuit_effect).
// - Drawing Arts+1 / +2 (SkillWork +0x684 flags 1 / 2, set on weapon draw):
//   the listed skills count as active; the query byte +0x12 picks list A or B.
// - Status Pursuit (skill 0x1EF; hit status bits as in mhfsdt StatusMask:
//   0x1 sleep, 0x2 poison, 0x4 paralysis): bonus damage = (add + the hit's
//   status value) x rate / 1000 for a poison hit on a monster with +0x890 > 0,
//   or a paralysis hit on a monster with +0x828 = 4
//   (skill_status_pursuit_bonus_damage); a sleep hit on a monster with +0x828
//   = 2 adds gaugeAdd to the three status gauges
//   (player_trigger_status_pursuit_effect).
struct ThunderCladActionPair {
	u8 playerByte15;
	u8 playerByte14;
};

struct ThunderCladExcludedActions {
	ThunderCladActionPair pairs[while(std::mem::read_signed($, 1) != -1)];
	s8 end;
};

struct ThunderCladParams {
	float activeReachBonus;
	s32 gaugeMax;
	u16 durationSeconds;
	u16 statusGaugeAdd;
	ThunderCladExcludedActions *excludedActions : u32;
	u16 *hitGainByClass[14] : u32;
	u16 *evadeGainByClass[14] : u32;
	u16 *moveGainByClass[14] : u32;
};

struct SkillIdList {
	u16 skills[while(std::mem::read_unsigned($, 2) != 0x217)];
	u16 end;
};

struct ThunderCladPursuitDrawingArts {
	ThunderCladParams *thunderClad : u32;
	SkillIdList *thunderCladSkills : u32;
	SkillIdList *drawingArts1SkillsA : u32;
	SkillIdList *drawingArts1SkillsB : u32;
	SkillIdList *drawingArts2SkillsA : u32;
	SkillIdList *drawingArts2SkillsB : u32;
	u16 *statusPursuitPoisonAddByClass[14] : u32;
	u16 *statusPursuitParalysisAddByClass[14] : u32;
	u16 *statusPursuitGaugeAddByClass[14] : u32;
	u16 *statusPursuitPoisonRateByClass[14] : u32;
	u16 *statusPursuitParalysisRateByClass[14] : u32;
};

ThunderCladPursuitDrawingArts thunderCladPursuitDrawingArts @ header.ptrs.thunderCladPursuitDrawingArts [[name("Thunder Clad, Status Pursuit, Drawing Arts")]];

// Header 0xB90 (Otya unkB90): ten counts (u16), then ten pointers in the
// same order: a table of 83 s16 constants and nine id lists, all read by
// Magnet Spike (weapon class 13) code: MS action handlers (0x1032xxxx-
// 0x1033xxxx, ms_handler_table_a 0x11926B40), the MS skill work block
// (gSkillWorks + 0x1C0) and the Magnet Spike shells (kinds 120 / 121). "MS
// mode" = SkillWork +0x224 (0 / 1); "MS gauge" = SkillWork +0x23A. Each
// value names the code that reads it. The lists end on 0xC9 (201) or their
// count; actions are the player's +0x14 when +0x15 = 1.
struct MsEvadeDistance {
	s16 extraDistance;
	s16 startFrame;
	s16 endFrame;
};

struct MagnetSpikeValues {
	s16 msEvent12CameraShake0 [[comment("[0] MS event 12 (ms_event12_camera_shake, ms_handler_table_a +0x30): camera_shake_request kind when the event argument is not 1 or 2")]];
	s16 msEvent12CameraShake1 [[comment("[1] same, argument 1")]];
	s16 msEvent12CameraShake2 [[comment("[2] same, argument 2")]];
	s16 msSteerYawStepMode0 [[comment("[3] FUN_10332250, MS mode 0: max yaw step per frame when turning toward the input (FUN_10A697F0)")]];
	s16 msSteerDelayFramesMode0 [[comment("[4] mode 0: no turn while the SkillWork +0x4 counter is below it")]];
	s16 msSteerDeadZoneMode0 [[comment("[5] mode 0: dead zone, converted to yaw units")]];
	s16 msSteerYawStepMode1 [[comment("[6] same as msSteerYawStepMode0, MS mode 1")]];
	s16 msSteerDelayFramesMode1 [[comment("[7] mode 1")]];
	s16 msSteerDeadZoneMode1 [[comment("[8] mode 1")]];
	s16 msEvasionPlus1Frames [[comment("[9] Evasion+1 (0xB1) or Starving Wolf+1 (0xFB): MS dodge invulnerability frames added (player_dodge_invuln_frames_from_evasion_skill, from ms_ev_iframes_raise_evasion)")]];
	s16 msEvasionPlus2Frames [[comment("[10] Evasion+2 (0xB2) or Starving Wolf+2 (0xFC)")]];
	s16 msAimYawStepDefault [[comment("[11] FUN_103379D0: yaw step toward the target when the action has no cap in msAimYawCaps")]];
	s16 msMotionWindowStart [[comment("[12] FUN_1032B550: MS motions 0xCE / 0xD1 return 1 before this frame (+0x31C) or after msMotionWindowEnd")]];
	s16 msMotionWindowEnd [[comment("[13] motions 0xD7, 0x119, 0x11A, 0x120, 0x121 return 1 before it")]];
	s16 magnetNetShellLifetime [[comment("[14] FUN_1033B2F0 (Monster_NetSync_PacketRecv): lifetime of the record of the kind 121 shell spawned for a net-synced monster not in magnetNetShellExcludedMonsters")]];
	s16 msTargetMaxAngle [[comment("[15] find_nearest_valid_target (MS callers): max angle in degrees between the facing and the target")]];
	s16 magnetShellSpeed [[comment("[16] kind 121 (Magnet Spike) shell callbacks: FUN_101E8DE0 multiplies the launch velocity by it, FUN_101E9070 compares distance steps with it")]];
	s16 msGaugeMax [[comment("[17] MS gauge (SkillWork +0x23A) maximum (magnetspike_gauge_regen_tick, FUN_1033BEC0)")]];
	s16 msGaugeResetValue [[comment("[18] value the MS gauge is reset to (weapon_slot_record_reset_to_sentinel_defaults, FUN_1033B9C0)")]];
	s16 msGaugeUnitCost [[comment("[19] gauge spent per unit (magnetspike_gauge_spend_units, msActionGaugeCost units); an action needs gauge >= it (magnetspike_gauge_has)")]];
	s16 msGaugeRegen [[comment("[20] gauge added every msGaugeRegenIntervalFrames (magnetspike_gauge_regen_tick)")]];
	s16 msGaugeRegenIntervalFrames [[comment("[21] frames between two gauge regen steps")]];
	s16 msCameraBlendStep [[comment("[22] camera_main_update: MS camera blend counter step per frame (FUN_1081FB30)")]];
	s16 msCameraBlendFrames [[comment("[23] length of that blend (counter / it)")]];
	s16 msCameraPresetAct60 [[comment("[24] MS acts 0x60 / 0x63 with skill blob flag 0x10: camera preset value (FUN_1033A3F0 return, camera +0x3F8)")]];
	s16 msCameraOffsetAct60 [[comment("[25] same acts: camera offset z (FUN_1033A530 -> FUN_1081FB00)")]];
	s16 msCameraPresetAct69 [[comment("[26] MS acts 0x69 / 0x9D in frames [msCameraAct69StartFrame - 2, msCameraAct69EndFrame): camera preset value")]];
	s16 msCameraOffsetAct69 [[comment("[27] same window: camera offset z")]];
	s16 msCameraAct69StartFrame [[comment("[28] start of that window (also forces camera preset override mode 2, FUN_1033A6B0)")]];
	s16 msCameraAct69EndFrame [[comment("[29] end of that window")]];
	s16 msChargeFramesA [[comment("[30] magnetspike_charge_frames: charge frames of charge types 0 and 2 (Focus applies: weapon_charge_time_apply_focus_multiplier)")]];
	s16 msChargeExtraFramesA [[comment("[31] frames added to type 2 after Focus")]];
	s16 msChargeLevelAfterHold [[comment("[32] FUN_103339D0: charge level (+0xB28) set when acts 0x12-0x16, 0x34, 0x84, 0x85, 0x8F are held past the charge frames")]];
	s16 msChargeFramesB [[comment("[33] charge frames of charge types 3 and 5 (Focus applies)")]];
	s16 msChargeExtraFramesB [[comment("[34] frames added to type 5 after Focus")]];
	s16 msChargeLevelAfterHoldAct22 [[comment("[35] charge level set when act 0x22 is held past the charge frames")]];
	s16 msAirborneHeight [[comment("[36] FUN_10336690: height above the ground at which the player counts as airborne (returns 2)")]];
	s16 msGaugeHitGain [[comment("[37] kind 120 / 121 hit on a monster: MS gauge += it x hit value / 100 x the Focus / Distraction percent / 100 (magnetspike_gauge_hit_gain)")]];
	s16 magnetHitFactor [[comment("[38] kind 120 / 121 hits: hit value x it / 100 goes to the monster magnet stock (magnet_hit_value_add)")]];
	s16 magnetWindowFirstPercent [[comment("[39] magnet action (acts 0x62 / 0x63, FUN_101BD650): the magnet window splits into this percent and the rest (FUN_101BC500 / FUN_101BC550)")]];
	s16 magnetActionStep [[comment("[40] that action: step added to its progress (+0x48, +0x50) and timer (+0x4C, capped at the window)")]];
	s16 magnetActionEndPercent [[comment("[41] that action: progress percent that ends it (FUN_1032B340(1), FUN_101BC900)")]];
	s16 magnetAfterWindowExtraFrames [[comment("[42] added with magnetAfterWindowFrames to the input lock timer and SkillWork +0x20E (magnet_state_end, FUN_101BC2A0, FUN_101BC900)")]];
	s16 magnetAfterWindowFrames [[comment("[43] after the magnet window the MS work +0x4E counts down from it; the control hint shows in its first 25 frames")]];
	s16 magnetWindowSpecialMode0E [[comment("[44] magnet window in weapon special mode 0xE (magnet_window_get)")]];
	s16 magnetHitValueSpecialMode0E [[comment("[45] weapon special mode 0xE: added to a kind 121 shell hit value +0x6C (FUN_101EAF90)")]];
	s16 specialMode0EOnHitAdd [[comment("[46] weapon special mode 0xE: added to the on-hit value sum when hit +0x77 bit 2 (FUN_101BE660, on_hit_effects_dispatch)")]];
	s16 specialMode0EOnHitRateTenths [[comment("[47] weapon special mode 0xE: the on-hit rate x it / 10 (on_hit_effects_dispatch)")]];
	s16 msGaugeRegenTech4 [[comment("[48] gauge regen instead of msGaugeRegen with weapon tech 0xD tier 4 and MS work +0x86 > 0")]];
	s16 msTech4AttackPercent [[comment("[49] attack x it / 100 with weapon tech 0xD tier 4 and MS work +0x86 > 0 (player_recalc_attack_power_full)")]];
	s16 msStylishAssaultSeconds [[comment("[50] Stylish Assault buff duration with a Magnet Spike (class 13 gate), x 30 frames (skill_stylish_assault_buff_timer_update)")]];
	s16 msTech4ReachPercent0 [[comment("[51] weapon tech 0xD tier 4: reach bonus it / 100 - 1 when player +0x12 is 0 (FUN_109BCD50)")]];
	s16 msTech4ReachPercent1 [[comment("[52] same when player +0x12 is not 0 (FUN_109BCD50, player_attack_reach_bonus_max)")]];
	s16 msGaugeGainFocusPlus2Percent [[comment("[53] Focus+2 (0x12E): percent applied to msGaugeHitGain (magnetspike_gauge_gain_focus_percent, only caller magnetspike_gauge_hit_gain)")]];
	s16 msGaugeGainFocusPlus1Percent [[comment("[54] Focus+1 (0x12F): same")]];
	s16 msGaugeGainDistractionPercent [[comment("[55] Distraction (0x130): same")]];
	s16 msModeGaugeMax [[comment("[56] per MS mode: mode gauge (+0x24A[mode]) maximum; full and idle = ready (magnetspike_mode_gauge_ready)")]];
	s16 msModeGaugeTickAdd [[comment("[57] mode gauge added by FUN_1033C880 (0 on ZZ)")]];
	s16 msModeGaugeHitPercent [[comment("[58] mode gauge += hit value x it / 100 (magnetspike_mode_gauge_hit_add)")]];
	s16 msModeCooldownFrames [[comment("[59] after the active state the mode state (+0x248[mode]) is 2 for it, then 0 (magnetspike_mode_state_tick)")]];
	s16 msModeActiveFrames [[comment("[60] a full mode gauge sets the mode state to 1 for it (magnetspike_mode_activate)")]];
	s16 msModeActiveBonusPercent [[comment("[61] in state 1 a kind 121 shell value gets + it percent (FUN_1033C5D0)")]];
	MsEvadeDistance msEvadeDistance[6] [[comment("[62]-[79], FUN_10332030 by motion (+0x32C): 0: 0x3EE / 0x3F2 (+), 0x3EF / 0x3F3 (-); 1: 0x5D5 (+), 0x5D6 (-); 2: 0x5B8 (-, arg 2); 3: 0x5C8 (+), 0x5C9 (-); 4: 0x5A7 (-, arg 2); 5: 0x3FD (+, arg 2); player_evade_extra_distance_in_window adds it with Evade Distance Up (0x1C9) or Spacing (0x20B)")]];
	s16 msEvent45StaminaCost [[comment("[80] MS event 45 (ms_event45_stamina_and_buff_drain, ms_handler_table_a +0xB4): stamina cost (FUN_10A996A0; the tower skill Stamina reduces it)")]];
	s16 msEvent45BuffTimerDrain [[comment("[81] same event: frames removed from the Dash Juice timer (+0xB74) and SkillWork +0x2B6")]];
	s16 msSharpnessCost [[comment("[82] FUN_1032BAA0 (player_update_weapon_stamina_and_sharpness): MS sharpness cost")]];
};

struct IdValuePair {
	u16 id;
	u16 value;
};

struct MagnetSpikeTunables {
	u16 numValues;
	u16 numMsActionsClass0;
	u16 numMsActionsClass1;
	u16 numMsActionsClass2;
	u16 numMsActionGaugeCost;
	u16 numMsNoAimActions;
	u16 numMsActions2C;
	u16 numMagnetNetShellExcludedMonsters;
	u16 numMsAimYawCaps;
	u16 numMsNoStaminaRegenActions;
	MagnetSpikeValues *values : u32;
	u16 *msActionsClass0[numMsActionsClass0] : u32 [[comment("ms_action_class_get: these MS actions are class 0")]];
	u16 *msActionsClass1[numMsActionsClass1] : u32 [[comment("class 1")]];
	u16 *msActionsClass2[numMsActionsClass2] : u32 [[comment("class 2: the caller then reads the MS mode")]];
	IdValuePair *msActionGaugeCost[numMsActionGaugeCost] : u32 [[comment("{action, gauge units}: starting the action spends units x msGaugeUnitCost (FUN_1032CF60 -> magnetspike_gauge_spend_units)")]];
	s16 *msNoAimActions[numMsNoAimActions] : u32 [[comment("FUN_103377C0 does not turn toward the target for these actions")]];
	u16 *msActions2C[numMsActions2C] : u32 [[comment("FUN_1032B7B0 (from ms_act_update): actions exempt from a forced action change; only the 0xC9 end on ZZ")]];
	u8 *magnetNetShellExcludedMonsters[numMagnetNetShellExcludedMonsters] : u32 [[comment("monster ids (entity +0x03) that do not get the net-synced kind 121 shell (FUN_1033B350); ends on 0xFF")]];
	IdValuePair *msAimYawCaps[numMsAimYawCaps] : u32 [[comment("{action, max yaw step toward the target} (FUN_103379D0); 10920 = 60 degrees")]];
	u16 *msNoStaminaRegenActions[numMsNoStaminaRegenActions] : u32 [[comment("MS actions during which stamina does not recover (FUN_1032B8F0, from player_entity_tick_hp_regen)")]];
};

MagnetSpikeTunables magnetSpikeTunables @ header.ptrs.magnetSpikeTunables [[name("Magnet Spike Tunables")]];
