#pragma once

#include <mhfsdt/utils/index.pat>

/// Key of the table D record at addr: (descriptor id << 16) | row index
fn d_key(u32 addr) {
    u32 o = 0;
    while (!isTerminator(o)) {
        u32 d = rd32(o + 0x14);
        u32 n = rd32(o + 0x18);
        if (d != 0 && addr >= d && addr < d + n * RECORD_D_SIZE)
            return (rd16(o + 2) << 16) | ((addr - d) / RECORD_D_SIZE);
        o = o + DESCRIPTOR_SIZE;
    }
    return 0xFFFFFFFF;
};

struct RecordD {
    u32 key = d_key($);
    u32 kind = key >> 16;
    u32 row = key & 0xFFFF;
    match (kind, row) {
        (125, 12): {
            float f_00; float f_04; float f_08; float f_0C;
            s32 i_10; s32 i_14;
            s32 debuff_frames;
            s32 debuff_level;
        }
        (125, 16): {
            float f_00; float f_04; float f_08; float f_0C;
            s32 i_10; s32 i_14;
            s32 buff_frames;
            s32 buff_level;
        }
        (125 | 546, 17): {
            float f_00; float f_04; float f_08; float f_0C;
            s32 i_10; s32 i_14; s32 i_18;
            s32 heal_hp;
        }
        (166, 27 ... 30): {
            float pull_speed;
            float pull_range_min;
            float pull_range_max;
            float f_0C;
            s32 i_10; s32 i_14; s32 i_18; s32 i_1C;
        }
        (142, 1): {
            float f_00;
            float dmg_mult;
            float f_08; float f_0C;
            s32 damage;
            s32 i_14; s32 i_18; s32 i_1C;
        }
        (_, _): {
            float f_00;
            float f_04; float f_08; float f_0C;
            s32 i_10;
            s32 i_14; s32 i_18; s32 i_1C;
        }
    }
};
