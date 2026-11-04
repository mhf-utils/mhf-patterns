#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Guild weekly bonus values (header 0x904). One row per bonus kind, one u16 per
// level 0-14 (the readers take the low byte). The level comes from the server
// reply to MSG_MHF_GET_GUILD_WEEKLY_BONUS_ACTIVE_COUNT {active, current, new}:
// (active + new) / 4 - 1 or current / 4 - 1 (guild_weekly_bonus_level_get), and
// only for the kinds in the active list, sized by g_player_hr_cache (0 / 3 / 5).
// Rows 0-5 are also Partnyaa stat bonuses x mhfgao pStatMultipliers[row] / 100
// (stat order of mhfgao.md). The bytes after row 6 belong to another table.
// =======================

struct GuildWeeklyBonusRow {
    u16 byLevel[15];
};

struct GuildWeeklyBonusValues {
    GuildWeeklyBonusRow attack [[comment("player_recalc_attack_power_full; Partnyaa stat 0")]];
    GuildWeeklyBonusRow defense [[comment("player_recalc_defense_value_full; Partnyaa stat 1")]];
    GuildWeeklyBonusRow health [[comment("Partnyaa stat 2 (partnyaa_ai_init_chances)")]];
    GuildWeeklyBonusRow bravery [[comment("Partnyaa stat 3")]];
    GuildWeeklyBonusRow reflexes [[comment("Partnyaa stat 4 (partnyaa_ai_init_chances)")]];
    GuildWeeklyBonusRow luck [[comment("Partnyaa stat 5, capped at 100")]];
    GuildWeeklyBonusRow treasureCorpChance [[comment("added to chance2 by treasure_corp_roll_result")]];
};

GuildWeeklyBonusValues guildWeeklyBonusValues @ header.ptrs.guildWeeklyBonusValues [[name("Guild Weekly Bonus Values")]];
