#pragma once

#include <std/sys.pat>
#include <misc/types.pat>

struct signature {
    u32 header1                 [[comment("Must equal 1A 66 68 6D")]];
    u32 header2                 [[comment("Must equal 00 00 00 59")]];
    padding[4];
    u32 header3                 [[comment("Must equal 00 00 0B C8")]];
};

struct ptr_table {
    // @ 0x010
    ptr important_nums          [[name("Important Numbers Pointer")]];
    padding[0x14];

    unk_ptr hd_dll_af5f9b;
    
    padding[0x8];
    
    ptr armorForging            [[name("Armor Forging Pointer")]]; 
    ptr weaponForging           [[name("Weapon Forging Pointer"), comment("The basic forge list, melee and ranged weapons")]];
    ptr meleeWeaponUpgradePath  [[name("Melee Weapon Upgrade Path Pointer")]];
    // @ 0x040
    ptr rangedWeaponUpgradePath [[name("Ranged Weapon Upgrade Path Pointer")]];
    ptr DecoShop                [[name("Deco Shop Pointer")]];
    unk_ptr hd_dll_af47e1;
    ptr armorUpgradeMats        [[name("Armor Upgrade Materials Pointer")]];

    // @ 0x050
    ptr headArmor               [[name("Head Armor Data Pointer")]];
    ptr bodyArmor               [[name("Body Armor Data Pointer")]];
    ptr armArmor                [[name("Arm Armor Data Pointer")]];
    ptr waistArmor              [[name("Waist Armor Data Pointer")]];
    ptr legArmor                [[name("Leg Armor Data Pointer")]];

    ptr headArmorNames          [[name("Head Armor Names Pointer")]];
    ptr bodyArmorNames          [[name("Body Armor Names Pointer")]];
    ptr armArmorNames           [[name("Arm Armor Names Pointer")]];
    ptr waistArmorNames         [[name("Waist Armor Names Pointer")]];
    ptr legArmorNames           [[name("Leg Armor Names Pointer")]];

    ptr equipDesc               [[name("Equipment Descriptions Poiner")]];

    ptr meleeWeapons            [[name("Melee Weapon Data Pointer")]];
    ptr rangedWeapons           [[name("Ranged Weapon Data Pointer")]];
    ptr rangedWeaponNames       [[name("Ranged Weapon Names Pointer")]];
    ptr meleeWeaponNames        [[name("Melee Weapon Names Pointer")]];
    ptr meleeWeaponDesc         [[name("Melee Weapon Descriptions Pointer")]];
    ptr rangedWeaponDesc        [[name("Ranged Weapon Descriptions Pointer")]];

    ptr armorStatArray          [[name("Armor Stat Pointer Array"), 
                                  comment("Seems redundant")
                                ]];
    ptr armorWeaponStatArray    [[name("Armor and Weapon Stat Pointer Array"),
                                  comment("Probably redundant")
                                ]];
    ptr armorNameArray          [[name("Armor Name Pointer Array"),
                                  comment("Probably redundant")
                                ]];
    
    
    ptr rapidFireAmmo [[name("Rapid Fire Ammo Pointer")]]; // @ 0x0A0, hd_dll_af5038
    ptr BulletSets              [[name("Bullet Sets Pointer")]];
    ptr weaponBonusSlots [[name("Weapon Upgrade Bonus Slots Pointer"), comment("Rows of 4 x s16; how many is unchecked (weapon_params.hexpat)")]]; // @ 0x0A8, hd_dll_af5044
    ptr SharpnessIds            [[name("Sharpness Ids Pointer")]];
    ptr coatingModifiers [[name("Coating Modifiers Pointer"), comment("Rows of 0x18 bytes; how many is unchecked (weapon_params.hexpat)")]]; // @ 0x0B0, hd_dll_af5073
    unk_ptr hd_dll_af5079;
    ptr armorUpgradeCostPercent [[name("Armor Upgrade Cost Percent Pointer")]]; // @ 0x0B8, hd_dll_af507f
    unk_ptr hd_dll_af5085;
    ptr rapidFireWeapons [[name("Rapid Fire Weapons Pointer")]]; // @ 0x0C0, hd_dll_af508b
    unk_ptr hd_dll_af4bc6;
    ptr shopCatalogs [[name("Shop Catalogs Pointer"), comment("14 records of 3 list pointers and a count; record 7 is the Guild Shop (shop_guild.hexpat)")]]; // @ 0x0C8, hd_dll_af4bf5
    unk_ptr hd_dll_af4bfb;
    ptr wswordEfts [[name("Dual Blades Blade Effects Pointer")]]; // @ 0x0D0, hd_dll_af4cd1
    ptr wswordEftReachScale [[name("Dual Blades Effect Reach Scale Pointer")]]; // @ 0x0D4, hd_dll_af4cd7
    ptr weaponReachBodies [[name("Weapon Reach Bodies Pointer")]]; // @ 0x0D8, hd_dll_af4cc5
    ptr weaponPosByReach [[name("Weapon Position By Reach Pointer")]]; // @ 0x0DC, hd_dll_af4d14
    ptr wswordEftModelRanges [[name("Dual Blades Effect Model Ranges Pointer")]]; // @ 0x0E0, hd_dll_af4d08
    unk_ptr hd_dll_af47b5;
    ptr hd_dll_af47af       [[name("Equipment Counts Pointer"), comment("Seems to point to how many of certain objects there are, such as weapons")]];
    ptr skillTree [[name("Skill Tree Pointer")]]; // @ 0x0EC, hd_dll_af4d2d
    
    // + 0x0F0
    ptr hunterPearlSkills       [[name("Hunter Pearl Skills")]];

    ptr hunterPearlSkillLists [[name("Hunter Pearl Skill Lists Pointer"), comment("One list of Caravan gem skills per tier, important numbers + 0x5E of them")]]; // @ 0x0F4, hd_dll_af4d7b
    ptr Deco_ID                 [[name("Decorations Pointer"), comment("An item's decoID (item +0x16) is its row here")]];

    ptr itemData                [[name("Item Data Pointer")]];
    ptr itemNames               [[name("Item Names Pointer")]];

    ptr combinePairRecords [[name("Combine Pair Records Pointer")]]; // @ 0x104, hd_dll_af4dec
    ptr combinePairIngredientA [[name("Combine Pair First Ingredients Pointer")]]; // @ 0x108, hd_dll_af4df2
    ptr combineTripleRecords [[name("Combine Triple Records Pointer")]]; // @ 0x10C, hd_dll_af4df8
    
    ptr combineTripleBuckets [[name("Combine Triple Buckets Pointer")]]; // @ 0x110, hd_dll_af4de0
    ptr combineTripleIngredientA [[name("Combine Triple First Ingredients Pointer")]]; // @ 0x114, hd_dll_af4e1b
    unk_ptr hd_dll_af4e0f;
    unk_ptr hd_dll_af4e3a;

    
    ptr carveItemDrops          [[name("Carve Drop Data Pointer")]]; // + 0x120
    ptr partBreakItemDrops      [[name("Part Break Drop Data Pointer")]];
    unk_ptr hd_dll_af4ec1;
    ptr itemDesc                [[name("Item Descriptions Pointer")]];

    ptr monsterCrowns [[name("Monster Crowns Pointer")]]; // @ 0x130, hd_dll_af4f23
    ptr monsterDesc             [[name("Monster Descriptions Pointer")]];
    ptr monsterCarvePoints [[name("Monster Carve Points Pointer")]]; // @ 0x138, hd_dll_af4ff0
    unk_ptr hd_dll_af5145;

