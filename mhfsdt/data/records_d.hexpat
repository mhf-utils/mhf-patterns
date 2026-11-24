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

// Table D: 0x20 parameter rows (4 f32 + 4 s32) read by kind code with a
// constant row number (mhfsdt_desc_get_d_row, fallback row 0x11880F08).
// Kind 100: row 136 = Tonfa level multiplier (% by weapon level / 3); a kick
// row's i_10 / i_14 / i_18 override the MV of kind 0 rows 4 / 5 / 0x60-0x61
// under skills 0xDB / 0x167 (melee_kick_attack_power_override).
// Kind 999: player status rows (0x21 / 0x22 frenzy, 0x15 / 0x30 ice blight...).
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
        (140, 100 ... 499): {
            float hit_frame [[comment("Frame tested by Monster_IsCurrentFrameInHitboxWindow (em_sdt8c_action_frame_window_ck)")]];
            float f_04; float f_08; float f_0C;
            s32 monster_id;
            s32 row_type [[comment("2 = hit frame window row")]];
            s32 act_category;
            s32 act_type;
        }
        (532, 1 ... 0xFFFF): {
            float f_00; float f_04; float f_08; float f_0C;
            s32 monster_id [[comment("0 skips the row (em_maze_tower_height_clamp)")]];
            s32 height [[comment("Height above ground the monster is clamped to")]];
            s32 act_category;
            s32 act_type;
        }
        (_, _): {
            float f_00;
            float f_04; float f_08; float f_0C;
            s32 i_10;
            s32 i_14; s32 i_18; s32 i_1C;
        }
    }
};
