#pragma once

/**
	Rasta guild (the player's own Rasta): hunt orders (header 0x254, until a
	monster of -1; clearing one sets its bit in the save's hunt bits), the GCP
	cost of each Loyalty and Cred level (header 0x258 / 0x25C, read at
	[current level + 1]), and what each level gives (level 0 to 20): attack
	(0x600), element (0x604) and defense (0x608) in percent of the player's,
	and the most active skills (0x60C).
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>

struct RastaHuntOrder {
    u16 monster                 [[format("rastaHuntMonster")]];
    u8  orderType               [[comment("2 = hunt the monster (its count in the quest work); the order in progress must match")]];
    u8  huntBit;
};

fn rastaHuntMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct RastaHuntOrders {
    RastaHuntOrder orders[while(std::mem::read_signed($, 2) != -1)];
    s16 end;
};

RastaHuntOrders rastaHuntOrders @ header.ptrs.rastaHuntOrders [[name("Rasta Hunt Orders")]];

u32 rastaLoyaltyCosts[21] @ header.ptrs.rastaLoyaltyCosts [[name("Rasta Loyalty Level Costs (GCP)")]];
u32 rastaCredCosts[21] @ header.ptrs.rastaCredCosts [[name("Rasta Cred Level Costs (GCP)")]];

u8 rastaLoyaltyAttackPercent[21] @ header.ptrs.rastaLoyaltyAttackPercent [[name("Rasta Loyalty: Attack Percent")]];
u8 rastaLoyaltyElementPercent[21] @ header.ptrs.rastaLoyaltyElementPercent [[name("Rasta Loyalty: Element Percent")]];
u8 rastaCredDefensePercent[21] @ header.ptrs.rastaCredDefensePercent [[name("Rasta Cred: Defense Percent")]];
u8 rastaCredSkillSlots[21] @ header.ptrs.rastaCredSkillSlots [[name("Rasta Cred: Skill Slots")]];