    unk_ptr hd_dll_af517d;      // @ 0x140
    ptr arenaItems              [[name("Arena Item Data Pointer")]];
    ptr arenaEquipment          [[name("Arena Equipment Data Pointer")]];
    ptr arenaStageIDC1          [[name("Arena Stage ID Chunk 1")]];

    ptr arenaStageInfoText [[name("Arena Stage Info Texts Pointer")]]; // @ 0x150, hd_dll_af51e0
    ptr arenaStageIDC0          [[name("Arena Stage ID Chunk 0")]];
    ptr arenaAmmo               [[name("Arena Ammo Pointer??")]];
    ptr tutorialEquipSets [[name("Tutorial Equipment Sets Pointer")]]; // @ 0x15C, hd_dll_af5261

    // + 0x160
    ptr machaPotRewards         [[name("Macha Pot Rewards Pointer")]];

    ptr machaPotItems [[name("Macha Pot Items Pointer")]]; // @ 0x164, hd_dll_af52c0
    unk_ptr hd_dll_af52ba;
    unk_ptr hd_dll_af52f3;

    padding[0x10];              // @ 0x170

    unk_ptr hd_dll_af5397;      // @ 0x180
    unk_ptr hd_dll_af53c0;
    ptr cookingCategories [[name("Cooking Ingredient Categories Pointer")]]; // @ 0x188, hd_dll_af53f0
    ptr cookingCategoryStats [[name("Cooking Category Stats Pointer")]]; // @ 0x18C, hd_dll_af5421
    ptr cookingStatTiers [[name("Cooking Stat Tiers Pointer")]]; // @ 0x190, hd_dll_af5427
    unk_ptr hd_dll_af542d;
    unk_ptr hd_dll_af5455;
    unk_ptr hd_dll_af5491;
    unk_ptr hd_dll_af54d3;      // @ 0x1A0
    unk_ptr hd_dll_af5542;
    unk_ptr hd_dll_af5570;
    unk_ptr hd_dll_af55a0;
    unk_ptr hd_dll_af55d0;      // @ 0x1B0
    unk_ptr hd_dll_af5611;
    ptr beginnerQuests [[name("Beginner Quest IDs Pointer")]]; // @ 0x1B8, hd_dll_af5640
    unk_ptr hd_dll_af5646;
    unk_ptr hd_dll_af5661;      // @ 0x1C0
    unk_ptr hd_dll_af567c;
    ptr gunnerShotPower [[name("Gunner Shot Power Pointer")]]; // @ 0x1C8, hd_dll_af57f2
    unk_ptr hd_dll_af583d;
    unk_ptr hd_dll_af5843;      // @ 0x1D0
    ptr mytraAdventures [[name("Mytra Adventure Dispatch Pointer")]]; // @ 0x1D4, hd_dll_af56ea
    unk_ptr hd_dll_af56cc;
    ptr mytraShopStage0 [[name("Mytra Shop Stock Stage 0 Pointer")]]; // @ 0x1DC, hd_dll_af56d2
    ptr mytraShopStage2 [[name("Mytra Shop Stock Stage 2 Pointer")]]; // @ 0x1E0, hd_dll_af56d8
    ptr mytraShopStage3 [[name("Mytra Shop Stock Stage 3 Pointer")]]; // @ 0x1E4, hd_dll_af56de
    ptr mytraShopStage3G [[name("Mytra Shop Stock Stage 3 GR600 Pointer")]]; // @ 0x1E8, hd_dll_af56e4
    ptr mytraCatMixStage0 [[name("Mytra Cat Mix Stage 0 Pointer")]]; // @ 0x1EC, hd_dll_af5682
    ptr mytraCatMixStage2 [[name("Mytra Cat Mix Stage 2 Pointer")]]; // @ 0x1F0, hd_dll_af5693
    ptr mytraCatMixStage3 [[name("Mytra Cat Mix Stage 3 Pointer")]]; // @ 0x1F4, hd_dll_af56a4
    ptr mytraCatMixStage3G [[name("Mytra Cat Mix Stage 3 GR600 Pointer")]]; // @ 0x1F8, hd_dll_af56b5
    unk_ptr hd_dll_af56c6;
    ptr meowkaPotRecipes [[name("Meowka Pot Recipes Pointer")]]; // @ 0x200, hd_dll_af57bf
    unk_ptr hd_dll_af5772;
    unk_ptr hd_dll_af5778;
    unk_ptr hd_dll_af577e;
    unk_ptr hd_dll_af5784;      // @ 0x210
    unk_ptr hd_dll_af578a;
    unk_ptr hd_dll_af57b9;
    unk_ptr hd_dll_af5849;
    unk_ptr hd_dll_af584f;      // @ 0x220
    unk_ptr hd_dll_af5855;
    unk_ptr hd_dll_af584b;
    ptr caravanVoyageRoutes [[name("Caravan Voyage Routes Pointer")]]; // @ 0x22C, hd_dll_af5861
    ptr caravanLevels [[name("Caravan Levels Pointer")]]; // @ 0x230, hd_dll_af5867
    ptr caravanTiers [[name("Caravan Tiers Pointer")]]; // @ 0x234, hd_dll_af4da9
    unk_ptr hd_dll_af586d;
    unk_ptr hd_dll_af588d;
    unk_ptr hd_dll_af58ca;      // @ 0x240
    unk_ptr hd_dll_af58ea;
    unk_ptr hd_dll_af58aa;
    unk_ptr hd_dll_af592a;
    unk_ptr hd_dll_af590a;      // @ 0x250
    ptr rastaHuntOrders [[name("Rasta Hunt Orders Pointer")]]; // @ 0x254, hd_dll_af594a
    ptr rastaLoyaltyCosts [[name("Rasta Loyalty Costs Pointer")]]; // @ 0x258, hd_dll_af596a
    ptr rastaCredCosts [[name("Rasta Cred Costs Pointer")]]; // @ 0x25C, hd_dll_af5970
    unk_ptr hd_dll_af5976;      // @ 0x260
    unk_ptr hd_dll_af59a1;
    unk_ptr hd_dll_af59a7;
    unk_ptr hd_dll_af59ad;
    unk_ptr hd_dll_af59c5;      // @ 0x270
    unk_ptr hd_dll_af59cb;
    unk_ptr hd_dll_af5a21;
    unk_ptr hd_dll_af5a27;
    ptr weaponEffectSets [[name("Weapon Effect Sets Pointer")]]; // @ 0x280, hd_dll_af5a2d
    ptr weaponEffects [[name("Weapon Effects Pointer")]]; // @ 0x284, hd_dll_af5a33
    unk_ptr hd_dll_af5a39;
    unk_ptr hd_dll_af5a3f;
    unk_ptr hd_dll_af5a45;      // @ 0x290
    ptr modelEffectSets [[name("Model Effect Sets Pointer")]]; // @ 0x294, hd_dll_af5a4b
    ptr modelEffects [[name("Model Effects Pointer")]]; // @ 0x298, hd_dll_af5a51
    ptr rastaItemSets [[name("Rasta Item Sets Pointer")]]; // @ 0x29C, hd_dll_af5a57
    unk_ptr hd_dll_af5a5d;      // @ 0x2A0
    unk_ptr hd_dll_af5ae0;
    unk_ptr hd_dll_af5ab1;
    unk_ptr hd_dll_af5ae6;
    unk_ptr hd_dll_af5a63;      // @ 0x2B0
    unk_ptr hd_dll_af5a69;
    unk_ptr hd_dll_af5a6f;
    unk_ptr hd_dll_af5a75;
    ptr CuffCrafting            [[name("Cuff Crafting Pointer")]];      // @ 0x2C0
    unk_ptr hd_dll_af5b21;
    unk_ptr hd_dll_af5b27;
    unk_ptr hd_dll_af5a7b;
    unk_ptr hd_dll_af5a81;      // @ 0x2D0
    unk_ptr hd_dll_af5a87;
    unk_ptr hd_dll_af5a8d;
    unk_ptr hd_dll_af5a93;
    unk_ptr hd_dll_af5a99;      // @ 0x2E0
    unk_ptr hd_dll_af5b6c;
    unk_ptr hd_dll_af5a9f;
    unk_ptr hd_dll_af5aa5;
    unk_ptr hd_dll_af5aab;      // @ 0x2F0
    unk_ptr hd_dll_af5be2;
    unk_ptr hd_dll_af5be8;
    unk_ptr hd_dll_af5bee;
    unk_ptr hd_dll_af5bf4;      // @ 0x300
    unk_ptr hd_dll_af5bfa;
    unk_ptr hd_dll_af5c00;
    unk_ptr hd_dll_af5c06;
    unk_ptr hd_dll_af5c0c;      // @ 0x310
    unk_ptr hd_dll_af5c12;
    ptr secretBookEffects [[name("Secret Book Effects Pointer")]]; // @ 0x318
    unk_ptr hd_dll_af5c18;
    ptr partnerFaces [[name("Partner Faces Pointer")]]; // @ 0x320, hd_dll_af5c1e
    unk_ptr hd_dll_af5bd0;
    unk_ptr hd_dll_af5bd6;

