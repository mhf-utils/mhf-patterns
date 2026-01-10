#pragma once

#include <misc/types.pat>

struct ImportantNumbers {
    padding[0x1C];
    
    // Offset 0x1C - [mhfo-hd.dll + 0xaf4e70]
    u16 numCarveDTs 
        [[name("Number of Carve Drop Tables")]];
    
    // Offset 0x1E - [mhfo-hd.dll + 0xaf4e98]
    u16 numPartBreakDTs 
        [[name("Number of Part Break Drop Tables")]];
    
    padding[0x2];
    
    u16 numMonsterDesc 
        [[name("Number of monster's dsecriptions")]];
    
    padding[0x206];
    
    u16 g50MeleeWeaponUpgradesCounter 
        [[name("g50 melee weapons upgrades counter")]];

    u16 g50RangedWeaponUpgradesCounter
        [[name("g50 ranged weapon updrades counter")]];
    
    padding[0xCA];
    
    u16 numAutoSkills 
        [[name("Number of Auto Skills"), 
          comment("Value: 1484 (0x05CC)")]];
    
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
