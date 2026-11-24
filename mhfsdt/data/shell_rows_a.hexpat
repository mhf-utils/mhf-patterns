#pragma once

#include <mhfsdt/utils/index.pat>

// =======================
// Table A: hit parameters, one 0x28 row per shell id (slot +6). The row is
// copied byte for byte to hit +0x68 (HitboxEntry_CopyPassive /
// HitboxEntry_CopyAndPostProcess), so A+x = hit+(0x68+x); rehit_delay,
// reaction_param and sharp_col_a are halved by the copy (0xFF kept).
// The same 0x28 format is used by the attack tables built into the DLL
// (slot +0xA8, kind 66 / em132...).
//
// Damage (A+0x04):
//   monster -> player (Monster_ApplyDamageToPlayer): absolute base damage
//     dmg = damage x EnemyWork.attackPower [x slot+0xF6 / 100]
//           x (1 - def / (def + 80)) x (100 - element res) / 100
//   player -> monster (on_hit_effects_dispatch): motion value
//     dmg = MV [x slot+0xF6 x 0.01] x hitzone term x PlayerWork.attackPower
//           + element total
//     hitzone term = max(cut, impact hitzone x split %) x 0.01
//                    x g_hit_8a_multiplier_table[column + sharpness tier x 4]
//     the MV is already modified on hit +0x6C before the hit: crit
//     (x player_critical_hit_damage_multiplier, sets hit_fx.critical),
//     negative affinity (x 0.75, sets hit_fx.negative_affinity), Charge
//     Attack Up (adds to it), slot+0x118 (cap 1000, shell_apply_attack_table)
//
// Each row shows "kind K row N | MV / damage | users": the users are the weapon class + move
// (player kinds) or the monster + action functions (monster kinds) that spawn this shell id,
// names as in mhfo-hd.dll (see utils/row_owner.pat). An empty user list means no spawn site
// of this row was traced.
// =======================

bitfield ElementFlags {
    impact  : 1 [[comment("Impact hitzone column; OR'ed into victim partElementMask[part]")]];
    cut     : 1 [[comment("Cut hitzone column; tail cut needs it on most monsters")]];
    fire    : 1 [[comment("Monster hits: x (100 - PlayerWork.pl_fireRes) / 100, blight 0")]];
    padding : 1; // 0x08: only OR'ed into victim partElementMask[part], never tested (kind 160 row 72, kind 529 rows 1 / 3)
    water   : 1 [[comment("Monster hits: PlayerWork.pl_waterRes")]];
    dragon  : 1 [[comment("Monster hits: PlayerWork.pl_dragonRes")]];
    thunder : 1 [[comment("Monster hits: PlayerWork.pl_thunderRes")]];
    ice     : 1 [[comment("Monster hits: PlayerWork.pl_iceRes")]];
};

