#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Guild Hall random rewards (header 0x810, guild_hall_reward_give_random):
// 18 lists, [mode * 6 + band] from player_rank_band_get: mode 0 = HR (band by
// the HR thresholds), 1 = SR (Secret Book rank above the HR threshold),
// 2 = G rank (band by the DLL G rank thresholds 0x118D73AC); 6 bands each.
// The game picks a group in 0 .. the list's highest group, then gives every row
// of that group count times, all of it repeated 1 to 5 times (a 1 / 3 / 5 roll,
// then that many coin flips, at least 1). reward_present_add queues each item
// (twice with the player flag mask 0x119DDFEC, except in the Old Town).
// The item ids are stored inverted (~id). Identical on the EN, JP and rain files.
// =======================

fn guildHallRewardItem(u16 v) {
    return getItemName(~v);
};

struct GuildHallReward {
    u16 group;
    u16 item [[format("guildHallRewardItem"), comment("Stored as ~item id")]];
    u32 count;
};

struct GuildHallRewardList {
    GuildHallReward rewards[while(std::mem::read_unsigned($ + 2, 2) != 0xFFFF)];
    u32 end[2];
};

struct GuildHallRewardListPtr {
    GuildHallRewardList *list : u32;
};

struct GuildHallRewardLists {
    GuildHallRewardListPtr hr[6] [[comment("By HR band")]];
    GuildHallRewardListPtr sr[6] [[comment("By Secret Book rank band")]];
    GuildHallRewardListPtr gr[6] [[comment("By G rank band")]];
};

GuildHallRewardLists guildHallRewardLists @ header.ptrs.guildHallRewardLists [[name("Guild Hall Reward Lists")]];
