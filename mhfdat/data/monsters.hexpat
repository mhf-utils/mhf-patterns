#pragma once

#include <std/core.pat>
#include <misc/MonsterIDs.hexpat>

struct Monster {
    MonsterID monster_id;
    u8  padding0;
    u16 monster_flag;
    u16 base_points;
    u16 level1_points;
    u16 level2_points;
    u16 level3_points;
    u16 level4_points;
    u16 level5_points;
} [[name("Monster Data Entry")]];

fn is_valid_monster_entry(ptr base, u32 max_size) {
    if ($ + sizeof(Monster) > base + max_size)
        return false;

    u8 raw_id = std::mem::read_unsigned($, 1);

    if (raw_id == MonsterID::NONE)
        return false;

    if (raw_id > MonsterID::King_Shakalaka)
        return false;

    return true;
};

const u32 MONSTER_BLOCK_SIZE = 0x1000;

u32 monsterDataPointer @ 0xB20 [[name("Monster Data Pointer")]];

Monster monsters[
    while (is_valid_monster_entry(monsterDataPointer, MONSTER_BLOCK_SIZE))
] @ monsterDataPointer [[name("Monster Data Table")]];