bitfield StatusMask {
    sleep            : 1 [[comment("PlayerWork.pl_sleepPending")]];
    poison           : 1 [[comment("PlayerWork.pl_poisonPending; severe poison for a Zenith Espinas / enraged Gasurabazura attacker")]];
    paralysis        : 1 [[comment("PlayerWork.pl_paraPending")]];
    tranquilizer     : 1 [[comment("EnemyWork.em_tranqHitBuildup (em_tranq_add); kind 6 row 29 only")]];
    elem_fire        : 1 [[comment("Player hits: fire element (victim partElementMask)")]];
    elem_water       : 1 [[comment("Player hits: water element")]];
    elem_thunder     : 1 [[comment("Player hits: thunder element")]];
    elem_dragon      : 1 [[comment("Player hits: dragon element")]];
    snowman          : 1;
    elem_ice         : 1 [[comment("Player hits: ice element")]];
    stench           : 1;
    stamina_max_down : 1 [[comment("Sets PlayerWork.pl_staminaMaxDownPending = 10 (hit_status_buildup_apply)")]];
    vocal_cords      : 1;
    defense_down     : 1 [[comment("On a monster: Table D kind 125 row 12")]];
    freeze_or_crystal : 1 [[comment("Ice attackers Dyuragaua / Duremudira / ThirdPhaseDuremudira / ArrogantDuremudira: freeze (PlayerWork.pl_freezePending); others: crystal (PlayerWork.pl_crystalBuildup)")]];
    shot_49_51_element : 1 [[comment("Runtime only: kind 6 shots 49-51 count as elemental (hit_is_elemental)")]];
    sharpen_reload   : 1;
    blind_fog        : 1 [[comment("Forokururu black fog: PlayerWork.pl_blindFogTimer = status_buildup (frames), attaches the kind 999 shells")]];
    set_hp           : 1 [[comment("set_player_hp(status_buildup); on a monster: Table D kind 125 row 17")]];
    attack_buff      : 1 [[comment("item_write_attack_buff_slot(status_buildup); on a monster: Table D kind 125 row 16")]];
    corrupted_poison : 1 [[comment("Duremudira corrupted poison (kinds 145 / 167)")]];
    padding          : 1; // 0x200000: no row sets it, no reader
    freeze_action_4  : 1 [[comment("Freeze action flag 4 (side +0x6BC)")]];
    freeze_action_8  : 1 [[comment("Freeze action flag 8 (side +0x6BC)")]];
    blast            : 1;
    zenith_sleep     : 1 [[comment("Severe sleep (side +0x72E): kinds 304 / 429")]];
    frenzy           : 1 [[comment("Frenzy virus: kinds 162 / 164")]];
    zenith_para      : 1 [[comment("Severe paralysis (side +0x734)")]];
    crystal_zenith_para : 1 [[comment("Crystal + severe paralysis: kind 306 only")]];
    bleed            : 1;
    zenith_spike_mark : 1 [[comment("Zenith Hyujikiki spike stuck on the player (kind 110 shells 25-27, runtime)")]];
    padding          : 1; // 0x80000000: no row sets it, no reader
};

bitfield GuardFlags {
    padding : 1; // 0x0001: no reader
    push_fixed_angle : 1 [[comment("Knock direction = shell yaw + push_angle; has priority (hit_set_victim_knock_dir)")]];
    push_from_impact : 1 [[comment("Direction from the contact point; ignores 0x8 / 0x800 / 0x1000")]];
    push_monster_facing : 1 [[comment("Direction = attacker yaw")]];
    padding : 3; // 0x0010 (3529 rows), 0x0020 (kind 128), 0x0040 (3259 rows): no reader
    heavy_guard       : 1 [[comment("Guard needs guard level >= 4")]];
    push_no_turn : 1 [[comment("Non-local victims: direction = victim yaw - 90, no turn")]];
    guard_up_required : 1 [[comment("Blockable only with Guard Up (Lance / Gunlance, stamina > 75)")]];
    unblockable       : 1 [[comment("Guard test skipped")]];
    push_away_from_monster : 1 [[comment("Direction monster -> contact point")]];
    push_toward_monster : 1 [[comment("Direction contact point -> monster")]];
    padding : 3; // 0x2000 / 0x4000 / 0x8000: no reader
};

bitfield MultiHit {
    hits_left      : 4 [[comment("Decremented per hit; the shell ends at 0")]];
    rehit_interval : 4 [[comment("Written back to rehit_delay (hit +0x68) when the hit re-arms")]];
};

bitfield HitFx {
    effect_class : 6 [[comment("Impact effect / sound class; 0 = none, 2 sets hit +0x90 |= 0x200, 0x23 has an extra call")]];
    negative_affinity : 1 [[comment("Runtime only: negative affinity roll (damage x 0.75)")]];
    critical     : 1 [[comment("Crit: damage x player_critical_hit_damage_multiplier; kept across the copy")]];
};

fn hit_param_fmt(ref auto r) {
    return std::format("kind {} row {} | MV / damage {} | {}", r.kind, r.row, r.damage, row_owner(r.kind, r.row));
};

