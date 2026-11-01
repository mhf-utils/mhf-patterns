#pragma once

#include <mhfsdt/utils/index.pat>

bitfield ElementFlags {
    impact  : 1;
    cut     : 1;
    fire    : 1;
    flag_08 : 1;
    water   : 1;
    dragon  : 1;
    thunder : 1;
    ice     : 1;
};

bitfield StatusMask {
    sleep            : 1;
    poison           : 1;
    paralysis        : 1;
    tranquilizer     : 1;
    elem_fire        : 1;
    elem_water       : 1;
    elem_thunder     : 1;
    elem_dragon      : 1;
    snowman          : 1;
    elem_ice         : 1;
    stench           : 1;
    voice_c84        : 1;
    vocal_cords      : 1;
    defense_down     : 1;
    freeze_or_crystal : 1;
    shot_49_51_element : 1;
    sharpen_reload   : 1;
    blind_fog        : 1;
    set_hp           : 1;
    attack_buff      : 1;
    corrupted_poison : 1;
    unused_200000    : 1;
    freeze_action_4  : 1;
    freeze_action_8  : 1;
    blast            : 1;
    zenith_sleep     : 1;
    frenzy           : 1;
    zenith_para      : 1;
    crystal_zenith_para : 1;
    bleed            : 1;
    zenith_spike_mark : 1;
    unused_80000000  : 1;
};

bitfield GuardFlags {
    flag_0001 : 1;
    push_fixed_angle : 1;
    push_from_impact : 1;
    push_monster_facing : 1;
    flag_0010 : 1;
    flag_0020 : 1;
    flag_0040 : 1;
    heavy_guard       : 1;
    push_no_turn : 1;
    guard_up_required : 1;
    unblockable       : 1;
    push_away_from_monster : 1;
    push_toward_monster : 1;
    flag_2000 : 1;
    flag_4000 : 1;
    flag_8000 : 1;
};

bitfield MultiHit {
    hits_left      : 4;
    rehit_interval : 4;
};

bitfield HitFx {
    effect_class : 6;
    flag_40      : 1;
    critical     : 1;
};

struct ShellRowA {
    u16 rehit_delay;
    u16 reaction_param;
    u16 damage [[color("00C853")]];
    u16 reaction_id [[color("AB47BC")]];
    u16 hit_70;
    GuardFlags guard_flags;
    s8 push_angle;
    u8 hit_75;
    u8 knock_power [[color("26A69A")]];
    ElementFlags element_flags [[color("FF7043")]];
    u16 group_index [[color("FFC107")]];
    s16 impact_fx_mode;
    StatusMask status_mask [[color("E91E63")]];
    s32 status_buildup;
    HitFx hit_fx;
    u8 hitstop_frames;
    u8 spirit_gauge_gain;
    MultiHit multi_hit;
    u8 hit_88;
    u8 stun_value [[color("FF7043")]];
    u8 sharp_col_a;
    u8 sharp_col_b;
    u16 status_buildup_alt;
    padding[2];
};
