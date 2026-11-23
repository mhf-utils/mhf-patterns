#pragma once

#include <mhfsdt/utils/index.pat>

// Table D: 0x20 parameter rows (4 f32 + 4 s32) read by kind code with a constant row number
// (mhfsdt_desc_get_d_row, fallback row 0x11880F08). Each row shows "kind K row N | read by
// <functions>" (mhfo-hd.dll names, utils/row_owner.pat). `not_traced` lanes have no proven
// meaning yet: the reader functions shown are where to look.
// Kind 100: row 136 = Tonfa level multiplier (% by weapon level / 3); a kick row's s32 lanes
// 0 / 1 / 2 override the MV of kind 0 rows 4 / 5 / 0x60-0x61 under skills 0xDB / 0x167
// (melee_kick_attack_power_override).
// Kind 999: player status rows (0x21 / 0x22 frenzy, 0x15 / 0x30 ice blight...).

fn record_d_fmt(ref auto r) {
    u32 at = addressof(r);
    s32 monster = std::mem::read_signed(at + 0x10, 4);
    s32 category = std::mem::read_signed(at + 0x18, 4);
    s32 act = std::mem::read_signed(at + 0x1C, 4);
    if (r.kind == 140 && r.row >= 100 && r.row <= 499)
        return std::format("kind 140 row {} | {} hit frame window, action {} / {} (em_sdt8c_action_frame_window_ck)", r.row, monster_name(monster), category, act);
    if (r.kind == 532 && r.row >= 1 && monster != 0)
        return std::format("kind 532 row {} | {} height clamp, action {} / {} (em_maze_tower_height_clamp)", r.row, monster_name(monster), category, act);
    str readers = record_d_owner(r.kind, r.row);
    if (readers == "")
        return std::format("kind {} row {} | no constant-row reader traced", r.kind, r.row);
    return std::format("kind {} row {} | read by {}", r.kind, r.row, readers);
};

fn monster_id_fmt(s32 id) { return std::format("{} ({})", monster_name(id), id); };

struct RecordD {
    u32 owner = owner_descriptor($, 0x14, 0x18, 4, RECORD_D_SIZE);
    s16 kind = kind_at(owner);
    u32 row = (owner == 0xFFFFFFFF) ? 0 : ($ - rd32(owner + 0x14)) / RECORD_D_SIZE;
    match (kind, row) {
        (125, 12): {
            float not_traced_f32[4];
            s32 not_traced_s32[2];
            s32 debuff_frames;
            s32 debuff_level;
        }
        (125, 16): {
            float not_traced_f32[4];
            s32 not_traced_s32[2];
            s32 buff_frames;
            s32 buff_level;
        }
        (125 | 546, 17): {
            float not_traced_f32[4];
            s32 not_traced_s32[3];
            s32 heal_hp;
        }
        (166, 27 ... 30): {
            float pull_speed;
            float pull_range_min;
            float pull_range_max;
            float not_traced_f32;
            s32 not_traced_s32[4];
        }
        (142, 1): {
            float not_traced_f32;
            float dmg_mult;
            float not_traced_f32_end[2];
            s32 damage;
            s32 not_traced_s32[3];
        }
        (140, 100 ... 499): {
            float hit_frame [[comment("Frame tested by Monster_IsCurrentFrameInHitboxWindow (em_sdt8c_action_frame_window_ck)")]];
            float not_traced_f32[3];
            s32 monster_id [[format("monster_id_fmt")]];
            s32 row_type [[comment("2 = hit frame window row")]];
            s32 act_category;
            s32 act_type;
        }
        (532, 1 ... 0xFFFF): {
            float not_traced_f32[4];
            s32 monster_id [[format("monster_id_fmt"), comment("0 skips the row (em_maze_tower_height_clamp)")]];
            s32 height [[comment("Height above ground the monster is clamped to")]];
            s32 act_category;
            s32 act_type;
        }
        (_, _): {
            float not_traced_f32[4];
            s32 not_traced_s32[4];
        }
    }
} [[format("record_d_fmt")]];
