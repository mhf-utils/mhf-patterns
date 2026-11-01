#pragma once

#include <mhfemd/utils/index.pat>

enum AiOp : u8 {
    em_cmd_kehai_ck = 0x01,
    em_cmd_ninshiki_ck = 0x02,
    em_cmd_area_move_ck = 0x03,
    em_cmd_top = 0x04,
    em_type_act_set = 0x05,
    em_cmd_target_set = 0x06,
    em_cmd_main_jump = 0x07,
    em_cmd_stand_ck = 0x08,
    em_cmd_fly_ck = 0x09,
    em_cmd_body_status_set = 0x0A,
    em_cmd_mode_ck = 0x0B,
    em_cmd_flag_set = 0x0C,
    em_cmd_flag_clear = 0x0D,
    em_cmd_stage_no_ck = 0x0E,
    em_cmd_route_set = 0x0F,
    em_cmd_route_ck = 0x10,
    em_cmd_kehai_pl_set = 0x11,
    em_cmd_find_ck = 0x12,
    em_cmd_pl_target_set = 0x13,
    em_cmd_angle_ck = 0x14,
    em_cmd_stage_no_sel = 0x15,
    em_cmd_action_set = 0x16,
    em_cmd_area_route_set = 0x17,
    em_cmd_area_route_move = 0x18,
    em_cmd_area_route_ck = 0x19,
    em_cmd_escape_area_set = 0x1A,
    em_cmd_mind_ck = 0x1B,
    em_cmd_vital_sel = 0x1C,
    em_cmd_mind_sel = 0x1D,
    em_cmd_mind_move_end = 0x1E,
    em_cmd_sit_ck = 0x1F,
    em_cmd_pl_ang_sel = 0x20,
    em_cmd_thirst_ck = 0x21,
    em_cmd_near_pos_ck = 0x22,
    em_cmd_emtype_sel = 0x23,
    em_cmd_repeat_cnt_set = 0x24,
    em_cmd_repeat_cnt_clr = 0x25,
    em_cmd_demo_flag_set = 0x26,
    em_cmd_type_sel = 0x27,
    em_cmd_all_pl_same_stage_ck = 0x28,
    em_cmd_stay_timer_ck = 0x29,
    em_cmd_runaway_timer_ck = 0x2A,
    em_cmd_flag_ck = 0x2B,
    em_cmd_myemtype_sel = 0x2C,
    em_cmd_smell_set = 0x2D,
    em_cmd_search_data_set = 0x2E,
    em_cmd_egg_ck = 0x2F,
    em_cmd_egg_cancel_ck = 0x30,
    em_cmd_yobi_pos_set = 0x31,
    em_cmd_body_status_ck = 0x32,
    em_cmd_body_status_sel = 0x33,
    em_cmd_act_st_ck = 0x34,
    em_cmd_ikari_ck = 0x35,
    em_cmd_near_pos2_ck = 0x36,
    em_cmd_kunren_ck = 0x37,
    em_cmd_water_ck = 0x38,
    em_cmd_eye_dmg_ck = 0x39,
    em_cmd_sensor_ck = 0x3A,
    em_cmd_boss_work_ck = 0x3B,
    em_cmd_boss_atk_ck = 0x3C,
    em_cmd_before_stage_ck = 0x3D,
    em_cmd_before_stage_sel = 0x3E,
    em_cmd_ground_area_move = 0x3F,
    em_cmd_em_mode_change = 0x40,
    em_cmd_em_hp_vital_add = 0x41,
    em_cmd_horm_pos_ang_ck = 0x42,
    em_cmd_boss_same_stage_ck = 0x44,
    em_cmd_pl_fishing_ck = 0x45,
    em_cmd_target_pl_act_ck = 0x46,
    em_cmd_fish_ok_ck = 0x47,
    em_cmd_timer_set = 0x48,
    em_cmd_pl_land_target = 0x49,
    em_cmd_pl_look_ck = 0x4A,
    em_cmd_kehai_clear = 0x4B,
    em_cmd_hate_clear = 0x4C,
    em_cmd_horm_pos_set = 0x4D,
    em_cmd_thirst_add = 0x4E,
    em_cmd_hungry_add = 0x4F,
    em_cmd_suimin_add = 0x50,
    em_cmd_swim_ck = 0x51,
    em_cmd_all_pl_target_sel = 0x52,
    em_cmd_samestage_pl_target_sel = 0x53,
    em_cmd_target_pl_samestage_ck = 0x54,
    em_cmd_target_pl_hate_high_ck = 0x55,
    em_cmd_quest_no_ck = 0x56,
    em_cmd_move_tbl_no_sel = 0x57,
    em_cmd_boss_pl_target_set = 0x58,
    em_cmd_tenjo_ck = 0x59,
    em_cmd_target_land_no_ck = 0x5A,
    em_cmd_ninshiki_timer_sub = 0x5B,
    em_cmd_tenjostage_ck = 0x5C,
    em_cmd_smell_set_ck = 0x5D,
    em_cmd_my_floor_ck = 0x5E,
    em_cmd_st25_pl_target_sel = 0x5F,
    em_cmd_st25_gate_ck = 0x60,
    em_cmd_runaway_timer_set = 0x61,
    em_cmd_dansa_sel = 0x62,
    em_cmd_type_and_ck = 0x63,
    em_cmd_target_pl_hate_ck = 0x64,
    em_cmd_all_pl_hate_clear = 0x65,
    em_cmd_pl_ride_ck = 0x66,
    em_cmd_em_master_ck = 0x67,
    em_cmd_em_cmd_reset = 0x68,
    em_cmd_horm_pos_ang_ck2 = 0x69,
    em_cmd_myemtype_sel_0 = 0x70,
    em_cmd_nando_ck = 0x71,
    em_cmd_arena_ck = 0x72,
    em_call_act_sel = 0x73,
    em_call_act_ck = 0x74,
    em_cmd_type2_sel = 0x75,
    em_cmd_season_sel = 0x76,
    em_cmd_day_ck = 0x77,
    em_cmd_haba_angle_ck = 0x78,
    em_cmd_unique_sel = 0x79,
    em_cmd_map_sel = 0x7A,
    em_act_rnd_update_7B = 0x7B,
    em_cmd_tougi_ck = 0x7C,
    em_cmd_var_sel = 0x7D,
    em_cmd_all_target_set = 0x7E,
    hd_tower_chase_ck = 0x7F,
    em_cmd_rnd32 = 0x80,
    em_cmd_contents = 0x81,
    em_cmd_sub_contents = 0x82,
    em_cmd_range_ck = 0x83,
    em_act_rnd_update = 0x84,
    hd_flag412_40_set = 0x85,
    hd_flag412_40_clear = 0x86,
    em_cmd_position_set = 0x90,
    em_cmd_vec_set = 0x91,
    em_cmd_demo_start = 0x92,
    em_cmd_wait_set = 0x93,
    em_cmd_em_atk_bit = 0x94,
    em_cmd_vec_set2 = 0x99,
    hd_hungry_ck = 0x9A,
    hd_tgt_jump_pl_ck = 0x9B,
    hd_tgt_jimen_height_ck = 0x9C,
    em_cmd_end_command = 0xFF,
};

