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
    ptr forgeSeparateList [[name("Forge Separate List Pointer")]]; // @ 0x048, hd_dll_af47e1
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
    ptr armorDefenseCoefs [[name("Armor Defense Upgrade Coefficients Pointer"), comment("32 rows of 7 floats, row = armor coefUpgrade (crafting.hexpat)")]]; // @ 0x0B4, hd_dll_af5079
    ptr armorUpgradeCostPercent [[name("Armor Upgrade Cost Percent Pointer")]]; // @ 0x0B8, hd_dll_af507f
    ptr armorSlotUpgrades [[name("Armor Slot Upgrades Pointer"), comment("16 rows of 7 bytes, row = armor slotUpgradeRow (crafting.hexpat)")]]; // @ 0x0BC, hd_dll_af5085
    ptr rapidFireWeapons [[name("Rapid Fire Weapons Pointer")]]; // @ 0x0C0, hd_dll_af508b
    ptr equipShopTiers [[name("Equipment Shop Tiers Pointer")]]; // @ 0x0C4, hd_dll_af4bc6
    ptr shopCatalogs [[name("Shop Catalogs Pointer"), comment("14 records of 3 list pointers and a count; record 7 is the Guild Shop (shop_guild.hexpat)")]]; // @ 0x0C8, hd_dll_af4bf5
    ptr shopCatalogPageLengths [[name("Shop Catalog Page Lengths Pointer")]]; // @ 0x0CC, hd_dll_af4bfb
    ptr wswordEfts [[name("Dual Blades Blade Effects Pointer")]]; // @ 0x0D0, hd_dll_af4cd1
    ptr wswordEftReachScale [[name("Dual Blades Effect Reach Scale Pointer")]]; // @ 0x0D4, hd_dll_af4cd7
    ptr weaponReachBodies [[name("Weapon Reach Bodies Pointer")]]; // @ 0x0D8, hd_dll_af4cc5
    ptr weaponPosByReach [[name("Weapon Position By Reach Pointer")]]; // @ 0x0DC, hd_dll_af4d14
    ptr wswordEftModelRanges [[name("Dual Blades Effect Model Ranges Pointer")]]; // @ 0x0E0, hd_dll_af4d08
    ptr armorModelIdLimits [[name("Armor Model Id Limits Pointer")]]; // @ 0x0E4, hd_dll_af47b5
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
    ptr captureBreakRewards [[name("Capture and Break Rewards Pointer")]]; // @ 0x128, hd_dll_af4ec1
    ptr itemDesc                [[name("Item Descriptions Pointer")]];

    ptr monsterCrowns [[name("Monster Crowns Pointer")]]; // @ 0x130, hd_dll_af4f23
    ptr monsterDesc             [[name("Monster Descriptions Pointer")]];
    ptr monsterCarvePoints [[name("Monster Carve Points Pointer")]]; // @ 0x138, hd_dll_af4ff0
    unk_ptr hd_dll_af5145;

    ptr armorColors [[name("Armor Colors Pointer")]]; // @ 0x140, hd_dll_af517d
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
    ptr publicBarHrReqs [[name("Public Bar HR Reqs Pointer")]]; // @ 0x168, hd_dll_af52ba
    unk_ptr hd_dll_af52f3;

    padding[0x10];              // @ 0x170

    ptr huntingHornSongPages [[name("Hunting Horn Song Pages Pointer")]]; // @ 0x180, hd_dll_af5397
    ptr ancientHuntingHornScorePages [[name("Ancient Hunting Horn Score Pages Pointer")]]; // @ 0x184, hd_dll_af53c0
    ptr cookingCategories [[name("Cooking Ingredient Categories Pointer")]]; // @ 0x188, hd_dll_af53f0
    ptr cookingCategoryStats [[name("Cooking Category Stats Pointer")]]; // @ 0x18C, hd_dll_af5421
    ptr cookingStatTiers [[name("Cooking Stat Tiers Pointer")]]; // @ 0x190, hd_dll_af5427
    ptr huntingInfoItems [[name("Hunting Info Items Pointer")]]; // @ 0x194, hd_dll_af542d
    ptr specialShopsDojoView [[name("Special Shops Dojo View Pointer")]]; // @ 0x198, hd_dll_af5455
    ptr specialShopsNpcView [[name("Special Shops NPC View Pointer")]]; // @ 0x19C, hd_dll_af5491
    ptr hunterGuideVolumes [[name("Hunter Guide Volumes Pointer")]]; // @ 0x1A0, hd_dll_af54d3
    ptr hunterBasicsPages [[name("Hunter Basics Pages Pointer")]]; // @ 0x1A4, hd_dll_af5542
    ptr dojoRulePagesOnline [[name("Dojo Rule Pages (Online) Pointer")]]; // @ 0x1A8, hd_dll_af5570
    ptr dojoRulePagesOffline [[name("Dojo Rule Pages (Offline) Pointer")]]; // @ 0x1AC, hd_dll_af55a0
    ptr tutorialLessons [[name("Tutorial Lessons Pointer")]]; // @ 0x1B0, hd_dll_af55d0
    ptr tutorialLessonGroups [[name("Tutorial Lesson Groups Pointer")]]; // @ 0x1B4, hd_dll_af5611
    ptr beginnerQuests [[name("Beginner Quest IDs Pointer")]]; // @ 0x1B8, hd_dll_af5640
    ptr publicBarMessages [[name("Public Bar Messages Pointer")]]; // @ 0x1BC, hd_dll_af5646
    ptr publicBarTargets [[name("Public Bar Targets Pointer")]]; // @ 0x1C0, hd_dll_af5661
    ptr plazaHrRanges [[name("Plaza HR Ranges Pointer")]]; // @ 0x1C4, hd_dll_af567c
    ptr gunnerShotPower [[name("Gunner Shot Power Pointer")]]; // @ 0x1C8, hd_dll_af57f2
    unk_ptr hd_dll_af583d;
    unk_ptr hd_dll_af5843;      // @ 0x1D0
    ptr mytraAdventures [[name("Mytra Adventure Dispatch Pointer")]]; // @ 0x1D4, hd_dll_af56ea
    ptr mytraCatEquipment [[name("Mytra Cat Equipment Pointer")]]; // @ 0x1D8, hd_dll_af56cc
    ptr mytraShopStage0 [[name("Mytra Shop Stock Stage 0 Pointer")]]; // @ 0x1DC, hd_dll_af56d2
    ptr mytraShopStage2 [[name("Mytra Shop Stock Stage 2 Pointer")]]; // @ 0x1E0, hd_dll_af56d8
    ptr mytraShopStage3 [[name("Mytra Shop Stock Stage 3 Pointer")]]; // @ 0x1E4, hd_dll_af56de
    ptr mytraShopStage3G [[name("Mytra Shop Stock Stage 3 GR600 Pointer")]]; // @ 0x1E8, hd_dll_af56e4
    ptr mytraCatMixStage0 [[name("Mytra Cat Mix Stage 0 Pointer")]]; // @ 0x1EC, hd_dll_af5682
    ptr mytraCatMixStage2 [[name("Mytra Cat Mix Stage 2 Pointer")]]; // @ 0x1F0, hd_dll_af5693
    ptr mytraCatMixStage3 [[name("Mytra Cat Mix Stage 3 Pointer")]]; // @ 0x1F4, hd_dll_af56a4
    ptr mytraCatMixStage3G [[name("Mytra Cat Mix Stage 3 GR600 Pointer")]]; // @ 0x1F8, hd_dll_af56b5
    ptr mytraGuildQuests [[name("Mytra Guild Quests Pointer")]]; // @ 0x1FC, hd_dll_af56c6
    ptr meowkaPotRecipes [[name("Meowka Pot Recipes Pointer")]]; // @ 0x200, hd_dll_af57bf
    ptr farmCatFailItemsHr1 [[name("Farm Cat Fail Items HR 1 Pointer")]]; // @ 0x204, hd_dll_af5772
    ptr farmCatFailItemsHr2 [[name("Farm Cat Fail Items HR 2-30 Pointer")]]; // @ 0x208, hd_dll_af5778
    ptr farmCatFailItemsHr31 [[name("Farm Cat Fail Items HR 31-50 Pointer")]]; // @ 0x20C, hd_dll_af577e
    ptr farmCatFailItemsHr51 [[name("Farm Cat Fail Items HR 51-99 Pointer")]]; // @ 0x210, hd_dll_af5784
    ptr lostItemRewardTiers [[name("Lost Item Reward Tiers Pointer")]]; // @ 0x214, hd_dll_af578a
    ptr helpCatItems [[name("Help Cat Items Pointer")]]; // @ 0x218, hd_dll_af57b9
    unk_ptr hd_dll_af5849;
    unk_ptr hd_dll_af584f;      // @ 0x220
    ptr poogieCostumeSkillCuffs [[name("Poogie Costume Skill Cuffs Pointer")]]; // @ 0x224, hd_dll_af5855
    ptr mytraPoogieLevelThresholds [[name("Mytra Poogie Level Thresholds Pointer")]]; // @ 0x228, hd_dll_af584b
    ptr caravanVoyageRoutes [[name("Caravan Voyage Routes Pointer")]]; // @ 0x22C, hd_dll_af5861
    ptr caravanLevels [[name("Caravan Levels Pointer")]]; // @ 0x230, hd_dll_af5867
    ptr caravanTiers [[name("Caravan Tiers Pointer")]]; // @ 0x234, hd_dll_af4da9
    ptr rastaMeleeWeapons [[name("Rasta Melee Weapons Pointer")]]; // @ 0x238, hd_dll_af586d
    ptr rastaRangedWeapons [[name("Rasta Ranged Weapons Pointer")]]; // @ 0x23C, hd_dll_af588d
    ptr rastaHeadArmor [[name("Rasta Head Armor Pointer")]]; // @ 0x240, hd_dll_af58ca
    ptr rastaChestArmor [[name("Rasta Chest Armor Pointer")]]; // @ 0x244, hd_dll_af58ea
    ptr rastaArmsArmor [[name("Rasta Arms Armor Pointer")]]; // @ 0x248, hd_dll_af58aa
    ptr rastaWaistArmor [[name("Rasta Waist Armor Pointer")]]; // @ 0x24C, hd_dll_af592a
    ptr rastaLegsArmor [[name("Rasta Legs Armor Pointer")]]; // @ 0x250, hd_dll_af590a
    ptr rastaHuntOrders [[name("Rasta Hunt Orders Pointer")]]; // @ 0x254, hd_dll_af594a
    ptr rastaLoyaltyCosts [[name("Rasta Loyalty Costs Pointer")]]; // @ 0x258, hd_dll_af596a
    ptr rastaCredCosts [[name("Rasta Cred Costs Pointer")]]; // @ 0x25C, hd_dll_af5970
    ptr myHouseThemes [[name("My House Themes Pointer")]]; // @ 0x260, hd_dll_af5976
    ptr combinePointRecipes [[name("Combine Point Recipes Pointer")]]; // @ 0x264, hd_dll_af59a1
    ptr combineCpRecipes [[name("Combine CP Recipes Pointer")]]; // @ 0x268, hd_dll_af59a7
    ptr combineZennyRecipes [[name("Combine Zenny Recipes Pointer")]]; // @ 0x26C, hd_dll_af59ad
    ptr combinePointDailyLineups [[name("Combine Point Daily Lineups Pointer")]]; // @ 0x270, hd_dll_af59c5
    ptr combineCpDailyLineups [[name("Combine CP Daily Lineups Pointer")]]; // @ 0x274, hd_dll_af59cb
    ptr combinePointTimedBonuses [[name("Combine Point Timed Bonuses Pointer")]]; // @ 0x278, hd_dll_af5a21
    ptr combineCpTimedBonuses [[name("Combine CP Timed Bonuses Pointer")]]; // @ 0x27C, hd_dll_af5a27
    ptr weaponEffectSets [[name("Weapon Effect Sets Pointer")]]; // @ 0x280, hd_dll_af5a2d
    ptr weaponEffects [[name("Weapon Effects Pointer")]]; // @ 0x284, hd_dll_af5a33
    ptr questSearchMonsters [[name("Quest Search Monsters Pointer")]]; // @ 0x288, hd_dll_af5a39
    ptr questSearchFields [[name("Quest Search Fields Pointer")]]; // @ 0x28C, hd_dll_af5a3f
    ptr questSearchFieldsG [[name("Quest Search Fields (G Rank Counter) Pointer")]]; // @ 0x290, hd_dll_af5a45
    ptr modelEffectSets [[name("Model Effect Sets Pointer")]]; // @ 0x294, hd_dll_af5a4b
    ptr modelEffects [[name("Model Effects Pointer")]]; // @ 0x298, hd_dll_af5a51
    ptr rastaItemSets [[name("Rasta Item Sets Pointer")]]; // @ 0x29C, hd_dll_af5a57
    unk_ptr hd_dll_af5a5d;      // @ 0x2A0
    ptr instructorChallengeTasks [[name("Instructor Challenge Tasks Pointer")]]; // @ 0x2A4, hd_dll_af5ae0
    ptr instructorChallengePicks [[name("Instructor Challenge Picks Pointer")]]; // @ 0x2A8, hd_dll_af5ab1
    ptr instructorChallengeRewards [[name("Instructor Challenge Rewards Pointer")]]; // @ 0x2AC, hd_dll_af5ae6
    ptr stageObjectPoints [[name("Stage Object Points Pointer")]]; // @ 0x2B0, hd_dll_af5a63
    ptr stageObjectKinds [[name("Stage Object Kinds Pointer")]]; // @ 0x2B4, hd_dll_af5a69
    ptr stageObjectPicks [[name("Stage Object Picks Pointer")]]; // @ 0x2B8, hd_dll_af5a6f
    ptr stageObjectIndex [[name("Stage Object Index Pointer")]]; // @ 0x2BC, hd_dll_af5a75
    ptr CuffCrafting            [[name("Cuff Crafting Pointer")]];      // @ 0x2C0
    ptr pioneerQuestItems [[name("Pioneer Quest Items Pointer")]]; // @ 0x2C4, hd_dll_af5b21
    ptr pioneerQuests [[name("Pioneer Quests Pointer")]]; // @ 0x2C8, hd_dll_af5b27
    ptr evoMeleeWeaponSeries [[name("Evolution Melee Weapon Series Pointer")]]; // @ 0x2CC, hd_dll_af5a7b
    ptr evoRangedWeaponSeries [[name("Evolution Ranged Weapon Series Pointer")]]; // @ 0x2D0, hd_dll_af5a81
    ptr evoSeries0 [[name("Evolution Series 0 Pointer")]]; // @ 0x2D4, hd_dll_af5a87
    ptr evoSeries1 [[name("Evolution Series 1 Pointer")]]; // @ 0x2D8, hd_dll_af5a8d
    ptr evoSeries2 [[name("Evolution Series 2 Pointer")]]; // @ 0x2DC, hd_dll_af5a93
    ptr evoSeries3 [[name("Evolution Series 3 Pointer")]]; // @ 0x2E0, hd_dll_af5a99
    ptr pioneerBaseCosts [[name("Pioneer Base Costs Pointer")]]; // @ 0x2E4, hd_dll_af5b6c
    ptr bowArrowKoValues [[name("Bow Arrow KO Values Pointer")]]; // @ 0x2E8, hd_dll_af5a9f
    ptr pioneerPublicRewardTiers [[name("Pioneer Public Reward Tiers Pointer")]]; // @ 0x2EC, hd_dll_af5aa5
    ptr pioneerQuestBonusRewards [[name("Pioneer Quest Bonus Rewards Pointer")]]; // @ 0x2F0, hd_dll_af5aab
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
    ptr innerBodyModels [[name("Inner Body Models Pointer")]]; // @ 0x31C, hd_dll_af5c18
    ptr partnerFaces [[name("Partner Faces Pointer")]]; // @ 0x320, hd_dll_af5c1e
    ptr hcMonstersHR [[name("HC Monsters HR Pointer")]]; // @ 0x324, hd_dll_af5bd0
    ptr secretBookRewardsHR [[name("Secret Book HR Rewards Pointer")]]; // @ 0x328, hd_dll_af5bd6

    ptr carveHCItemDrops        [[name("HC Carve Drop Data Pointer")]];

    ptr rookieQuestRewards [[name("Rookie Quest Rewards Pointer")]]; // @ 0x330, hd_dll_af5c24
    ptr chequeGateByPlayers [[name("Cheque Gate by Players Pointer")]]; // @ 0x334, hd_dll_af5c2a
    ptr chequeGateByPlayersRasta [[name("Cheque Gate by Players (Rasta) Pointer")]]; // @ 0x338, hd_dll_af5c30
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
    ptr nameDisplaySizes [[name("Name Display Sizes Pointer")]]; // @ 0x364, hd_dll_af5c7e
    ptr trapSkillCombineResults [[name("Trap Skill Combine Results Pointer")]]; // @ 0x368, hd_dll_af5c84
    ptr exGWeaponData [[name("Random (ex G) Weapons Pointer")]]; // @ 0x36C, hd_dll_af5c8a
    ptr randomSharpnessSwordAndShield [[name("Random Sharpness Sword and Shield Pointer")]]; // @ 0x370, hd_dll_af5c90
    ptr randomSharpnessDualBlades [[name("Random Sharpness Dual Blades Pointer")]]; // @ 0x374, hd_dll_af5c96
    ptr randomSharpnessGreatSwordLongSword [[name("Random Sharpness Great Sword and Long Sword Pointer")]]; // @ 0x378, hd_dll_af5c9c
    ptr randomSharpnessLance [[name("Random Sharpness Lance Pointer")]]; // @ 0x37C, hd_dll_af5ca2
    ptr randomSharpnessHammerHorn [[name("Random Sharpness Hammer and Hunting Horn Pointer")]]; // @ 0x380
    ptr exGTopTierRollPercents [[name("Ex G Top Tier Roll Percents Pointer")]]; // @ 0x384, hd_dll_af5cae
    ptr exGMidTierRollPercents [[name("Ex G Mid Tier Roll Percents Pointer")]]; // @ 0x388, hd_dll_af5cb4
    ptr exGBaseTierRollOverrides [[name("Ex G Base Tier Roll Overrides Pointer")]]; // @ 0x38C, hd_dll_af5cba
    ptr chequeHrChances [[name("30k Cheque HR Chances Pointer")]]; // @ 0x390, hd_dll_af5ccc
    ptr nBonusItemChances [[name("N Bonus Item Chances Pointer")]]; // @ 0x394, hd_dll_af5cd2
    ptr nBonusItems [[name("N Bonus Items Pointer")]]; // @ 0x398, hd_dll_af5cd8
    ptr gQuestPartySizeRates [[name("G Quest Party Size Rates Pointer")]]; // @ 0x39C, hd_dll_af5cde
    ptr exGRankChances [[name("Ex G Weapon Rank Chances Pointer")]]; // @ 0x3A0, hd_dll_af5cc0
    ptr exGArrowSets [[name("Ex G Bow Arrow Sets Pointer")]]; // @ 0x3A4, hd_dll_af5cc6
    ptr evoSeries4 [[name("Evolution Series 4 Pointer")]]; // @ 0x3A8, hd_dll_af5cea
    ptr evoSeries5 [[name("Evolution Series 5 Pointer")]]; // @ 0x3AC, hd_dll_af5cf0
    ptr evoSeries6 [[name("Evolution Series 6 Pointer")]]; // @ 0x3B0, hd_dll_af5cf6
    ptr evoSeries7 [[name("Evolution Series 7 Pointer")]]; // @ 0x3B4, hd_dll_af5cfc
    unk_ptr hd_dll_af5d02;
    ptr gousyuSkillUpConditions [[name("Gousyu Skill Up Conditions Pointer")]]; // @ 0x3BC, hd_dll_af5d08
    ptr gousyuSkillUpSkillTypes [[name("Gousyu Skill Up Skill Types Pointer")]]; // @ 0x3C0, hd_dll_af5d0e
    ptr goocooHats [[name("Goocoo Hats Pointer")]]; // @ 0x3C4, hd_dll_af5d14
    ptr goocooClothes [[name("Goocoo Clothes Pointer")]]; // @ 0x3C8, hd_dll_af5d1a
    ptr goocooMasks [[name("Goocoo Masks Pointer")]]; // @ 0x3CC, hd_dll_af5d20
    ptr goocooBags [[name("Goocoo Bags Pointer")]]; // @ 0x3D0, hd_dll_af5d26
    ptr goocooTails [[name("Goocoo Tail Accessories Pointer")]]; // @ 0x3D4, hd_dll_af5d2c
    ptr goocooHatNames [[name("Goocoo Hat Names Pointer")]]; // @ 0x3D8, hd_dll_af5d32
    ptr goocooClothesNames [[name("Goocoo Clothes Names Pointer")]]; // @ 0x3DC, hd_dll_af5d60
    ptr goocooMaskNames [[name("Goocoo Mask Names Pointer")]]; // @ 0x3E0, hd_dll_af5d90
    ptr goocooBagNames [[name("Goocoo Bag Names Pointer")]]; // @ 0x3E4, hd_dll_af5dc0
    ptr goocooTailNames [[name("Goocoo Tail Accessory Names Pointer")]]; // @ 0x3E8, hd_dll_af5df0
    ptr goocooHatDescs [[name("Goocoo Hat Descriptions Pointer")]]; // @ 0x3EC, hd_dll_af5e20
    ptr goocooClothesDescs [[name("Goocoo Clothes Descriptions Pointer")]]; // @ 0x3F0, hd_dll_af5e50
    ptr goocooMaskDescs [[name("Goocoo Mask Descriptions Pointer")]]; // @ 0x3F4, hd_dll_af5e80
    ptr goocooBagDescs [[name("Goocoo Bag Descriptions Pointer")]]; // @ 0x3F8, hd_dll_af5eb0
    ptr goocooTailDescs [[name("Goocoo Tail Accessory Descriptions Pointer")]]; // @ 0x3FC, hd_dll_af5ee0
    ptr goocooClothingSeriesNames [[name("Goocoo Clothing Series Names Pointer")]]; // @ 0x400, hd_dll_af5f10
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
    ptr goocooEggCare [[name("Goocoo Egg Care Pointer")]]; // @ 0x438, hd_dll_af5fb3
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
    ptr goocooQuestLists [[name("Goocoo Quest Lists Pointer")]]; // @ 0x474, hd_dll_af61b0
    ptr goocooTrustParams [[name("Goocoo Trust Parameters Pointer")]]; // @ 0x478, hd_dll_af61e0
    ptr goocooTrustDecay [[name("Goocoo Trust Decay Pointer")]]; // @ 0x47C, hd_dll_af61e6
    ptr goocooNewSkinLots [[name("Goocoo New Skin Lots Pointer")]]; // @ 0x480, hd_dll_af61ec
    ptr goocooSkinClasses [[name("Goocoo Skin Classes Pointer")]]; // @ 0x484, hd_dll_af61f2
    ptr goocooSkinClassScores [[name("Goocoo Skin Class Scores Pointer")]]; // @ 0x488, hd_dll_af61f8
    ptr goocooEggClassLots [[name("Goocoo Egg Class Lots Pointer")]]; // @ 0x48C, hd_dll_af61fe
    ptr goocooEggSkinSourceLots [[name("Goocoo Egg Skin Source Lots Pointer")]]; // @ 0x490, hd_dll_af6204
    ptr goocooExchanges [[name("Goocoo Exchanges Pointer")]]; // @ 0x494, hd_dll_af620a
    ptr goocooClothesCosts [[name("Goocoo Clothes Costs Pointer")]]; // @ 0x498, hd_dll_af623d
    ptr goocooRemodelCosts [[name("Goocoo Remodel Costs Pointer")]]; // @ 0x49C, hd_dll_af6243
    ptr goocooGroupSpots [[name("Goocoo Group Spots Pointer")]]; // @ 0x4A0, hd_dll_af6249
    ptr goocooTalkItems [[name("Goocoo Talk Items Pointer")]]; // @ 0x4A4, hd_dll_af6280
    ptr goocooTalkDropItems [[name("Goocoo Talk Drop Items Pointer")]]; // @ 0x4A8, hd_dll_af6286
    ptr goocooTalkItemThresholds [[name("Goocoo Talk Item Thresholds Pointer")]]; // @ 0x4AC, hd_dll_af628C
    ptr goocooGroupGaugeGain [[name("Goocoo Group Gauge Gain Pointer")]]; // @ 0x4B0, hd_dll_af6292
    ptr goocooEmoteDelays [[name("Goocoo Emote Delays Pointer")]]; // @ 0x4B4, hd_dll_af6298
    ptr goocooPotWelldoneItems [[name("Goocoo Pot Well-Done Items Pointer"), comment("Secret Book swap of a pot material's well-done item: 12 items per weapon class")]]; // @ 0x4B8, hd_dll_af62d4
    ptr goocooPotMaterials [[name("Goocoo Pot Materials Pointer")]]; // @ 0x4BC, hd_dll_af62c8
    ptr goocooPotSoups [[name("Goocoo Pot Soups Pointer")]]; // @ 0x4C0, hd_dll_af62ce
    ptr goocooFarmTimers [[name("Goocoo Farm Timers Pointer")]]; // @ 0x4C4, hd_dll_af62da
    ptr goocooFarmHarvests [[name("Goocoo Farm Harvests Pointer")]]; // @ 0x4C8, hd_dll_af62e0
    ptr strayGoocooLobbyMeshes [[name("Stray Goocoo Lobby Meshes Pointer")]]; // @ 0x4CC, hd_dll_af629e
    ptr strayGoocooEquipMeshLots [[name("Stray Goocoo Equip Mesh Lots Pointer")]]; // @ 0x4D0, hd_dll_af62a4
    ptr strayGoocooMyHouseActionLots [[name("Stray Goocoo My House Action Lots Pointer")]]; // @ 0x4D4, hd_dll_af62aa
    ptr strayGoocooWorkshopActionLots0 [[name("Stray Goocoo Workshop Action Lots 0 Pointer")]]; // @ 0x4D8, hd_dll_af62b0
    ptr strayGoocooWorkshopActionLots1 [[name("Stray Goocoo Workshop Action Lots 1 Pointer")]]; // @ 0x4DC, hd_dll_af62b6
    ptr strayGoocooMyHawkLayoutLots [[name("Stray Goocoo MyHawk Layout Lots Pointer")]]; // @ 0x4E0, hd_dll_af62bc
    ptr extraStages [[name("Extra Stages Pointer")]]; // @ 0x4E4, hd_dll_af62c2
    ptr greatSlayingQuests [[name("Great Slaying Quests Pointer")]]; // @ 0x4E8, hd_dll_af6304
    unk_ptr hd_dll_af630a;
    ptr randomShellTypes [[name("Random Gunlance Shell Types Pointer")]]; // @ 0x4F0, hd_dll_af6310
    ptr handlingDrawSpeed [[name("Handling Draw Speed Pointer")]]; // @ 0x4F4, hd_dll_af632e
    ptr randomSharpnessGunlance [[name("Random Sharpness Gunlance Pointer")]]; // @ 0x4F8, hd_dll_af6316
    unk_ptr hd_dll_af5ce4;
    ptr exGTopTierRollPercentsGunlance [[name("Ex G Top Tier Roll Percents Gunlance Pointer")]]; // @ 0x500, hd_dll_af631c
    ptr exGMidTierRollPercentsGunlance [[name("Ex G Mid Tier Roll Percents Gunlance Pointer")]]; // @ 0x504, hd_dll_af6322
    ptr exGBaseTierRollOverridesGunlance [[name("Ex G Base Tier Roll Overrides Gunlance Pointer")]]; // @ 0x508, hd_dll_af6328
    ptr entityMotionSounds [[name("Entity Motion Sounds Pointer")]]; // @ 0x50C, hd_dll_af6334
    ptr halkFoods [[name("Halk Foods Pointer")]]; // @ 0x510, hd_dll_af6434
    ptr eventSceneScriptSizes [[name("Event Scene Script Sizes Pointer")]]; // @ 0x514, hd_dll_af643a
    ptr eventSceneScripts [[name("Event Scene Scripts Pointer")]]; // @ 0x518, hd_dll_af6440
    ptr monsterIconIndices [[name("Monster Icon Indices Pointer")]]; // @ 0x51C
    ptr evolutionGunAmmo [[name("Evolution Gun Extra Ammo Pointer")]]; // @ 0x520, hd_dll_af647d
    ptr my_mission_data         [[name("My Mission Data Pointer")]];
    ptr secretBookEffectValues [[name("Secret Book Effect Values Pointer")]]; // @ 0x528, hd_dll_af658e
    ptr myHouseArmorDisplays [[name("My House Armor Displays Pointer")]]; // @ 0x52C, hd_dll_af659a
    unk_ptr hd_dll_af65ea;      // @ 0x530
    ptr myMissionSetObjectives [[name("My Mission Set Objectives Pointer")]]; // @ 0x534, hd_dll_af65f0
    ptr my_mission_objective    [[name("My Mission Objective Pointer")]];
    ptr monsterHitzoneEffectScales [[name("Monster Hitzone Effect Scales Pointer")]]; // @ 0x53C, hd_dll_af65fc
    ptr soundVolumeCurves [[name("Sound Volume Curves Pointer")]]; // @ 0x540, hd_dll_af6602
    ptr soundCurves2 [[name("Sound Curves 2 Pointer")]]; // @ 0x544, hd_dll_af6608
    ptr soundTypes [[name("Sound Types Pointer")]]; // @ 0x548, hd_dll_af660e
    ptr seasonalEventTiming     [[name("Seasonal Event Timing Table Pointer")]];
    ptr titleCategories [[name("Title Categories Pointer")]]; // @ 0x550, hd_dll_af661a
    ptr evoBowgunBombRates [[name("Evolution Bowgun Bomb Rates Pointer")]]; // @ 0x554, hd_dll_af6640
    ptr cookedDishes [[name("Cooked Dishes Pointer")]]; // @ 0x558, hd_dll_af6646
    ptr hcSecretBookBonusHagi2Plus [[name("HC Secret Book Bonus HagiLv 2+ Pointer")]]; // @ 0x55C, hd_dll_af664c
    ptr hcSecretBookBonusHagi1 [[name("HC Secret Book Bonus HagiLv 1 Pointer")]]; // @ 0x560, hd_dll_af6652
    ptr hcSecretBookBonusHagi0 [[name("HC Secret Book Bonus HagiLv 0 Pointer")]]; // @ 0x564, hd_dll_af6658
    ptr cookingRecipes [[name("Cooking Recipes Pointer")]]; // @ 0x568, hd_dll_af665e
    ptr npcHunters [[name("NPC Hunters Pointer")]]; // @ 0x56C, hd_dll_af6664
    ptr npcHunterWeapons [[name("NPC Hunter Weapons Pointer")]]; // @ 0x570, hd_dll_af666a
    ptr npcHunterArmorSets [[name("NPC Hunter Armor Sets Pointer")]]; // @ 0x574, hd_dll_af6670
    unk_ptr hd_dll_af6676;
    ptr bowModelMaterials [[name("Bow Model Materials Pointer")]]; // @ 0x57C, hd_dll_af667c
    ptr bowModelMaterialRows [[name("Bow Model Material Rows Pointer")]]; // @ 0x580, hd_dll_af6682
    ptr priorityRequestEntries [[name("Guild Priority Request Entries Pointer")]]; // @ 0x584, hd_dll_af6688
    ptr priorityRequestRotations [[name("Guild Priority Request Rotations Pointer")]]; // @ 0x588, hd_dll_af668e
    ptr cookingMenuLayout [[name("Cooking Menu Layout Pointer")]]; // @ 0x58C, hd_dll_af6694
    unk_ptr hd_dll_af669a;      // @ 0x590
    ptr skillEffects [[name("Skill Effects Pointer")]]; // @ 0x594, hd_dll_af66a0
    ptr gArmorFxElementRate [[name("G Armor Fx Element Rate Pointer")]]; // @ 0x598, hd_dll_af66a6
    ptr gArmorFxStatusRate [[name("G Armor Fx Status Rate Pointer")]]; // @ 0x59C, hd_dll_af66ac
    ptr gArmorFxElementPercent [[name("G Armor Fx Element Percent Pointer")]]; // @ 0x5A0, hd_dll_af66b2
    unk_ptr hd_dll_af66b8;
    ptr gArmorFxAttackAdd [[name("G Armor Fx Attack Add Pointer")]]; // @ 0x5A8, hd_dll_af66be
    unk_ptr hd_dll_af66c4;
    ptr hcKaiCritDamage [[name("HC Kai Critical Damage Pointer")]]; // @ 0x5B0, hd_dll_af66ca
    ptr hcKaiDefense [[name("HC Kai Defense Pointer")]]; // @ 0x5B4, hd_dll_af66d0
    ptr secretBookSrLevels [[name("Secret Book SR Levels Pointer")]]; // @ 0x5B8, hd_dll_af703a
    ptr hcKaiGClassSDamageReduction [[name("HC Kai / G Class S Damage Reduction Pointer")]]; // @ 0x5BC, hd_dll_af66d6
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
    ptr stageMapBackgroundColors [[name("Stage Map Background Colors Pointer")]]; // @ 0x610, hd_dll_af6c2c
    ptr weaponActions [[name("Weapon Action Scripts Pointer")]]; // @ 0x614, hd_dll_af6c32
    ptr playerMotionEventBanks [[name("Player Motion Event Banks Pointer")]]; // @ 0x618, hd_dll_af6c98
    ptr playerSoundBanks [[name("Player Sound Banks Pointer")]]; // @ 0x61C, hd_dll_af6d00
    // random sigils (sigils.hexpat)
    ptr sigilCraftingRecipes    [[name("Sigil Crafting Recipes Pointer")]];        // @ 0x620, hd_dll_af6d60
    ptr sigilSkillProbabilities [[name("Sigil Skill Probabilities Pointer")]];     // hd_dll_af6d66
    ptr sigilSkillBlacklists    [[name("Sigil Skill Blacklists Pointer")]];        // hd_dll_af6d6c
    ptr sigilSkillBaseInfo      [[name("Sigil Skill Base Info Pointer")]];         // hd_dll_af6da0
    ptr sigilClassThresholds [[name("Sigil Class Thresholds Pointer")]]; // @ 0x630, hd_dll_af6da6
    ptr sigilCraftMaterials [[name("Sigil Craft Materials Pointer")]]; // @ 0x634, hd_dll_af6dac
    ptr sigilIconThresholds [[name("Sigil Icon Thresholds Pointer")]]; // @ 0x638, hd_dll_af6db2
    ptr motionValues [[name("Motion Values Pointer")]]; // @ 0x63C, hd_dll_af6db8
    ptr hbgShotGaugeGains [[name("HBG Shot Gauge Gains Pointer")]]; // @ 0x640, hd_dll_af6dbe
    ptr fencingHitstopOverrides [[name("Fencing Hitstop Overrides Pointer")]]; // @ 0x644, hd_dll_af6e7c
    ptr skillParams [[name("Skill Parameters Pointer"), comment("Rush gauge thresholds at +0x64; the rest is shared with other skills")]]; // @ 0x648, hd_dll_af6eab
    ptr roadMilestones [[name("Road Floor Milestones Pointer")]]; // @ 0x64C, hd_dll_af6eb1
    ptr shortcutCombineBlockedActions [[name("Shortcut Combine Blocked Actions Pointer")]]; // @ 0x650, hd_dll_af6eb7
    ptr lanceComboRules [[name("Lance Combo Rules Pointer")]]; // @ 0x654, hd_dll_af6e82
    ptr sharpnessMultipliers [[name("Sharpness Multipliers Pointer")]]; // @ 0x658, hd_dll_af6f6f
    ptr weaponParams [[name("Weapon Parameters Pointer")]]; // @ 0x65C, hd_dll_af6f75
    ptr weaponConstants [[name("Weapon Constants Pointer")]]; // @ 0x660, hd_dll_af6f7b
    ptr weaponUseBanFreeActions [[name("Weapon Use Ban Free Actions Pointer")]]; // @ 0x664, hd_dll_af6f81
    ptr justReloadLists [[name("Just Reload Lists Pointer")]]; // @ 0x668, hd_dll_af6fa8
    ptr justShotLists [[name("Just Shot Lists Pointer")]]; // @ 0x66C, hd_dll_af6fca
    ptr hornMelodies [[name("Horn Melodies Pointer")]]; // @ 0x670, hd_dll_af6fec
    ptr hornExtremeMelodies [[name("Horn Extreme Melodies Pointer")]]; // @ 0x674, hd_dll_af6ff2
    ptr gunlanceShells [[name("Gunlance Shells Pointer")]]; // @ 0x678, hd_dll_af6ff8
    ptr gunlanceShellLowSharpnessDamageRate [[name("Gunlance Shell Low Sharpness Damage Rate Pointer")]]; // @ 0x67C, hd_dll_af6ffe
    ptr gunlanceShellDamageRate [[name("Gunlance Shell Damage Rate Pointer")]]; // @ 0x680, hd_dll_af7004
    ptr gunlanceShellGDamageRate [[name("Gunlance Shell G Damage Rate Pointer")]]; // @ 0x684, hd_dll_af700a
    ptr gunlanceShellSharpnessCost [[name("Gunlance Shell Sharpness Cost Pointer")]]; // @ 0x688, hd_dll_af7010
    ptr gunlanceSpDragonCannonDamageRate [[name("Gunlance Sp Dragon Cannon Damage Rate Pointer")]]; // @ 0x68C, hd_dll_af7016
    ptr gunlanceSpDragonCannonTimerRate [[name("Gunlance Sp Dragon Cannon Timer Rate Pointer")]]; // @ 0x690, hd_dll_af701c
    ptr gunlanceSpDragonCannonSharpnessCost [[name("Gunlance Sp Dragon Cannon Sharpness Cost Pointer")]]; // @ 0x694, hd_dll_af7022
    ptr gunlanceExShotDamageRate [[name("Gunlance Extreme Shot Damage Rate Pointer")]]; // @ 0x698, hd_dll_af7028
    ptr gunlanceExShotTimerRate [[name("Gunlance Extreme Shot Timer Rate Pointer")]]; // @ 0x69C, hd_dll_af702e
    ptr gunlanceExShotSharpnessCost [[name("Gunlance Extreme Shot Sharpness Cost Pointer")]]; // @ 0x6A0, hd_dll_af7034
    ptr guildIconMonsterIcons [[name("Guild Icon Monster Icons Pointer")]]; // @ 0x6A4, hd_dll_af7052
    ptr compoundElements [[name("Compound Elements Pointer")]]; // @ 0x6A8, hd_dll_af7040
    ptr carveKindChances [[name("Carve Kind Chances Pointer")]]; // @ 0x6AC, hd_dll_af7046
    ptr partnerStarterWeapons [[name("Partner Starter Weapons Pointer")]]; // @ 0x6B0, hd_dll_af7058
    ptr partnerArmorSetA [[name("Partner Armor Set A Pointer")]]; // @ 0x6B4, hd_dll_af705e
    ptr partnerArmorSetB [[name("Partner Armor Set B Pointer")]]; // @ 0x6B8, hd_dll_af7064
    unk_ptr hd_dll_af706a;
    ptr monsterPriceBoard [[name("Monster Price Board Pointer")]]; // @ 0x6C0, hd_dll_af7070
    ptr carveNormalItems [[name("Carve Normal Items Pointer")]]; // @ 0x6C4, hd_dll_af704c
    // G1 to G7 quest lists, each to a u32 holding the list's address (quests.hexpat)
    ptr GRankQuestG1            [[name("G1 Quests Pointer")]];     // @ 0x6C8, hd_dll_af7076
    ptr GRankQuestG2            [[name("G2 Quests Pointer")]];     // hd_dll_af70bc
    ptr GRankQuestG3            [[name("G3 Quests Pointer")]];     // @ 0x6D0, hd_dll_af710a
    ptr GRankQuestG4            [[name("G4 Quests Pointer")]];     // hd_dll_af715a
    ptr GRankQuestG5            [[name("G5 Quests Pointer")]];     // hd_dll_af71aa
    ptr GRankQuestG6            [[name("G6 Quests Pointer")]];     // hd_dll_af71fa
    ptr GRankQuestG7            [[name("G7 Quests Pointer")]];     // @ 0x6E0
    ptr gatherStarItems1 [[name("Gather Star Items 1 Pointer")]]; // @ 0x6E4, hd_dll_af738a
    ptr gatherStarItems0 [[name("Gather Star Items 0 Pointer")]]; // @ 0x6E8, hd_dll_af7390
    ptr gatherStarItems2 [[name("Gather Star Items 2 Pointer")]]; // @ 0x6EC, hd_dll_af7396
    ptr veggieElderTradeMaps [[name("Veggie Elder Trade Maps Pointer")]]; // @ 0x6F0, hd_dll_af739c
    unk_ptr hd_dll_af73d7;
    unk_ptr hd_dll_af73dd;
    unk_ptr hd_dll_af73e3;
    unk_ptr hd_dll_af73e9;      // @ 0x700
    unk_ptr hd_dll_af740a;
    padding[0x8];
    padding[0x4];               // @ 0x710
    unk_ptr hd_dll_af771d;
    ptr boxSearchSigilSkills [[name("Box Search Sigil Skills Pointer")]]; // @ 0x718, hd_dll_af5c66
    unk_ptr hd_dll_af7723;
    unk_ptr hd_dll_af7729;      // @ 0x720
    ptr weaponModelSoundIds [[name("Weapon Model Sound Ids Pointer")]]; // @ 0x724, hd_dll_af772f
    ptr sigilRecoveryItems [[name("Sigil Recovery Items Pointer")]]; // @ 0x728, hd_dll_af7735
    ptr playerUniqueParams [[name("Player Unique Parameters Pointer")]]; // @ 0x72C, hd_dll_af773b
    ptr hcMonstersG [[name("HC Monsters G Pointer")]]; // @ 0x730, hd_dll_af7741
    ptr secretBookRewardsG [[name("Secret Book G Rewards Pointer")]]; // @ 0x734, hd_dll_af7747

    ptr carveGRHCItemDrops      [[name("Carve GR HC Drop Data Pointer")]];

    ptr secretBookGBonusItems [[name("Secret Book G Bonus Items Pointer")]]; // @ 0x73C, hd_dll_af7753
    ptr GRankQuestG8 [[name("G8 Quests Pointer")]]; // @ 0x740, hd_dll_af729a
    ptr GRankQuestG9 [[name("G9 Quests Pointer")]]; // @ 0x744, hd_dll_af72ea
    ptr GRankQuestG10 [[name("G10 Quests Pointer")]]; // @ 0x748, hd_dll_af733a
    ptr motionValuesAlt [[name("Motion Values Alternate Bank Pointer")]]; // @ 0x74C, hd_dll_af7759
    ptr GrankCuffCrafting        [[name("G-Rank Cuff Crafting Pointer")]];      // @ 0x750
    ptr gsrAttackLevels [[name("GSR Attack Levels Pointer")]]; // @ 0x754, hd_dll_af7765
    ptr gsrUnlocks [[name("GSR Unlocks Pointer")]]; // @ 0x758
    ptr gsrExtremeAttack [[name("GSR Extreme Attack Pointer")]]; // @ 0x75C, hd_dll_af7771
    ptr gsrExtremeDefense [[name("GSR Extreme Defense Pointer")]]; // @ 0x760, hd_dll_af7777
    ptr gsrDefenseBonus [[name("GSR Defense Bonus Pointer")]]; // @ 0x764, hd_dll_af777d
    ptr gsrFireResBonus [[name("GSR Fire Res Bonus Pointer")]]; // @ 0x768, hd_dll_af7783
    ptr gsrWaterResBonus [[name("GSR Water Res Bonus Pointer")]]; // @ 0x76C, hd_dll_af7789
    ptr gsrThunderResBonus [[name("GSR Thunder Res Bonus Pointer")]]; // @ 0x770, hd_dll_af778f
    ptr gsrIceResBonus [[name("GSR Ice Res Bonus Pointer")]]; // @ 0x774, hd_dll_af7795
    ptr gsrDragonResBonus [[name("GSR Dragon Res Bonus Pointer")]]; // @ 0x778, hd_dll_af779b
    ptr gsrAllResBonus [[name("GSR All Res Bonus Pointer")]]; // @ 0x77C, hd_dll_af77a1
    ptr fishingBaits [[name("Fishing Baits Pointer")]]; // @ 0x780, hd_dll_af77a7
    unk_ptr hd_dll_af77ef;
    unk_ptr hd_dll_af77f5;
    ptr pouchItemRewards [[name("Pouch Item Rewards Pointer")]]; // @ 0x78C, hd_dll_af77fb
    ptr heatCannonSigilPower [[name("Heat Cannon Sigil Power Pointer")]]; // @ 0x790, hd_dll_af7801
    ptr superRapidFirePower [[name("Super Rapid Fire Power Pointer")]]; // @ 0x794, hd_dll_af7807
    ptr gQuestDifficultyThresholds [[name("G Quest Difficulty Thresholds Pointer")]]; // @ 0x798, hd_dll_af780d
    ptr gQuestDifficultyDefenses [[name("G Quest Difficulty Base Defenses Pointer")]]; // @ 0x79C, hd_dll_af7813
    ptr vampirism [[name("Vampirism Pointer")]]; // @ 0x7A0, hd_dll_af7819
    unk_ptr hd_dll_af781f;
    ptr npcMotionSounds [[name("NPC Motion Sounds Pointer")]]; // @ 0x7A8, hd_dll_af7825

    ptr weaponSpecialForging    [[name("Special Weapon Forging Pointer")]];
    
    ptr armorPremiumForging     [[name("Armor Premium Forging Pointer")]];      // @ 0x7B0
    ptr questRareRewardChance [[name("Quest Rare Reward Chance Pointer")]]; // @ 0x7B4, hd_dll_af787b
    ptr questRareRewards [[name("Quest Rare Rewards Pointer")]]; // @ 0x7B8, hd_dll_af7881
    ptr rewardSlotChancesBasicB [[name("Basic B Reward Slot Chances Pointer")]]; // @ 0x7BC, hd_dll_af7887
    ptr rewardSlotChancesSub [[name("Sub Target Reward Slot Chances Pointer")]]; // @ 0x7C0, hd_dll_af78b2
    ptr carveFailChances [[name("Carve Fail Chances Pointer")]]; // @ 0x7C4, hd_dll_af7a30
    ptr divaHallActorPoints [[name("Diva Hall Actor Points Pointer")]]; // @ 0x7C8, hd_dll_af7a36
    ptr divaHallCameras [[name("Diva Hall Cameras Pointer")]]; // @ 0x7CC, hd_dll_af7a3c
    ptr divaStoryGiftLiking [[name("Diva Story Gift Liking Pointer")]]; // @ 0x7D0, hd_dll_af7a42
    ptr huntingMedalMilestones [[name("Hunting Medal Milestones Pointer")]]; // @ 0x7D4, hd_dll_af7a48
    ptr koryoAmulets [[name("Koryo Amulets Pointer")]]; // @ 0x7D8, hd_dll_af7a7c
    ptr rewardSlotChancesCapture [[name("Capture Reward Slot Chances Pointer")]]; // @ 0x7DC, hd_dll_af78e0
    ptr noPreviewEquipment [[name("No Preview Equipment Pointer")]]; // @ 0x7E0, hd_dll_af7a82
    ptr rewardRateExemptItems [[name("Reward Rate Exempt Items Pointer")]]; // @ 0x7E4, hd_dll_af7a88
    ptr rewardSlotChancesBasicBStOther [[name("Basic B S/T Other Reward Slot Chances Pointer")]]; // @ 0x7E8, hd_dll_af7910
    ptr rewardSlotChancesBasicBSt5 [[name("Basic B S/T 5 Reward Slot Chances Pointer")]]; // @ 0x7EC, hd_dll_af7940
    ptr rewardSlotChancesBasicBSt6 [[name("Basic B S/T 6 Reward Slot Chances Pointer")]]; // @ 0x7F0, hd_dll_af7970
    ptr rewardSlotChancesBasicBSt7 [[name("Basic B S/T 7 Reward Slot Chances Pointer")]]; // @ 0x7F4, hd_dll_af79a0
    ptr serverBoxSlotChances [[name("Server Reward Box Slot Chances Pointer")]]; // @ 0x7F8, hd_dll_af79d0
    ptr serverBoxSlotChancesByMode [[name("Server Reward Box Slot Chances by Mode Pointer")]]; // @ 0x7FC, hd_dll_af7a00
    ptr partnerLooks [[name("Partner Looks Pointer")]]; // @ 0x800, hd_dll_af7a8e
    ptr AutomaticSkillsTable    [[name("Automatic Skills Table Pointer")]];
    unk_ptr hd_dll_af7a9a;
    ptr incitementTunables [[name("Incitement Tunables Pointer")]]; // @ 0x80C, hd_dll_af7aa0
    ptr guildHallRewardLists [[name("Guild Hall Reward Lists Pointer")]]; // @ 0x810, hd_dll_af7aa6
    ptr guildHallRewardGroups [[name("Guild Hall Reward Groups Pointer")]]; // @ 0x814, hd_dll_af7ae3
    ptr guildHallRewardStacks [[name("Guild Hall Reward Stacks Pointer")]]; // @ 0x818, hd_dll_af7ae9
    ptr guildHallRewardItems [[name("Guild Hall Reward Items Pointer")]]; // @ 0x81C, hd_dll_af7aef
    ptr guildHallRewardExtraItemsHrLow [[name("Guild Hall Reward Extra Items HR 1-30 Pointer")]]; // @ 0x820, hd_dll_af7af5
    ptr guildHallRewardExtraItemsHrMid [[name("Guild Hall Reward Extra Items HR 31-100 Pointer")]]; // @ 0x824, hd_dll_af7afb
    ptr guildHallRewardExtraItemsHrHigh [[name("Guild Hall Reward Extra Items HR 101+ Pointer")]]; // @ 0x828, hd_dll_af7b01
    padding[0x4];
    ptr incitementEnmityCut [[name("Incitement Enmity Cut Pointer")]]; // @ 0x830, hd_dll_af7b07
    ptr incitementUnreachableRelease [[name("Incitement Unreachable Release Pointer")]]; // @ 0x834, hd_dll_af7b0d
    ptr partnerSkills [[name("Partner Skills Pointer")]]; // @ 0x838, hd_dll_af7b13
    ptr partnerLevelAttack [[name("Partner Level Attack Pointer")]]; // @ 0x83C, hd_dll_af7b19
    ptr partnerClassLevelAttack [[name("Partner Class Level Attack Pointer")]]; // @ 0x840, hd_dll_af7b1f
    ptr partnerLevelDefense [[name("Partner Level Defense Pointer")]]; // @ 0x844, hd_dll_af7b25
    ptr partnerClassLevelElement [[name("Partner Class Level Element Pointer")]]; // @ 0x848, hd_dll_af7b2b
    ptr partnerTeachFees [[name("Partner Teach Fees Pointer")]]; // @ 0x84C, hd_dll_af7b31
    ptr partnerPointRates [[name("Partner Point Rates Pointer")]]; // @ 0x850, hd_dll_af7b37
    ptr partnerWeaponCategoryAttack [[name("Partner Weapon Category Attack Pointer")]]; // @ 0x854, hd_dll_af7b3d
    ptr partnerArmorCategoryDefense [[name("Partner Armor Category Defense Pointer")]]; // @ 0x858, hd_dll_af7b43
    ptr partnerSkillPointCaps [[name("Partner Skill Point Caps Pointer")]]; // @ 0x85C, hd_dll_af7b49
    ptr partnerSkillSlotCounts [[name("Partner Skill Slot Counts Pointer")]]; // @ 0x860, hd_dll_af7b4f
    ptr largeMonsterQuestTabs [[name("Large Monster Quest Tabs Pointer")]]; // @ 0x864, hd_dll_af7b73
    ptr guildCookingRecipes [[name("Guild Cooking Recipes Pointer")]]; // @ 0x868, hd_dll_af7b79
    ptr guildCookingIngredients [[name("Guild Cooking Ingredients Pointer")]]; // @ 0x86C, hd_dll_af7b7f
    ptr legendRastaDailyRotation [[name("Legend Rasta Daily Rotation Pointer")]]; // @ 0x870, hd_dll_af7b85
    ptr secretBookRewardsGR500 [[name("Secret Book GR 500 Rewards Pointer")]]; // @ 0x874, hd_dll_af7b8b
    unk_ptr hd_dll_af7b91;
    ptr guildAdventureDestinations [[name("Guild Adventure Destinations Pointer")]]; // @ 0x87C, hd_dll_af7be3
    ptr guildAdventureRewards [[name("Guild Adventure Rewards Pointer")]]; // @ 0x880, hd_dll_af7c0a
    ptr legendRastaStoryEpisodes [[name("Legend Rasta Story Episodes Pointer")]]; // @ 0x884, hd_dll_af7c10
    ptr Tonfa_Params_pointer [[name("Tonfa Params Pointer")]];
    ptr caravanCpRates [[name("Caravan CP Rates Pointer")]]; // @ 0x88C, hd_dll_af7c9c
    ptr sigilSkillsNoValueAtOne [[name("Sigil Skills Without Value At 1 Pointer")]]; // @ 0x890, hd_dll_af7b5b
    ptr sigilCraftUniqueSkills [[name("Sigil Craft Unique Skills Pointer")]]; // @ 0x894, hd_dll_af7b61
    ptr sigilCraftValueNamedSkills [[name("Sigil Craft Value-Named Skills Pointer")]]; // @ 0x898, hd_dll_af7b67
    ptr guildCookingSkillPools [[name("Guild Cooking Skill Pools Pointer")]]; // @ 0x89C, hd_dll_af7ca2
    ptr rarityChangeAttackCaps [[name("Rarity Change Attack Caps Pointer")]]; // @ 0x8A0, hd_dll_af7cc8
    ptr rarityChangeElementRates [[name("Rarity Change Element Rates Pointer")]]; // @ 0x8A4, hd_dll_af7cce
    ptr rarityChangeStatusRates [[name("Rarity Change Status Rates Pointer")]]; // @ 0x8A8, hd_dll_af7cd4
    ptr rarityChangeAffinityRates [[name("Rarity Change Affinity Rates Pointer")]]; // @ 0x8AC, hd_dll_af7cda
    ptr treasureHuntSpots [[name("Treasure Hunt Spots Pointer")]]; // @ 0x8B0, hd_dll_af7b55
    ptr courseBonusItems [[name("Course Bonus Items Pointer")]]; // @ 0x8B4, hd_dll_af7ce0
    ptr courseBonusItemsRight10 [[name("Course Bonus Items (Rights 8 + 10) Pointer")]]; // @ 0x8B8, hd_dll_af7ce6
    unk_ptr hd_dll_af7cec;
    ptr evadeActions [[name("Evade Actions Pointer")]]; // @ 0x8C0, hd_dll_af7d34
    ptr assistanceTunables [[name("Assistance Tunables Pointer")]]; // @ 0x8C4, hd_dll_af7d67
    ptr companionStagePoints [[name("Companion Stage Points Pointer")]]; // @ 0x8C8, hd_dll_af7e55
    ptr baseCampNpcPoints [[name("Base Camp NPC Points Pointer")]]; // @ 0x8CC, hd_dll_af7e5b
    ptr treasureCorpAreas [[name("Treasure Corp Areas Pointer")]]; // @ 0x8D0, hd_dll_af7e79
    ptr treasureCorpResultChances [[name("Treasure Corp Result Chances Pointer")]]; // @ 0x8D4, hd_dll_af7e7f
    ptr treasureCorpDrawRulesKind2 [[name("Treasure Corp Draw Rules Kind 2 Pointer")]]; // @ 0x8D8, hd_dll_af7e85
    ptr treasureCorpDrawRulesKind01 [[name("Treasure Corp Draw Rules Kind 0 and 1 Pointer")]]; // @ 0x8DC, hd_dll_af7e8b
    ptr treasureCorpListsA [[name("Treasure Corp Lists A Pointer")]]; // @ 0x8E0, hd_dll_af7e91
    ptr treasureCorpListsB [[name("Treasure Corp Lists B Pointer")]]; // @ 0x8E4, hd_dll_af7e97
    ptr treasureCorpListsC [[name("Treasure Corp Lists C Pointer")]]; // @ 0x8E8, hd_dll_af7e9d
    ptr treasureCorpListsD [[name("Treasure Corp Lists D Pointer")]]; // @ 0x8EC, hd_dll_af7ea3
    ptr caravanPartBreakCountRates [[name("Caravan Part Break Count Rates Pointer")]]; // @ 0x8F0, hd_dll_af7d73
    ptr caravanRankingCpRolls [[name("Caravan Ranking CP Rolls Pointer")]]; // @ 0x8F4, hd_dll_af7d6d
    ptr caravanPartBreakCp [[name("Caravan Part Break CP Pointer")]]; // @ 0x8F8
    ptr monsterSoundTables [[name("Monster Sound Tables Pointer")]]; // @ 0x8FC, hd_dll_af530c
    ptr shitenRewards [[name("Shiten Rewards Pointer")]]; // @ 0x900, hd_dll_af8165
    ptr guildWeeklyBonusValues [[name("Guild Weekly Bonus Values Pointer")]]; // @ 0x904, hd_dll_af8171
    ptr catDecoSearchSkillCategories [[name("Cat Decoration Search Skill Categories Pointer")]]; // @ 0x908, hd_dll_af5c6c
    ptr felyneGmShop [[name("Felyne Gm Shop Pointer")]]; // @ 0x90C, hd_dll_af8177
    ptr extraCounters [[name("Extra Counters Pointer"), comment("u16 counts: +0 the Felyne Gm shop (0x90C), +4 the Blue NPC Gm shop (0x924), +8 the Hunting Road skills")]]; // @ 0x910, hd_dll_af469d
    unk_ptr hd_dll_af818f;
    unk_ptr hd_dll_af81cc;
    ptr caravanRankingRoutes [[name("Caravan Ranking Routes Pointer")]]; // @ 0x91C, hd_dll_af821c
    ptr felyneGmShopStockRolls [[name("Felyne Gm Shop Stock Rolls Pointer")]]; // @ 0x920, hd_dll_af8183
    ptr blueNpcGmShop [[name("Blue NPC Gm Shop Pointer")]]; // @ 0x924, hd_dll_af817d
    ptr towerSkills [[name("Tower Skills Pointer")]]; // @ 0x928, hd_dll_af8189
    ptr partnerTonfaCategoryAttack [[name("Partner Tonfa Category Attack Pointer")]]; // @ 0x92C, hd_dll_af816b
    ptr roadSkills [[name("Hunting Road Skills Pointer")]]; // @ 0x930, hd_dll_af82c4
    ptr roadSkillsResultCosts [[name("Road Skills Result Costs Pointer")]]; // @ 0x934, hd_dll_af82ca
    ptr towerJewelRecipes [[name("Tower Jewel Recipes Pointer")]]; // @ 0x938, hd_dll_af82d0
    ptr towerUpgradeCosts [[name("Tower Weapon Upgrade Costs Pointer")]]; // @ 0x93C, hd_dll_af82d6

    // @ 0x940
    ptr weaponTowerForging      [[name("Tower Weapon Forging Pointer")]];

    ptr SigilTowerForging       [[name("Tower Sigil Forging Pointer")]];
    ptr towerMedalShop          [[name("Tower Medal Shop Pointer")]];
    ptr felyne2ModeRoll [[name("Felyne2 Mode Roll Pointer")]]; // @ 0x94C, hd_dll_af832c
    ptr rescuedFelyneMedalCounts [[name("Rescued Felyne Medal Counts Pointer")]]; // @ 0x950, hd_dll_af8332
    ptr combatSupremacyTunables [[name("Combat Supremacy Tunables Pointer")]]; // @ 0x954, hd_dll_af8338
    ptr tonfaTargetHitDamage [[name("Tonfa Target Hit Damage Pointer")]]; // @ 0x958, hd_dll_af833e
    ptr tonfaChainShellRates [[name("Tonfa Chain Shell Hit Rates Pointer")]]; // @ 0x95C, hd_dll_af8344
    ptr tonfaStyle1GaugeGainRates [[name("Tonfa Style 1 Gauge Gain Rates Pointer")]]; // @ 0x960, hd_dll_af834a
    ptr tonfaStyle3GaugeGainRates [[name("Tonfa Style 3 Gauge Gain Rates Pointer")]]; // @ 0x964, hd_dll_af8350
    ptr armorFlag10000ElementRate [[name("Armor Flag 0x10000 Element Rate Pointer")]]; // @ 0x968, hd_dll_af8356
    ptr armorFlag10000StatusRate [[name("Armor Flag 0x10000 Status Rate Pointer")]]; // @ 0x96C, hd_dll_af835c
    ptr armorFlag10000ElementPercent [[name("Armor Flag 0x10000 Element Percent Pointer")]]; // @ 0x970, hd_dll_af8362
    ptr skillSlotId4ElementPercent [[name("Skill Slot Id 4 Element Percent Pointer")]]; // @ 0x974, hd_dll_af8368
    ptr armorFlag10000AttackAdd [[name("Armor Flag 0x10000 Attack Add Pointer")]]; // @ 0x978, hd_dll_af836e
    ptr voiceFaceMotionsMale [[name("Voice Face Motions (Male) Pointer")]]; // @ 0x97C, hd_dll_af8374
    ptr voiceFaceMotionsFemale [[name("Voice Face Motions (Female) Pointer")]]; // @ 0x980, hd_dll_af837a
    unk_ptr hd_dll_af8380;
    ptr skillCounts [[name("Skill Counts Pointer"), comment("u16 counts: +2 the skill effects, +4 the vampirism rows, +0x14 / +0x16 / +0x18 the zenith skills, trees and effects, +0x1A the trap skill combine results")]]; // @ 0x988, hd_dll_af46c9
    ptr nsQuestExcludedMonstersG [[name("Storm Style Trial G Excluded Monsters Pointer")]]; // @ 0x98C, hd_dll_af839f
    ptr transcendDepths [[name("Transcend Depths Pointer")]]; // @ 0x990, hd_dll_af83a5
    ptr transcendQuestGains [[name("Transcend Quest Gains Pointer")]]; // @ 0x994, hd_dll_af83ab

    ptr armorTowerForging       [[name("Tower Armor Forging Pointer")]];

    ptr sigilCraftRecipes [[name("Sigil Craft Recipes Pointer")]]; // @ 0x99C, hd_dll_af83b7
    padding[4];                 // @ 0x9A0
    ptr conquestCrystalRewards [[name("Conquest Crystal Rewards Pointer")]]; // @ 0x9A4, hd_dll_af83bd
    padding[4];
    ptr rightExchanges [[name("Right Exchanges Pointer")]]; // @ 0x9AC, hd_dll_af83c3
    ptr thunderCladPursuitDrawingArts [[name("Thunder Clad, Status Pursuit, Drawing Arts Pointer")]]; // @ 0x9B0
    ptr rastaActiveSkillsByClass [[name("Legend Rasta Active Skills by Class Pointer")]]; // @ 0x9B4, hd_dll_af84a9
    ptr fixedSkillsByClass [[name("Fixed Skills by Class Pointer")]]; // @ 0x9B8, hd_dll_af8536
    ptr rastaActiveSkillsByClassG [[name("Legend Rasta Active Skills by Class (G) Pointer")]]; // @ 0x9BC, hd_dll_af84f4
    ptr fixedSkillsByClassG [[name("Fixed Skills by Class (G) Pointer")]]; // @ 0x9C0, hd_dll_af8581
    padding[4];
    ptr gemCraftRecipes [[name("Gem Craft Recipes Pointer")]]; // @ 0x9C8, hd_dll_af85c4
    u32 gemRegenResultCount [[name("Gem Regeneration Result Count")]]; // @ 0x9CC, a value (not relocated)
    ptr gemRegenResults [[name("Gem Regeneration Results Pointer")]]; // @ 0x9D0, hd_dll_af85ca
    u32 partnerExtraSkillCount [[name("Partner Extra Skill Count")]]; // @ 0x9D4
    ptr partnerExtraSkills [[name("Partner Extra Skills Pointer")]]; // @ 0x9D8, hd_dll_af85d0
    ptr specialSlotChancesBasicHR [[name("Special Basic HR Reward Slot Chances Pointer")]]; // @ 0x9DC, hd_dll_af85d6
    ptr specialSlotChancesSubHR [[name("Special Sub HR Reward Slot Chances Pointer")]]; // @ 0x9E0, hd_dll_af8601
    ptr specialSlotChancesCaptureHR [[name("Special Capture HR Reward Slot Chances Pointer")]]; // @ 0x9E4, hd_dll_af8630
    ptr specialSlotChancesBasicG [[name("Special Basic G Reward Slot Chances Pointer")]]; // @ 0x9E8, hd_dll_af8660
    ptr specialSlotChancesSubG [[name("Special Sub G Reward Slot Chances Pointer")]]; // @ 0x9EC, hd_dll_af8690
    ptr specialSlotChancesCaptureG [[name("Special Capture G Reward Slot Chances Pointer")]]; // @ 0x9F0, hd_dll_af86c0
    unk_ptr hd_dll_af86f0;
    ptr exoticBonusMaterials [[name("GR800 Exotic Bonus Materials Pointer")]]; // @ 0x9F8, hd_dll_af86f6
    ptr evoSeries8 [[name("Evolution Series 8 Pointer")]]; // @ 0x9FC, hd_dll_af86fc
    ptr evoSeries9 [[name("Evolution Series 9 Pointer")]]; // @ 0xA00, hd_dll_af8702
    ptr evoSeries10 [[name("Evolution Series 10 Pointer")]]; // @ 0xA04, hd_dll_af8708
    ptr evoSeries11 [[name("Evolution Series 11 Pointer")]]; // @ 0xA08, hd_dll_af870e
    // evolution weapon levels, 100 each (crafting.hexpat)
    ptr evoUpgradesFlash        [[name("Evolution Upgrade Pointer (Flash)")]];  // @ 0xA0C, hd_dll_af8714
    ptr evoUpgradesShine        [[name("Evolution Upgrade Pointer (Shine)")]];  // @ 0xA10, hd_dll_af871a
    ptr evoUpgradesGlory        [[name("Evolution Upgrade Pointer (Glory)")]];  // hd_dll_af8720
    ptr evoUpgrades             [[name("Evolution Upgrade Pointer (Clear)")]];  // @ 0xA18

    ptr critConversion [[name("Crit Conversion Pointer")]]; // @ 0xA1C, hd_dll_af872c
    padding[4];                 // @ 0xA20
    ptr stageObjectLevel3Chances [[name("Stage Object Level 3 Chances Pointer")]]; // @ 0xA24, hd_dll_af874a
    ptr clanMissionTargets [[name("Clan Mission Targets Pointer")]]; // @ 0xA28, hd_dll_af8750
    ptr clanMissionSlayChances [[name("Clan Mission Slay Chances Pointer")]]; // @ 0xA2C, hd_dll_af875c
    ptr clanMissionTimeWeights [[name("Clan Mission Time Weights Pointer")]]; // @ 0xA30, hd_dll_af8762
    ptr clanMissionRewardWeights [[name("Clan Mission Reward Weights Pointer")]]; // @ 0xA34, hd_dll_af8768
    ptr clanMissionMultiplierWeights [[name("Clan Mission Multiplier Weights Pointer")]]; // @ 0xA38, hd_dll_af876e
    ptr clanHunterGemPointRates [[name("Clan Hunter Gem Point Rates Pointer")]]; // @ 0xA3C, hd_dll_af8756

    // @ 0xA40
    ptr itemSourceStrings       [[name("Item Source Strings Pointer")]];

    ptr bondBonusCosts [[name("Bond Bonus Costs Pointer")]]; // @ 0xA44, hd_dll_af8774
    ptr towerSupportBonuses [[name("Tower Support Bonuses Pointer")]]; // @ 0xA48, hd_dll_af877a
    u32 towerSupportBonusCount [[name("Tower Support Bonus Count")]]; // @ 0xA4C
    ptr towerSupportLevelThresholds [[name("Tower Support Level Thresholds Pointer")]]; // @ 0xA50, hd_dll_af8780
    ptr clanConquestTargetSlayPoints [[name("Clan Conquest Target Slay Points Pointer")]]; // @ 0xA54, hd_dll_af87bb
    ptr clanConquestSupportConditions [[name("Clan Conquest Support Conditions Pointer")]]; // @ 0xA58, hd_dll_af87c1
    ptr clanConquestMonsterLevelPoints [[name("Clan Conquest Monster Level Points Pointer")]]; // @ 0xA5C, hd_dll_af87f2
    ptr playerMonsterMotionBanks [[name("Player Monster Motion Banks Pointer")]]; // @ 0xA60, hd_dll_af87f8
    u32 playerSoundBankCount [[name("Player Sound Bank Count")]]; // @ 0xA64, + 0x12 banks
    unk_ptr hd_dll_af87fe;
    ptr titleUnlocks [[name("Title Unlocks Pointer")]]; // @ 0xA6C, hd_dll_af8804
    ptr bowgunShotTables [[name("Bowgun Shot Tables Pointer")]]; // @ 0xA70, hd_dll_af8819
    u32 halkSkillBookOrderCount [[name("Halk Skill Book Order Count")]]; // @ 0xA74
    ptr halkSkillBookOrder [[name("Halk Skill Book Order Pointer")]]; // @ 0xA78, hd_dll_af8886
    padding[4];
    ptr mapBonusPools [[name("Map Bonus Pools Pointer")]]; // @ 0xA80, hd_dll_af888c
    ptr mapBonusChances [[name("Map Bonus Chances Pointer")]]; // @ 0xA84, hd_dll_af88c7
    ptr switchAxeFTunables [[name("Switch Axe F Tunables Pointer")]]; // @ 0xA88, hd_dll_af88f2
    ptr weaponSkillModifiers [[name("Weapon Skill Modifiers Pointer")]]; // @ 0xA8C
    ptr SwitchAxe_Params        [[name("Switch Axe Params Pointer")]];                 // @ 0xA90
    ptr aiNoCarveQuests [[name("AI No Carve Quests Pointer")]]; // @ 0xA94, hd_dll_af8cac

    ptr questList               [[name("Quest List Struct Pointer")]];

    ptr experienceQuests [[name("Experience Quests Pointer")]]; // @ 0xA9C, hd_dll_af8cf8
    ptr obscurity [[name("Obscurity Pointer")]]; // @ 0xAA0, hd_dll_af8cfe
    ptr skillBonusValues [[name("Skill Bonus Values Pointer")]]; // @ 0xAA4, hd_dll_af8d0f
    ptr zenithSkills [[name("Zenith Skills Pointer")]]; // @ 0xAA8, hd_dll_af8d1d
    ptr zenithTreeSkills [[name("Zenith Tree Skills Pointer")]]; // @ 0xAAC, hd_dll_af8d23
    ptr zenithSkillEffects [[name("Zenith Skill Effects Pointer")]]; // @ 0xAB0, hd_dll_af8d29
    ptr zenithQuestMonsters [[name("Zenith Quest Monsters Pointer")]]; // @ 0xAB4, hd_dll_af8d2f

    ptr transmogForging         [[name("Armor Transmog Forging Pointer")]];

    ptr transmogForging2        [[name("Second Armor Transmog Forging Pointer")]];

    // @ 0xAC0
    ptr zenithWeaponForging     [[name("Zenith Weapon Forging Pointer")]];
    ptr armorZenithForging     [[name("Zenith Armor Forging")]];

    ptr monsterCarvePointsZenith [[name("Zenith Monster Carve Points Pointer")]]; // @ 0xAC8, hd_dll_af8d66
    ptr captureBreakRewardsZenith [[name("Zenith Capture and Break Rewards Pointer")]]; // @ 0xACC, hd_dll_af8dc1
    ptr monsterCarvePointsSmallParty [[name("Berserk Raviente Small Party Carve Points Pointer")]]; // @ 0xAD0, hd_dll_af8dc7
    ptr monsterStartActions [[name("Monster Start Actions Pointer")]]; // @ 0xAD4, hd_dll_af8d60
    ptr equipModelEffectRows [[name("Equip Model Effect Rows Pointer")]]; // @ 0xAD8, hd_dll_af7da4
    ptr equipModelEffectLists [[name("Equip Model Effect Lists Pointer")]]; // @ 0xADC, hd_dll_af7daa
    ptr forgeRankWeaponLists [[name("Forge Rank Weapon Lists Pointer")]]; // @ 0xAE0, hd_dll_af8e16
    ptr forgeRankArmorLists [[name("Forge Rank Armor Lists Pointer")]]; // @ 0xAE4, hd_dll_af8e5e
    ptr sigilCountedSkills [[name("Sigil Counted Skills Pointer")]]; // @ 0xAE8, hd_dll_af7b6d
    ptr combineSoulRecipes [[name("Combine Soul Recipes Pointer")]]; // @ 0xAEC, hd_dll_af59b3
    ptr quizQuestHeader [[name("Quiz Quest Header Pointer")]]; // @ 0xAF0, hd_dll_af46e9
    ptr quizQuestSpawnsA [[name("Quiz Quest Spawns A Pointer")]]; // @ 0xAF4, hd_dll_af8eae
    ptr quizQuestSpawnsB [[name("Quiz Quest Spawns B Pointer")]]; // @ 0xAF8, hd_dll_af8eb4
    ptr quizQuestQuestions [[name("Quiz Quest Questions Pointer")]]; // @ 0xAFC, hd_dll_af8eba
    ptr quizQuestTimeLimits [[name("Quiz Quest Time Limits Pointer")]]; // @ 0xB00, hd_dll_af8f01
    ptr dataCounters [[name("Data Counters Pointer"), comment("u16 counts: +4 the Road cat shop, +6 the Road rank curve (u32 count), +8 the Road monster points")]]; // @ 0xB04, hd_dll_af4709
    unk_ptr hd_dll_af8f07;
    ptr roadMonsterScales [[name("Road Monster Scales Pointer")]]; // @ 0xB0C, hd_dll_af8f0d
    ptr Road_Cat_Item_Shop_Pointer [[name("Road Cat Item Shop Pointer")]];      // @ 0xB10
    ptr roadRankCurve [[name("Road Rank Curve Pointer")]]; // @ 0xB14, hd_dll_af8f19
    ptr interceptionMonsterCount [[name("Interception Monster Count Pointer")]]; // @ 0xB18, hd_dll_af4729
    ptr interceptionMonsterStars [[name("Interception Monster G Stars Pointer")]]; // @ 0xB1C, hd_dll_af8f1f
    ptr Road_Monster_Point_Value_Pointer [[name("Road Monster Point Value Pointer")]];      // @ 0xB20
    ptr roadZenithMonsterScale [[name("Road Zenith Monster Scale Pointer")]]; // @ 0xB24, hd_dll_af8f2b
    ptr roadSuspendedCameras [[name("Road Suspended Cameras Pointer")]]; // @ 0xB28, hd_dll_af8f31

    ptr specialShops            [[name("Special Shops Pointer")]];

    ptr conquestQuests [[name("Conquest Quests Pointer")]]; // @ 0xB30, hd_dll_af4749
    ptr shitenQuests [[name("Shiten Quests Pointer")]]; // @ 0xB34, hd_dll_af4772
    ptr koryoLotteryPrizes [[name("Koryo Lottery Prizes Pointer")]]; // @ 0xB38, hd_dll_af8f80
    ptr koryoPortaExchangeItems [[name("Koryo Porta Card Exchange Items Pointer")]]; // @ 0xB3C, hd_dll_af8fca
    ptr koryoMonsterPoints [[name("Koryo Monster Points Pointer")]]; // @ 0xB40, hd_dll_af8fd0
    unk_ptr hd_dll_af8fd6;
    ptr GrankDecoShop          [[name("Grank Deco Shop Pointer")]];
    ptr pointBreakthroughTunables [[name("Point Breakthrough Tunables Pointer")]]; // @ 0xB4C, hd_dll_af8fdc
    ptr dailyRotationQuests0 [[name("Daily Rotation Quests 0 Pointer")]]; // @ 0xB50, hd_dll_af8ff6
    ptr dailyRotationQuests1 [[name("Daily Rotation Quests 1 Pointer")]]; // @ 0xB54, hd_dll_af903a
    ptr dailyRotationQuests2 [[name("Daily Rotation Quests 2 Pointer")]]; // @ 0xB58, hd_dll_af9088
    ptr talkCameraCounts [[name("Talk Camera Counts Pointer")]]; // @ 0xB5C, hd_dll_af4794
    ptr talkCameraIndex [[name("Talk Camera Index Pointer")]]; // @ 0xB60, hd_dll_af90cc
    ptr talkCamerasFixed [[name("Talk Cameras Fixed Pointer")]]; // @ 0xB64, hd_dll_af90d2
    ptr talkCamerasOrbit [[name("Talk Cameras Orbit Pointer")]]; // @ 0xB68, hd_dll_af90d8
    ptr talkCamerasSide [[name("Talk Cameras Side Pointer")]]; // @ 0xB6C, hd_dll_af90de
    ptr caravanMonsterPrices [[name("Caravan Monster Prices Pointer")]]; // @ 0xB70, hd_dll_af90e4
    ptr stampCardRewards [[name("Stamp Card Rewards Pointer")]]; // @ 0xB74, hd_dll_af90ea
    ptr obscurityUp [[name("Obscurity UP Pointer")]]; // @ 0xB78, hd_dll_af90f0
    ptr soloRoadMonsterScales [[name("Solo Road Monster Scales Pointer")]]; // @ 0xB7C, hd_dll_af8f37
    ptr soloRoadZenithMonsterScale [[name("Solo Road Zenith Monster Scale Pointer")]]; // @ 0xB80, hd_dll_af8f3d
    ptr combineHidenRecipes [[name("Combine Hiden Recipes Pointer")]]; // @ 0xB84, hd_dll_af59b9
    ptr spacingAndSoulValues [[name("Spacing And Soul Values Pointer")]]; // @ 0xB88, hd_dll_af9107
    ptr guildMsgBoardIconAnims [[name("Guild Message Board Icon Animations Pointer"), comment("Post icon idle animations + board update poll delays (clan.hexpat)")]]; // @ 0xB8C, hd_dll_af91ba
    ptr magnetSpikeTunables [[name("Magnet Spike Tunables Pointer")]]; // @ 0xB90, hd_dll_af91e4
    ptr skillCells [[name("Skill Cells Pointer"), comment("+4: the Rush UP stage 3 block")]]; // @ 0xB94, hd_dll_af9323
    ptr Magnetspike_params_pointer [[name("Magnetspike Params Pointer")]];
    ptr sigilCraftMaterialsZenith [[name("Sigil Craft Materials Zenith Pointer")]]; // @ 0xB9C, hd_dll_af93fc
    ptr sigilCraftRecipeMaterialCategories [[name("Sigil Craft Recipe Material Categories Pointer")]]; // @ 0xBA0, hd_dll_af9402
    ptr zenithSigilStampChance [[name("Zenith Sigil Stamp Chances Pointer")]]; // @ 0xBA4, hd_dll_af9450
    ptr zenithRangedSigils [[name("Zenith and Ranged Sigils Pointer")]]; // @ 0xBA8, hd_dll_af9408
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