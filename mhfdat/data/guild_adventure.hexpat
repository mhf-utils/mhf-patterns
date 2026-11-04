#pragma once

#include <std/mem.pat>
#include <std/string.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Guild adventure (expedition) destinations (header 0x87C) and their reward
// pools (header 0x880). The menu (guild_adventure_list_build) lists a
// destination when the HR (GR + 2000 above HR 998) reaches minHr and, if
// requiredItem is set, the item is in the pouch, box or storage. The row index
// is the destination sent by REGIST_GUILD_ADVENTURE (0x113) / its Special Clan
// Hall version (0x1A5); cost is taken from a save counter. The grade of a
// result is the number of thresholds reached (guild_adventure_grade_get). The
// reward row is rewards[rank band] (guild_adventure_rank_band: low HR, high
// HR, G rank). Items: base pool groups drawn grade + 1 times, the bonus pool
// at grade 3+ or a 20 % roll, the rare pool at grade 4+ or a 5 % roll after
// the bonus one (guild_adventure_reward_flags_roll).
// =======================

struct GuildAdventureText {
    std::string::NullString *text : u32;
} [[inline]];

struct GuildAdventureDestination {
    GuildAdventureText name;
    GuildAdventureText description;
    u16 cost;
    u16 rewards[3] [[comment("guildAdventureRewards row by rank band")]];
    u16 minHr;
    ItemId requiredItem [[comment("0: none")]];
    u16 thresholds[4];
};

GuildAdventureDestination guildAdventureDestinations[while(std::mem::read_unsigned($, 4) != 0)] @ header.ptrs.guildAdventureDestinations [[name("Guild Adventure Destinations")]];

struct GuildAdventureRewardItem {
    ItemId item;
    u16 count;
};

struct GuildAdventureRewardGroup {
    GuildAdventureRewardItem items[3];
};

struct GuildAdventureRewardRow {
    GuildAdventureRewardGroup basePool[5];
    GuildAdventureRewardGroup bonusPool[5];
    GuildAdventureRewardGroup rarePool[5];
};

GuildAdventureRewardRow guildAdventureRewards[37] @ header.ptrs.guildAdventureRewards [[name("Guild Adventure Rewards")]];
