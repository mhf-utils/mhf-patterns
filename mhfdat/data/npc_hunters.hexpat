#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// NPC hunters (header 0x56C to 0x574): the hunters npc_hunters_pick
// (room setup state 0x14, 2 hunters with 1 player in the room, else 1) adds,
// named by mhfpac pCaravanElementNames (Non, Ignir, Thales, Irena, Hiems, Zari).
// The hunter order is shuffled; for each one the game picks at random a weapon
// and an armor set of that hunter whose HR window holds the player's HR, the
// armor set of the weapon's side (weaponKind 6 = blademaster, else gunner).
// npc_hunter_card_build copies the appearance and equipment into a 0x114-byte
// hunter record (the Partner's record uses the same fields). Identical on the
// EN, JP and rain files.
// =======================

struct NpcHunter {
    u8 hunter [[comment("pCaravanElementNames index")]];
    u8 gender [[comment("0 = male, 1 = female")]];
    u8 face;
    u8 hairstyle;
    u8 voice;
    u8 inner;
    padding[2];
};

struct NpcHunterWeapon {
    u8 hunter;
    u8 kind [[format("getEquipType")]];
    u16 minHr;
    u16 maxHr;
    u16 weapon;
} [[format("npcHunterWeaponName")]];

fn npcHunterWeaponName(ref auto w) {
    return std::format("hunter {} | HR {}-{} | {}", w.hunter, w.minHr, w.maxHr, getEquipKindName(w.kind, w.weapon));
};

struct NpcHunterArmorSet {
    u8 hunter;
    u8 weaponKind [[format("getEquipType"), comment("6: worn with a melee weapon, else with a ranged one")]];
    u16 minHr;
    u16 maxHr;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
} [[format("npcHunterArmorSetName")]];

fn npcHunterArmorSetName(ref auto a) {
    return std::format("hunter {} | HR {}-{} | {}", a.hunter, a.minHr, a.maxHr, getEquipKindName(2, a.head));
};

NpcHunter npcHunters[importantNums.numNpcHunters] @ header.ptrs.npcHunters [[name("NPC Hunters")]];
NpcHunterWeapon npcHunterWeapons[importantNums.numNpcHunterWeapons] @ header.ptrs.npcHunterWeapons [[name("NPC Hunter Weapons")]];
NpcHunterArmorSet npcHunterArmorSets[importantNums.numNpcHunterArmorSets] @ header.ptrs.npcHunterArmorSets [[name("NPC Hunter Armor Sets")]];
