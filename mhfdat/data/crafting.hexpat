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


struct evoUpgradeSub {
    u16 dmg;
    u16 unkSub2;
    u16 eleDamage;
    padding[2];
    u16 unkSub8;
    padding[2];
} [[single_color]];

struct evoUpgrade {
    u32 gCost;
    u16 unk04;
    u16 level;
    evoUpgradeSub sub[11];
    u16 unk8C   [[comment("Increments with level from 650 to 850")]]; 
    u8 unk8E;
    padding[1];
    u16 unk90;
    padding[2];
    float unk94 [[comment("Always 0.70??")]]; 
    float unk98 [[comment("Always 1.00??")]];
    float unk9C [[comment("Always 1.20??")]];
    float unkA0 [[comment("Always 2.50??")]];
    float unkA4 [[comment("Always 1.43??")]]; 
    u16 unkA8   [[comment("Increments")]];
    u16 unkAA   [[comment("Increments")]];
    u8 unkAC    [[comment("Increments with level. 32 32, 33 33, ... in HR")]];
    u8 unkAD    [[comment("Increments with level")]];
    padding[2];
};

// each list has its header pointer: they follow each other on ZZ, but don't rely on it
evoUpgrade evoUpgradesClear[100] @ header.ptrs.evoUpgrades;
evoUpgrade evoUpgradesGlory[100] @ header.ptrs.evoUpgradesGlory;
evoUpgrade evoUpgradesShine[100] @ header.ptrs.evoUpgradesShine;
evoUpgrade evoUpgradesFlash[100] @ header.ptrs.evoUpgradesFlash;

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

struct TowerG50WeaponParams {
    u16 modelId;          
    u8  sharpness_id;         
    u8  max_sharpness;          
    u16 weaponRaw;         
    u8  elementId;         
    u8  eleDamage;         
    u8  ailmentId;         
    u8  ailDamage;         
    u16 defense;         
    u8  chance_rate [[comment("Chance to get upgraded on low cost upgrade?")]];         
    u8  unk_0d;         
    u16 upgradePath;      
};

// a weapon's TowerParamId (melee +0x26, ranged +0x2C) picks one of its class's 130 lists
struct WeaponTypeParams2 {
	ptr dataptr [[hidden]];
    TowerG50WeaponParams g50LevelStats[while(std::mem::read_unsigned($, 2) != 0xFFFF)] @ dataptr;};

struct WeaponTypeParams {
    WeaponTypeParams2 greatSwordParams [130]      @ header.ptrs.GreatSword_Params_pointer     [[name("Tower/G50 Params - Great Sword")]];
	WeaponTypeParams2 heavyBowgunParams  [130]    @ header.ptrs.HeavyBowGun_Params_pointer    [[name("Tower/G50 Params - Heavy Bowgun")]];
	WeaponTypeParams2 hammerParams  [130]         @ header.ptrs.Hammer_Params_pointer         [[name("Tower/G50 Params - Hammer")]];
	WeaponTypeParams2 lanceParams  [130]          @ header.ptrs.Lance_Params_pointer          [[name("Tower/G50 Params - Lance")]];
	WeaponTypeParams2 swordAndShieldParams  [130] @ header.ptrs.SwordAndShield_Params_pointer [[name("Tower/G50 Params - Sword and Shield")]];
	WeaponTypeParams2 lightBowgunParams  [130]    @ header.ptrs.LightBowgun_Params_pointer    [[name("Tower/G50 Params - Light Bowgun")]];
	WeaponTypeParams2 dualBladesParams  [130]     @ header.ptrs.DualBlades_Params_pointer     [[name("Tower/G50 Params - Dual Blades")]];
	WeaponTypeParams2 longswordParams  [130]      @ header.ptrs.LongSword_Params_pointer      [[name("Tower/G50 Params - Long Sword")]];
	WeaponTypeParams2 huntingHornParams  [130]    @ header.ptrs.HuntingHorn_Params_pointer    [[name("Tower/G50 Params - Hunting Horn")]];
	WeaponTypeParams2 gunlanceParams  [130]       @ header.ptrs.GunLance_Params_pointer       [[name("Tower/G50 Params - Gunlance")]];
	WeaponTypeParams2 bowParams  [130]            @ header.ptrs.Bow_Params_pointer            [[name("Tower/G50 Params - Bow")]];
	WeaponTypeParams2 tonfaParams  [130]          @ header.ptrs.Tonfa_Params_pointer          [[name("Tower/G50 Params - Tonfa")]];
	WeaponTypeParams2 switchAxeParams [130]       @ header.ptrs.SwitchAxe_Params              [[name("Tower/G50 Params - Switch Axe")]];
	WeaponTypeParams2 magnetspikeParams [130]     @ header.ptrs.Magnetspike_params_pointer    [[name("Tower/G50 Params - Magnet Spike")]];
};

WeaponTypeParams motionValues @ header.ptrs.Hammer_Params_pointer [[name("G50/Tower Params")]];

DecoShop decoShop[while(std::mem::read_unsigned($, 4))]          @ header.ptrs.DecoShop;
DecoShop grankDecoShop[while(std::mem::read_unsigned($, 4))]     @ header.ptrs.GrankDecoShop;
DecoShop cuffCrafting[while(std::mem::read_unsigned($, 4))]      @ header.ptrs.CuffCrafting;
DecoShop grankCuffCrafting[while(std::mem::read_unsigned($, 4))] @ header.ptrs.GrankCuffCrafting;