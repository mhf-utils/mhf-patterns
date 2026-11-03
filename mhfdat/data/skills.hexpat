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

// Header 0xA48 (header 0xA4C holds the row count, not a pointer): bonuses by
// the level (1-5) of a byte of the player's SkillWork, only in the quests
// ValidateRankAccess accepts (EmergencyHuntArea / TowerQuestRange ids,
// Duremudira, or quest variant2 bit 0x80), on top of the header 0x928 value
// for the same level. Each reader looks for its kind:
// - kind 1: attack + valueByLevel x 0.01, level SkillWork +0x708
//   (CalculatePlayerBonuses);
// - kind 2: defense + valueByLevel x 0.01, level +0x709 (FUN_10A858A0, from
//   player_recalc_defense_value_basic / _full);
// - kind 0xC: level +0x70A (FUN_111C5370, FUN_111C6390); kind 0xD: level
//   +0x70C (FUN_111BCDC0); kind 0xE: level +0x70E (FUN_109F5680, from
//   Player_ActionType0_StateUpdate): valueByLevel x 0.01;
// - kind 6: level +0x70D, rateByLevel multiplies a value (FUN_111BCAB0,
//   FUN_111BC4F0).
// Kinds 7, 8 and 9 have no reader. What sets the SkillWork levels is not
// found yet.
struct SkillWorkLevelBonus {
	s32 kind;
	s32 valueByLevel[5];
	float rateByLevel[5];
};

SkillWorkLevelBonus skillWorkLevelBonuses[header.ptrs.skillWorkLevelBonusCount] @ header.ptrs.skillWorkLevelBonuses [[name("Skill Work Level Bonuses")]];
