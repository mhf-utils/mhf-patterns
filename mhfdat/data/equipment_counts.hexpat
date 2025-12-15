#pragma once

#include <misc/types.pat>

u16 numMonsterDesc  @ (header.ptrs.important_nums + 0x22) [[name("Number of monsters")]];
u16 numCarveDTs     @ (header.ptrs.important_nums + 0x1C) [[name("Number of Carve Drop Tables")]];
u16 numPartBreakDTs @ (header.ptrs.important_nums + 0x1E) [[name("Number of Part Break Drop Tables")]];

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
