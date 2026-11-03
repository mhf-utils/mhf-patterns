#pragma once

/**
	Monster motion sounds. On the HD client mhfGetEmSndTbl takes a monster's
	table from mhfdat, not from mhfemd: header 0x8FC holds one pointer per
	monster id (0xB1, null for none) to 200 motion sound lists (EmSndMot, as
	in mhfemd), and header 0x5C0 the alternate tables some variants use
	(important numbers + 0x20E rows, 15 on ZZ: em95, em20, em123...), picked by
	row in the code of each monster.
*/

#include <std/core.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfemd/utils/sound.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct EmSndMotTable {
    EmSndMot motions[200];
};

struct MonsterSoundTable {
    ptVar<EmSndMotTable> table;
} [[name(fmtMonsterID(std::core::array_index()))]];

MonsterSoundTable monsterSoundTables[MONSTER_NAME_COUNT]
    @ header.ptrs.monsterSoundTables
    [[name("Monster Sound Tables")]];

struct MonsterAltSoundTable {
    MonsterID monster;
    padding[1];
    u16 unk02;
    EmSndMotTable *table : u32;
};

MonsterAltSoundTable monsterAltSoundTables[importantNums.numMonsterAltSoundTables]
    @ header.ptrs.monsterAltSoundTables
    [[name("Monster Alternate Sound Tables")]];
