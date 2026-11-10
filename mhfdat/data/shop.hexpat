#pragma once
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/combine_shop.hexpat>
#include <mhfdat/data/shop_tower_medal.hexpat>

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

// the road shop (shop kind 0xC, special_shop_menu_init: shop work +0x20)
struct RoadShopItem {
	ItemId item;
	padding[2];
	u32 price;
	u8 tab [[comment("Listed on the tab shop work +0x3B; bit 0x80: GR terms from the server row (shop_entry_gr_tier_check)")]];
	u8 rankTier [[comment("Listed when <= the player's tier (road_shop_static_find_entry: 0-2 HR 1/31/100, 3-5 highest SR, 6-15 GR 1-900)")]];
	u16 quantity [[comment("Items per purchase, 0 = 1 (shop_can_buy_check)")]];
	u8 roadFloors [[comment("Copied to the terms RoadFloors (shop work row +0x6E): RoadMaxStagesMultiplayer must reach it (road_shop_terms_check)")]];
	padding[3];
};

// Stock rows of the NPC shops (special_shop_menu_init kinds 1-4: Hunter
// Festival, N Cafe, special items or their SR version, GCP exchange): the shop
// list build copies the rows of the current tab until item 0, at price x shop
// work +0x7868 / 100 (at least 1)
struct NpcShopItem {
	ItemId item;
	padding[2];
	u32 price;
	u8 tab [[comment("Listed on the tab shop work +0x3B; bit 0x80: GR terms from the server row (shop_entry_gr_tier_check)")]];
	u8 rankTier [[comment("Below 6: no GR needed; 6-15: GR shop_rank_tier_to_gr (1, 100 ... 900) (shop_entry_gr_tier_check)")]];
	u16 quantity [[comment("Items per purchase, 0 = 1 (shop_can_buy_check)")]];
};

// the dojo shops
struct DojoPrice {
	ItemId item;
	padding[2];
	u32 price;
};


RoadShopItem roadShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptRoadShop;
NpcShopItem festiShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptFestiShop;
NpcShopItem nCafeShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptNCafe;
NpcShopItem gcpShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptGCPExchange;
NpcShopItem specialItemShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptSpecialItemShop;
NpcShopItem specialItemShopSR[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptSpecialItemShopSR1;
DojoPrice dojoShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoGeneral;
DojoPrice dojoShopHR5[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoHR5;
DojoPrice dojoShopDone[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoDoneComps;
DojoPrice dojoShopOnline[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnline;
DojoPrice dojoShopOnlineSpecial[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnlineSpecial;
DojoPrice dojoShopOnlineComplete[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptDojoOnlineComplete;
