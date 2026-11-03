#pragma once

/**
	Secret Book (秘伝書) effects: header 0x318 holds 18 tiers x 14 weapon
	classes of pointers, each to a list of {SR threshold, effect id} ending at
	a threshold of -1; header 0x5B8 turns a Skill Rank into a level, ending at
	SR 10000. The tier is the number of Secret Books owned (1-14), or 15 to 18
	when 11 to 14 of them are owned and maxed.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

struct SecretBookEffect {
    s16 srThreshold;
    u16 effect;
};

struct SecretBookEffectList {
    SecretBookEffect entries[while(std::mem::read_signed($, 2) != -1)];
    SecretBookEffect end;
};

struct SecretBookTier {
    ptVar<SecretBookEffectList> classes[14];
};

SecretBookTier secretBookEffects[18] @ header.ptrs.secretBookEffects [[name("Secret Book Effects"), comment("Tier 1 to 18, then the weapon class")]];

struct SecretBookSrLevel {
    u16 sr;
    u16 level;
};

struct SecretBookSrLevels {
    SecretBookSrLevel entries[while(std::mem::read_unsigned($, 2) != 10000)];
    SecretBookSrLevel end;
};

SecretBookSrLevels secretBookSrLevels @ header.ptrs.secretBookSrLevels [[name("Secret Book SR Levels")]];

// =======================
// Effect values and G (GSR) unlocks. Header 0x528: value of each effect id
// (SbSpabiGetValue). Header 0x758: {GSR, type} unlocks ending at GSR >= 1000;
// GsbCountUnlocks counts the reached ones per type (types 13 / 14 add one to
// types 1 / 2 per other G book). SbSpabiGetValue adds table[count of the
// type] to the value, by effect family: 0x1 defense -> 0x764 (type 3), 0x2-0x6
// fire / water / thunder / ice / dragon res -> 0x768-0x778 (types 4-8), 0x7 all
// res -> 0x77C (type 9); 0x0B [極] defense = 0x760 (type 1), 0x0C [極] attack
// = 0x75C (type 2). Arrays run to the next table; the code index stops at the
// type's unlock count. Proofs: docs/reverse/secret_book_effects.md.
// =======================

u8 secretBookEffectValues[0xA0] @ header.ptrs.secretBookEffectValues [[name("Secret Book Effect Values"), comment("by effect id 0x00-0x9E")]];

struct GsrUnlock {
    u16 gsr;
    u16 type [[comment("1 [極] defense, 2 [極] attack, 3 defense bonus, 4-9 resistance bonuses, 10 0x0D, 11 0x0F, 12 0x0E, 13 / 14 +1 type 1 / 2 per other G book")]];
};

GsrUnlock gsrUnlocks[while (std::mem::read_unsigned($, 2) < 1000)] @ header.ptrs.gsrUnlocks [[name("GSR Unlocks")]];
u16 gsrExtremeAttack[48] @ header.ptrs.gsrExtremeAttack [[name("GSR Extreme Attack"), comment("0x0C [極] attack by type 2 count (SbGetExtremeAttack)")]];
u16 gsrExtremeDefense[48] @ header.ptrs.gsrExtremeDefense [[name("GSR Extreme Defense"), comment("0x0B [極] defense by type 1 count (SbGetExtremeDefense)")]];
u16 gsrDefenseBonus[32] @ header.ptrs.gsrDefenseBonus [[name("GSR Defense Bonus"), comment("added to family 0x1 (defense) by type 3 count")]];
u8 gsrFireResBonus[8] @ header.ptrs.gsrFireResBonus [[name("GSR Fire Res Bonus"), comment("family 0x2, type 4 count")]];
u8 gsrWaterResBonus[8] @ header.ptrs.gsrWaterResBonus [[name("GSR Water Res Bonus"), comment("family 0x3, type 5 count")]];
u8 gsrThunderResBonus[8] @ header.ptrs.gsrThunderResBonus [[name("GSR Thunder Res Bonus"), comment("family 0x4, type 6 count")]];
u8 gsrIceResBonus[8] @ header.ptrs.gsrIceResBonus [[name("GSR Ice Res Bonus"), comment("family 0x5, type 7 count")]];
u8 gsrDragonResBonus[8] @ header.ptrs.gsrDragonResBonus [[name("GSR Dragon Res Bonus"), comment("family 0x6, type 8 count")]];
u8 gsrAllResBonus[8] @ header.ptrs.gsrAllResBonus [[name("GSR All Res Bonus"), comment("family 0x7, type 9 count")]];
