#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

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

// The three rollers guild_hall_reward_build_list picks from (1 in 3, called N
// times: N = HR tier 1-5, x50 on a 1/99 roll or x10 on a 1/7 roll). Item ids
// are stored inverted (~id, reward_present_add inverts them back).
// guild_hall_reward_give_random_group (header 0x814): rolls a group in 0 .. the
// highest group and gives every row of that group once.
struct GuildHallRewardGroupRow {
    u16 group;
    u16 item [[format("guildHallRewardItem"), comment("Stored as ~item id")]];
};

GuildHallRewardGroupRow guildHallRewardGroups[importantNums.numGuildHallRewardGroupRows] @ header.ptrs.guildHallRewardGroups [[name("Guild Hall Reward Groups")]];

// guild_hall_reward_give_random_stack (header 0x818): one random row, its item
// given count times
struct GuildHallRewardStack {
    u16 count;
    u16 item [[format("guildHallRewardItem"), comment("Stored as ~item id")]];
};

GuildHallRewardStack guildHallRewardStacks[importantNums.numGuildHallRewardStacks] @ header.ptrs.guildHallRewardStacks [[name("Guild Hall Reward Stacks")]];

// guild_hall_reward_give_random_item (header 0x81C): one random item
using GuildHallRewardItemId = u16 [[format("guildHallRewardItem")]];

GuildHallRewardItemId guildHallRewardItems[importantNums.numGuildHallRewardItems] @ header.ptrs.guildHallRewardItems [[name("Guild Hall Reward Items"), comment("Stored as ~item id")]];
