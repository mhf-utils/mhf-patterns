#pragma once

#include <mhfsdt/utils/index.pat>

/// Key of the table B row at addr: (descriptor id << 16) | row index
fn b_key(u32 addr) {
    u32 o = 0;
    while (!isTerminator(o)) {
        u32 b = rd32(o + 0x0C);
        u32 n = rd16(o + 0x04);
        if (b != 0 && addr >= b && addr < b + n * ROW_B_SIZE)
            return (rd16(o + 2) << 16) | ((addr - b) / ROW_B_SIZE);
        o = o + DESCRIPTOR_SIZE;
    }
    return 0xFFFFFFFF;
};

// Table B: 0x10 per shell id, parallel to Table A (count_a rows), bound at
// slot +0x178 by shell_bind_mhfsdt_descriptor; most monster spawners copy it
// to work +0x3C..+0x48. Lanes are per kind; the views below are the proven ones.
struct ShellRowB {
    u32 key = b_key($);
    u32 kind = key >> 16;
    u32 row = key & 0xFFFF;
    match (kind, row) {
        (142, 23 | 37 | 60): {
            s32 fan_radius;
            s32 fan_count;
            s32 fan_arc_deg;
            s32 fan_radius_add;
        }
        (300, 36): {
            s32 burst_count;
            s32 burst_frame_start;
            s32 burst_frame_end;
            s32 param_0C;
        }
        (300, 40): {
            s32 spawn_distance;
            s32 hit_timer;
            s32 param_08;
            s32 param_0C;
        }
        (160, 15 | 46 | 47): {
            s32 period_frames;
            s32 param_04;
            s32 param_08; s32 param_0C;
        }
        (160, 41): {
            s32 ring_count;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (160, 16 ... 18): {
            s32 param_00; s32 param_04;
            s32 range_near;
            s32 range_far;
        }
        (160, 45): {
            s32 vel_y;
            s32 vel_z;
            s32 accel_y;
            s32 jitter;
        }
        (160, 48 ... 50): {
            s32 param_00; s32 param_04;
            s32 range;
            s32 param_0C;
        }
        (170, _): {
            s32 yaw_offset_deg;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (125, 72 ... 80): {
            s32 duration_frames;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (113 | 158 | 161, _): {
            s32 scale_pct;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (300, 5): {
            s32 param_00;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (300, 0 ... 4 | 6 ... 35 | 37 ... 39 | 41 ... 0xFFFF): {
            s32 scale_pct;
            s32 param_04; s32 param_08; s32 param_0C;
        }
        (100, _): {
            s32 mode [[comment("3 = not a weapon hit: no sharpness / sword crystal / thunder effects (shell_k100_subtype_weapon_hit_check)")]];
            s32 part_gauge_add [[comment("monster +0xCF2[gauge group] (hit_monster_part_gauge_add), x3 when work +0x92 == 1; scaled like the motion value (tonfa_style_hit_value_rate)")]];
            s32 param_08 [[comment("Dead load")]];
            s32 hit_flags [[comment("4 = end the shell on a monster victim, 8 = on a player victim (shell_k100_shell_ctrl)")]];
        }
        (106 | 107 | 120 | 121, _): {
            s32 param_00 [[comment("No reader")]];
            s32 part_gauge_add [[comment("monster +0xCF2[gauge group] (hit_monster_part_gauge_add); the row is also copied to the shell work (SAF +0x30, MS +0x70)")]];
            s32 param_08; s32 param_0C;
        }
        (_, _): {
            s32 param_00;
            s32 param_04; s32 param_08; s32 param_0C;
        }
    }
};
