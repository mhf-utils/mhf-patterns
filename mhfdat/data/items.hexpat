#pragma once
#include <mhfdat/utils/index.pat>

/**
	All icons can be found in 0055_001266FC.png, extracted from dat/mhf.dat
*/
fn getItemIconName(u8 icon) {
	match (icon) {
		(0x00): return "smoke";
		(0x01): return "orb";
		(0x02): return "bomb";
		(0x03): return "meat";
		(0x04): return "fish_bait";
		(0x05): return "fish";
		(0x06): return "box";
		(0x07): return "whetstone";
		(0x08): return "dung";
		(0x09): return "monster";
		(0x0A): return "bones";
		(0x0B): return "binoculars";
		(0x0C): return "mushroom";
		(0x0D): return "bugnet";
		(0x0E): return "pelt";
		(0x0F): return "leaf";
		(0x10): return "pickaxe";
		(0x11): return "barrel";
		(0x12): return "seed";
		(0x13): return "bbq_spit";
		(0x14): return "insect";
		(0x15): return "trap";
		(0x16): return "net";
		(0x17): return "scale";
		(0x18): return "drink";
		(0x19): return "egg";
		(0x1A): return "ammo";
		(0x1B): return "stone";
		(0x1C): return "husk";
		(0x1D): return "map";
		(0x1E): return "flute";
		(0x1F): return "fang";
		(0x20): return "grid";
		(0x21): return "question_mark";
		(0x22): return "coin";
		(0x23): return "sac";
		(0x24): return "book";
		(0x25): return "ticket";
		(0x26): return "knife";
		(0x29): return "music_sheet";
		(0x2B): return "jewel";
		(0x2C): return "house";
		(0x2D): return "plant";
		(0x2F): return "mocha";
		(0x30): return "pot";
		(0x31): return "boomerang";
		(0x32): return "coating";
		(0x33): return "empty_bottle";
		(0x34): return "carapace";
		(0x4F): return "sword_crystal";
		(0x50): return "potion";
		(0x52): return "fruit";
		(0x56): return "tower_w_sigil";
		(0x5B): return "tower_a_sigil";
		(0x5C): return "mantle";
		(0x5D): return "armor_sphere";
	}
	return "unknown";
};

fn getItemIconColorName(u8 color) {
	match (color) {
		(0): return "white";
		(1): return "red";
		(2): return "green";
		(3): return "blue";
		(4): return "yellow";
		(5): return "purple";
		(6): return "teal";
		(7): return "orange";
		(8): return "pink";
		(10): return "grey";
	}
	return "white";
};

u32 __sizeof_Item = 0x24;

fn plusone (u8 n) {
	return n+1;
};

fn equipType (u16 n) {
str ret = "!!Unknown!!";

match (n) {
	(0x00): ret = "Normal Cuff";
	(0x01): ret = "Premium Cuff";
	(0x02): ret = "Cat Deco";
	(0x03): ret = "Cat Deco2";
	(0x04): ret = "Tower Deco";
	(0x06): ret = "Sigil";
	(0x07): ret = "Sigil2";
	(0x08): ret = "Z Cuff";
	(0x09): ret = "Premium Z Cuff";
	(0x0A): ret = "Sigil3";
	(0x0B): ret = "Hidden Cuff";
}

return ret;
};
	
fn getStructItemName(auto i) {
	return getItemName(($-header.ptrs.itemData)/__sizeof_Item);
};

fn getItemInteractionTypeName(u8 n) {
	match (n) {
		(0): return "None";
		(1): return "Carryable";
		(2): return "Ammo";
		(3): return "Coating";
	}
	return "Unknown";
};

fn getItemUsabilityFlags(u8 f) {
	str ret = "";
	if (f & 0x01) ret += "Usable ";
	if (f & 0x02) ret += "Quest ";
	if (f & 0x10) ret += "Eatable ";
	if (ret == "") ret = "None";
	return ret;
};

fn getItemFlags(u8 f) {
	str ret = "";
	if (f & 0x20) ret += "Sellable ";
	if (f & 0x40) ret += "TowerPoints ";
	if (f & 0x04) ret += "DivaRelated ";
	if (f & 0x02) ret += "DivaRelated2 ";
	if (ret == "") ret = "None";
	return ret;
};

fn getItemCategory(u16 n) {
	match (n) {
		(0x00): return "None";
		(0x01): return "KeyItem";
		(0x04): return "Consumable";
		(0x05): return "Placeable";
		(0x06): return "Ammo";
		(0x07): return "Material";
	}
	return "UnknownCategory";
};

