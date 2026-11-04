#pragma once

/**
	Rasta guild (the player's own Rasta): hunt orders (header 0x254, until a
	monster of -1; clearing one sets its bit in the save's hunt bits), the GCP
	cost of each Loyalty and Cred level (header 0x258 / 0x25C, read at
	[current level + 1]), and what each level gives (level 0 to 20): attack
	(0x600), element (0x604) and defense (0x608) in percent of the player's,
	and the most active skills (0x60C).
	Equipment lists (header 0x238 to 0x250, menu state 0x8D,
	rasta_equipment_list_build): the weapons (by Loyalty) and armor (by Cred)
	of each rank, one list per equipment type, until an id of 0xFFFF. The menu
	lists the rows of the chosen rank (cursor 0-9; rows of rank 10 exist) and,
	for weapons, of the chosen class. A row is locked while rank > level - 1,
	and a weapon row also while its class is not unlocked
	(rasta_unlock_bit_test; Sword and Shield and Tonfa skip that test).
	Otherwise it is marked owned when the equipment box holds that equipment
	(equip_box_has_equipment).
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <misc/s32p.pat>

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

struct RastaWeaponEntry<auto Kind> {
    u16 weapon [[comment("Row of the melee (0x238) or ranged (0x23C) weapon table; its classId picks the class page")]];
    u16 rank   [[comment("Listed on this rank page; locked while rank > Loyalty level - 1")]];
} [[format("rastaEquipEntryName")]];

struct RastaArmorEntry<auto Kind> {
    u16 armor [[comment("Row of the armor table of this type")]];
    u16 unk02;
    u16 rank  [[comment("Listed on this rank page; locked while rank > Cred level - 1")]];
} [[format("rastaEquipEntryName")]];

fn rastaEquipEntryName(ref auto e) {
    u16 id = std::mem::read_unsigned(addressof(e), 2);
    return std::format("rank {} | {}", e.rank, getEquipKindName(e.Kind, id));
};

struct RastaWeaponList<auto Kind> {
    RastaWeaponEntry<Kind> entries[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    u16 end;
};

struct RastaArmorList<auto Kind> {
    RastaArmorEntry<Kind> entries[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    u16 end;
};

RastaWeaponList<6> rastaMeleeWeapons @ header.ptrs.rastaMeleeWeapons [[name("Rasta Melee Weapons")]];
RastaWeaponList<7> rastaRangedWeapons @ header.ptrs.rastaRangedWeapons [[name("Rasta Ranged Weapons")]];
RastaArmorList<2> rastaHeadArmor @ header.ptrs.rastaHeadArmor [[name("Rasta Head Armor")]];
RastaArmorList<3> rastaChestArmor @ header.ptrs.rastaChestArmor [[name("Rasta Chest Armor")]];
RastaArmorList<4> rastaArmsArmor @ header.ptrs.rastaArmsArmor [[name("Rasta Arms Armor")]];
RastaArmorList<5> rastaWaistArmor @ header.ptrs.rastaWaistArmor [[name("Rasta Waist Armor")]];
RastaArmorList<0> rastaLegsArmor @ header.ptrs.rastaLegsArmor [[name("Rasta Legs Armor")]];
