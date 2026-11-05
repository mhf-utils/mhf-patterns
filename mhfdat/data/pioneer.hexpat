#pragma once

#include <std/mem.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>

// =======================
// Pioneer (開拓) quest settings (docs/reverse/pioneer.md).
// Header 0x2C8: 4 maps x 6 lists of quest rows, [(map - 1) * 6 + list] with the
// map of the Pioneer work +0xAE (the texts list Jungle, Desert, Snowy Mountain,
// Volcano); the 6 lists are for Pioneer levels 1, 2, 3, 3, 4, 5 (DLL table
// 0x119231C8). The quest settings menu (state 0xB) lists the monsters of the
// rows, 11 a page (pioneer_quest_monsters_page); the quest is one of the row's
// non-zero quest ids at random (pioneer_quest_pick). pioneer_quest_lookup and
// pioneer_quest_monster_find go from a quest back to its row.
// Header 0x2C4: the items the item settings screen (state 0xC) offers, 7 a page,
// only the ones in the pouch, item box or 400-slot store (items 0xA1-0xA9 count
// as one group in the pouch); pioneer_quest_items_page.
// Identical on the EN, JP and rain files.
// =======================

fn pioneerMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct PioneerQuestRow {
    u16 monster [[format("pioneerMonster")]];
    u16 unk02;
    u16 quests[6] [[comment("Quest ids; 0 = none")]];
};

struct PioneerQuestList {
    PioneerQuestRow rows[while(std::mem::read_signed($, 2) != -1)];
    s16 end[8];
};

struct PioneerQuestListPtr {
    PioneerQuestList *list : u32;
};

struct PioneerMapQuests {
    PioneerQuestListPtr levels[6] [[comment("Pioneer levels 1, 2, 3, 3, 4, 5")]];
};

struct PioneerQuestItems {
    ItemId items[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

PioneerMapQuests pioneerQuests[4] @ header.ptrs.pioneerQuests [[name("Pioneer Quests")]];
PioneerQuestItems pioneerQuestItems @ header.ptrs.pioneerQuestItems [[name("Pioneer Quest Items")]];