fn getItemEffectFromIconColor(u8 icon, u8 color) {
	str iconName = getItemIconName(icon);

	if (iconName == "meat") {
		match (color) {
			(0): return "RawMeat";
			(1): return "PoisonMeat";
			(3): return "ParalysisMeat";
			(5): return "SleepMeat";
			(4): return "RareMeat";
		}
	}

	if (iconName == "ammo" || iconName == "coating") {
		match (color) {
			(1): return "Fire";
			(2): return "Poison";
			(3): return "Water";
			(4): return "Thunder";
			(5): return "Dragon";
			(7): return "Blast";
			(8): return "Sleep";
		}
	}

	if (iconName == "drink" || iconName == "potion") {
		match (color) {
			(2): return "Heal";
			(3): return "Environment";
			(1): return "AttackBuff";
			(5): return "MegaBuff";
			(4): return "Stamina";
		}
	}

	return "None";
};

fn validateEatableByIconColor(u8 icon, u8 color, u8 flags) {
	str iconName = getItemIconName(icon);

	if (iconName == "meat") {
		if (color != 0 && (flags & 0x10))
			return "⚠ bait meat marked eatable";
	}

	return "OK";
};


fn validateInteractionByIcon(u8 icon, u8 interactionType) {
	str iconName = getItemIconName(icon);

	if (iconName == "ammo" && interactionType != 2)
		return "⚠ icon=ammo but interactionType!=Ammo";

	if (iconName == "coating" && interactionType != 3)
		return "⚠ icon=coating but interactionType!=Coating";

	return "OK";
};

fn validateUsabilityByIcon(u8 icon, u8 flags) {
	str iconName = getItemIconName(icon);

	if (iconName == "meat" && !(flags & 0x10))
		return "⚠ meat without Eatable flag";

	if ((iconName == "potion" || iconName == "drink") && !(flags & 0x01))
		return "⚠ consumable not usable";

	return "OK";
};

fn validateCategoryByIcon(u8 icon, u16 category) {
	str iconName = getItemIconName(icon);

	if (iconName == "ammo" && category != 0x06)
		return "⚠ ammo icon but category!=Ammo";

	if (iconName == "trap" && category != 0x05)
		return "⚠ trap icon but category!=Placeable";

	return "OK";
};

fn getItemSanity(auto i) {
	return std::format(
		"[{}] {} | {} | {} | {}",
		getStructItemName(i),
		validateInteractionByIcon(i.icon, i.interactionType),
		validateUsabilityByIcon(i.icon, i.usabilityFlag),
		validateCategoryByIcon(i.icon, i.type),
		getItemEffectFromIconColor(i.icon, i.iconColor)
	);
};

struct Item {
	u8 interactionType [[format("getItemInteractionTypeName")]];
	u8 usabilityFlag   [[format("getItemUsabilityFlags")]];
	u8 rarity          [[format("plusone")]];
	u8 maxStack;

	u8 itemFlags [[format("getItemFlags")]];
	u8 icon      [[format("getItemIconName")]];
	u8 iconColor [[format("getItemIconColorName")]];
	u8 unk07;

	u16 bottle;
	u16 unk0A;

	u32 buyPrice;
	u32 sellPrice;

	u16 type    [[format("getItemCategory")]];
	u16 decoID;

	u16 unk18;
	u8 unk1A;
	u8 unk1B;

	u16 equipType [[format("equipType")]];
	u8 isGz;
	u8 unk1F;

	u16 unk20;
	u16 unk22;
} [[format("getItemSanity")]];
// [[format("getStructItemName")]];


struct ItemName {
	s32p name;
};

struct ItemDescription {
	s32p description;
};

struct ItemSource {
	s32p source;
};

num ItemQuantity @ (header.ptrs.important_nums + 0x8) [[name("Number of total Items")]];

struct Items {
  Item            data         [ItemQuantity] @ header.ptrs.itemData  [[name("Data")]];
  ItemName        names        [ItemQuantity] @ header.ptrs.itemNames [[name("Names")]];
  ItemDescription descriptions [ItemQuantity] @ (header.ptrs.itemDesc + 0x60) [[name("Descriptions")]];
  ItemSource      source       [ItemQuantity] @ header.ptrs.itemSourceStrings [[name("Source")]];
};

Items items @ header.ptrs.itemData [[name("Items")]];