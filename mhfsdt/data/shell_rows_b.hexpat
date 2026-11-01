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
            s32 mode;
            s32 part_gauge_add;
            s32 param_08;
            s32 hit_flags;
        }
        (_, _): {
            s32 param_00;
            s32 param_04; s32 param_08; s32 param_0C;
        }
    }
};