fn aiSize(u32 p) {
    u8 op = rd8(p);
    u8 s = rd8(p + 1);
    if (op == 0x01 || op == 0x02 || op == 0x03 || op == 0x07 || op == 0x08 || op == 0x09 || op == 0x0A || op == 0x0D || op == 0x16 || op == 0x1F || op == 0x26 || op == 0x28 || op == 0x29 || op == 0x2A || op == 0x2E || op == 0x2F || op == 0x35 || op == 0x37 || op == 0x38 || op == 0x39 || op == 0x3A || op == 0x3B || op == 0x3C || op == 0x40 || op == 0x41 || op == 0x44 || op == 0x45 || op == 0x47 || op == 0x48 || op == 0x49 || op == 0x4A || op == 0x4E || op == 0x4F || op == 0x50 || op == 0x51 || op == 0x54 || op == 0x55 || op == 0x59 || op == 0x5B || op == 0x5C || op == 0x5D || op == 0x60 || op == 0x62 || op == 0x66 || op == 0x67 || op == 0x72 || op == 0x77 || op == 0x7C || op == 0x7F || op == 0x81 || op == 0x90 || op == 0x91 || op == 0x99 || op == 0xFF) return 2;
    if (op == 0x04 || op == 0x10 || op == 0x11 || op == 0x12 || op == 0x13 || op == 0x18 || op == 0x19 || op == 0x1E || op == 0x25 || op == 0x2D || op == 0x30 || op == 0x31 || op == 0x4B || op == 0x4C || op == 0x4D || op == 0x52 || op == 0x53 || op == 0x58 || op == 0x5F || op == 0x61 || op == 0x65 || op == 0x68 || op == 0x7B || op == 0x7E || op == 0x84 || op == 0x85 || op == 0x86 || op == 0x92 || op == 0x93) return 1;
    if (op == 0x05 || op == 0x3F) return 4;
    if (op == 0x06) { if (s == 3) return 5; return 4; }
    if (op == 0x0B || op == 0x14 || op == 0x1B || op == 0x22 || op == 0x32 || op == 0x36 || op == 0x42 || op == 0x5A || op == 0x5E || op == 0x63 || op == 0x64 || op == 0x69 || op == 0x71 || op == 0x74) { if (s == 0) return 3; if (s == 1 || s == 2) return 2; return 1; }
    if (op == 0x0C || op == 0x1A || op == 0x82) return 3;
    if (op == 0x0E || op == 0x2B || op == 0x34 || op == 0x3D || op == 0x46 || op == 0x56 || op == 0x78 || op == 0x9A || op == 0x9B || op == 0x9C) { if (s == 0) return 4; if (s == 1 || s == 2) return 2; return 1; }
    if (op == 0x0F) return 6;
    if (op == 0x15) { if (s == 0) return 7; if (s == 1) return 4; return 2; }
    if (op == 0x17) return 5;
    if (op == 0x1C || op == 0x1D || op == 0x20 || op == 0x23 || op == 0x27 || op == 0x2C || op == 0x33 || op == 0x70 || op == 0x73 || op == 0x75 || op == 0x76 || op == 0x7A || op == 0x7D) { if (s == 0) return 6; if (s == 1) return 3; return 2; }
    if (op == 0x21) return 2;
    if (op == 0x24) { if (s == 0) return 3; if (s == 1) return 2; return 1; }
    if (op == 0x3E || op == 0x57) { if (s == 0) return 7; if (s == 1) return 4; if (s == 2 || s == 3) return 2; return 1; }
    if (op == 0x79) { if (s == 0) return 7; if (s == 1) return 3; return 2; }
    if (op == 0x80) { if (s == 0) return 6; if (s <= 0x20) return 3; if (s == 0xFF) return 2; return 1; }
    if (op == 0x83) { if (s == 0) return 5; if (s < 6 || s == 0xFF) return 2; return 1; }
    if (op == 0x94) { if (s == 0) return 5; if (s == 1) return 3; return 2; }
    return 1;
};

