#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/MonsterIDs.hexpat>

// =======================
// Hunting Medal (item 0x1F60) milestones (header 0x7D4): per monster, up to
// 16 hunt-count milestones, each giving `medals` Hunting Medals once
// (hunting_medal_menu_open, hunting_medal_pending_for_monster,
// hunting_medal_pending_total, hunting_medal_claim). The hunt count is the
// monster's count (the sum of its variants for monsters 0x02, 0x39, 0x7A,
// 0x93, 0x9F, 0xAA); bit n of the save u16 at +0x21327 + 0x1A95 +
// saveIndex * 2 marks milestone n as claimed. huntCount -1: no milestone.
// =======================

struct HuntingMedalMilestone {
    s16 huntCount;
    s16 medals;
    u32 unk04;
};

struct HuntingMedalMonster {
    s16 saveIndex;
    MonsterID monster;
    padding[1];
    HuntingMedalMilestone *milestones[16] : u32;
};

HuntingMedalMonster huntingMedalMilestones[importantNums.numHuntingMedalMonsters] @ header.ptrs.huntingMedalMilestones [[name("Hunting Medal Milestones")]];
