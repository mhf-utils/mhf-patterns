#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Equipment shop stock (header 0x0C4, equip_shop_tier_list_get): 8 tiers of 22
// pages; a page lists equipment ids until 0. The page is category * 11 + tab:
// category 0 = weapons (tabs 0-7 melee, 8-10 ranged), category 1 = armor (tabs
// 0-4 head, chest, arms, waist, legs; tabs 5-10 have no use: the same 3 ids in
// every tier). The equipment type of each tab comes from DLL tables 0x11924FCC /
// 0x11924FD8. equip_shop_build_page shows 7 rows a page, only the equipment the
// player's gender can wear (Get_equip_bit), with Get_equip_price (10 % off with
// the shop discount flag).
// Tier: offline 0, 1 (quest flag case 0x37) or 2 (case 0x3E); online 7 when the
// G rank reaches the server threshold (default 999, g_rank_shop_threshold_reached),
// else 3 / 2 / 1 by three special quest flags, else 6 (HR >= 5) or 0 (HR < 5);
// the second shop menu (DAT_1EE269FF == 1) uses 5 (HR >= 5) or 4 (HR < 5).
// Identical on the EN, JP and rain files.
// =======================

struct EquipShopEntry<auto Kind> {
    u16 id;
} [[format("equipShopEntryName")]];

fn equipShopEntryName(ref auto e) {
    return getEquipKindName(e.Kind, e.id);
};

struct EquipShopList<auto Kind> {
    EquipShopEntry<Kind> items[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

struct EquipShopPage<auto Kind> {
    EquipShopList<Kind> *list : u32;
};

struct EquipShopTier {
    EquipShopPage<6> melee[8];
    EquipShopPage<7> ranged[3];
    EquipShopPage<2> head;
    EquipShopPage<3> chest;
    EquipShopPage<4> arms;
    EquipShopPage<5> waist;
    EquipShopPage<0> legs;
    u32 unusedPages[6] [[comment("Armor tabs 5-10: the same 3 ids (26733, 6758, 89) in every tier")]];
};

struct EquipShopTierPtr {
    EquipShopTier *tier : u32;
};

EquipShopTierPtr equipShopTiers[8] @ header.ptrs.equipShopTiers [[name("Equipment Shop Tiers")]];