    ptr carveHCItemDrops        [[name("HC Carve Drop Data Pointer")]];

    unk_ptr hd_dll_af5c24;      // @ 0x330
    unk_ptr hd_dll_af5c2a;
    unk_ptr hd_dll_af5c30;
    ptr protectedItems [[name("Protected Items Pointer")]]; // @ 0x33C, hd_dll_af5c36
    unk_ptr hd_dll_af5c3c;      // @ 0x340
    unk_ptr hd_dll_af5c42;
    unk_ptr hd_dll_af5c48;
    ptr boxSearchIcons [[name("Box Search Icons Pointer")]]; // @ 0x34C, hd_dll_af5c4e
    ptr boxSearchDecorations [[name("Box Search Decorations Pointer")]]; // @ 0x350, hd_dll_af5c54
    ptr boxSearchSkillTrees [[name("Box Search Skill Trees Pointer")]]; // @ 0x354, hd_dll_af5c5a
    ptr boxSearchZenithSkills [[name("Box Search Zenith Skills Pointer")]]; // @ 0x358, hd_dll_af5c60
    ptr legendRastaLoadouts [[name("Legend Rasta Loadouts Pointer")]]; // @ 0x35C, hd_dll_af5c72
    ptr legendRastaGroups [[name("Legend Rasta Groups Pointer")]]; // @ 0x360, hd_dll_af5c78
    unk_ptr hd_dll_af5c7e;
    unk_ptr hd_dll_af5c84;
    ptr exGWeaponData [[name("Ex G Weapon Data Pointer")]]; // @ 0x36C, hd_dll_af5c8a
    ptr randomSharpnessSwordAndShield [[name("Random Sharpness Sword and Shield Pointer")]]; // @ 0x370, hd_dll_af5c90
    ptr randomSharpnessDualBlades [[name("Random Sharpness Dual Blades Pointer")]]; // @ 0x374, hd_dll_af5c96
    ptr randomSharpnessGreatSwordLongSword [[name("Random Sharpness Great Sword and Long Sword Pointer")]]; // @ 0x378, hd_dll_af5c9c
    ptr randomSharpnessLance [[name("Random Sharpness Lance Pointer")]]; // @ 0x37C, hd_dll_af5ca2
    ptr randomSharpnessHammerHorn [[name("Random Sharpness Hammer and Hunting Horn Pointer")]]; // @ 0x380
    unk_ptr hd_dll_af5cae;
    unk_ptr hd_dll_af5cb4;
    unk_ptr hd_dll_af5cba;
    unk_ptr hd_dll_af5ccc;      // @ 0x390
    unk_ptr hd_dll_af5cd2;
    unk_ptr hd_dll_af5cd8;
    unk_ptr hd_dll_af5cde;
    unk_ptr hd_dll_af5cc0;      // @ 0x3A0
    unk_ptr hd_dll_af5cc6;
    unk_ptr hd_dll_af5cea;
    unk_ptr hd_dll_af5cf0;
    unk_ptr hd_dll_af5cf6;      // @ 0x3B0
    unk_ptr hd_dll_af5cfc;
    unk_ptr hd_dll_af5d02;
    unk_ptr hd_dll_af5d08;
    unk_ptr hd_dll_af5d0e;      // @ 0x3C0
    unk_ptr hd_dll_af5d14;
    unk_ptr hd_dll_af5d1a;
    unk_ptr hd_dll_af5d20;
    unk_ptr hd_dll_af5d26;      // @ 0x3D0
    unk_ptr hd_dll_af5d2c;
    unk_ptr hd_dll_af5d32;
    unk_ptr hd_dll_af5d60;
    unk_ptr hd_dll_af5d90;      // @ 0x3E0
    unk_ptr hd_dll_af5dc0;
    unk_ptr hd_dll_af5df0;
    unk_ptr hd_dll_af5e20;
    unk_ptr hd_dll_af5e50;      // @ 0x3F0
    unk_ptr hd_dll_af5e80;
    unk_ptr hd_dll_af5eb0;
    unk_ptr hd_dll_af5ee0;
    unk_ptr hd_dll_af5f10;      // @ 0x400
    ptr goocooFoods [[name("Goocoo Foods Pointer")]]; // @ 0x404, hd_dll_af5f40
    ptr goocooFoodTexts [[name("Goocoo Food Texts Pointer")]]; // @ 0x408, hd_dll_af5f46
    ptr goocooSitItems [[name("Goocoo House-Sitting Items Pointer")]]; // @ 0x40C, hd_dll_af5f71
    ptr goocooSitGradeChances [[name("Goocoo House-Sitting Grade Chances Pointer")]]; // @ 0x410, hd_dll_af5f77
    ptr goocooSitCounts [[name("Goocoo House-Sitting Counts Pointer")]]; // @ 0x414, hd_dll_af5f7d
    ptr goocooSitPersonalityMods [[name("Goocoo House-Sitting Personality Modifiers Pointer")]]; // @ 0x418, hd_dll_af5f83
    ptr goocooSitMoodMods [[name("Goocoo House-Sitting Mood Modifiers Pointer")]]; // @ 0x41C, hd_dll_af5f89
    ptr goocooSitFishRarity [[name("Goocoo House-Sitting Fish Rarity Pointer")]]; // @ 0x420, hd_dll_af5f8f
    ptr goocooSitBugsRarity [[name("Goocoo House-Sitting Bugs Rarity Pointer")]]; // @ 0x424, hd_dll_af5f95
    ptr goocooSitJunkRarity [[name("Goocoo House-Sitting Junk Rarity Pointer")]]; // @ 0x428
    ptr goocooSitBargainsRarity [[name("Goocoo House-Sitting Bargains Rarity Pointer")]]; // @ 0x42C, hd_dll_af5fa1
    ptr goocooSitGrades [[name("Goocoo House-Sitting Grades Pointer")]]; // @ 0x430, hd_dll_af5fa7
    ptr goocooSitMoodItems [[name("Goocoo House-Sitting Mood Items Pointer")]]; // @ 0x434, hd_dll_af5fad
    unk_ptr hd_dll_af5fb3;
    ptr goocooPersonalities [[name("Goocoo Personalities Pointer")]]; // @ 0x43C, hd_dll_af5fb9
    ptr goocooCareActions [[name("Goocoo Care Actions Pointer")]]; // @ 0x440, hd_dll_af5fbf
    ptr goocooCareStyles [[name("Goocoo Care Styles Pointer")]]; // @ 0x444, hd_dll_af5ff0
    ptr goocooPersonalityNames [[name("Goocoo Personality Names Pointer")]]; // @ 0x448, hd_dll_af6020
    ptr goocooRemodelBeds [[name("Goocoo Remodel Beds Pointer")]]; // @ 0x44C, hd_dll_af6050
    ptr goocooRemodelPools [[name("Goocoo Remodel Pools Pointer")]]; // @ 0x450, hd_dll_af6056
    ptr goocooRemodelGrounds [[name("Goocoo Remodel Grounds Pointer")]]; // @ 0x454, hd_dll_af605c
    ptr goocooBedNames [[name("Goocoo Bed Names Pointer")]]; // @ 0x458, hd_dll_af6062
    ptr goocooPoolNames [[name("Goocoo Pool Names Pointer")]]; // @ 0x45C, hd_dll_af6090
    ptr goocooGroundNames [[name("Goocoo Ground Names Pointer")]]; // @ 0x460, hd_dll_af60c0
    ptr goocooBedTexts [[name("Goocoo Bed Texts Pointer")]]; // @ 0x464, hd_dll_af60f0
    ptr goocooPoolTexts [[name("Goocoo Pool Texts Pointer")]]; // @ 0x468, hd_dll_af6120
    ptr goocooGroundTexts [[name("Goocoo Ground Texts Pointer")]]; // @ 0x46C, hd_dll_af6150
    ptr goocooSeriesNames [[name("Goocoo Series Names Pointer")]]; // @ 0x470, hd_dll_af6180
    unk_ptr hd_dll_af61b0;
    ptr goocooTrustParams [[name("Goocoo Trust Parameters Pointer")]]; // @ 0x478, hd_dll_af61e0
    ptr goocooTrustDecay [[name("Goocoo Trust Decay Pointer")]]; // @ 0x47C, hd_dll_af61e6
    unk_ptr hd_dll_af61ec;      // @ 0x480
    unk_ptr hd_dll_af61f2;
    unk_ptr hd_dll_af61f8;
    unk_ptr hd_dll_af61fe;
    unk_ptr hd_dll_af6204;      // @ 0x490
    ptr goocooExchanges [[name("Goocoo Exchanges Pointer")]]; // @ 0x494, hd_dll_af620a
    ptr goocooClothesCosts [[name("Goocoo Clothes Costs Pointer")]]; // @ 0x498, hd_dll_af623d
    ptr goocooRemodelCosts [[name("Goocoo Remodel Costs Pointer")]]; // @ 0x49C, hd_dll_af6243
    unk_ptr hd_dll_af6249;      // @ 0x4A0
    unk_ptr hd_dll_af6280;
    unk_ptr hd_dll_af6286;
    unk_ptr hd_dll_af628C;
    unk_ptr hd_dll_af6292;      // @ 0x4B0
    unk_ptr hd_dll_af6298;
    unk_ptr hd_dll_af62d4;
    ptr goocooPotMaterials [[name("Goocoo Pot Materials Pointer")]]; // @ 0x4BC, hd_dll_af62c8
    ptr goocooPotSoups [[name("Goocoo Pot Soups Pointer")]]; // @ 0x4C0, hd_dll_af62ce
    unk_ptr hd_dll_af62da;
    unk_ptr hd_dll_af62e0;
    unk_ptr hd_dll_af629e;
    unk_ptr hd_dll_af62a4;      // @ 0x4D0
    unk_ptr hd_dll_af62aa;
    unk_ptr hd_dll_af62b0;
    unk_ptr hd_dll_af62b6;
    unk_ptr hd_dll_af62bc;      // @ 0x4E0
    unk_ptr hd_dll_af62c2;
    unk_ptr hd_dll_af6304;
    unk_ptr hd_dll_af630a;
    ptr randomShellTypes [[name("Random Gunlance Shell Types Pointer")]]; // @ 0x4F0, hd_dll_af6310
    ptr handlingDrawSpeed [[name("Handling Draw Speed Pointer")]]; // @ 0x4F4, hd_dll_af632e
    ptr randomSharpnessGunlance [[name("Random Sharpness Gunlance Pointer")]]; // @ 0x4F8, hd_dll_af6316
    unk_ptr hd_dll_af5ce4;
    unk_ptr hd_dll_af631c;      // @ 0x500
    unk_ptr hd_dll_af6322;
    unk_ptr hd_dll_af6328;
    unk_ptr hd_dll_af6334;
    ptr halkFoods [[name("Halk Foods Pointer")]]; // @ 0x510, hd_dll_af6434
    unk_ptr hd_dll_af643a;
    unk_ptr hd_dll_af6440;
    ptr monsterIconIndices [[name("Monster Icon Indices Pointer")]]; // @ 0x51C
    unk_ptr hd_dll_af647d;      // @ 0x520
    ptr my_mission_data         [[name("My Mission Data Pointer")]];
    unk_ptr hd_dll_af658e;
    unk_ptr hd_dll_af659a;
    unk_ptr hd_dll_af65ea;      // @ 0x530
    unk_ptr hd_dll_af65f0;
    ptr my_mission_objective    [[name("My Mission Objective Pointer")]];
    unk_ptr hd_dll_af65fc;
    unk_ptr hd_dll_af6602;      // @ 0x540
    unk_ptr hd_dll_af6608;
    unk_ptr hd_dll_af660e;
    ptr seasonalEventTiming     [[name("Seasonal Event Timing Table Pointer")]];
    unk_ptr hd_dll_af661a;      // @ 0x550
    unk_ptr hd_dll_af6640;
    ptr cookedDishes [[name("Cooked Dishes Pointer")]]; // @ 0x558, hd_dll_af6646
    unk_ptr hd_dll_af664c;
    unk_ptr hd_dll_af6652;      // @ 0x560
    unk_ptr hd_dll_af6658;
    unk_ptr hd_dll_af665e;
    unk_ptr hd_dll_af6664;
    unk_ptr hd_dll_af666a;      // @ 0x570
    unk_ptr hd_dll_af6670;
    unk_ptr hd_dll_af6676;
    unk_ptr hd_dll_af667c;
    unk_ptr hd_dll_af6682;      // @ 0x580
    ptr priorityRequestEntries [[name("Guild Priority Request Entries Pointer")]]; // @ 0x584, hd_dll_af6688
    ptr priorityRequestRotations [[name("Guild Priority Request Rotations Pointer")]]; // @ 0x588, hd_dll_af668e
    unk_ptr hd_dll_af6694;
    unk_ptr hd_dll_af669a;      // @ 0x590
    ptr skillEffects [[name("Skill Effects Pointer")]]; // @ 0x594, hd_dll_af66a0
    ptr gArmorFxElementRate [[name("G Armor Fx Element Rate Pointer")]]; // @ 0x598, hd_dll_af66a6
    ptr gArmorFxStatusRate [[name("G Armor Fx Status Rate Pointer")]]; // @ 0x59C, hd_dll_af66ac
    ptr gArmorFxElementPercent [[name("G Armor Fx Element Percent Pointer")]]; // @ 0x5A0, hd_dll_af66b2
    unk_ptr hd_dll_af66b8;
    unk_ptr hd_dll_af66be;
    unk_ptr hd_dll_af66c4;
    ptr hcKaiCritDamage [[name("HC Kai Critical Damage Pointer")]]; // @ 0x5B0, hd_dll_af66ca
    ptr hcKaiDefense [[name("HC Kai Defense Pointer")]]; // @ 0x5B4, hd_dll_af66d0
    ptr secretBookSrLevels [[name("Secret Book SR Levels Pointer")]]; // @ 0x5B8, hd_dll_af703a
    unk_ptr hd_dll_af66d6;
    ptr monsterAltSoundTables [[name("Monster Alternate Sound Tables Pointer")]]; // @ 0x5C0, hd_dll_af66dc
    ptr GreatSword_Params_pointer [[name("Great Sword Params Pointer")]];
    ptr HeavyBowGun_Params_pointer [[name("Heavy Bowgun Params Pointer")]];
    ptr Hammer_Params_pointer [[name("Hammer Params Pointer")]];
    ptr Lance_Params_pointer [[name("Lance Params Pointer")]];      // @ 0x5D0
    ptr SwordAndShield_Params_pointer [[name ("Sword and Shield Params Pointer")]];
    ptr LightBowgun_Params_pointer [[name("Light Bowgun Params Pointer")]];
    ptr DualBlades_Params_pointer [[name("Dual Blades Params Pointer")]];
    ptr LongSword_Params_pointer [[name ("Longsword Params Pointer")]];      // @ 0x5E0
    ptr HuntingHorn_Params_pointer [[name("Hunting Horn Params Pointer")]];
    ptr GunLance_Params_pointer [[name("Gunlance Params Pointer")]];
    ptr Bow_Params_pointer [[name("Bow Params Pointer")]];

