#pragma once

#include <std/mem.pat>
#include <misc/s32p.pat>
#include <mhfdat/header.hexpat>

/**
	@param n The item ID
	@return The item ID, formatted as expected by Ferias /sozai/sozai.htm?{ID}
	Optionally also returns the item name, comment out the first return
	to disable.
*/
fn getItemName(u16 n) {
	return std::format("{:04X} | {}", n, rIPPS(header.ptrs.itemNames, n));
return std::format("{:04X}", n);
};

/**
	An item ID shown with its name, for arrays of item IDs
*/
using ItemId = u16 [[format("getItemName")]];

/**
	Add 1 to n (used for pattern formatting: rarities are stored from 0)
*/
fn plusone (u8 n) {
	return n+1;
};

/**
	@param n An equipment type, as crafting and automatic skill records store it
	@return Its name
*/
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

/**
	A table with no end marker ends where the next table the header points to
	starts, and some markers lie past it (the JP combine shop runs into the
	tables after it).
	@param addr A table's address
	@return The address of the next table the header points to, or the file's end
*/
fn nextTable(u32 addr) {
	u32 next = std::mem::size();
	u32 slot = 0x10;
	while (slot < 0xBC8) {
		u32 target = std::mem::read_unsigned(slot, 4);
		if (target > addr && target < next) next = target;
		slot += 4;
	}
	return next;
};

/**
	@param n A weapon class id (weapon records, crafting, the per-class tables)
	@return Its name
*/
fn className(u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Great Sword";
		(0x01): ret = "Heavy Bowgun";
		(0x02): ret = "Hammer";
		(0x03): ret = "Lance";
		(0x04): ret = "Sword and Shield";
		(0x05): ret = "Light Bowgun";
		(0x06): ret = "Dual Blades";
		(0x07): ret = "Long Sword";
		(0x08): ret = "Hunting Horn";
		(0x09): ret = "Gunlance";
		(0x0A): ret = "Bow";
		(0x0B): ret = "Tonfa";
		(0x0C): ret = "Switch Axe F";
		(0x0D): ret = "Magnet Spike";
	}

	return ret;
};
