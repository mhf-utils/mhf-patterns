#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Treasure hunt spots (header 0x8B0, importantNums.numTreasureHuntSpots rows).
// treasure_hunt_spot_load (from quest_bind_file_header_to_quest_info) copies
// the row of the current quest into quest work +0xB24..+0xB37 and sets +0xB38.
// treasure_hunt_spot_reveal (each tick) shows the spot when its reveal mode is
// met (mhfpac pQuestProgressTexts[0xEC]); quest_spot_glow_tick then spawns
// effect 0x10 at the spot every 6 ticks on that stage. A player within 200
// units (x / z distance, and y within 200) gathers it
// (quest_player_near_treasure_spot, gather type 7): it gives item and marks
// the spot taken (+0xB3A). Identical on the EN, JP and rain files.
// =======================

enum TreasureHuntReveal : u8 {
    Always = 0,
    MainObjective1 = 1, // quest objective 1 met (quest_objective_is_met(1))
    MainObjectives1And2 = 2,
    Always3 = 3, // the code also tests an address (always true): same as 0
    MainObjective1Alt = 4, // same as 1
    MainObjectives1And2Alt = 5 // same as 2
};

struct TreasureHuntSpot {
    u16 quest;
    u16 stage;
    float position[3];
    ItemId item [[comment("What gathering the spot gives")]];
    TreasureHuntReveal reveal [[comment("Byte read (treasure_hunt_spot_reveal: movzx byte quest work +0xB36)")]];
    padding[1];
};

TreasureHuntSpot treasureHuntSpots[importantNums.numTreasureHuntSpots] @ header.ptrs.treasureHuntSpots [[name("Treasure Hunt Spots")]];
