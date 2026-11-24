#pragma once

#include <mhfsdt/utils/index.pat>

// Table B: 0x10 per shell id, parallel to Table A (count_a rows, same row = same shell id),
// bound at slot +0x178 by shell_bind_mhfsdt_descriptor; most monster spawners copy it to work
// +0x3C..+0x48. The four s32 lanes mean what the kind's shell code reads them as: the views
// below are the proven ones, `not_traced` lanes have no reader identified yet (unlike padding,
// they may be read). Each row shows "kind K row N | users", users as in Table A.

fn hit_extra_fmt(ref auto r) {
    return std::format("kind {} row {} | {}", r.kind, r.row, row_owner(r.kind, r.row));
};

struct ShellRowB {
    u32 owner = owner_descriptor($, 0x0C, 0x04, 2, ROW_B_SIZE);
    s16 kind = kind_at(owner);
    u32 row = (owner == 0xFFFFFFFF) ? 0 : ($ - rd32(owner + 0x0C)) / ROW_B_SIZE;
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
            s32 not_traced;
        }
        (300, 40): {
            s32 spawn_distance;
            s32 hit_timer;
            s32 not_traced[2];
        }
        (160, 15 | 46 | 47): {
            s32 period_frames;
            s32 not_traced[3];
        }
        (160, 41): {
            s32 ring_count;
            s32 not_traced[3];
        }
        (160, 16 ... 18): {
            s32 not_traced[2];
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
            s32 not_traced[2];
            s32 range;
            s32 not_traced_last;
        }
        (170, _): {
            s32 yaw_offset_deg;
            s32 not_traced[3];
        }
        (125, 72 ... 80): {
            s32 duration_frames;
            s32 not_traced[3];
        }
        (113 | 158 | 161, _): {
            s32 scale_pct [[comment("Shell scale % (slot +0xEC = scale_pct x 0.01): hit volume offsets and radius")]];
            s32 not_traced[3];
        }
        (300, 0 ... 4 | 6 ... 35 | 37 ... 39 | 41 ... 0xFFFF): {
            s32 scale_pct [[comment("Shell scale % (slot +0xEC = scale_pct x 0.01): hit volume offsets and radius")]];
            s32 not_traced[3];
        }
        (100, _): {
            s32 mode [[comment("3 = not a weapon hit: no sharpness / sword crystal / thunder effects (shell_k100_subtype_weapon_hit_check)")]];
            s32 part_gauge_add [[comment("EnemyWork.em_partGauge[gauge group] (hit_monster_part_gauge_add), x3 when work +0x92 == 1; scaled like the motion value (tonfa_style_hit_value_rate)")]];
            padding[4]; // loaded, never used
            s32 hit_flags [[comment("4 = end the shell on a monster victim, 8 = on a player victim (shell_k100_shell_ctrl)")]];
        }
        (106 | 107 | 120 | 121, _): {
            padding[4]; // no reader
            s32 part_gauge_add [[comment("EnemyWork.em_partGauge[gauge group] (hit_monster_part_gauge_add); the row is also copied to the shell work (SAF +0x30, MS +0x70)")]];
            s32 not_traced[2];
        }
        (_, _): {
            s32 not_traced[4];
        }
    }
} [[format("hit_extra_fmt")]];
