#pragma once
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

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
		(0x55): return "neko_jewel";
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

// Item row (header 0xFC; important numbers + 0x8 rows, itemData + id * 0x24).
// Audited 2026-11-05 against every reader found (docs/reverse/item_data.md).

// The weapon class checks refuse ammo outside the bowguns (classes 1 and 5)
// and coatings outside the bow (0xA); value 1 is named from the data only
enum ItemInteraction : u8 {
	None = 0,
	Carried = 1,
	BowgunAmmo = 2,
	BowCoating = 3
};

bitfield ItemUseFlags {
	usable : 1 [[comment("Item pouch use (inventory_find_next_owned_item, pause menu)")]];
	bowgunAmmo : 1 [[comment("Ammo pouch (bowgun_ammo_item_is_usable, AddItemToInventory mask 6)")]];
	bowCoating : 1 [[comment("Ammo pouch, bow coating (mask 6)")]];
	swordCrystal : 1 [[comment("sword_crystal_find_next_usable_index")]];
	needsSigilSkill40 : 1 [[comment("Usable only while weapon sigil skill 0x28 is set (pouch_cursor_next_usable_slot); cooking ingredients")]];
	unkBit5 : 1;
	unkBit6 : 1;
	unkBit7 : 1;
};

bitfield ItemFlags {
	iconMark : 1 [[comment("Draws a marker sprite over the icon; meaning unproven")]];
	soldAtQuestEnd : 1 [[comment("Removed at quest end, count x sellPrice paid in the result (mask 0x42)")]];
	removedAtQuestEnd : 1 [[comment("quest_complete_consume_temporary_items")]];
	unkBit3 : 1 [[comment("never set, no tester")]];
	rarityM : 1 [[comment("Rarity printed RARE-%dM; mailed whatever its rarity")]];
	unkBit5 : 1 [[comment("86 rows, no tester found")]];
	towerSoldAtQuestEnd : 1 [[comment("Like soldAtQuestEnd, paid into the Tower result total")]];
	noDeliveryBox : 1 [[comment("Refused by the Delivery Box unless the rank reaches deliveryBoxMinRank")]];
};

// item_play_obtain_jingle: music_enqueue_play_task id (0 plays 7, 1 nothing)
enum ItemObtainJingle : u16 {
	Default = 0,
	None = 1,
	Jingle8 = 2,
	JingleB7 = 3,
	Jingle1D6 = 4
};

// My House item list tabs, labelled with mhfpac pItemCategoryNames
enum ItemCategory : u8 {
	None = 0,
	MonsterMaterial = 1,
	Biological = 2,
	Ore = 3,
	FoodMedicine = 4,
	Support = 5,
	BooksTicketsCoins = 6,
	Decorations = 7,
	Other = 8
};

// Names from the item names and the readers (item_poogie_cuff_restricted,
// tower_weapon_stone_fill_owned_list 5, tower_armor_stone_fill_owned_list 7)
enum ItemEquipType : u16 {
	None = 0,
	CuffSA = 1,
	CuffPA = 2,
	NekoJewel = 3,
	NekoJewelP = 4,
	TowerWeaponGem = 5,
	Sigil = 6,
	TowerArmorSigil = 7,
	CuffSZ = 8,
	CuffPZ = 9,
	ZenithSigil = 10,
	HidenCuff = 11,
	Unknown12 = 12
};

u32 __sizeof_Item = 0x24;

fn getStructItemName(auto i) {
	return getItemName(($-header.ptrs.itemData)/__sizeof_Item);
};

struct Item {
	ItemInteraction interactionType;
	ItemUseFlags useFlags;
	u8 rarity [[format("plusone")]];
	u8 maxStack [[comment("0xFF: unlimited, the count is pinned at 255 (item_has_unlimited_stack)")]];
	ItemFlags flags;
	u8 icon [[format("getItemIconName")]];
	u8 iconColor [[format("getItemIconColorName")]];
	u8 unk07 [[comment("no reader, always 0")]];
	u16 subType [[comment("Ammo / coating / crystal kind: bit index into the weapon's usable mask (was bottle)")]];
	ItemObtainJingle obtainJingle;
	u32 buyPrice;
	u32 sellPrice;
	ItemCategory category;
	u8 unk15 [[comment("no reader, always 0")]];
	u16 decoID [[comment("Row of the decorations table (header 0x0F8, decoID.hexpat) for decorations and cuffs, 0 otherwise")]];
	s16 sortGroup [[comment("Item box sort key = sortGroup x 0x8000 + sortOrder (item_sort_key_compare)")]];
	s16 sortOrder;
	ItemEquipType equipType;
	bool isGRank [[comment("Priced in Gz, kept out of the Delivery Box, compared to the G rank instead of the HR (was isGz)")]];
	u8 unk1F [[comment("no reader; 2 on 9 Fatalis materials")]];
	u16 deliveryBoxMinRank [[comment("delivery_box_item_is_rank_locked, with flags.noDeliveryBox; 0 = always refused")]];
	u16 unk22 [[comment("no reader, always 0")]];
};

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

// =======================
// Koryo (功猟) amulets (header 0x7D8, important numbers + 0x2E2 rows): the
// amulets of the Koryo Point Exchange (mhfpac pKoryoRewardTexts, 7 per page,
// koryo_amulet_shop_list_build). In a quest koryo_amulet_best_in_pouch_get
// (kind) picks the carried amulet of that kind with the highest tier.
// =======================

enum KoryoAmuletKind : u16 {
    Haste = 1,
    Gathering = 2,
    Health = 3,
    Stamina = 4,
    TwoToned = 5,
    Adrenaline = 6,
    Starvation = 7,
};

struct KoryoAmulet {
    KoryoAmuletKind kind;
    u16 tier [[comment("the highest tier carried wins")]];
    ItemId item;
    u16 koryoCost [[comment("exchange cost in Koryo points (\"Cost %s(%d)\")")]];
    u16 gap08;
    u16 gap0A;
    u16 value [[comment("Haste: seconds; Gathering: max gathers +; Health: max HP + (koryo_amulet_health_apply); Two Toned: hunter jewel points % (hunter_gem_quest_points_calc); Adrenaline: HP set to it (koryo_amulet_adrenaline_apply); Starvation: 25")]];
    u16 gap0E;
    u16 value2 [[comment("Haste: 20; Gathering: min gathers +; Stamina: max stamina + (koryo_amulet_stamina_apply)")]];
    u8 gap12[14];
};

KoryoAmulet koryoAmulets[importantNums.numKoryoAmulets] @ header.ptrs.koryoAmulets [[name("Koryo Amulets")]];
