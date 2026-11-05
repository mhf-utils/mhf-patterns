#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Road Gm shops (header 0x90C, 0x924, 0x920; mhfpac pGmShopTexts [1] "Purchase
// for %dGm?", [5] "%7d Gm"): road_gm_shop_get_table picks the table from the
// local player action: 0 / 0xD6 the Felyne Gm shop (0x90C, set by em134 Felyne2
// in FUN_10DDB6E0), 0 / 0xD7 the Blue NPC Gm shop (0x924, set by em135 in
// FUN_10DDCDF0), 0 / 0xF9 header 0xB10. Counts: extraCounters +0 and +4.
// road_gm_shop_count_items / road_gm_shop_get_item list a row when the s8
// gMazeTower +0xC (0-3) bit of mazeTowerTierMask is set (or gMazeTower is null
// or the value is outside 0-3) and stockGroupMask AND road_gm_shop_stock_mask
// (DLL 0x11A23254, static 0xFFFF) is not 0. em134_init sets that mask to 1 << i
// from a 1-100 roll over the 16 stock group weights of header 0x920 (the full
// mask when DAT_1E76B897 or player_contexts & 4 is set). The price is the item's
// buyPrice x (1 - the tower skill 0xB discount) x quantity, paid in road Gm.
// On rain, 0x924 points 8 bytes before 0x90C (one row, count still 66).
// =======================

struct RoadGmShopItem {
    ItemId item;
    u16 mazeTowerTierMask [[comment("Bit (gMazeTower +0xC)")]];
    u16 stockGroupMask [[comment("AND the stock mask rolled from header 0x920")]];
    u16 unk06 [[comment("no reader")]];
};

RoadGmShopItem felyneGmShop[std::mem::read_unsigned(header.ptrs.extraCounters, 2)] @ header.ptrs.felyneGmShop [[name("Felyne Gm Shop")]];
RoadGmShopItem blueNpcGmShop[std::mem::read_unsigned(header.ptrs.extraCounters + 4, 2)] @ header.ptrs.blueNpcGmShop [[name("Blue NPC Gm Shop")]];
u8 felyneGmShopStockRolls[16] @ header.ptrs.felyneGmShopStockRolls [[name("Felyne Gm Shop Stock Rolls"), comment("Stock group weights in percent; cumulative over a 1-100 roll")]];
