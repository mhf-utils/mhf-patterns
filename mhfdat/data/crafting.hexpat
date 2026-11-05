#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/s32p.pat>

fn meleeName (u16 n) {
    return rIPPS(
        header.ptrs.meleeWeaponNames,
        n
    );
};


fn rangedName (u16 n) {
    return rIPPS(
        header.ptrs.rangedWeaponNames,
        n
    );
};

fn getEquipName(u32 n) {
    u8 equipType = u8 (n);
    u16 equipID = u16 (n>>16);
    
    str equipName = std::format("{:04X}", equipID);
        if (equipType == 0) 
        equipName = rIPPS(header.ptrs.legArmorNames, equipID);
    else if (equipType == 2) 
        equipName = rIPPS(header.ptrs.headArmorNames, equipID);
    else if (equipType == 3)
        equipName = rIPPS(header.ptrs.bodyArmorNames, equipID);
    else if (equipType == 4)
        equipName = rIPPS(header.ptrs.armArmorNames, equipID);
    else if (equipType == 5)
        equipName = rIPPS(header.ptrs.waistArmorNames, equipID);
    else if (equipType == 6) 
        equipName = rIPPS(header.ptrs.meleeWeaponNames, equipID);
    else if (equipType == 7) 
        equipName = rIPPS(header.ptrs.rangedWeaponNames, equipID);

    return std::format("{} | {}", getEquipType(equipType), equipName);
};

fn mUpgradeName (auto n) {
	return rIPPS(
        header.ptrs.meleeWeaponNames, 
        ( ($-header.ptrs.meleeWeaponUpgradePath) / 36)
    );
};

fn rUpgradeName (auto n) {
	return rIPPS(
        header.ptrs.rangedWeaponNames, 
        ( ($-header.ptrs.rangedWeaponUpgradePath) / 36)
    );
};

struct RegWUpgrade {
    u16 weaponID         [[format("meleeName")]];
    padding[10];
    u16 upgradeMaterial1 [[format("getItemName")]];
    u8 numMaterial1;
    padding[5];
    u16 upgradeMaterial2 [[format("getItemName")]];
    u8 numMaterial2;
    padding[5];
    u16 upgradeMaterial3 [[format("getItemName")]];
    u8 numMaterial3;
    padding[5];
} [[comment("On using the materials listed, the weapon will upgrade to the listed weaponID, if it exists")]];

