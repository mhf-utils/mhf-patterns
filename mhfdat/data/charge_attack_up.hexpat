#pragma once

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Charge Attack Up (header 0x984): one row per weapon class (PlayerWork +3,
// < 0xE in both readers; rd_mhfdat relocates 14 rows). Skill 0x1C8 gives tier
// 2, else 0x1C7 tier 1; column = tier - 1 (clamped to 0-4).
// weapon_charge_attack_up_bonus: the first hit row whose kind / sub equal hit
// +4 / +6 adds bonus[column] to the hit value (hit +0x6C).
// weapon_charge_attack_up_multiplier: the attack x multiplier[column] / 1000
// when a hit row matches (or when the caller skips the match).
// =======================

struct ChargeAttackUpHit {
    s16 hitKind [[comment("Compared with hit +4")]];
    s16 hitSub [[comment("Compared with hit +6")]];
    u8 bonus[5] [[comment("Added to the hit value, by column (MOVZX)")]];
    padding[1];
};

struct ChargeAttackUp {
    s16 n = std::mem::read_signed($ + 4, 2);
    ChargeAttackUpHit *hits[n] : u32;
    s16 hitCount;
    s16 multiplier[5] [[comment("x 0.001, by column")]];
} [[name(className(std::core::array_index()))]];

ChargeAttackUp chargeAttackUp[14] @ header.ptrs.chargeAttackUp [[name("Charge Attack Up")]];
