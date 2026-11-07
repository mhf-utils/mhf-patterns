#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/MonsterIDs.hexpat>

// =======================
// Hunting Medal (item 0x1F60) milestones (header 0x7D4; Wii U mohGetDataTbl,
// slot 0x7D0): per monster, up to 16 hunt-count milestones, each giving
// `medals` Hunting Medals once (hunting_medal_menu_open, mohSetMedalStatus,
// mohSetAllMedalCnt, mohSetMedalReceiptBit, mohGetNextDataTbl, mohGetMaxPage,
// mohExecMedalBitSet). The hunt count is the
// monster's count (the sum of its variants for monsters 0x02, 0x39, 0x7A,
// 0x93, 0x9F, 0xAA); bit n of the save u16 at +0x21327 + 0x1A95 +
// saveIndex * 2 marks milestone n as claimed. huntCount <= 0: no milestone.
// =======================

struct HuntingMedalMilestone {
    s16 huntCount [[comment("Signed compare with the hunt count (movsx); <= 0: no milestone")]];
    s16 medals;
    u32 unk04 [[comment("No reader, always 0")]];
};

struct HuntingMedalMonster {
    s16 saveIndex [[comment("Index of the claimed-bits save u16; negative rows are skipped (mohSetAllMedalCnt)")]];
    u16 monster [[format("fmtMonsterIdU16"), comment("Read as a u16: movzx / word compare (Wii U mohGetDataTblID)")]];
    HuntingMedalMilestone *milestones[16] : u32;
};

HuntingMedalMonster huntingMedalMilestones[importantNums.numHuntingMedalMonsters] @ header.ptrs.huntingMedalMilestones [[name("Hunting Medal Milestones")]];