fn aiInstrSize(u32 p) {
    u8 op = rd8(p);
    u8 s = rd8(p + 1);
    if (op == 0x82) return 3;
    if (op == 0x80) { if (s == 0) return 3; if (s <= 0x20) return 3; if (s == 0xFF) return 2; return 1; }
    if (op == 0x83) { if (s == 0) return 3; if (s < 6 || s == 0xFF) return 2; return 1; }
    if (op == 0x14) { if (s == 0) return 3; if (s == 1 || s == 2) return 2; return 1; }
    if (op == 0x05) return 4;
    if (op == 0xFF) return 2;
    if (s == 0) {
        if (op == 0x15 || op == 0x1C || op == 0x1D || op == 0x20 || op == 0x23 || op == 0x27 || op == 0x2C || op == 0x33 || op == 0x3E || op == 0x57 || op == 0x70 || op == 0x73 || op == 0x75 || op == 0x76 || op == 0x7A || op == 0x7D || op == 0x80 || op == 0x83) return 3;
        if (op == 0x79) return 4;
        if (op == 0x94) return 2;
    }
    return aiSize(p);
};

/// Returns the offset of the 0 terminator of the script starting at p
fn aiScriptEnd(u32 p) {
    u32 o = p;
    while (rd8(o) != 0)
        o = o + aiInstrSize(o);
    return o;
};

struct AiInstr {
    u32 n = aiInstrSize($);
    AiOp op;
    if (n > 1)
        u8 args[n - 1];
};

struct AiScript {
    AiInstr code[while(rd8($) != 0)];
};

struct AiScriptRef {
    if (rd32($) != 0)
        AiScript *script : u32;
    else
        u32 none;
};