    // @ 0x5F0
    ptr weaponGRForging         [[name("G-Rank Weapon Forging Pointer")]];
    ptr armorGRForging          [[name("G-Rank Armor Forging Pointer")]];
    ptr g50MeleeUpgrades [[name("G-50 Melee Weapon Upgrades Pointer")]]; // @ 0x5F8, hd_dll_af6c08
    ptr g50RangedUpgrades [[name("G-50 Ranged Weapon Upgrades Pointer")]]; // @ 0x5FC

    ptr rastaLoyaltyAttackPercent [[name("Rasta Loyalty Attack Percent Pointer")]]; // @ 0x600, hd_dll_af6c14
    ptr rastaLoyaltyElementPercent [[name("Rasta Loyalty Element Percent Pointer")]]; // @ 0x604, hd_dll_af6c1a
    ptr rastaCredDefensePercent [[name("Rasta Cred Defense Percent Pointer")]]; // @ 0x608, hd_dll_af6c20
    ptr rastaCredSkillSlots [[name("Rasta Cred Skill Slots Pointer")]]; // @ 0x60C, hd_dll_af6c26
    unk_ptr hd_dll_af6c2c;      // @ 0x610
    ptr weaponActions [[name("Weapon Action Scripts Pointer")]]; // @ 0x614, hd_dll_af6c32
    unk_ptr hd_dll_af6c98;
    ptr playerSoundBanks [[name("Player Sound Banks Pointer")]]; // @ 0x61C, hd_dll_af6d00
    // random sigils (sigils.hexpat)
    ptr sigilCraftingRecipes    [[name("Sigil Crafting Recipes Pointer")]];        // @ 0x620, hd_dll_af6d60
    ptr sigilSkillProbabilities [[name("Sigil Skill Probabilities Pointer")]];     // hd_dll_af6d66
    ptr sigilSkillBlacklists    [[name("Sigil Skill Blacklists Pointer")]];        // hd_dll_af6d6c
    ptr sigilSkillBaseInfo      [[name("Sigil Skill Base Info Pointer")]];         // hd_dll_af6da0
    unk_ptr hd_dll_af6da6;      // @ 0x630
    unk_ptr hd_dll_af6dac;
    unk_ptr hd_dll_af6db2;
    ptr motionValues [[name("Motion Values Pointer")]]; // @ 0x63C, hd_dll_af6db8
    unk_ptr hd_dll_af6dbe;      // @ 0x640
    unk_ptr hd_dll_af6e7c;
    ptr skillParams [[name("Skill Parameters Pointer"), comment("Rush gauge thresholds at +0x64; the rest is shared with other skills")]]; // @ 0x648, hd_dll_af6eab
    ptr roadMilestones [[name("Road Floor Milestones Pointer")]]; // @ 0x64C, hd_dll_af6eb1
    unk_ptr hd_dll_af6eb7;      // @ 0x650
    unk_ptr hd_dll_af6e82;
    unk_ptr hd_dll_af6f6f;
    ptr weaponParams [[name("Weapon Parameters Pointer")]]; // @ 0x65C, hd_dll_af6f75
    unk_ptr hd_dll_af6f7b;      // @ 0x660
    unk_ptr hd_dll_af6f81;
    ptr justReloadLists [[name("Just Reload Lists Pointer")]]; // @ 0x668, hd_dll_af6fa8
    ptr justShotLists [[name("Just Shot Lists Pointer")]]; // @ 0x66C, hd_dll_af6fca
    ptr hornMelodies [[name("Horn Melodies Pointer")]]; // @ 0x670, hd_dll_af6fec
    unk_ptr hd_dll_af6ff2;
    ptr gunlanceShells [[name("Gunlance Shells Pointer")]]; // @ 0x678, hd_dll_af6ff8
    unk_ptr hd_dll_af6ffe;
    unk_ptr hd_dll_af7004;      // @ 0x680
    unk_ptr hd_dll_af700a;
    ptr gunlanceShellSharpnessCost [[name("Gunlance Shell Sharpness Cost Pointer")]]; // @ 0x688, hd_dll_af7010
    ptr gunlanceSpDragonCannonDamageRate [[name("Gunlance Sp Dragon Cannon Damage Rate Pointer")]]; // @ 0x68C, hd_dll_af7016
    ptr gunlanceSpDragonCannonTimerRate [[name("Gunlance Sp Dragon Cannon Timer Rate Pointer")]]; // @ 0x690, hd_dll_af701c
    ptr gunlanceSpDragonCannonSharpnessCost [[name("Gunlance Sp Dragon Cannon Sharpness Cost Pointer")]]; // @ 0x694, hd_dll_af7022
    ptr gunlanceExShotDamageRate [[name("Gunlance Extreme Shot Damage Rate Pointer")]]; // @ 0x698, hd_dll_af7028
    ptr gunlanceExShotTimerRate [[name("Gunlance Extreme Shot Timer Rate Pointer")]]; // @ 0x69C, hd_dll_af702e
    ptr gunlanceExShotSharpnessCost [[name("Gunlance Extreme Shot Sharpness Cost Pointer")]]; // @ 0x6A0, hd_dll_af7034
    unk_ptr hd_dll_af7052;
    unk_ptr hd_dll_af7040;
    unk_ptr hd_dll_af7046;
    ptr partnerStarterWeapons [[name("Partner Starter Weapons Pointer")]]; // @ 0x6B0, hd_dll_af7058
    ptr partnerArmorSetA [[name("Partner Armor Set A Pointer")]]; // @ 0x6B4, hd_dll_af705e
    ptr partnerArmorSetB [[name("Partner Armor Set B Pointer")]]; // @ 0x6B8, hd_dll_af7064
    unk_ptr hd_dll_af706a;
    unk_ptr hd_dll_af7070;      // @ 0x6C0
    unk_ptr hd_dll_af704c;
    // G1 to G7 quest lists, each to a u32 holding the list's address (quests.hexpat)
    ptr GRankQuestG1            [[name("G1 Quests Pointer")]];     // @ 0x6C8, hd_dll_af7076
    ptr GRankQuestG2            [[name("G2 Quests Pointer")]];     // hd_dll_af70bc
    ptr GRankQuestG3            [[name("G3 Quests Pointer")]];     // @ 0x6D0, hd_dll_af710a
    ptr GRankQuestG4            [[name("G4 Quests Pointer")]];     // hd_dll_af715a
    ptr GRankQuestG5            [[name("G5 Quests Pointer")]];     // hd_dll_af71aa
    ptr GRankQuestG6            [[name("G6 Quests Pointer")]];     // hd_dll_af71fa
    ptr GRankQuestG7            [[name("G7 Quests Pointer")]];     // @ 0x6E0
    unk_ptr hd_dll_af738a;
    unk_ptr hd_dll_af7390;
    unk_ptr hd_dll_af7396;
    unk_ptr hd_dll_af739c;      // @ 0x6F0
    unk_ptr hd_dll_af73d7;
    unk_ptr hd_dll_af73dd;
    unk_ptr hd_dll_af73e3;
    unk_ptr hd_dll_af73e9;      // @ 0x700
    unk_ptr hd_dll_af740a;
    padding[0x8];
    padding[0x4];               // @ 0x710
    unk_ptr hd_dll_af771d;
    unk_ptr hd_dll_af5c66;
    unk_ptr hd_dll_af7723;
    unk_ptr hd_dll_af7729;      // @ 0x720
    unk_ptr hd_dll_af772f;
    unk_ptr hd_dll_af7735;
    ptr playerUniqueParams [[name("Player Unique Parameters Pointer")]]; // @ 0x72C, hd_dll_af773b
    unk_ptr hd_dll_af7741;      // @ 0x730
    unk_ptr hd_dll_af7747;

