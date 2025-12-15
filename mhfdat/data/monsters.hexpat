#pragma once

#include <std/core.pat>
#include <misc/MonsterIDs.hexpat>

fn is_valid_monster_entry(ptr base, u32 max_size) {
    if ($ + sizeof(Monster) > base + max_size)
        return false;

    u8 raw_id = std::mem::read_unsigned($, 1);

    if (raw_id == 0)
        return false;

    if (raw_id > u8(MonsterID::King_Shakalaka))
        return false;

    return true;
};

const u32 MONSTER_BLOCK_SIZE = 0x1000;

u32 monsterDataPointer @ 0xB20 [[name("Pointers")]];

Monster monsters[while (is_valid_monster_entry(monsterDataPointer, MONSTER_BLOCK_SIZE))] @ monsterDataPointer [[name("Monsters")]];
