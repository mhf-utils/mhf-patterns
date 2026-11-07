#pragma once
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/combine_shop.hexpat>

u32 shopInventory; 
shopInventory = std::mem::find_sequence(0, 0x0F, 01, 01, 00, 00, 00, 00, 00, 03, 01, 01, 00, 00, 00, 00, 00);
u128 shopHeader @ shopInventory;


struct ItemOut {
	u16 id [[format("getItemName")]];
	padding[6];
};

struct SpecialShopHeader {
	ptr ptRoadShop;
	ptr ptFestiShop;
	ptr ptNCafe;
	ptr ptSpecialItemShop;
	ptr ptSpecialItemShopSR1;
	ptr ptGCPExchange;
	ptr ptDojoGeneral;
	ptr ptDojoHR5;
	ptr ptDojoDoneComps;
	ptr ptDojoOnline;
	ptr ptDojoOnlineSpecial;
	ptr ptDojoOnlineComplete;
};

SpecialShopHeader sShopHeader @ header.ptrs.specialShops;

// Header 0x19C and 0x198 point into the same block (+0x4 and +0x18): the
// NPC shop menu (FUN_104029C0) takes the stock of shop type 1-4 from 0x19C
// (Hunter Festival, N Cafe, special items or their SR version by
// FUN_10B386F0, GCP exchange) and the dojo shop (FUN_1072AAF0) from 0x198.
// The lists themselves are read through sShopHeader below.
struct SpecialShopsNpcView {
    ptr ptFestiShop;
    ptr ptNCafe;
    ptr ptSpecialItemShop;
    ptr ptSpecialItemShopSR1;
    ptr ptGCPExchange;
};

struct SpecialShopsDojoView {
    ptr ptDojoGeneral [[comment("Offline (gIsOnline 0), save byte +0x1FA4D < 2")]];
    ptr ptDojoHR5 [[comment("Offline, save byte +0x1FA4D >= 2")]];
    ptr ptDojoDoneComps [[comment("Offline, FUN_1072A8F0 and FUN_1072A970 both 1")]];
    ptr ptDojoOnline [[comment("Online, quest_flag_condition_special 0")]];
    ptr ptDojoOnlineSpecial [[comment("Online, quest_flag_condition_special not 0")]];
    ptr ptDojoOnlineComplete [[comment("Online, FUN_1072AA70 1 (save flags of ids 0x2775-0x2779 all set)")]];
};

SpecialShopsNpcView specialShopsNpcView @ header.ptrs.specialShopsNpcView [[name("Special Shops NPC View")]];
SpecialShopsDojoView specialShopsDojoView @ header.ptrs.specialShopsDojoView [[name("Special Shops Dojo View")]];

// the road shop
struct RoadShopItem {
	u16 id [[format("getItemName")]];
	padding[2];
	u32 price;
	u8 tab;
	u8 rankTier [[comment("Listed when <= the player's tier (road_shop_static_find_entry: 0-2 HR 1/31/100, 3-5 highest SR, 6-15 GR 1-900)")]];
	u8 unk0A;
	padding[1];
	u8 unk0C;
	padding[3];
};

// the special item shops
struct SpecialPrice {
	u16 id [[format("getItemName")]];
	padding[2];
	u32 price;
	u32 unk08;
};

// the dojo shops
struct DojoPrice {
	u16 id [[format("getItemName")]];
	padding[2];
	u32 price;
};

enum TowerMedalUnlockKind : u16 {
	Always = 0,
	Hr = 1,
	HighestSr = 2, // highest SbGetRank of the 14 secret books with flag 0x80
	GRank = 3, // get_g_class_rank
	HrStarTier = 4 // hr_points_to_star_tier
};

struct TowerMedalShop {
	u16 Itemid [[format("getItemName")]];
	TowerMedalUnlockKind unlockKind;
	u16 unlockMin [[comment("FUN_103841E0 lists the row when unlockMin <= the value of unlockKind")]];
	padding[2];
	u32 price [[name("Price")]];
};

struct CategorizedPrice {
	u16 id [[format("getItemName")]];
	padding[2];
	u16 price;
	padding[2];

	// 01 00 01 = NCafe(Gatherables)
	// 03 02 01 = NCafe(HR5+)(Mats (HR5~7))
	// 06 06 01 = NCafe(GR1+)(GItems (GR1+))
	// 04 02 01 = NCafe(HR5+)(Decorations)
	// 04 01 01 = NCafe(HR3+)(Decorations)
	// 02 00 01 = NCafe(HR3+)(Mats (HR 1~4))
	// 02 01 01 = NCafe(Mats (HR 1~4))
	// 03 03 01 = NCafe(SR Equip)(Mats (HR 5~7))
	// 05 03 01 = NCafe(SR Equip)(Other Items)
	// 05 01 01 = NCafe(HR3+)(Other Items)
	// 05 02 01 = NCafe(HR5+)(Other Items)
	u8; u8; u8; 
	
	padding[1];
};



RoadShopItem roadShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptRoadShop;
CategorizedPrice festiShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptFestiShop;
CategorizedPrice nCafeShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptNCafe;
CategorizedPrice gcpShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptGCPExchange;
SpecialPrice specialItemShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptSpecialItemShop;
SpecialPrice specialItemShopSR[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptSpecialItemShopSR1;
DojoPrice dojoShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoGeneral;
DojoPrice dojoShopHR5[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoHR5;
DojoPrice dojoShopDone[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoDoneComps;
DojoPrice dojoShopOnline[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnline;
DojoPrice dojoShopOnlineSpecial[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnlineSpecial;
DojoPrice dojoShopOnlineComplete[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnlineComplete;
TowerMedalShop towerShopMedal[std::mem::read_unsigned(header.ptrs.extraCounters + 0x0E, 2)] @ header.ptrs.towerMedalShop;