struct MWUpgradePath {
    u16 upgradeMaterial1 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial1     [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial2 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial2     [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial3 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial3     [[color("FF8888")]];
    padding[4];
    u16 upgradesTo1      [[format("meleeName")]];
    u16 upgradesTo2      [[format("meleeName")]];
    u16 upgradesTo3      [[format("meleeName")]];
    u16 upgradesTo4      [[format("meleeName")]];
    padding[4];
} [[format("mUpgradeName"), color("88FF88")]];

struct RWUpgradePath {
    u16 upgradeMaterial1 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial1     [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial2 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial2     [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial3 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial3     [[color("FF8888")]];
    padding[4];
    u16 upgradesTo1      [[format("rangedName")]];
    u16 upgradesTo2      [[format("rangedName")]];
    u16 upgradesTo3      [[format("rangedName")]];
    u16 upgradesTo4      [[format("rangedName")]];
    padding[4];
} [[format("rUpgradeName"), color("88FF88")]];

// a G-50 upgrade level: the weapon, then its levels, success rate, cost and
// materials (melee and ranged tables share the layout)
struct g50UpgradeLevel {
    u16 level1;
    u16 level2;
    u16 fullSuccRate;
    u32 zennyCost;
    u16 upgradeMaterial1 [[format("getItemName")]];
    u8 numMaterial1;
    padding[5];
    u16 upgradeMaterial2 [[format("getItemName")]];
    u8 numMaterial2;
    padding[5];
    u16 upgradeMaterial3 [[format("getItemName")]];
    u8 numMaterial3;
    padding[9];
};

struct g50MeleeUpgrade {
    u16 weaponId [[format("meleeName")]];
    g50UpgradeLevel level [[inline]];
};

struct g50RangedUpgrade {
    u16 weaponId [[format("rangedName")]];
    g50UpgradeLevel level [[inline]];
};

struct RegAUpgradeRow {
    u16 itemID [[format("getItemName")]];
    u16 lv1Upgrade;
    u16 lv2Upgrade;
    u16 lv3Upgrade;
    u16 lv4Upgrade;
    u16 lv5Upgrade;
    u16 lv6Upgrade;
    u16 lv7Upgrade;
};

struct GenericAUpgrade {
    RegAUpgradeRow itemsForUpgrade [ while (std::mem::read_unsigned($, 0x10)) ];
};

struct SigilTowerTable {
    u16 ItemID           [[format("getItemName")]];
    u16 ReceiptCategory;
    u16 ItemCraft1       [[format("getItemName")]];
    u8 ItemQty1;
    u8 ItemUnlockFlag1;
    u16 ItemCraft2       [[format("getItemName")]];
    u8 ItemQty2;
    u8 ItemUnlockFlag2;
    u16 ItemCraft3       [[format("getItemName")]];
    u8 ItemQty3;
    u8 ItemUnlockFlag3;
    u16 ItemCraft4       [[format("getItemName")]];
    u8 ItemQty4;
    u8 ItemUnlockFlag4;
};

struct CraftMatReq {
    u32 equipID                  [[color("0088FF"), format("getEquipName")]];
    bool purchaseable @ $-0x03;
	u16 materialID1              [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt1            [[color("FFFF22")]];
	padding[4];
	u16 materialID2              [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt2            [[color("FFFF22")]];
	padding[4];
	u16 materialID3              [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt3            [[color("FFFF22")]];
	padding[4];
    u16 materialID4              [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt4            [[color("FFFF22")]];
    padding[4];
	u16 unk24                    [[comment("Some kind of flag?")]];
	padding[2];
	u16 rankReq                  [[comment("HR needed to forge, GR in the G-rank tables")]];
	u16 unk2A                    [[comment("Some kind of flag?")]];
	bool previewAble;
	padding[3];
	u8 footer                    [[color("8888FF"), comment("0F")]];
	padding[3];
    u8 unk34                     [[comment("W02=exotic, A01=Festi?, A02=Diva?, A03=SP?, A04=hiden, A05=exotic")]];
    padding[3];
} [[color("660066")]];

// a crafting table ends at an entry whose type byte is 0xFF
struct CraftMatTable {
    CraftMatReq entry [ while (std::mem::read_signed($, 1) != -1)] [[inline]];
};

MWUpgradePath mwUpgradePath[equipmentCounts.numMeleeW]  @ header.ptrs.meleeWeaponUpgradePath;
RWUpgradePath rwUpgradePath[equipmentCounts.numRangedW] @ header.ptrs.rangedWeaponUpgradePath;

// G-50 upgrades: melee (header 0x5F8, important numbers + 0x22A rows, 62,726 on
// ZZ) and ranged (header 0x5FC, + 0x22C, 19,188). On the JP file the ranged
// table runs straight into the melee one: no end marker between them.
g50MeleeUpgrade g50MeleeUpgrades[importantNums.g50MeleeWeaponUpgradesCounter] @ header.ptrs.g50MeleeUpgrades;
g50RangedUpgrade g50RangedUpgrades[importantNums.g50RangedWeaponUpgradesCounter] @ header.ptrs.g50RangedUpgrades;

// Armor upgrade zenny (header 0xB8): zennyCost x percent[upgradeCostRow, max
// 15][current level, max 6] / 100
struct ArmorUpgradeCostRow {
    u16 percentByLevel[7];
};

ArmorUpgradeCostRow armorUpgradeCostPercent[16] @ header.ptrs.armorUpgradeCostPercent [[name("Armor Upgrade Cost Percent")]];

// Armor defense upgrade coefficients (header 0xB4; Get_Armor_adj_eq, and
// Get_Gao_Armor_adj_eq for Partnyaa armor from mhfgao): defense = baseDefense,
// then for each upgrade level i = 1..level, defense = ceil(defense x
// levelCoef[i]) of row min(coefUpgrade, 31). No count: 32 rows (the code clamp
// and the gap to the next table); rows 23-31 are all 1.0.
struct ArmorDefenseCoefRow {
    float levelCoef[7] [[comment("[0] is never read (1.0 everywhere); [i] applies at upgrade level i")]];
};

ArmorDefenseCoefRow armorDefenseCoefs[32] @ header.ptrs.armorDefenseCoefs [[name("Armor Defense Upgrade Coefficients")]];

// Armor slot upgrades (header 0xBC; Get_Armor_slot_eq): slots = min(baseSlots +
// slotsByLevel[min(level, 6)] of row min(slotUpgradeRow, 15), maxSlots). No count:
// 16 rows (the code clamp; 112 of the 128 bytes before the next table).
struct ArmorSlotUpgradeRow {
    u8 slotsByLevel[7];
};

ArmorSlotUpgradeRow armorSlotUpgrades[16] @ header.ptrs.armorSlotUpgrades [[name("Armor Slot Upgrades")]];

// [mhfo-hd.dll + 0xaf47ed] an armor part's UpgradeID (+0x28) picks a list (ZZ: 4855)
ptVar<GenericAUpgrade> armorUpgrades[while(std::mem::read_unsigned($,4))] @ header.ptrs.armorUpgradeMats;
SigilTowerTable sigilTowerTable[while(std::mem::read_unsigned($, 4))]     @ header.ptrs.SigilTowerForging    [[name("Sigil Tower Forging Data")]];
CraftMatTable towerArmorCraftingTable                                     @ header.ptrs.armorTowerForging    [[name("Tower Armor Forging Data")]];
CraftMatTable towerWeaponCraftingTable                                    @ header.ptrs.weaponTowerForging   [[name("Tower Weapon Forging Data")]];
CraftMatTable specialWeaponCraftingTable                                  @ header.ptrs.weaponSpecialForging [[name("Special Weapon Forging Data??")]]; //length = 56 
CraftMatTable armorGCraftingTable                                         @ header.ptrs.armorGRForging       [[name("G-Rank Armor Forging Data")]];
CraftMatTable weaponGCraftingTable                                        @ header.ptrs.weaponGRForging      [[name("G-Rank Weapon Forging Data")]];
CraftMatTable transmogCraftingTable2                                      @ header.ptrs.transmogForging2     [[name("Second Armor Transmog Forging Data")]];
CraftMatTable transmogCraftingTable                                       @ header.ptrs.transmogForging      [[name("Armor Transmog Forging Data")]];
CraftMatTable zenithWeaponCraftingTable                                   @ header.ptrs.zenithWeaponForging  [[name("Zenith Weapon Forging Data")]];
CraftMatTable armorPremiumCraftingTable                                   @ header.ptrs.armorPremiumForging  [[name("Armor Premium Forging Data")]];
CraftMatTable zArmorCraftingTable                                         @ header.ptrs.armorZenithForging   [[name("Zenith Armor Forging Data")]];
CraftMatTable armorCraftingTable                                          @ header.ptrs.armorForging         [[name("Armor Forging Data")]];
CraftMatTable weaponCraftingTable                                         @ header.ptrs.weaponForging        [[name("Weapon Forging Data")]];


struct DecoShop {
    u16 decoItemID       [[format("getItemName")]];
    u16 ReceiptCategory;
    u16 ItemID1          [[format("getItemName")]];
    u8 ItemQty1;
    u8 ItemUnlockFlag1;
    u16 ItemID2          [[format("getItemName")]];
    u8 ItemQty2;
    u8 ItemUnlockFlag2;
    u16 ItemID3          [[format("getItemName")]];
    u8 ItemQty3;
    u8 ItemUnlockFlag3;
    u16 ItemID4          [[format("getItemName")]];
    u8 ItemQty4;
    u8 ItemUnlockFlag4;
} [[single_color]];

// Tower / G50 weapon level stats (header 0x5C4-0x5EC, 0x888, 0xA90, 0xB98, one
// table per weapon class in class order; g50_tower_params_pointers): each table
// has 130 list pointers, indexed by the weapon's TowerParamId (melee +0x26,
// ranged +0x2C); the row is the weapon's level - 1 (level 0 also takes row 0),
// and a list ends at modelId 0xFFFF (count_tower_g50_entries; 50 rows at most on
// the 3 files). Each getter reads one field: get_tower_g50_model_id /
// gGetWeaponModelID, get_tower_g50_sharpness_id, get_tower_g50_max_sharpness,
// get_tower_g50_raw_damage, get_tower_g50_affinity, get_tower_g50_element_value,
// get_tower_g50_status_value, get_tower_g50_gunlance_shell, get_tower_g50_visual_effect,
// getGPlateUseSlotMax and get_tower_g50_upgrade_path.
struct TowerG50WeaponParams {
    u16 modelId [[comment("0xFFFF ends the list")]];
    u8  sharpnessId;
    u8  maxSharpness;
    u16 weaponRaw;
    s8  affinity [[comment("get_tower_g50_affinity, from get_weapon_base_affinity")]];
    u8  elementValue [[comment("get_tower_g50_element_value: the element value of weapon_element_status_affinity_value; the element type comes from the weapon")]];
    u8  statusValue [[comment("get_tower_g50_status_value: the status value, used when the weapon has a status below Blast; the type comes from the weapon")]];
    u8  gunlanceShell [[comment("get_tower_g50_gunlance_shell: read from the Gunlance table only, shell type + level x 3 (then + the shell sigil level); no reader in the other tables")]];
    u16 visualEffect [[comment("get_tower_g50_visual_effect: replaces the weapon's visualEffects for G class weapons (weapon_effect_init), a row of weaponEffectSets (header 0x280)")]];
    u8  unk0C [[comment("0-100 in steps of 10 on the 3 files; no reader found")]];
    u8  gPlateUseSlotMax [[comment("getGPlateUseSlotMax: usable G sigil slots (2 or 3)")]];
    u16 upgradePath;
};

struct TowerG50LevelList {
    TowerG50WeaponParams levels[while(std::mem::read_unsigned($, 2) != 0xFFFF)] [[comment("Row = weapon level - 1")]];
    u16 end;
};

struct TowerG50LevelListPtr {
    TowerG50LevelList *list : u32;
};

TowerG50LevelListPtr towerG50GreatSwordParams[130] @ header.ptrs.GreatSword_Params_pointer [[name("Tower/G50 Params - Great Sword"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50HeavyBowgunParams[130] @ header.ptrs.HeavyBowGun_Params_pointer [[name("Tower/G50 Params - Heavy Bowgun"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50HammerParams[130] @ header.ptrs.Hammer_Params_pointer [[name("Tower/G50 Params - Hammer"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50LanceParams[130] @ header.ptrs.Lance_Params_pointer [[name("Tower/G50 Params - Lance"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50SwordAndShieldParams[130] @ header.ptrs.SwordAndShield_Params_pointer [[name("Tower/G50 Params - Sword and Shield"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50LightBowgunParams[130] @ header.ptrs.LightBowgun_Params_pointer [[name("Tower/G50 Params - Light Bowgun"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50DualBladesParams[130] @ header.ptrs.DualBlades_Params_pointer [[name("Tower/G50 Params - Dual Blades"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50LongSwordParams[130] @ header.ptrs.LongSword_Params_pointer [[name("Tower/G50 Params - Long Sword"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50HuntingHornParams[130] @ header.ptrs.HuntingHorn_Params_pointer [[name("Tower/G50 Params - Hunting Horn"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50GunlanceParams[130] @ header.ptrs.GunLance_Params_pointer [[name("Tower/G50 Params - Gunlance"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50BowParams[130] @ header.ptrs.Bow_Params_pointer [[name("Tower/G50 Params - Bow"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50TonfaParams[130] @ header.ptrs.Tonfa_Params_pointer [[name("Tower/G50 Params - Tonfa"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50SwitchAxeParams[130] @ header.ptrs.SwitchAxe_Params [[name("Tower/G50 Params - Switch Axe F"), comment("Index = TowerParamId")]];
TowerG50LevelListPtr towerG50MagnetSpikeParams[130] @ header.ptrs.Magnetspike_params_pointer [[name("Tower/G50 Params - Magnet Spike"), comment("Index = TowerParamId")]];

DecoShop decoShop[while(std::mem::read_unsigned($, 4))]          @ header.ptrs.DecoShop;
DecoShop grankDecoShop[while(std::mem::read_unsigned($, 4))]     @ header.ptrs.GrankDecoShop;
DecoShop cuffCrafting[while(std::mem::read_unsigned($, 4))]      @ header.ptrs.CuffCrafting;
DecoShop grankCuffCrafting[while(std::mem::read_unsigned($, 4))] @ header.ptrs.GrankCuffCrafting;

// Forge separate list (header 0x048): equipment that the forge menus split
// out. The forge menu flag (forge work +0x169, copied by
// forge_weapon_menu_init from byte +3 of the menu descriptor) picks the side:
// 0 hides these rows from the weapon (forge_melee_build_weapon_page_a ...) and
// armor (forge_armor_build_list_page) forge lists, 1 lists only them. Ends with
// an id of 0. 597 rows on the EN, JP and rain files.
struct ForgeSeparateEquipment {
    u32 kind [[format("getEquipType")]];
    u32 id;
} [[format("forgeSeparateEquipmentName")]];

fn forgeSeparateEquipmentName(ref auto e) {
    return std::format("{} | {}", getEquipType(e.kind), getEquipKindName(e.kind, e.id));
};

ForgeSeparateEquipment forgeSeparateList[while(std::mem::read_unsigned($ + 4, 4) != 0)] @ header.ptrs.forgeSeparateList [[name("Forge Separate List")]];

// =======================
// Forge rank lists (header 0xAE0 weapons, 0xAE4 armor; forge_rank_list_has_equip):
// 8 lists each. The player's rank picks which lists count (forge_rank_lists_get):
// in G rank list 7; else the HR band of DLL table 0x11858BEC (HR up to 1, 30,
// 50, 99, 299, 998, 999 and more) picks lists [0], [0, 1], [1, 2], [2, 3],
// [3, 4], [4, 5] or [4, 5, 6] (DLL table 0x11925000).
// In the forge lists (forge_armor_build_list_page, upgrade_tree_build_list_c,
// forge_melee_check_rarity_match, Check_equipOnList) a row whose u16 +0x2C
// (CraftMatReq.previewAble) is 0 shows only when its equipment is on a list
// that counts, or seisan_row_is_available; when forge work +0xB57 is set (no
// writer found), only listed equipment shows. forge_list_draw_rank_icons draws
// icon 0x1C5 on listed equipment, 0x1C9 on the server's trend weapons
// (GetTrendWeapon, forge_trend_weapon_check), 0x1C4 for both with flag 4.
// A list ends at an entry whose kind is -1.
// =======================

struct ForgeRankEquip {
    u16 id;
    s8 kind [[format("getEquipType")]];
    u8 unk03;
} [[format("forgeRankEquipName")]];

fn forgeRankEquipName(ref auto e) {
    if (e.kind < 0) return "end";
    return getEquipKindName(e.kind, e.id);
};

struct ForgeRankList {
    ForgeRankEquip equipment[while(std::mem::read_signed($ + 2, 1) != -1)];
    ForgeRankEquip end;
};

struct ForgeRankListPtr {
    ForgeRankList *list : u32;
};

ForgeRankListPtr forgeRankWeaponLists[8] @ header.ptrs.forgeRankWeaponLists [[name("Forge Rank Weapon Lists")]];
ForgeRankListPtr forgeRankArmorLists[8] @ header.ptrs.forgeRankArmorLists [[name("Forge Rank Armor Lists")]];