    ptr carveGRHCItemDrops      [[name("Carve GR HC Drop Data Pointer")]];

    unk_ptr hd_dll_af7753;
    ptr GRankQuestG8 [[name("G8 Quests Pointer")]]; // @ 0x740, hd_dll_af729a
    ptr GRankQuestG9 [[name("G9 Quests Pointer")]]; // @ 0x744, hd_dll_af72ea
    ptr GRankQuestG10 [[name("G10 Quests Pointer")]]; // @ 0x748, hd_dll_af733a
    ptr motionValuesAlt [[name("Motion Values Alternate Bank Pointer")]]; // @ 0x74C, hd_dll_af7759
    ptr GrankCuffCrafting        [[name("G-Rank Cuff Crafting Pointer")]];      // @ 0x750
    unk_ptr hd_dll_af7765;
    padding[4];
    unk_ptr hd_dll_af7771;
    unk_ptr hd_dll_af7777;      // @ 0x760
    unk_ptr hd_dll_af777d;
    unk_ptr hd_dll_af7783;
    unk_ptr hd_dll_af7789;
    unk_ptr hd_dll_af778f;      // @ 0x770
    unk_ptr hd_dll_af7795;
    unk_ptr hd_dll_af779b;
    unk_ptr hd_dll_af77a1;
    unk_ptr hd_dll_af77a7;      // @ 0x780
    unk_ptr hd_dll_af77ef;
    unk_ptr hd_dll_af77f5;
    unk_ptr hd_dll_af77fb;
    unk_ptr hd_dll_af7801;      // @ 0x790
    ptr superRapidFirePower [[name("Super Rapid Fire Power Pointer")]]; // @ 0x794, hd_dll_af7807
    unk_ptr hd_dll_af780d;
    unk_ptr hd_dll_af7813;
    ptr vampirism [[name("Vampirism Pointer")]]; // @ 0x7A0, hd_dll_af7819
    unk_ptr hd_dll_af781f;
    unk_ptr hd_dll_af7825;

