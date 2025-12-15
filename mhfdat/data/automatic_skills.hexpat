#pragma once

#include <misc/s32p.pat>
#include <misc/automaticskills.hexpat>
#include <std/mem.pat>

fn getEquipClass(u8 n) {
	match (n) {
		(1): return "Armor";
		(0): return "Weapon";
	}
	return "UnknownClass";
};

fn getEquipType(u8 n) {
	str ret = "!!Unknown!!";
	match (n) {
		(0x00): ret = "Legs";
		(0x02): ret = "Head";
		(0x03): ret = "Chest";
		(0x04): ret = "Arms";
		(0x05): ret = "Waist";
		(0x06): ret = "Melee";
		(0x07): ret = "Ranged";
	}
	return ret;
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
	u8  equipClass [[format("getEquipClass")]];
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

fn get_autoskills_count(ptr start_addr) {
	u32 count = 0;
	ptr current_addr = start_addr;

	while (count < 5000) {
		if (current_addr + sizeof(AutoSkill) > std::mem::size())
			break;

		u8  equipClass = std::mem::read_unsigned(current_addr,     1);
		u8  eqType     = std::mem::read_unsigned(current_addr + 1, 1);
		u16 equipID    = std::mem::read_unsigned(current_addr + 2, 2);
		u16 skill_id   = std::mem::read_unsigned(current_addr + 4, 2);

		if (equipClass == 0 && eqType == 0 && equipID == 0 && skill_id == 0)
			break;
		if (equipID == 0xFFFF)
			break;
		if (eqType > 7 && eqType != 0)
			break;
		if (eqType == 1)
			break;

		count += 1;
		current_addr += sizeof(AutoSkill);
	}

	if (count == 0)
		count = 1;

	return count;
};

AutoSkill automaticSkills[
	get_autoskills_count(header.ptrs.AutomaticSkillsTable)
] @ header.ptrs.AutomaticSkillsTable [[name("Automatic Skills")]];
