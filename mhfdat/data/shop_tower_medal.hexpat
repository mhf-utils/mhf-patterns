#pragma once

#include <mhfdat/utils/index.pat>

enum TowerMedalUnlockKind : u16 {
	Always = 0,
	Hr = 1,
	HighestSr = 2, // highest SbGetRank of the 14 secret books with flag 0x80
	GRank = 3, // get_g_class_rank
	HrStarTier = 4 // hr_points_to_star_tier
};

struct TowerMedalShop {
	ItemId item;
	TowerMedalUnlockKind unlockKind;
	u16 unlockMin [[comment("FUN_103841E0 lists the row when unlockMin <= the value of unlockKind")]];
	padding[2];
	u32 price [[name("Price")]];
};

TowerMedalShop towerShopMedal[std::mem::read_unsigned(header.ptrs.extraCounters + 0x0E, 2)] @ header.ptrs.towerMedalShop [[name("Tower Medal Shop")]];