    ptr weaponSpecialForging    [[name("Special Weapon Forging Pointer")]];
    
    ptr armorPremiumForging     [[name("Armor Premium Forging Pointer")]];      // @ 0x7B0
    unk_ptr hd_dll_af787b;
    unk_ptr hd_dll_af7881;
    unk_ptr hd_dll_af7887;
    unk_ptr hd_dll_af78b2;      // @ 0x7C0
    unk_ptr hd_dll_af7a30;
    unk_ptr hd_dll_af7a36;
    unk_ptr hd_dll_af7a3c;
    unk_ptr hd_dll_af7a42;      // @ 0x7D0
    unk_ptr hd_dll_af7a48;
    unk_ptr hd_dll_af7a7c;
    unk_ptr hd_dll_af78e0;
    unk_ptr hd_dll_af7a82;      // @ 0x7E0
    unk_ptr hd_dll_af7a88;
    unk_ptr hd_dll_af7910;
    unk_ptr hd_dll_af7940;
    unk_ptr hd_dll_af7970;      // @ 0x7F0
    unk_ptr hd_dll_af79a0;
    unk_ptr hd_dll_af79d0;
    unk_ptr hd_dll_af7a00;
    ptr partnerLooks [[name("Partner Looks Pointer")]]; // @ 0x800, hd_dll_af7a8e
    ptr AutomaticSkillsTable    [[name("Automatic Skills Table Pointer")]];
    unk_ptr hd_dll_af7a9a;
    unk_ptr hd_dll_af7aa0;
    unk_ptr hd_dll_af7aa6;      // @ 0x810
    unk_ptr hd_dll_af7ae3;
    unk_ptr hd_dll_af7ae9;
    unk_ptr hd_dll_af7aef;
    unk_ptr hd_dll_af7af5;      // @ 0x820
    unk_ptr hd_dll_af7afb;
    unk_ptr hd_dll_af7b01;
    padding[0x4];
    unk_ptr hd_dll_af7b07;      // @ 0x830
    unk_ptr hd_dll_af7b0d;
    ptr partnerSkills [[name("Partner Skills Pointer")]]; // @ 0x838, hd_dll_af7b13
    unk_ptr hd_dll_af7b19;
    unk_ptr hd_dll_af7b1f;      // @ 0x840
    unk_ptr hd_dll_af7b25;
    unk_ptr hd_dll_af7b2b;
    ptr partnerTeachFees [[name("Partner Teach Fees Pointer")]]; // @ 0x84C, hd_dll_af7b31
    unk_ptr hd_dll_af7b37;      // @ 0x850
    unk_ptr hd_dll_af7b3d;
    unk_ptr hd_dll_af7b43;
    ptr partnerSkillPointCaps [[name("Partner Skill Point Caps Pointer")]]; // @ 0x85C, hd_dll_af7b49
    ptr partnerSkillSlotCounts [[name("Partner Skill Slot Counts Pointer")]]; // @ 0x860, hd_dll_af7b4f
    unk_ptr hd_dll_af7b73;
    ptr guildCookingRecipes [[name("Guild Cooking Recipes Pointer")]]; // @ 0x868, hd_dll_af7b79
    ptr guildCookingIngredients [[name("Guild Cooking Ingredients Pointer")]]; // @ 0x86C, hd_dll_af7b7f
    unk_ptr hd_dll_af7b85;      // @ 0x870
    unk_ptr hd_dll_af7b8b;
    unk_ptr hd_dll_af7b91;
    unk_ptr hd_dll_af7be3;
    unk_ptr hd_dll_af7c0a;      // @ 0x880
    unk_ptr hd_dll_af7c10;
    ptr Tonfa_Params_pointer [[name("Tonfa Params Pointer")]];
    unk_ptr hd_dll_af7c9c;
    unk_ptr hd_dll_af7b5b;      // @ 0x890
    unk_ptr hd_dll_af7b61;
    unk_ptr hd_dll_af7b67;
    ptr guildCookingSkillPools [[name("Guild Cooking Skill Pools Pointer")]]; // @ 0x89C, hd_dll_af7ca2
    unk_ptr hd_dll_af7cc8;      // @ 0x8A0
    unk_ptr hd_dll_af7cce;
    unk_ptr hd_dll_af7cd4;
    unk_ptr hd_dll_af7cda;
    unk_ptr hd_dll_af7b55;      // @ 0x8B0
    unk_ptr hd_dll_af7ce0;
    unk_ptr hd_dll_af7ce6;
    unk_ptr hd_dll_af7cec;
    unk_ptr hd_dll_af7d34;      // @ 0x8C0
    unk_ptr hd_dll_af7d67;
    unk_ptr hd_dll_af7e55;
    unk_ptr hd_dll_af7e5b;
    unk_ptr hd_dll_af7e79;      // @ 0x8D0
    unk_ptr hd_dll_af7e7f;
    unk_ptr hd_dll_af7e85;
    unk_ptr hd_dll_af7e8b;
    unk_ptr hd_dll_af7e91;      // @ 0x8E0
    unk_ptr hd_dll_af7e97;
    unk_ptr hd_dll_af7e9d;
    unk_ptr hd_dll_af7ea3;
    unk_ptr hd_dll_af7d73;      // @ 0x8F0
    unk_ptr hd_dll_af7d6d;
    padding[4];
    ptr monsterSoundTables [[name("Monster Sound Tables Pointer")]]; // @ 0x8FC, hd_dll_af530c
    unk_ptr hd_dll_af8165;      // @ 0x900
    unk_ptr hd_dll_af8171;
    unk_ptr hd_dll_af5c6c;
    unk_ptr hd_dll_af8177;
    ptr extraCounters [[name("Extra Counters Pointer"), comment("u16 counts: +8 the Hunting Road skills")]]; // @ 0x910, hd_dll_af469d
    unk_ptr hd_dll_af818f;
    unk_ptr hd_dll_af81cc;
    ptr caravanRankingRoutes [[name("Caravan Ranking Routes Pointer")]]; // @ 0x91C, hd_dll_af821c
    unk_ptr hd_dll_af8183;      // @ 0x920
    unk_ptr hd_dll_af817d;
    unk_ptr hd_dll_af8189;
    unk_ptr hd_dll_af816b;
    ptr roadSkills [[name("Hunting Road Skills Pointer")]]; // @ 0x930, hd_dll_af82c4
    unk_ptr hd_dll_af82ca;
    ptr towerJewelRecipes [[name("Tower Jewel Recipes Pointer")]]; // @ 0x938, hd_dll_af82d0
    ptr towerUpgradeCosts [[name("Tower Weapon Upgrade Costs Pointer")]]; // @ 0x93C, hd_dll_af82d6

