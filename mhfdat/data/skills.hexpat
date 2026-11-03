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
