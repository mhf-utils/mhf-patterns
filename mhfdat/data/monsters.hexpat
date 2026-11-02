#pragma once

/**
	Monster crowns (header 0x130) and in-game monster descriptions (header
	0x134): important numbers + 0x22 rows each (142 on ZZ), one per monster,
	in the same order. A description has no monster id: the crown row with its
	index names the monster (checked on the ZZ JP and EN files: description 0
	is the Felyne's and crown row 0 is monster 9, then the Melynx and 23, the
	Uruki and 124, the Shakalaka and 57). Both tables end at zero padding.
	Crown fields from ezemania2/mhf-file-editor.
	The Hunting Road points of each monster (header 0xB20) are in road.hexpat.
*/

#include <std/core.pat>
#include <misc/s32p.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// Sizes in percent of the monster's base size: up to mini a mini crown, from
// silver and gold those crowns; -1 for none (the Felynes)
struct MonsterCrown {
    u8        unk00;
    MonsterID monster;
    s16       silver;
    s16       gold;
    s16       mini;
    s16       unk08;
    u16       unk0A;
    u8        unk0C;
    MonsterID monsterAgain [[comment("The same id as +0x01 on every ZZ row")]];
} [[name(fmtMonsterID(monster))]];

MonsterCrown monsterCrowns[importantNums.numMonsterDesc]
    @ header.ptrs.monsterCrowns
    [[name("Monster Crowns")]];

s32p monsterDescriptions[importantNums.numMonsterDesc]
    @ header.ptrs.monsterDesc
    [[name("Monster Descriptions"), comment("Row i is the monster of crown row i")]];
