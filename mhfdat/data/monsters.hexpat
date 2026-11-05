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

// Carve points (header 0x138): one row per monster id. A carve point gives
// the carve table (header 0x120 row) of each rank (HagiLv), how many carves
// (skill 0xC0 adds one), the reach in percent of the monster's size and the
// point's offset from the monster (from a bone when boneFlag is set). The
// list ends at a row whose unk1E is 0x8000. HagiLv 9 quests use header 0xAC8
// instead; some Zenith variants take altCarvePoints.
struct CarvePoint {
    s16 carveTableByRank[12];
    u16 carveCount;
    u16 reachPercent;
    u16 unk1C;
    u16 unk1E;
    u8  boneFlag;
    u8  unk21;
    s16 offsetX;
    s16 offsetY;
    s16 offsetZ;
};

struct CarvePointList {
    CarvePoint points[while(std::mem::read_unsigned($ + 0x1E, 2) != 0x8000)];
    CarvePoint terminator;
};

struct MonsterCarvePoints {
    ptVar<CarvePointList> carvePoints;
    u32 altCarvePoints;
    u32 unk08;
} [[name(fmtMonsterID(std::core::array_index()))]];

MonsterCarvePoints monsterCarvePoints[MONSTER_NAME_COUNT]
    @ header.ptrs.monsterCarvePoints
    [[name("Monster Carve Points")]];

// Start actions (header 0xAD4): on quests whose variant has flag 0x2000, a
// listed monster starts in this action (act, sub) and locomotion state
// (EnemyWork +0x410), until a monster of -1
fn startActionMonster(s32 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct MonsterStartAction {
    s32 monster [[format("startActionMonster")]];
    s32 act;
    s32 sub;
    s32 locomotion;
};

MonsterStartAction monsterStartActions[while(std::mem::read_signed($, 4) >= 0)]
    @ header.ptrs.monsterStartActions
    [[name("Monster Start Actions")]];

// Monster icons (header 0x51C): per monster id, the section of som_sef.pac
// holding its icon; 0x84 and values above 0x8D show the default icon 0x8E
struct MonsterIcon {
    u16 section;
} [[name(fmtMonsterID(std::core::array_index()))]];

MonsterIcon monsterIconIndices[MONSTER_NAME_COUNT]
    @ header.ptrs.monsterIconIndices
    [[name("Monster Icon Indices")]];

// Felyne2 mode roll (header 0x94C): em134_mode_roll draws 1-100 from the quest
// LCG at gMazeTower +0x118 and returns 0 when outcome0Chance >= the roll, else
// 1; em134_init stores it in EnemyWork +0xDC0, and when any Felyne2 (0x86) has
// +0xDC0 set, em134_any_mode_set_ck makes FUN_10DDB6E0 set +0x53B to 1, which
// changes its action states (+0x510). The roll cannot run on HD: em134_init is
// only entry 134 (0x86) of the init table 0x118C3350 and rolls only on the
// branch where the monster is not 0x86 or +0xDC0 is already set. The 6 bytes
// after it (30, 25, 15, 15, 10, 5) have no reader.
struct Felyne2ModeRoll {
    u8 outcome0Chance [[comment("Percent; 0 in the 3 files")]];
    u8 unk01 [[comment("no reader")]];
};

Felyne2ModeRoll felyne2ModeRoll @ header.ptrs.felyne2ModeRoll [[name("Felyne2 Mode Roll")]];
