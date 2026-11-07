#pragma once

#include <std/mem.pat>
#include <mhfdat/data/shop_road_gm.hexpat>

// Header 0xB10: the third table of road_gm_shop_get_table (local player
// action 0 / 0xF9), read like the two Gm shops by road_gm_shop_count_items /
// road_gm_shop_get_item: 8-byte RoadGmShopItem rows, count dataCounters
// (header 0xB04) +4 (81 EN, 80 JP / rain).
RoadGmShopItem roadCatShop[std::mem::read_unsigned(header.ptrs.dataCounters + 4, 2)] @ header.ptrs.Road_Cat_Item_Shop_Pointer [[name("Road Cat Shop")]];
