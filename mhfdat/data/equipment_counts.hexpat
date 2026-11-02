#pragma once

#include <misc/types.pat>

// The block header 0x10 points to: the counts of tables that have no end marker
struct ImportantNumbers {
    padding[0x1C];

    // Offset 0x1C - [mhfo-hd.dll + 0xaf4e70]
    u16 numCarveDTs
        [[name("Number of Carve Drop Tables")]];

    // Offset 0x1E - [mhfo-hd.dll + 0xaf4e98]
    u16 numPartBreakDTs
        [[name("Number of Part Break Drop Tables")]];

    padding[0x2];

    // Offset 0x22: monster crowns (header 0x130) and descriptions (header 0x134)
    u16 numMonsterDesc
        [[name("Number of monster's dsecriptions")]];

    padding[0x18];

    // Offset 0x3C: beginner quest ids (header 0x1B8)
    u16 numBeginnerQuests
        [[name("Number of Beginner Quests")]];

    padding[0xA];

    // Offset 0x48: pointers to tutorial equipment sets (header 0x15C)
    u16 numTutorialEquipSets
        [[name("Number of Tutorial Equipment Sets")]];

    padding[0x14];

    // Offset 0x5E: Caravan gem skill lists, one per tier (header 0xF4) [mhfo-hd.dll + 0xaf4d91]
    u16 numHunterPearlSkillLists
        [[name("Number of Hunter Pearl Skill Lists")]];

    padding[0x17A];

    // Offset 0x1DA: seasonal event timings (header 0x54C)
    u16 numSeasonalEvents
        [[name("Number of Seasonal Events")]];

    padding[0x4E];

    u16 g50MeleeWeaponUpgradesCounter
        [[name("g50 melee weapons upgrades counter")]];

    u16 g50RangedWeaponUpgradesCounter
        [[name("g50 ranged weapon updrades counter")]];

    padding[0x2A];

    // Offset 0x258: hunting horn melodies (header 0x670)
    u16 numHornMelodies
        [[name("Number of Horn Melodies")]];

    padding[0x9E];

    u16 numAutoSkills
        [[name("Number of Auto Skills")]];

    padding[0x76];

    // Offset 0x370: 11 on ZZ, the Caravan ranking route groups that are used (header 0x91C)
    u16 numRankingGroups
        [[name("Number of Caravan Ranking Groups")]];

    u16 unk372 [[comment("7 on ZZ, use unknown")]];

    padding[0x16];

    // Offset 0x38A: tower jewel recipes (header 0x938)
    u16 numTowerJewelRecipes
        [[name("Number of Tower Jewel Recipes")]];

} [[name("Important Numbers")]];

ImportantNumbers importantNums @ header.ptrs.important_nums;

struct EquipmentCounts {
	u16 numLegA;
	u16 numUnk;
	u16 numHeadA;
	u16 numBodyA;
	u16 numArmA;
	u16 numWaistA;
	u16 numMeleeW;
	u16 numRangedW;
};

EquipmentCounts equipmentCounts @ header.ptrs.hd_dll_af47af [[name("Equipment Counts")]];
