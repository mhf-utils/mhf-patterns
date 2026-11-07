#pragma once

#include <misc/s32p.pat>
#include <misc/automaticskills.hexpat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

fn getEquipClass(u8 n) {
	match (n) {
		(1): return "Armor";
		(0): return "Weapon";
	}
	return "UnknownClass";
};

fn getEquipNameFromID(u16 equipID, u8 equipType) {
	match (equipType) {
		(0): return rIPPS(header.ptrs.legArmorNames, equipID);
		(2): return rIPPS(header.ptrs.headArmorNames, equipID);
		(3): return rIPPS(header.ptrs.bodyArmorNames, equipID);
		(4): return rIPPS(header.ptrs.armArmorNames, equipID);
		(5): return rIPPS(header.ptrs.waistArmorNames, equipID);
		(6): return rIPPS(header.ptrs.meleeWeaponNames, equipID);
		(7): return rIPPS(header.ptrs.rangedWeaponNames, equipID);
	}
	return std::format("{:04X}", equipID);
};

struct AutoSkill {
	u8  equipClass [[format("getEquipClass"), comment("No reader: autoskills_find_entry_for_item / autoskills_lookup_equip_slots match eqType + equipID only")]];
	u8  eqType     [[format("getEquipType")]];
	u16 equipID    [[comment("getEquipNameFromID(equipID, eqType)")]];
	autoSkillList skill_id;
	padding[2];
} [[format("autoskillsFmt")]];

using AutoSkill;
fn autoskillsFmt(AutoSkill entry) {
	return std::format(
		"[{}] {} | {} | {}",
		getEquipClass(entry.equipClass),
		getEquipType(entry.eqType),
		getEquipNameFromID(entry.equipID, entry.eqType),
		entry.skill_id
	);
};

AutoSkill automaticSkills[importantNums.numAutoSkills] @ header.ptrs.AutomaticSkillsTable [[name("Automatic Skills")]];
