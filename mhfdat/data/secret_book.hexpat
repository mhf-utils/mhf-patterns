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
