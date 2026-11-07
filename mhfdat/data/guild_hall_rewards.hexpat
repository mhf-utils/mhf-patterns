#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Guild Hall random rewards (header 0x810, guild_hall_reward_give_random):
// 18 lists (gReadMhfDat relocates important numbers +0x2FC = 18 pointers),
// [mode * 6 + band] from player_rank_band_get: mode 0 = HR (band by
// the HR thresholds), 1 = SR (Secret Book rank above the HR threshold),
// 2 = G rank (band by the DLL G rank thresholds 0x118D73AC); 6 bands each.
// The game picks a group in 0 .. the list's highest group, then gives every row
// of that group count times, all of it repeated 1 to 5 times (a 1 / 3 / 5 roll,
// then that many coin flips, at least 1). reward_present_add queues each item
// (twice with the player flag mask 0x119DDFEC, except in the Old Town).
// The item ids are stored inverted (~id). A row with item 0xFFFF ends a list
// (the game tests +2, gReadMhfDat walks +0; the end row is all 0xFF).
// Identical on the EN, JP and rain files.
// =======================

fn guildHallRewardItem(u16 v) {
    return getItemName(~v);
};

struct GuildHallReward {
    u16 group;
    u16 item [[format("guildHallRewardItem"), comment("Stored as ~item id")]];
    s32 count [[comment("Read signed: test / jle, cmp / jl")]];
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
// times: N = HR tier 1-5, x50 on a 1/99 roll or x10 on a 1/7 roll). They and the
// extra roll below only run when guild_hall_reward_find_date_row_pg13 finds no
// row for today's date in the 0xC8 catalog (else guild_hall_reward_give_row_pg14
// gives that fixed row instead). Item ids
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

// Extra items (header 0x820 / 0x824 / 0x828): after the main roll,
// guild_hall_reward_build_list rolls once more at 1/20 (1/10 on stage 0xCB, 1/5 on
// 0xCC and 0x1BD; always after the 1/99 x50 roll) and gives 1 uniformly drawn
// entry (5 on the x50 roll) through reward_present_add, from the list of the HR
// band: below 31, below 101, else. Header 0x82C points to a fourth list that
// rd_mhfdat does not relocate and no code reads.
GuildHallRewardItemId guildHallRewardExtraItemsHrLow[importantNums.numGuildHallRewardExtraItemsHrLow] @ header.ptrs.guildHallRewardExtraItemsHrLow [[name("Guild Hall Reward Extra Items (HR 1-30)"), comment("Stored as ~item id")]];
GuildHallRewardItemId guildHallRewardExtraItemsHrMid[importantNums.numGuildHallRewardExtraItemsHrMid] @ header.ptrs.guildHallRewardExtraItemsHrMid [[name("Guild Hall Reward Extra Items (HR 31-100)"), comment("Stored as ~item id")]];
GuildHallRewardItemId guildHallRewardExtraItemsHrHigh[importantNums.numGuildHallRewardExtraItemsHrHigh] @ header.ptrs.guildHallRewardExtraItemsHrHigh [[name("Guild Hall Reward Extra Items (HR 101+)"), comment("Stored as ~item id")]];