    // @ 0x940
    ptr weaponTowerForging      [[name("Tower Weapon Forging Pointer")]];

    ptr SigilTowerForging       [[name("Tower Sigil Forging Pointer")]];
    ptr towerMedalShop          [[name("Tower Medal Shop Pointer")]];
    unk_ptr hd_dll_af832c;
    unk_ptr hd_dll_af8332;      // @ 0x950
    unk_ptr hd_dll_af8338;
    unk_ptr hd_dll_af833e;
    unk_ptr hd_dll_af8344;
    unk_ptr hd_dll_af834a;      // @ 0x960
    unk_ptr hd_dll_af8350;
    ptr armorFlag10000ElementRate [[name("Armor Flag 0x10000 Element Rate Pointer")]]; // @ 0x968, hd_dll_af8356
    ptr armorFlag10000StatusRate [[name("Armor Flag 0x10000 Status Rate Pointer")]]; // @ 0x96C, hd_dll_af835c
    ptr armorFlag10000ElementPercent [[name("Armor Flag 0x10000 Element Percent Pointer")]]; // @ 0x970, hd_dll_af8362
    ptr skillSlotId4ElementPercent [[name("Skill Slot Id 4 Element Percent Pointer")]]; // @ 0x974, hd_dll_af8368
    unk_ptr hd_dll_af836e;
    unk_ptr hd_dll_af8374;
    unk_ptr hd_dll_af837a;      // @ 0x980
    unk_ptr hd_dll_af8380;
    ptr skillCounts [[name("Skill Counts Pointer"), comment("u16 counts: +2 the skill effects, +4 the vampirism rows")]]; // @ 0x988, hd_dll_af46c9
    unk_ptr hd_dll_af839f;
    ptr transcendDepths [[name("Transcend Depths Pointer")]]; // @ 0x990, hd_dll_af83a5
    ptr transcendQuestGains [[name("Transcend Quest Gains Pointer")]]; // @ 0x994, hd_dll_af83ab

    ptr armorTowerForging       [[name("Tower Armor Forging Pointer")]];

    unk_ptr hd_dll_af83b7;
    padding[4];                 // @ 0x9A0
    unk_ptr hd_dll_af83bd;
    padding[4];
    unk_ptr hd_dll_af83c3;
    padding[4];                 // @ 0x9B0
    unk_ptr hd_dll_af84a9;
    unk_ptr hd_dll_af8536;
    unk_ptr hd_dll_af84f4;
    unk_ptr hd_dll_af8581;      // @ 0x9C0
    padding[4];
    unk_ptr hd_dll_af85c4;
    padding[4];
    unk_ptr hd_dll_af85ca;      // @ 0x9D0 Tower/G50 Params ID?
    u32 partnerExtraSkillCount [[name("Partner Extra Skill Count")]]; // @ 0x9D4
    ptr partnerExtraSkills [[name("Partner Extra Skills Pointer")]]; // @ 0x9D8, hd_dll_af85d0
    unk_ptr hd_dll_af85d6;
    unk_ptr hd_dll_af8601;      // @ 0x9E0
    unk_ptr hd_dll_af8630;
    unk_ptr hd_dll_af8660;
    unk_ptr hd_dll_af8690;
    unk_ptr hd_dll_af86c0;      // @ 0x9F0
    unk_ptr hd_dll_af86f0;
    unk_ptr hd_dll_af86f6;
    unk_ptr hd_dll_af86fc;
    unk_ptr hd_dll_af8702;      // @ 0xA00
    unk_ptr hd_dll_af8708;
    unk_ptr hd_dll_af870e;
    // evolution weapon levels, 100 each (crafting.hexpat)
    ptr evoUpgradesFlash        [[name("Evolution Upgrade Pointer (Flash)")]];  // @ 0xA0C, hd_dll_af8714
    ptr evoUpgradesShine        [[name("Evolution Upgrade Pointer (Shine)")]];  // @ 0xA10, hd_dll_af871a
    ptr evoUpgradesGlory        [[name("Evolution Upgrade Pointer (Glory)")]];  // hd_dll_af8720
    ptr evoUpgrades             [[name("Evolution Upgrade Pointer (Clear)")]];  // @ 0xA18

