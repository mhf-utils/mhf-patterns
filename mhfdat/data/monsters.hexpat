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
// instead (falling back to this table when the monster is missing).
// The second list is not an alternative carve list but the monster's drop
// points: monster action and damage handlers spawn row N at the monster as a
// carve reward entry (monster_drop_point_try_spawn and
// monster_drop_point_obj_try_spawn roll (rng & 0x1F) <= chance,
// monster_drop_point_spawn does not roll). At HagiLv 9 both lists take column
// 1 / 2 / 3 for gGetMonsterStatus 0x41 / 0x42 / 0x43, else 0.
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

struct MonsterDropPoint {
    s16 carveTableByRank[12] [[comment("Carve table (header 0x120) by HagiLv; 0 or -1: no drop")]];
    u8 chance [[comment("Spawns when (rng & 0x1F) <= chance (32 always)")]];
    u8 carveCount;
};

struct MonsterCarvePoints {
    ptVar<CarvePointList> carvePoints;
    u32 dropPointCount = std::mem::read_unsigned($ + 4, 4);
    if (std::mem::read_unsigned($, 4) != 0)
        MonsterDropPoint *dropPoints[dropPointCount] : u32;
    else
        u32 dropPoints;
    u32 unk08 [[comment("No reader; equals the drop point count on the 3 files")]];
} [[name(fmtMonsterID(std::core::array_index()))]];

MonsterCarvePoints monsterCarvePoints[MONSTER_NAME_COUNT]
    @ header.ptrs.monsterCarvePoints
    [[name("Monster Carve Points")]];

// Zenith carve points (header 0xAC8): rows walked until monster 0 / 0xFF, no
// terminator in the block (the rows end where header 0x128 starts). Replace the
// 0x138 lists at HagiLv 9 (monster_carve_points_get, monster_carve_points_alt_get),
// for Berserk Raviente 0x95 on the extreme Great Slaying quests
// (great_slaying_is_berserk_extreme_quest) and variant 0xD (carve_roll_item), and
// for the drop points of monster 0x50 with em_variation_check(0x50, 0x10) on
// variant2 & 0x80 quests. carve_roll_item_zenith (carve kind 8) rolls from the
// first point's column 0.
fn carveRowsGoOn(u32 addr, u32 end) {
    u8 m = std::mem::read_unsigned(addr, 1);
    return m != 0x00 && m != 0xFF && addr < end;
};

struct MonsterCarvePointsZenith {
    MonsterID monster;
    padding[3];
    if (std::mem::read_unsigned($, 4) != 0)
        CarvePointList *carvePoints : u32;
    else
        u32 carvePoints;
    u32 dropPointCount = std::mem::read_unsigned($ + 4, 4);
    if (std::mem::read_unsigned($, 4) != 0)
        MonsterDropPoint *dropPoints[dropPointCount] : u32;
    else
        u32 dropPoints;
    u32 unk0C [[comment("No reader; equals the drop point count on the 3 files")]];
} [[name(fmtMonsterID(monster))]];

MonsterCarvePointsZenith monsterCarvePointsZenith[while(carveRowsGoOn($, header.ptrs.captureBreakRewards))] @ header.ptrs.monsterCarvePointsZenith [[name("Monster Carve Points: Zenith")]];

// Berserk Raviente small party carve points (header 0xAD0;
// monster_carve_points_small_party_find, used by monster_carve_points_get and
// carve_roll_item for 0x95 on the small party Great Slaying quests,
// great_slaying_is_berserk_small_party_quest). One row in the 3 files.
struct MonsterCarvePointsSmallParty {
    MonsterID monster;
    u8 unk01 [[comment("Rows with a non-zero value are skipped")]];
    u16 unk02 [[comment("no reader")]];
    if (std::mem::read_unsigned($, 4) != 0)
        CarvePointList *carvePoints : u32;
    else
        u32 carvePoints;
} [[name(fmtMonsterID(monster))]];

MonsterCarvePointsSmallParty monsterCarvePointsSmallParty[while(carveRowsGoOn($, 0xFFFFFFFF))] @ header.ptrs.monsterCarvePointsSmallParty [[name("Monster Carve Points: Berserk Raviente Small Party")]];

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

// Rescued Felyne Tower Medal counts (header 0x950): one row per value of the
// Felyne2 (em134) EnemyWork +0xDC0 byte, which initialize_monster_entity copies
// from the spawn block (+0x3C; the Tower spawn FUN_10AAA900 fills it, other
// spawns leave 0 = guide Felyne). em134_rescue_medal_count_roll returns
// min + rand % (max - min + 1) (min when max <= min); em134 action 6 gives that
// many item 0x2B9F. No bound in the code: 8 rows fill the gap to header 0x94C.
struct RescuedFelyneMedalCount {
    u8 min;
    u8 max;
};

RescuedFelyneMedalCount rescuedFelyneMedalCounts[8] @ header.ptrs.rescuedFelyneMedalCounts [[name("Rescued Felyne Medal Counts")]];

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

// Monster hitzone effect scales (header 0x53C): effect_msg_slot_get_scale, for an
// effect message whose flags have bit 0x20, calls
// effect_msg_get_hitzone_radius_scale: a uniform scale = the hitzone radius of
// the request's index x 0.01 x the scale of the first row whose monster is the
// entity's (no row: radius x 0.01); without the flag the scale is 1.0.
struct MonsterHitzoneEffectScale {
    u16 monster [[format("fmtMonsterHitzoneMonster"), comment("Compared as a u16 with the entity's monster id")]];
    u16 unk02 [[comment("no reader, 0")]];
    u32 unk04 [[comment("no reader, 0")]];
    float scale;
};

fn fmtMonsterHitzoneMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

MonsterHitzoneEffectScale monsterHitzoneEffectScales[importantNums.numMonsterHitzoneEffectScales] @ header.ptrs.monsterHitzoneEffectScales [[name("Monster Hitzone Effect Scales")]];
