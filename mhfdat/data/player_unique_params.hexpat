#pragma once

/**
	Player unique parameters (header 0x72C, important numbers + 0x292 rows,
	198 on ZZ; the Wii U client reads them through pl_get_unq_prm): tuning
	values the game code reads by a fixed row number, one row per mechanic
	(Vigorous thresholds, Absolute Defense timing, evade frames, Bomber
	damage, the Hunter Jewel cost limit, Hunting Road monster picks...).
	pl_get_unq_prm(row) returns row * 0x20, or a zeroed row past the end. Each row is named after the code that reads it; what each column
	means differs from row to row, so the columns are not named.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

fn playerUniqueParamName(u32 i) {
    match (i) {
        (0 ... 3 | 0x89): return "Charge gauge HUD";
        (0x04 | 0x8D | 0xAA): return "Attack power recalc";
        (0x05): return "Recovery after an action";
        (0x07): return "Weapon action frame bonuses";
        (0x0A): return "Monster target selection";
        (0x0B): return "Sharpen, reload, coating";
        (0x0C): return "Hunter Jewel cost limit";
        (0x0D | 0x40 | 0xB2 | 0xB3): return "On-hit effects";
        (0x0E | 0x0F): return "Gathering";
        (0x4D): return "Absolute Defense";
        (0x4F): return "Consumable attack bonus, element value";
        (0x51): return "Evade invulnerability frames";
        (0x87): return "Vigorous";
        (0x88): return "Monster damage to the player";
        (0x9E): return "Bomber";
        (0xAD): return "Charge gauge, weapon stamina and sharpness";
        (0xB4): return "Gunner shot damage";
        (0xC2): return "Damage, Hunting Road monster choice";
        (0xC4): return "Hunting Road floor monster choices";
        (_): return "";
    }
};

struct PlayerUniqueParamRow {
    float floats[4];
    s32   ints[4];
} [[name(std::format("Row 0x{:02X} {}", std::core::array_index(), playerUniqueParamName(std::core::array_index())))]];

PlayerUniqueParamRow playerUniqueParams[importantNums.numPlayerUniqueParams]
    @ header.ptrs.playerUniqueParams
    [[name("Player Unique Parameters")]];