    ptr critConversion [[name("Crit Conversion Pointer")]]; // @ 0xA1C, hd_dll_af872c
    padding[4];                 // @ 0xA20
    unk_ptr hd_dll_af874a;
    ptr clanMissionTargets [[name("Clan Mission Targets Pointer")]]; // @ 0xA28, hd_dll_af8750
    ptr clanMissionSlayChances [[name("Clan Mission Slay Chances Pointer")]]; // @ 0xA2C, hd_dll_af875c
    ptr clanMissionTimeWeights [[name("Clan Mission Time Weights Pointer")]]; // @ 0xA30, hd_dll_af8762
    ptr clanMissionRewardWeights [[name("Clan Mission Reward Weights Pointer")]]; // @ 0xA34, hd_dll_af8768
    ptr clanMissionMultiplierWeights [[name("Clan Mission Multiplier Weights Pointer")]]; // @ 0xA38, hd_dll_af876e
    unk_ptr hd_dll_af8756;

    // @ 0xA40
    ptr itemSourceStrings       [[name("Item Source Strings Pointer")]];

    unk_ptr hd_dll_af8774;
    unk_ptr hd_dll_af877a;
    padding[4];
    unk_ptr hd_dll_af8780;      // @ 0xA50
    unk_ptr hd_dll_af87bb;
    unk_ptr hd_dll_af87c1;
    unk_ptr hd_dll_af87f2;
    unk_ptr hd_dll_af87f8;      // @ 0xA60
    u32 playerSoundBankCount [[name("Player Sound Bank Count")]]; // @ 0xA64, + 0x12 banks
    unk_ptr hd_dll_af87fe;
    unk_ptr hd_dll_af8804;
    unk_ptr hd_dll_af8819;      // @ 0xA70
    padding[4];
    unk_ptr hd_dll_af8886;
    padding[4];
    unk_ptr hd_dll_af888c;      // @ 0xA80
    unk_ptr hd_dll_af88c7;
    unk_ptr hd_dll_af88f2;
    padding[4];
    ptr SwitchAxe_Params        [[name("Switch Axe Params Pointer")]];                 // @ 0xA90
    unk_ptr hd_dll_af8cac;

    ptr questList               [[name("Quest List Struct Pointer")]];

    unk_ptr hd_dll_af8cf8;
    ptr obscurity [[name("Obscurity Pointer")]]; // @ 0xAA0, hd_dll_af8cfe
    unk_ptr hd_dll_af8d0f;
    unk_ptr hd_dll_af8d1d;
    unk_ptr hd_dll_af8d23;
    unk_ptr hd_dll_af8d29;      // @ 0xAB0
    unk_ptr hd_dll_af8d2f;

    ptr transmogForging         [[name("Armor Transmog Forging Pointer")]];

    ptr transmogForging2        [[name("Second Armor Transmog Forging Pointer")]];

    // @ 0xAC0
    ptr zenithWeaponForging     [[name("Zenith Weapon Forging Pointer")]];
    ptr armorZenithForging     [[name("Zenith Armor Forging")]];

    unk_ptr hd_dll_af8d66;
    unk_ptr hd_dll_af8dc1;
    unk_ptr hd_dll_af8dc7;      // @ 0xAD0
    ptr monsterStartActions [[name("Monster Start Actions Pointer")]]; // @ 0xAD4, hd_dll_af8d60
    unk_ptr hd_dll_af7da4;
    unk_ptr hd_dll_af7daa;
    unk_ptr hd_dll_af8e16;      // @ 0xAE0
    unk_ptr hd_dll_af8e5e;
    unk_ptr hd_dll_af7b6d;
    unk_ptr hd_dll_af59b3;
    unk_ptr hd_dll_af46e9;      // @ 0xAF0
    unk_ptr hd_dll_af8eae;
    unk_ptr hd_dll_af8eb4;
    unk_ptr hd_dll_af8eba;
    unk_ptr hd_dll_af8f01;      // @ 0xB00
    ptr dataCounters [[name("Data Counters Pointer"), comment("u16 counts: +4 the Road cat shop, +8 the Road monster points")]]; // @ 0xB04, hd_dll_af4709
    unk_ptr hd_dll_af8f07;
    unk_ptr hd_dll_af8f0d;
    ptr Road_Cat_Item_Shop_Pointer [[name("Road Cat Item Shop Pointer")]];      // @ 0xB10
    unk_ptr hd_dll_af8f19;
    ptr interceptionMonsterCount [[name("Interception Monster Count Pointer")]]; // @ 0xB18, hd_dll_af4729
    ptr interceptionMonsterStars [[name("Interception Monster G Stars Pointer")]]; // @ 0xB1C, hd_dll_af8f1f
    ptr Road_Monster_Point_Value_Pointer [[name("Road Monster Point Value Pointer")]];      // @ 0xB20
    unk_ptr hd_dll_af8f2b;
    unk_ptr hd_dll_af8f31;

    ptr specialShops            [[name("Special Shops Pointer")]];

    ptr conquestQuests [[name("Conquest Quests Pointer")]]; // @ 0xB30, hd_dll_af4749
    unk_ptr hd_dll_af4772;
    unk_ptr hd_dll_af8f80;
    unk_ptr hd_dll_af8fca;
    unk_ptr hd_dll_af8fd0;      // @ 0xB40
    unk_ptr hd_dll_af8fd6;
    ptr GrankDecoShop          [[name("Grank Deco Shop Pointer")]];
    unk_ptr hd_dll_af8fdc;
    unk_ptr hd_dll_af8ff6;      // @ 0xB50
    unk_ptr hd_dll_af903a;
    unk_ptr hd_dll_af9088;
    unk_ptr hd_dll_af4794;
    unk_ptr hd_dll_af90cc;      // @ 0xB60
    unk_ptr hd_dll_af90d2;
    unk_ptr hd_dll_af90d8;
    unk_ptr hd_dll_af90de;
    unk_ptr hd_dll_af90e4;      // @ 0xB70
    unk_ptr hd_dll_af90ea;
    ptr obscurityUp [[name("Obscurity UP Pointer")]]; // @ 0xB78, hd_dll_af90f0
    unk_ptr hd_dll_af8f37;
    unk_ptr hd_dll_af8f3d;      // @ 0xB80
    unk_ptr hd_dll_af59b9;
    unk_ptr hd_dll_af9107;
    unk_ptr hd_dll_af91ba;
    unk_ptr hd_dll_af91e4;      // @ 0xB90
    ptr skillCells [[name("Skill Cells Pointer"), comment("+4: the Rush UP stage 3 block")]]; // @ 0xB94, hd_dll_af9323
    ptr Magnetspike_params_pointer [[name("Magnetspike Params Pointer")]];
    unk_ptr hd_dll_af93fc;
    unk_ptr hd_dll_af9402;      // @ 0xBA0
    unk_ptr hd_dll_af9450;
    unk_ptr hd_dll_af9408;
    ptr CombineShop [[name("Combine Shop Pointer")]];
};

struct mhfdat_header {
    signature sig               [[name("File header signature")]];
    ptr_table ptrs              [[name("Top level pointer table")]];
};

mhfdat_header header @ 0x0      [[name("mhfdat Header")]];

str __header_fail_msg = "File header does not match expected mhfdat header";

std::assert_warn(header.sig.header1 == 0x1A66686D, __header_fail_msg);
std::assert_warn(header.sig.header2 == 0x00000059, __header_fail_msg);
std::assert_warn(header.sig.header3 == 0x00000BC8, __header_fail_msg);