struct ShellRowA {
    u32 owner = owner_descriptor($, 0x08, 0x04, 2, ROW_A_SIZE);
    s16 kind = kind_at(owner);
    u32 row = (owner == 0xFFFFFFFF) ? 0 : ($ - rd32(owner + 0x08)) / ROW_A_SIZE;
    u16 rehit_delay [[comment("Frames before the hit (re)activates; halved on copy; player hits subtract PlayerWork.motionStartFrame0 / motionBlendTicks0")]];
    u16 reaction_param [[comment("Reaction duration in frames; halved on copy, divided by the shell speed (shell_apply_attack_table, cap 60000)")]];
    u16 damage [[color("00C853"), comment("Monster attack: base damage x attack power. Player attack: motion value (hit +0x6C). See the formulas at the top")]];
    u16 reaction_id [[color("AB47BC"), comment("Victim reaction (PlayerWork.hitReactionId, Monster_ApplyDamageToPlayer switch: 8 = heal, 0x7A / 0x7B launch, 0x7B adds 200 stun...). Hardcore variants upgrade it on copy: 0xF->4, 5->0x26, 0xE->5, 4->0x15, 0x12->0x35, 0x14->0x36, 0x1A->0x37")]];
    padding[2]; // hit +0x70: only copied, no reader (2 rows non-zero)
    GuardFlags guard_flags [[comment("OR'ed into victim guardFlagsIn (guard test 0x80 / 0x200 / 0x400) and read by the knock direction")]];
    s8 push_angle [[comment("Degrees added to the shell yaw with push_fixed_angle")]];
    padding[1]; // hit +0x75: no reader (0xE0 on 1719 rows)
    u8 knock_power [[color("26A69A"), comment("Victim hitKnockPower: <= 10 small flinch, > 10 launch; x slot+0x120 (cap 255); enraged Rajang forces >= 50")]];
    ElementFlags element_flags [[color("FF7043"), comment("Damage type (impact / cut) and element; monster hits: damage x (100 - res) / 100, then blight")]];
    u16 group_index [[color("FFC107"), comment("Index into the descriptor groups; slot 0 becomes the volume list (hit +0xA0)")]];
    s16 impact_se_mode [[comment("Hit sound: 1 = se_req_3D(0x20), 0x0D = range-timed SE 0x21, 0xFF = none, else se_req_3D(0x21)")]];
    StatusMask status_mask [[color("E91E63"), comment("hit_status_buildup_apply")]];
    s32 status_buildup [[comment("Buildup of the status_mask bits for non-player kinds; on player weapon hits replaced by the weapon element value")]];
    HitFx hit_fx;
    u8 hitstop_frames [[comment("Attacker hitstop: the monster on a player hit, the player on a monster hit (capped at 10)")]];
    u8 spirit_gauge_gain [[comment("Long Sword spirit gauge, x g_ls_spirit_gauge_gain_mult[hit result]; kinds 0 / 85 / 108")]];
    MultiHit multi_hit;
    padding[1]; // hit +0x88: no reader (3 rows non-zero)
    u8 stun_value [[color("FF7043"), comment("KO. Player: PlayerWork.pl_stunPending -> stunGauge, stunned at >= 50 (x2 / x1.5 by status, halved in quest 0x61A9). Monster: x skill mults x hitzone KO value / 100. x slot+0x11C (cap 255). Not element damage")]];
    u8 sharp_col_a [[comment("Halved on copy. Column of g_hit_8a_multiplier_table: 0xFF = 0, non-zero = 1, 0 = see sharp_col_b")]];
    u8 sharp_col_b [[comment("Read when sharp_col_a == 0: non-zero = column 2, or 3 when the attacking volume hzv_index (+4) == 1")]];
    u16 status_buildup_player [[comment("Secondary status buildup for player kinds (weapon poison / para / sleep / blast, written as an i32 with the padding)")]];
    padding[2];
} [[format("hit_param_fmt")]];
