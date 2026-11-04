#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Veggie Elder item trades (header 0x6F0, talk_move): one row per field map
// (the day map: g_map_night_to_day_tbl turns a night map into its day map),
// until a row of map 0, whose lists serve every map not listed. Lists start
// on 0x20 boundaries. The Elder (em10) uses trades0 or trades1 by its byte
// +0x1B (0 / 1, which also shifts its pEm10MessageRows lines by one). It asks
// first for a few hard-coded items, then: 10 % of the time (no request yet)
// it asks for the give item of a random row 7-14; otherwise it offers the
// first row whose give item the player holds. Reward: rareReward 20 % of the
// time, else reward. Identical on the EN, JP and rain files.
// =======================

struct VeggieElderTrade {
    ItemId give;
    ItemId reward [[comment("80 %")]];
    ItemId rareReward [[comment("20 %")]];
};

struct VeggieElderTrades {
    VeggieElderTrade trades[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    u16 end[3];
};

struct VeggieElderMap {
    u16 map [[comment("Field map id (day version)")]];
    u16 unk02;
    VeggieElderTrades *trades0 : u32 [[comment("Elder +0x1B == 0")]];
    VeggieElderTrades *trades1 : u32 [[comment("Elder +0x1B == 1")]];
};

struct VeggieElderMaps {
    VeggieElderMap maps[while(std::mem::read_unsigned($, 2) != 0)];
    VeggieElderMap otherMaps [[comment("Map 0: used when the map is not listed")]];
};

VeggieElderMaps veggieElderTradeMaps @ header.ptrs.veggieElderTradeMaps [[name("Veggie Elder Trades")]];
