#pragma once
#include <mhfdat/utils/index.pat>

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
	ptr unk[3] 
	[[comment("Same contents as previous dojo shops, unknown purpose")]];
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
    ptr ptDojoGeneral [[comment("Save byte +0x1FA4D < 2")]];
    ptr ptDojoHR5 [[comment("Save byte +0x1FA4D >= 2")]];
    ptr ptDojoDoneComps;
    ptr unk[3] [[comment("Picked by FUN_1072AA70 / quest_flag_condition_special instead of the three above")]];
};

SpecialShopsNpcView specialShopsNpcView @ header.ptrs.specialShopsNpcView [[name("Special Shops NPC View")]];
SpecialShopsDojoView specialShopsDojoView @ header.ptrs.specialShopsDojoView [[name("Special Shops Dojo View")]];

// the road shop
struct RoadShopItem {
	u16 id [[format("getItemName")]];
	padding[2];
	u32 price;
	u8 tab;
	u8 subTab;
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

struct TowerMedalShop {
	u16 Itemid [[format("getItemName")]];
	u8 shoptype;
	padding[1];
	u16 qty [[name("Quantity")]];
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

struct ComboShop{
	u16 Itemid [[format("getItemName")]];
	u16 Combo_fee;
	u16 Recipe_No;
	u8 Recipe1_min1 [[
		name("Recipe 1 Min")
		]];
	u8 Recipe1_max2 [[
		name("Recipe 1 Max")
	]];
	u16 Recipe1_Itemid1 [[
		format("getItemName"),
		name("Recipe 1 Item ID 1")
	]];
	u16 Recipe1_Itemid_Qty1 [[name("Recipe 1 Item Id Qty 1")]];

	u16 Recipe1_Itemid2 [[
		format("getItemName"),
		name("Recipe 1 Item ID 2")
	]];
	u16 Recipe1_Itemid_Qty2 [[name("Recipe 1 Item Id Qty 2")]];

	u16 Recipe1_Itemid3 [[
		format("getItemName"),
		name("Recipe 1 Item ID 3")
	]];
	u16 Recipe1_Itemid_Qty3 [[name("Recipe 1 Item Id Qty 3")]];

	u8 Recipe2_min [[
		name("Recipe 2 Min")
		]];
	u8 Recipe2_max [[
		name("Recipe 2 Max")
	]];
	
	u16 Recipe2_Itemid1 [[
		format("getItemName"),
		name("Recipe 2 Item ID 1")
	]];
	u16 Recipe2_Itemid_Qty1 [[name("Recipe 2 Item Id Qty 1")]];

	u16 Recipe2_Itemid2 [[
		format("getItemName"),
		name("Recipe 2 Item ID 2")
	]];
	u16 Recipe2_Itemid_Qty2 [[name("Recipe 2 Item Id Qty 2")]];

	u16 Recipe2_Itemid3 [[
		format("getItemName"),
		name("Recipe 2 Item ID 3")
	]];
	u16 Recipe2_Itemid_Qty3 [[name("Recipe 2 Item Id Qty 3")]];

	u8 Recipe3_min [[
		name("Recipe 3 Min")
		]];
	u8 Recipe3_max [[
		name("Recipe 3 Max")
		]];

	u16 Recipe3_Itemid1 [[
		format("getItemName"),
		name("Recipe 3 Item ID 1")
	]];
	u16 Recipe3_Itemid_Qty1 [[name("Recipe 3 Item Id Qty 1")]];

	u16 Recipe3_Itemid2 [[
		format("getItemName"),
		name("Recipe 3 Item ID 2")
	]];
	u16 Recipe3_Itemid_Qty2 [[name("Recipe 3 Item Id Qty 2")]];

	u16 Recipe3_Itemid3 [[
		format("getItemName"),
		name("Recipe 3 Item ID 3")
	]];
	u16 Recipe3_Itemid_Qty3 [[name("Recipe 3 Item Id Qty 3")]];

};

/**
	The combine shop ends at an item 0 or at the next table the header points
	to, whichever comes first (the JP one runs into the tables after it).
*/
fn get_combo_shop_count(ptr start_addr) {
	u32 end = nextTable(start_addr);
	u32 count = 0;
	while (start_addr + (count + 1) * sizeof(ComboShop) <= end &&
	       std::mem::read_unsigned(start_addr + count * sizeof(ComboShop), 2) != 0) {
		count += 1;
	}
	return count;
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
DojoPrice dojoShop2[while(std::mem::read_unsigned($,4))] @ sShopHeader.unk[0];
DojoPrice dojoShopHR52[while(std::mem::read_unsigned($,4))] @ sShopHeader.unk[1];
DojoPrice dojoShopDone2[while(std::mem::read_unsigned($,4))] @ sShopHeader.unk[2];
TowerMedalShop towerShopMedal[while(std::mem::read_unsigned($,2))] @ header.ptrs.towerMedalShop;
ComboShop hidenCuffCombineShop[get_combo_shop_count(header.ptrs.CombineShop)] @ header.ptrs.CombineShop [[name("Combine Shop")]];
