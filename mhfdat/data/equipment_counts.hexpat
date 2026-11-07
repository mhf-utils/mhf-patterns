#pragma once

#include <misc/types.pat>

// The block header 0x10 points to: the counts of tables that have no end marker
struct ImportantNumbers {
    padding[0x8];

    // Offset 0x8: items (header 0xFC, 0x100); FUN_104E8A20 / Deco_item_check refuse an item id >= it
    u16 numItems
        [[name("Number of Items")]];

    // Offset 0xA: decoration id rows (header 0xF8, 0x14 bytes); FUN_104E8A20 refuses an item's deco row >= it
    u16 numDecoIds
        [[name("Number of Decoration Id Rows")]];

    // Offset 0xC: combine pair records (header 0x104, 8 bytes), FUN_105E3030
    u16 numCombinePairRecords
        [[name("Number of Combine Pair Records")]];

    // Offset 0xE: combine triple records (header 0x10C, 8 bytes), FUN_105E3030
    u16 numCombineTripleRecords
        [[name("Number of Combine Triple Records")]];

    padding[0xA];

    // Offset 0x1A: ranged weapons with rapid fire (header 0xC0)
    u16 numRapidFireWeapons
        [[name("Number of Rapid Fire Weapons")]];

    // Offset 0x1C - [mhfo-hd.dll + 0xaf4e70]
    u16 numCarveDTs
        [[name("Number of Carve Drop Tables")]];

    // Offset 0x1E - [mhfo-hd.dll + 0xaf4e98]
    u16 numPartBreakDTs
        [[name("Number of Part Break Drop Tables")]];

    padding[0x2];

    // Offset 0x22: monster crowns (header 0x130) and descriptions (header 0x134)
    u16 numMonsterDesc
        [[name("Number of monster's dsecriptions")]];

    padding[0x2];

    // Offset 0x26: Hunting Horn melody book pages (header 0x180, 0x184)
    u16 numHuntingHornSongPages
        [[name("Number of Hunting Horn Song Pages")]];

    u16 numAncientHuntingHornScorePages
        [[name("Number of Ancient Hunting Horn Score Pages")]];

    // Offset 0x2A: Hunting Info item table pointers (header 0x194), relocated by rd_mhfdat
    u16 numHuntingInfoAreaTables
        [[name("Number of Hunting Info Area Tables")]];

    // Offset 0x2C: Hunter Dojo rule pages (header 0x1A8 online, 0x1AC offline)
    u16 numDojoRulePagesOnline
        [[name("Number of Dojo Rule Pages (Online)")]];

    u16 numDojoRulePagesOffline
        [[name("Number of Dojo Rule Pages (Offline)")]];

    // Offset 0x30: Hunter Basics pages (header 0x1A4)
    u16 numHunterBasicsPages
        [[name("Number of Hunter Basics Pages")]];

    padding[0x4];

    // Offset 0x36: Hunter Guide volumes (header 0x1A0)
    u16 numHunterGuideVolumes
        [[name("Number of Hunter Guide Volumes")]];

    // Offset 0x38: Instructor tutorial (header 0x1B0, 0x1B4)
    u16 numTutorialLessons
        [[name("Number of Tutorial Lessons")]];

    u16 numTutorialLessonGroups
        [[name("Number of Tutorial Lesson Groups")]];

    // Offset 0x3C: beginner quest ids (header 0x1B8)
    u16 numBeginnerQuests
        [[name("Number of Beginner Quests")]];

    padding[0x2];

    // Offset 0x40: Arena item lists, courses, course quest pairs (header 0x144, 0x148, 0x14C)
    u16 numArenaItemSets
        [[name("Number of Arena Item Lists")]];

    u16 numArenaCourses
        [[name("Number of Arena Courses")]];

    u16 numArenaCourseQuests
        [[name("Number of Arena Course Quest Pairs")]];

    // Offset 0x46: tutorial item lists (header 0x158)
    u16 numTutorialItemSets
        [[name("Number of Tutorial Item Lists")]];

    // Offset 0x48: pointers to tutorial equipment sets (header 0x15C)
    u16 numTutorialEquipSets
        [[name("Number of Tutorial Equipment Sets")]];

    // Offset 0x4A: Public Bar recruit HR Reqs / Messages / Targets (header 0x168, 0x1BC, 0x1C0)
    u16 numPublicBarMessages
        [[name("Number of Public Bar Messages")]];

    u16 numPublicBarTargets
        [[name("Number of Public Bar Targets")]];

    u16 numPublicBarHrReqs
        [[name("Number of Public Bar HR Reqs (the default row after them is not counted)")]];

    // Offset 0x50: garden Meowka Pot recipes (header 0x200)
    u16 numMeowkaPotRecipes
        [[name("Number of Meowka Pot Recipes")]];

    // Offset 0x52: farm cat fail items by HR tier (header 0x204, 0x208, 0x20C,
    // 0x210); u16 values, 2 per row
    u16 numFarmCatFailItemsHr1Values
        [[name("Number of u16 Values in Farm Cat Fail Items HR 1")]];

    u16 numFarmCatFailItemsHr2Values
        [[name("Number of u16 Values in Farm Cat Fail Items HR 2-30")]];

    u16 numFarmCatFailItemsHr31Values
        [[name("Number of u16 Values in Farm Cat Fail Items HR 31-50")]];

    u16 numFarmCatFailItemsHr51Values
        [[name("Number of u16 Values in Farm Cat Fail Items HR 51-99")]];

    // Offset 0x5A: lost item reward tiers (header 0x214)
    u16 numLostItemRewardTiers
        [[name("Number of Lost Item Reward Tiers")]];

    // Offset 0x5C: help cat items (header 0x218)
    u16 numHelpCatItems
        [[name("Number of Help Cat Items")]];

    // Offset 0x5E: Caravan gem skill lists, one per tier (header 0xF4) [mhfo-hd.dll + 0xaf4d91]
    u16 numHunterPearlSkillLists
        [[name("Number of Hunter Pearl Skill Lists")]];

    // Offset 0x60: Caravan tier levels (9: levels 0-8); FUN_104996F0 lists the upgrade rows of header 0x234 while row < this - 1
    u16 numCaravanTierLevels
        [[name("Number of Caravan Tier Levels")]];

    // Offset 0x62: My House renovation themes (header 0x260)
    u16 numMyHouseThemes
        [[name("Number of My House Themes")]];

    padding[0x4];

    // Offset 0x68: zenny combine recipes (header 0x26C)
    u16 numCombineZennyRecipes
        [[name("Number of Combine Zenny Recipes")]];

    // Offset 0x6A: point combine daily lineups (header 0x270)
    u16 numCombinePointDailyLineups
        [[name("Number of Combine Point Daily Lineups")]];

    // Offset 0x6C: CP combine daily lineups (header 0x274)
    u16 numCombineCpDailyLineups
        [[name("Number of Combine CP Daily Lineups")]];

    // Offset 0x6E: point combine timed bonuses (header 0x278)
    u16 numCombinePointTimedBonuses
        [[name("Number of Combine Point Timed Bonuses")]];

    // Offset 0x70: CP combine timed bonuses (header 0x27C)
    u16 numCombineCpTimedBonuses
        [[name("Number of Combine CP Timed Bonuses")]];

    padding[0x4];

    // Offset 0x76: quest search target monsters (header 0x288), a count of u16 (rows x 2)
    u16 numQuestSearchMonsterValues
        [[name("Number of Quest Search Monster u16 Values")]];

    // Offset 0x78: quest search fields (header 0x28C normal counter, 0x290 G rank counter)
    u16 numQuestSearchFields
        [[name("Number of Quest Search Fields")]];

    u16 numQuestSearchFieldsG
        [[name("Number of Quest Search Fields (G Rank Counter)")]];

    padding[0x26];

    // Offset 0xA2: Instructor challenge pick lists and reward lists (header 0x2A8, 0x2AC), relocated by the loader
    u16 numInstructorChallengePicks
        [[name("Number of Instructor Challenge Pick Lists")]];

    u16 numInstructorChallengeRewards
        [[name("Number of Instructor Challenge Reward Lists")]];

    padding[0x8];

    // Offset 0xAE: cuff crafting rows incl. the zero end row (header 0x2C0, cuff_crafting_get_recipe_by_index)
    u16 numCuffRecipes
        [[name("Number of Cuff Recipes")]];

    padding[0x2];

    // Offset 0xB2: Pioneer quest lists (header 0x2C8 pointers, 4 maps x 6 levels), relocated by rd_mhfdat
    u16 numPioneerQuestLists
        [[name("Number of Pioneer Quest Lists")]];

    // Offset 0xB4: evolution weapon series (header 0x2CC melee, 0x2D0 ranged)
    u16 numEvoMeleeWeapons
        [[name("Number of Evolution Melee Weapons")]];

    u16 numEvoRangedWeapons
        [[name("Number of Evolution Ranged Weapons")]];

    padding[0x8];

    // Offset 0xC0: Pioneer base cost maps (header 0x2E4 pointers), relocated by rd_mhfdat
    u16 numPioneerBaseCostMaps
        [[name("Number of Pioneer Base Cost Maps")]];

    padding[0x2];

    // Offset 0xC4: Pioneer quest bonus rewards (header 0x2F0)
    u16 numPioneerQuestBonusRewards
        [[name("Number of Pioneer Quest Bonus Rewards")]];

    // Offset 0xC6: rows of header 0x2F4 (0x16 bytes); setupMHFIconControlContainer uses row 0 for an id >= it
    u16 num2F4Rows
        [[name("Number of Header 0x2F4 Rows")]];

    // Offset 0xC8: rows of header 0x2F8 (0xC bytes); translateMHFIconSubFunctionManualIconIndex returns no row for an index >= it
    u16 num2F8Rows
        [[name("Number of Header 0x2F8 Rows")]];

    padding[0xE];

    // Offset 0xD8: Secret Book effect lists (header 0x318), 18 tiers x 14 weapon classes
    u16 numSecretBookEffectLists
        [[name("Number of Secret Book Effect Lists")]];

    // Offset 0xDA: inner body models (header 0x31C)
    u16 numInners
        [[name("Number of Inners")]];

    // Offset 0xDC: Partner faces (header 0x320)
    u16 numPartnerFaces
        [[name("Number of Partner Faces")]];

    padding[0xC];

    // Offset 0xEA: items monsters cannot steal and daily missions skip (header 0x33C)
    u16 numProtectedItems
        [[name("Number of Protected Items")]];

    // Offset 0xEC: item box search filters (header 0x34C-0x358)
    u16 numBoxSearchIcons
        [[name("Number of Box Search Icons")]];

    u16 numBoxSearchDecorations
        [[name("Number of Box Search Decorations")]];

    u16 numBoxSearchSkillTrees
        [[name("Number of Box Search Skill Trees")]];

    u16 numBoxSearchZenithSkills
        [[name("Number of Box Search Zenith Skills")]];

    // Offset 0xF4: Legend Rasta loadouts (header 0x35C, 0x70 bytes); legend_rasta_loadout_index_get / FUN_1044E8A0 loop over them
    u16 numLegendRastaLoadouts
        [[name("Number of Legend Rasta Loadouts")]];

    // Offset 0xF6: Legend Rasta groups (header 0x360)
    u16 numLegendRastaGroups
        [[name("Number of Legend Rasta Groups")]];

    // Offset 0xF8: name display sizes (header 0x364)
    u16 numNameDisplaySizes
        [[name("Number of Name Display Sizes")]];

    // Offset 0xFA: random (ex G) weapons (header 0x36C)
    u16 numExGWeapons
        [[name("Number of Random (ex G) Weapons")]];

    padding[0xE];

    // Offset 0x10A: ex G base tier roll overrides (header 0x38C)
    u16 numExGBaseTierRollOverrides
        [[name("Number of Ex G Base Tier Roll Overrides")]];

    // Offset 0x10C: 30k Cheque HR chances (header 0x390)
    u16 numChequeHrChances
        [[name("Number of 30k Cheque HR Chances")]];

    // Offset 0x10E: N course bonus item chances (header 0x394)
    u16 numNBonusItemChances
        [[name("Number of N Bonus Item Chances")]];

    // Offset 0x110: N course bonus items (header 0x398)
    u16 numNBonusItems
        [[name("Number of N Bonus Items")]];

    // Offset 0x112: G quest party size rates (header 0x39C)
    u16 numGQuestPartySizeRates
        [[name("Number of G Quest Party Size Rates")]];

    padding[0xE];

    // Offset 0x122: G armor skill up conditions (header 0x3BC)
    u16 numGousyuSkillUpConditions
        [[name("Number of Gousyu Skill Up Conditions")]];

    padding[0x2];

    // Offset 0x126: Goocoo accessories by slot (header 0x3C4 to 0x3FC)
    u16 numGoocooHats
        [[name("Number of Goocoo Hats")]];

    u16 numGoocooClothes
        [[name("Number of Goocoo Clothes")]];

    u16 numGoocooMasks
        [[name("Number of Goocoo Masks")]];

    u16 numGoocooBags
        [[name("Number of Goocoo Bags")]];

    u16 numGoocooTails
        [[name("Number of Goocoo Tail Accessories")]];

    // Offset 0x130: Goocoo accessory names and descriptions, clothing series names (header 0x3D8 to 0x400),
    // one count per list in header order; rd_mhfdat relocates that many string pointers per list
    u16 numGoocooHatNames
        [[name("Number of Goocoo Hat Names")]];

    u16 numGoocooClothesNames
        [[name("Number of Goocoo Clothes Names")]];

    u16 numGoocooMaskNames
        [[name("Number of Goocoo Mask Names")]];

    u16 numGoocooBagNames
        [[name("Number of Goocoo Bag Names")]];

    u16 numGoocooTailNames
        [[name("Number of Goocoo Tail Accessory Names")]];

    u16 numGoocooHatDescs
        [[name("Number of Goocoo Hat Descriptions")]];

    u16 numGoocooClothesDescs
        [[name("Number of Goocoo Clothes Descriptions")]];

    u16 numGoocooMaskDescs
        [[name("Number of Goocoo Mask Descriptions")]];

    u16 numGoocooBagDescs
        [[name("Number of Goocoo Bag Descriptions")]];

    u16 numGoocooTailDescs
        [[name("Number of Goocoo Tail Accessory Descriptions")]];

    u16 numGoocooClothingSeriesNames
        [[name("Number of Goocoo Clothing Series Names")]];

    // Offset 0x146: Goocoo tables (header 0x404 to 0x4C0), one count per table in header order
    u16 numGoocooFoods
        [[name("Number of Goocoo Foods")]];

    u16 numGoocooFoodTexts
        [[name("Number of Goocoo Food Texts")]];

    u16 numGoocooSitItems
        [[name("Number of Goocoo House-Sitting Items")]];

    u16 numGoocooSitGradeChances
        [[name("Number of Goocoo House-Sitting Grade Chances")]];

    u16 numGoocooSitCounts
        [[name("Number of Goocoo House-Sitting Counts")]];

    u16 numGoocooSitPersonalityMods
        [[name("Number of Goocoo House-Sitting Personality Modifiers")]];

    u16 numGoocooSitMoodMods
        [[name("Number of Goocoo House-Sitting Mood Modifiers")]];

    u16 numGoocooSitFishRarity
        [[name("Number of Goocoo House-Sitting Fish Rarity Rows")]];

    u16 numGoocooSitBugsRarity
        [[name("Number of Goocoo House-Sitting Bugs Rarity Rows")]];

    u16 numGoocooSitJunkRarity
        [[name("Number of Goocoo House-Sitting Junk Rarity Rows")]];

    u16 numGoocooSitBargainsRarity
        [[name("Number of Goocoo House-Sitting Bargains Rarity Rows")]];

    u16 numGoocooSitGrades
        [[name("Number of Goocoo House-Sitting Grades")]];

    u16 numGoocooSitMoodItems
        [[name("Number of Goocoo House-Sitting Mood Items")]];

    // Offset 0x160: Goocoo egg care rows (header 0x438)
    u16 numGoocooEggCare
        [[name("Number of Goocoo Egg Care Rows")]];

    u16 numGoocooPersonalities
        [[name("Number of Goocoo Personalities")]];

    u16 numGoocooCareActions
        [[name("Number of Goocoo Care Actions")]];

    u16 numGoocooCareStyles
        [[name("Number of Goocoo Care Styles")]];

    u16 numGoocooPersonalityNames
        [[name("Number of Goocoo Personality Names")]];

    u16 numGoocooRemodelBeds
        [[name("Number of Goocoo Remodel Beds")]];

    u16 numGoocooRemodelPools
        [[name("Number of Goocoo Remodel Pools")]];

    u16 numGoocooRemodelGrounds
        [[name("Number of Goocoo Remodel Grounds")]];

    u16 numGoocooBedNames
        [[name("Number of Goocoo Bed Names")]];

    u16 numGoocooPoolNames
        [[name("Number of Goocoo Pool Names")]];

    u16 numGoocooGroundNames
        [[name("Number of Goocoo Ground Names")]];

    u16 numGoocooBedTexts
        [[name("Number of Goocoo Bed Texts")]];

    u16 numGoocooPoolTexts
        [[name("Number of Goocoo Pool Texts")]];

    u16 numGoocooGroundTexts
        [[name("Number of Goocoo Ground Texts")]];

    u16 numGoocooSeriesNames
        [[name("Number of Goocoo Series Names")]];

    // Offset 0x17E: Goocoo quest lists (header 0x474)
    u16 numGoocooQuestLists
        [[name("Number of Goocoo Quest Lists")]];

    u16 numGoocooTrustParams
        [[name("Number of Goocoo Trust Parameters")]];

    u16 numGoocooTrustDecay
        [[name("Number of Goocoo Trust Decay Steps")]];

    // Offset 0x184: Goocoo new skin lots (header 0x480)
    u16 numGoocooNewSkinLots
        [[name("Number of Goocoo New Skin Lot Rows")]];

    // Offset 0x186: Goocoo skin classes (header 0x484)
    u16 numGoocooSkinClasses
        [[name("Number of Goocoo Skins")]];

    // Offset 0x188: Goocoo egg class lots (header 0x48C)
    u16 numGoocooEggClassLots
        [[name("Number of Goocoo Egg Class Lot Rows")]];

    // Offset 0x18A: Goocoo egg skin source lots (header 0x490)
    u16 numGoocooEggSkinSourceLots
        [[name("Number of Goocoo Egg Skin Source Lot Rows")]];

    u16 numGoocooExchanges
        [[name("Number of Goocoo Exchanges")]];

    u16 numGoocooClothesCosts
        [[name("Number of Goocoo Clothes Costs")]];

    u16 numGoocooRemodelCosts
        [[name("Number of Goocoo Remodel Costs")]];

    // Offset 0x192: Goocoo group spot lists (header 0x4A0)
    u16 numGoocooGroupSpotLists
        [[name("Number of Goocoo Group Spot Lists")]];

    // Offset 0x194: Goocoo talk items (header 0x4A4)
    u16 numGoocooTalkItems
        [[name("Number of Goocoo Talk Items")]];

    // Offset 0x196: Goocoo talk drop items (header 0x4A8)
    u16 numGoocooTalkDropItems
        [[name("Number of Goocoo Talk Drop Items")]];

    // Offset 0x198: Goocoo talk item thresholds (header 0x4AC)
    u16 numGoocooTalkItemThresholds
        [[name("Number of Goocoo Talk Item Thresholds")]];

    // Offset 0x19A: Goocoo emote delays by mood (header 0x4B4)
    u16 numGoocooEmoteDelays
        [[name("Number of Goocoo Emote Delay Rows")]];

    u16 numGoocooPotMaterials
        [[name("Number of Goocoo Pot Materials")]];

    // Offset 0x19E: stray Goocoo Mezeporta mesh codes (header 0x4CC)
    u16 numStrayGoocooLobbyMeshes
        [[name("Number of Stray Goocoo Lobby Meshes")]];

    // Offset 0x1A0: Goocoo farm timer values (header 0x4C4), u32
    u16 numGoocooFarmTimerValues
        [[name("Number of Goocoo Farm Timer Values")]];

    // Offset 0x1A2: stray Goocoo My House actions (header 0x4D4)
    u16 numStrayGoocooMyHouseActions
        [[name("Number of Stray Goocoo My House Actions")]];

    // Offset 0x1A4: stray Goocoo Workshop actions 0 (header 0x4D8)
    u16 numStrayGoocooWorkshopActions0
        [[name("Number of Stray Goocoo Workshop Actions 0")]];

    // Offset 0x1A6: stray Goocoo Workshop actions 1 (header 0x4DC)
    u16 numStrayGoocooWorkshopActions1
        [[name("Number of Stray Goocoo Workshop Actions 1")]];

    // Offset 0x1A8: stray Goocoo MyHawk layouts (header 0x4E0)
    u16 numStrayGoocooMyHawkLayouts
        [[name("Number of Stray Goocoo MyHawk Layouts")]];

    // Offset 0x1AA: extra stages (header 0x4E4)
    u16 numExtraStages
        [[name("Number of Extra Stages")]];

    padding[0x10];

    // Offset 0x1BC: ex G base tier roll overrides, Gunlance (header 0x508)
    u16 numExGBaseTierRollOverridesGunlance
        [[name("Number of Ex G Base Tier Roll Overrides: Gunlance")]];

    // Offset 0x1BE: entity motion sounds by entity kind (header 0x50C)
    u16 numEntityMotionSounds
        [[name("Number of Entity Motion Sound Rows")]];

    // Offset 0x1C0: Halk foods (header 0x510)
    u16 numHalkFoods
        [[name("Number of Halk Foods")]];

    padding[0x4];

    // Offset 0x1C6: evolution gun extra ammo (header 0x520)
    u16 numEvolutionGunAmmo
        [[name("Number of Evolution Gun Extra Ammo Rows")]];

    padding[0x4];

    // Offset 0x1CC: My House armor display classes (header 0x52C pointers), relocated by rd_mhfdat
    u16 numMyHouseArmorDisplays
        [[name("Number of My House Armor Displays")]];

    padding[0x6];

    // Offset 0x1D4: monster hitzone effect scales (header 0x53C)
    u16 numMonsterHitzoneEffectScales
        [[name("Number of Monster Hitzone Effect Scales")]];

    padding[0x2];

    // Offset 0x1D8: sound distance curves 2 (header 0x544, se_req_3D)
    u16 numSoundCurves2
        [[name("Number of Sound Curves 2")]];

    // Offset 0x1DA: seasonal event timings (header 0x54C)
    u16 numSeasonalEvents
        [[name("Number of Seasonal Events")]];

    // Offset 0x1DC: evolution bowgun bomb rates (header 0x554)
    u16 numEvoBowgunBombRates
        [[name("Number of Evolution Bowgun Bomb Rates")]];

    padding[0xA];

    // Offset 0x1E8: NPC hunters (header 0x56C)
    u16 numNpcHunters
        [[name("Number of NPC Hunters")]];

    // Offset 0x1EA: NPC hunter weapons (header 0x570)
    u16 numNpcHunterWeapons
        [[name("Number of NPC Hunter Weapons")]];

    // Offset 0x1EC: NPC hunter armor sets (header 0x574)
    u16 numNpcHunterArmorSets
        [[name("Number of NPC Hunter Armor Sets")]];

    padding[0x2];

    // Offset 0x1F0: bow model material rows (header 0x580)
    u16 numBowModelMaterialRows
        [[name("Number of Bow Model Material Rows")]];

    // Offset 0x1F2: Guild Priority Request entries and rotations (header 0x584, 0x588)
    u16 numPriorityRequestEntries
        [[name("Number of Guild Priority Request Entries")]];

    u16 numPriorityRequestRotations
        [[name("Number of Guild Priority Request Rotations")]];

    padding[0x18];

    // Offset 0x20E: monster alternate sound tables (header 0x5C0)
    u16 numMonsterAltSoundTables
        [[name("Number of Monster Alternate Sound Tables")]];

    // Offset 0x210: Tower / G50 level lists of header 0x5C4 (towerG50SwordAndShieldParams), relocated by rd_mhfdat
    u16 numTowerG50SwordAndShieldParams
        [[name("Number of towerG50SwordAndShieldParams")]];

    // Offset 0x212: Tower / G50 level lists of header 0x5C8 (towerG50DualBladesParams), relocated by rd_mhfdat
    u16 numTowerG50DualBladesParams
        [[name("Number of towerG50DualBladesParams")]];

    // Offset 0x214: Tower / G50 level lists of header 0x5CC (towerG50GreatSwordParams), relocated by rd_mhfdat
    u16 numTowerG50GreatSwordParams
        [[name("Number of towerG50GreatSwordParams")]];

    // Offset 0x216: Tower / G50 level lists of header 0x5D0 (towerG50LongSwordParams), relocated by rd_mhfdat
    u16 numTowerG50LongSwordParams
        [[name("Number of towerG50LongSwordParams")]];

    // Offset 0x218: Tower / G50 level lists of header 0x5D4 (towerG50LanceParams), relocated by rd_mhfdat
    u16 numTowerG50LanceParams
        [[name("Number of towerG50LanceParams")]];

    // Offset 0x21A: Tower / G50 level lists of header 0x5D8 (towerG50GunlanceParams), relocated by rd_mhfdat
    u16 numTowerG50GunlanceParams
        [[name("Number of towerG50GunlanceParams")]];

    // Offset 0x21C: Tower / G50 level lists of header 0x5DC (towerG50HammerParams), relocated by rd_mhfdat
    u16 numTowerG50HammerParams
        [[name("Number of towerG50HammerParams")]];

    // Offset 0x21E: Tower / G50 level lists of header 0x5E0 (towerG50HuntingHornParams), relocated by rd_mhfdat
    u16 numTowerG50HuntingHornParams
        [[name("Number of towerG50HuntingHornParams")]];

    // Offset 0x220: Tower / G50 level lists of header 0x5E4 (towerG50HeavyBowgunParams), relocated by rd_mhfdat
    u16 numTowerG50HeavyBowgunParams
        [[name("Number of towerG50HeavyBowgunParams")]];

    // Offset 0x222: Tower / G50 level lists of header 0x5E8 (towerG50LightBowgunParams), relocated by rd_mhfdat
    u16 numTowerG50LightBowgunParams
        [[name("Number of towerG50LightBowgunParams")]];

    // Offset 0x224: Tower / G50 level lists of header 0x5EC (towerG50BowParams), relocated by rd_mhfdat
    u16 numTowerG50BowParams
        [[name("Number of towerG50BowParams")]];

    padding[0x4];

    u16 g50MeleeWeaponUpgradesCounter
        [[name("g50 melee weapons upgrades counter")]];

    u16 g50RangedWeaponUpgradesCounter
        [[name("g50 ranged weapon updrades counter")]];

    padding[0xA];

    // Offset 0x238: random sigil recipes (header 0x620, FUN_105625F0) and their
    // skill blacklists (header 0x628, relocated by the loader)
    u16 numSigilCraftingRecipes
        [[name("Number of Sigil Crafting Recipes")]];

    padding[2];

    u16 numSigilSkillBlacklists
        [[name("Number of Sigil Skill Blacklists")]];

    padding[2];

    // Offset 0x240: sigil class / icon thresholds (header 0x630, 0x638)
    u16 numSigilClassThresholds
        [[name("Number of Sigil Class Thresholds")]];

    // Offset 0x242: sigil craft material catalog (header 0x634)
    u16 numSigilCraftMaterials
        [[name("Number of Sigil Craft Materials")]];

    u16 numSigilIconThresholds
        [[name("Number of Sigil Icon Thresholds")]];

    // Offset 0x246: HBG shot gauge gains (header 0x640)
    u16 numHbgShotGaugeGains
        [[name("Number of HBG Shot Gauge Gains")]];

    // Offset 0x248: Fencing hitstop overrides (header 0x644)
    u16 numFencingHitstopOverrides
        [[name("Number of Fencing Hitstop Overrides")]];

    // Offset 0x24A: Road floor milestones (header 0x64C)
    u16 numRoadMilestones
        [[name("Number of Road Floor Milestones")]];

    // Offset 0x24C: shortcut combine blocked actions (header 0x650)
    u16 numShortcutCombineBlockedActions
        [[name("Number of Shortcut Combine Blocked Actions")]];

    padding[0x2];

    // Offset 0x250: just reload rows per list (header 0x668)
    u16 numJustReloadRows
        [[name("Number of Just Reload Rows")]];

    // Offset 0x252: just reload lists (header 0x668)
    u16 numJustReloadLists
        [[name("Number of Just Reload Lists")]];

    // Offset 0x254: just shot rows per list (header 0x66C)
    u16 numJustShotRows
        [[name("Number of Just Shot Rows")]];

    padding[0x2];

    // Offset 0x258: hunting horn melodies (header 0x670)
    u16 numHornMelodies
        [[name("Number of Horn Melodies")]];

    // Offset 0x25A: hunting horn Extreme style melodies (header 0x674)
    u16 numHornExtremeMelodies
        [[name("Number of Horn Extreme Melodies")]];

    // Offset 0x25C: gunlance shells (header 0x678)
    u16 numGunlanceShells
        [[name("Number of Gunlance Shell Rows")]];

    // Offset 0x25E: guild icon monster icon rows (header 0x6A4)
    u16 numGuildIconMonsterIconRows
        [[name("Number of Guild Icon Monster Icon Rows")]];

    padding[0x2];

    // Offset 0x262: carve kind chances by monster (header 0x6AC)
    u16 numCarveKindChanceMonsters
        [[name("Number of Carve Kind Chance Monsters")]];

    // Offset 0x264: Partner starter weapons (header 0x6B0)
    u16 numPartnerStarterWeapons
        [[name("Number of Partner Starter Weapons")]];

    padding[0x6];

    // Offset 0x26C: monster price board rows (header 0x6C0)
    u16 numMonsterPriceBoardRows
        [[name("Number of Monster Price Board Rows")]];

    padding[0x2];

    // Offset 0x270: G1 to G7 quest list pointers (header 0x6C8 to 0x6E0, one count each), relocated by rd_mhfdat
    u16 numG1QuestLists
        [[name("Number of G1 Quest Lists")]];

    u16 numG2QuestLists
        [[name("Number of G2 Quest Lists")]];

    u16 numG3QuestLists
        [[name("Number of G3 Quest Lists")]];

    u16 numG4QuestLists
        [[name("Number of G4 Quest Lists")]];

    u16 numG5QuestLists
        [[name("Number of G5 Quest Lists")]];

    u16 numG6QuestLists
        [[name("Number of G6 Quest Lists")]];

    u16 numG7QuestLists
        [[name("Number of G7 Quest Lists")]];

    padding[0x6];

    // Offset 0x284: Veggie Elder map rows with the map 0 row (header 0x6F0), relocated by rd_mhfdat
    u16 numVeggieElderMaps
        [[name("Number of Veggie Elder Maps")]];

    padding[0x2];

    // Offset 0x288: box search sigil skills (header 0x718)
    u16 numBoxSearchSigilSkills
        [[name("Number of Box Search Sigil Skills")]];

    padding[0x4];

    // Offset 0x28E: weapon sound bank by weapon model (header 0x724)
    u16 numWeaponModelSoundIds
        [[name("Number of Weapon Model Sound Ids")]];

    padding[0x2];

    // Offset 0x292: player unique parameters (header 0x72C, pl_get_unq_prm)
    u16 numPlayerUniqueParams
        [[name("Number of Player Unique Parameter Rows")]];

    padding[0x8];

    // Offset 0x29C: G8 to G10 quest list pointers (header 0x740 to 0x748), relocated by rd_mhfdat
    u16 numG8QuestLists
        [[name("Number of G8 Quest Lists")]];

    u16 numG9QuestLists
        [[name("Number of G9 Quest Lists")]];

    u16 numG10QuestLists
        [[name("Number of G10 Quest Lists")]];

    // Offset 0x2A2: G rank cuff crafting rows incl. the zero end row (header 0x750)
    u16 numGCuffRecipes
        [[name("Number of G Rank Cuff Recipes")]];

    padding[0x16];

    // Offset 0x2BA: fishing baits (header 0x780)
    u16 numFishingBaits
        [[name("Number of Fishing Baits")]];

    padding[0x8];

    // Offset 0x2C4: super rapid fire power rows (header 0x794)
    u16 numSuperRapidFirePowers
        [[name("Number of Super Rapid Fire Powers")]];

    // Offset 0x2C6: G quest difficulty thresholds (header 0x798)
    u16 numGQuestDifficultyThresholds
        [[name("Number of G Quest Difficulty Thresholds")]];

    // Offset 0x2C8: G quest difficulty base defenses, s32 count = 2 per G star (header 0x79C)
    u16 numGQuestDifficultyDefenses
        [[name("Number of G Quest Difficulty Base Defense Values")]];

    // Offset 0x2CA: lobby NPC motion sounds (header 0x7A8), the last row is the 0 end row
    u16 numNpcMotionSounds
        [[name("Number of NPC Motion Sound Rows")]];

    padding[0x6];

    // Offset 0x2D2: quest rare rewards by monster (header 0x7B8)
    u16 numQuestRareRewards
        [[name("Number of Quest Rare Rewards")]];

    padding[0x4];

    // Offset 0x2D8: carve fail chances by G star offset (header 0x7C4)
    u16 numCarveFailChances
        [[name("Number of Carve Fail Chances")]];

    padding[0x4];

    // Offset 0x2DE: Diva Story gift liking (header 0x7D0): u16 values, so pairs = this / 2
    u16 numDivaStoryGiftLikingValues
        [[name("Number of Diva Story Gift Liking u16 Values")]];

    // Offset 0x2E0: Hunting Medal milestones by monster (header 0x7D4)
    u16 numHuntingMedalMonsters
        [[name("Number of Hunting Medal Monsters")]];

    // Offset 0x2E2: Koryo amulets (header 0x7D8)
    u16 numKoryoAmulets
        [[name("Number of Koryo Amulets")]];

    padding[0x4];

    // Offset 0x2E8: items the reward rate does not scale (header 0x7E4)
    u16 numRewardRateExemptItems
        [[name("Number of Reward Rate Exempt Items")]];

    padding[0xE];

    u16 numAutoSkills
        [[name("Number of Auto Skills")]];

    // Offset 0x2FA: map variant rows (header 0x808, 16 s8 each); FUN_11384A20 (map_instantiate_event) reads row quest mapVariant when below it, else uses 0
    u16 numMapVariantRows
        [[name("Number of Map Variant Rows")]];

    // Offset 0x2FC: Guild Hall reward list pointers (header 0x810), relocated by gReadMhfDat
    u16 numGuildHallRewardLists
        [[name("Number of Guild Hall Reward Lists")]];

    // Offset 0x2FE: Guild Hall reward groups (header 0x814)
    u16 numGuildHallRewardGroupRows
        [[name("Number of Guild Hall Reward Group Rows")]];

    // Offset 0x300: Guild Hall reward stacks (header 0x818)
    u16 numGuildHallRewardStacks
        [[name("Number of Guild Hall Reward Stacks")]];

    // Offset 0x302: Guild Hall reward items (header 0x81C)
    u16 numGuildHallRewardItems
        [[name("Number of Guild Hall Reward Items")]];

    // Offset 0x304: Guild Hall reward extra items by HR band (header 0x820 / 0x824 / 0x828)
    u16 numGuildHallRewardExtraItemsHrLow
        [[name("Number of Guild Hall Reward Extra Items HR 1-30")]];

    u16 numGuildHallRewardExtraItemsHrMid
        [[name("Number of Guild Hall Reward Extra Items HR 31-100")]];

    u16 numGuildHallRewardExtraItemsHrHigh
        [[name("Number of Guild Hall Reward Extra Items HR 101+")]];

    padding[0x2];

    // Offset 0x30C: Partner skills (header 0x838)
    u16 numPartnerSkills
        [[name("Number of Partner Skills")]];

    padding[0x14];

    // Offset 0x322: Large Monster quest tabs (header 0x864)
    u16 numLargeMonsterQuestTabs
        [[name("Number of Large Monster Quest Tabs")]];

    // Offset 0x324: guild cooking recipes and ingredients (header 0x868, 0x86C)
    u16 numGuildCookingRecipes
        [[name("Number of Guild Cooking Recipes")]];

    u16 numGuildCookingIngredients
        [[name("Number of Guild Cooking Ingredients")]];

    // Offset 0x328: Legend Rasta daily rotation (header 0x870)
    u16 numLegendRastaDailyRotation
        [[name("Number of Legend Rasta Daily Rotation Days")]];

    padding[0x2];

    // Offset 0x32C: 0x10C-byte route rows of header 0x878 (RankingRoute layout), relocated by rd_mhfdat; no other reader
    u16 num878Routes
        [[name("Number of Header 0x878 Routes")]];

    padding[0x4];

    // Offset 0x332: Tower / G50 level lists of header 0x888 (towerG50TonfaParams), relocated by rd_mhfdat
    u16 numTowerG50TonfaParams
        [[name("Number of towerG50TonfaParams")]];

    padding[0x4];

    // Offset 0x338: sigil crafting skill lists (header 0x894, 0x898)
    u16 numSigilCraftUniqueSkills
        [[name("Number of Sigil Craft Unique Skills")]];

    u16 numSigilCraftValueNamedSkills
        [[name("Number of Sigil Craft Value-Named Skills")]];

    // Offset 0x33C: guild cooking random skill pools (header 0x89C)
    u16 numGuildCookingSkillPools
        [[name("Number of Guild Cooking Skill Pools")]];

    padding[0x8];

    // Offset 0x346: treasure hunt spots (header 0x8B0)
    u16 numTreasureHuntSpots
        [[name("Number of Treasure Hunt Spots")]];

    padding[0x6];

    // Offset 0x34E: companion stage points (header 0x8C8)
    u16 numCompanionStagePoints
        [[name("Number of Companion Stage Points")]];

    // Offset 0x350: Treasure Corp (header 0x8D0-0x8EC)
    u16 numTreasureCorpAreas
        [[name("Number of Treasure Corp Areas")]];

    u16 numTreasureCorpResultChances
        [[name("Number of Treasure Corp Result Chances")]];

    u16 numTreasureCorpDrawRulesKind2
        [[name("Number of Treasure Corp Draw Rules Kind 2")]];

    u16 numTreasureCorpDrawRulesKind01
        [[name("Number of Treasure Corp Draw Rules Kind 0 and 1")]];

    u16 numTreasureCorpListsA
        [[name("Number of Treasure Corp Lists A")]];

    u16 numTreasureCorpListsB
        [[name("Number of Treasure Corp Lists B")]];

    u16 numTreasureCorpListsC
        [[name("Number of Treasure Corp Lists C")]];

    u16 numTreasureCorpListsD
        [[name("Number of Treasure Corp Lists D")]];

    // Offset 0x360: caravan CP (header 0x8F0-0x8F8)
    u16 numCaravanPartBreakCountRates
        [[name("Number of Caravan Part Break Count Rates")]];

    u16 numCaravanRankingCpRolls
        [[name("Number of Caravan Ranking CP Rolls")]];

    u16 numCaravanPartBreakCpMonsters
        [[name("Number of Caravan Part Break CP Monsters")]];

    // Offset 0x366: Shiten reward rows (header 0x900)
    u16 numShitenRewards
        [[name("Number of Shiten Rewards")]];

    padding[0x2];

    // Offset 0x36A: Cat Decoration search skill categories (header 0x908)
    u16 numCatDecoSearchSkillCategories
        [[name("Number of Cat Decoration Search Skill Categories")]];

    // Offset 0x36C: 12-byte rows of header 0x914 (pointer at +4), relocated by rd_mhfdat; no other reader
    u16 num914Rows
        [[name("Number of Header 0x914 Rows")]];

    // Offset 0x36E: rows of header 0x918 (0x10 bytes, sorted by the s32 at +0xC); FUN_113AD220 binary-searches them
    u16 num918Rows
        [[name("Number of Header 0x918 Rows")]];

    // Offset 0x370: 11 on ZZ, the Caravan ranking route groups that are used (header 0x91C)
    u16 numRankingGroups
        [[name("Number of Caravan Ranking Groups")]];

    u16 rankingGroupRouteCounts[11] [[comment("Routes in ranking group g (header 0x91C); rd_mhfdat relocates this many rows per group")]];

    u16 unk388 [[comment("18 on ZZ, use unknown")]];

    // Offset 0x38A: tower jewel recipes (header 0x938)
    u16 numTowerJewelRecipes
        [[name("Number of Tower Jewel Recipes")]];

    padding[0x4];

    // Offset 0x390: Tonfa per-target hit damage rows (header 0x958)
    u16 numTonfaTargetHitDamage
        [[name("Number of Tonfa Target Hit Damage Rows")]];

    // Offset 0x392: Tonfa chain shell hit rates (header 0x95C)
    u16 numTonfaChainShellRates
        [[name("Number of Tonfa Chain Shell Hit Rates")]];

    // Offset 0x394: Tonfa style 1 / style 3 gauge gain rates (header 0x960 / 0x964)
    u16 numTonfaStyle1GaugeGainRates
        [[name("Number of Tonfa Style 1 Gauge Gain Rates")]];

    u16 numTonfaStyle3GaugeGainRates
        [[name("Number of Tonfa Style 3 Gauge Gain Rates")]];

    padding[0xA];

    // Offset 0x3A2: voice face motions, male / female (header 0x97C, 0x980)
    u16 numVoiceFaceMotionsMale
        [[name("Number of Voice Face Motions (Male)")]];

    u16 numVoiceFaceMotionsFemale
        [[name("Number of Voice Face Motions (Female)")]];

    // Offset 0x3A6: Storm Style trial G excluded monsters (header 0x98C)
    u16 numNsQuestExcludedMonstersG
        [[name("Number of Storm Style Trial G Excluded Monsters")]];

    // Offset 0x3A8: Transcend depths (header 0x990)
    u16 numTranscendDepths
        [[name("Number of Transcend Depths")]];

    padding[0x14];

    // Offset 0x3BE: GR800 Exotic bonus materials (header 0x9F8)
    u16 numExoticBonusMaterials
        [[name("Number of GR800 Exotic Bonus Materials")]];

    padding[0x10];

    // Offset 0x3D0: clan mission part targets (header 0xA28)
    u16 numClanMissionTargets
        [[name("Number of Clan Mission Targets")]];

    padding[0xA];

    // Offset 0x3DC: Tower / G50 level lists of header 0xA90 (towerG50SwitchAxeParams), relocated by rd_mhfdat
    u16 numTowerG50SwitchAxeParams
        [[name("Number of towerG50SwitchAxeParams")]];

    padding[0x2];

    // Offset 0x3E0: HR quest tiers (header 0xA98 pointers walked by the HR quest lookups)
    u16 numHrQuestTiers
        [[name("Number of HR Quest Tiers")]];

    // Offset 0x3E2: experience quests (header 0xA9C)
    u16 numExperienceQuests
        [[name("Number of Experience Quests")]];

    padding[0x12];

    // Offset 0x3F6: forge rank weapon / armor lists (header 0xAE0, 0xAE4 pointers), relocated by rd_mhfdat
    u16 numForgeRankWeaponLists
        [[name("Number of Forge Rank Weapon Lists")]];

    u16 numForgeRankArmorLists
        [[name("Number of Forge Rank Armor Lists")]];

    padding[0x2];

    // Offset 0x3FC: soul combine recipes (header 0xAEC)
    u16 numCombineSoulRecipes
        [[name("Number of Combine Soul Recipes")]];

    padding[0x2];

    // Offset 0x400: Conquest quest ids (header 0xB30)
    u16 numConquestQuests
        [[name("Number of Conquest Quests")]];

    // Offset 0x402: Shiten quest ids (header 0xB34)
    u16 numShitenQuests
        [[name("Number of Shiten Quests")]];

    // Offset 0x404: Koryo lottery prize lists (header 0xB38)
    u16 numKoryoLotteryLists
        [[name("Number of Koryo Lottery Lists")]];

    padding[0x2];

    // Offset 0x408: Koryo points by monster (header 0xB40)
    u16 numKoryoMonsterPoints
        [[name("Number of Koryo Monster Points")]];

    // Offset 0x40A: rows of header 0xB44 (0x20 bytes); hunting_medal_menu_open falls back to DLL row 0x11880F08 for a row >= it
    u16 numB44Rows
        [[name("Number of Header 0xB44 Rows")]];

    padding[0x2];

    // Offset 0x40E: daily rotation quest lists, JST day % 3 = 0 / 1 / 2 (header 0xB50, 0xB54, 0xB58)
    u16 numDailyRotationQuestLists0
        [[name("Number of Daily Rotation Quest Lists 0")]];

    u16 numDailyRotationQuestLists1
        [[name("Number of Daily Rotation Quest Lists 1")]];

    u16 numDailyRotationQuestLists2
        [[name("Number of Daily Rotation Quest Lists 2")]];

    // Offset 0x414: Caravan monster prices (header 0xB70)
    u16 numCaravanMonsterPrices
        [[name("Number of Caravan Monster Prices")]];

    // Offset 0x416: stamp card rewards (header 0xB74)
    u16 numStampCardRewards
        [[name("Number of Stamp Card Rewards")]];

    // Offset 0x418: hiden combine recipes (header 0xB84)
    u16 numCombineHidenRecipes
        [[name("Number of Combine Hiden Recipes")]];

    // Offset 0x41A: Tower / G50 level lists of header 0xB98 (towerG50MagnetSpikeParams), relocated by rd_mhfdat
    u16 numTowerG50MagnetSpikeParams
        [[name("Number of towerG50MagnetSpikeParams")]];

    // Offset 0x41C: Zenith sigil craft material catalog (header 0xB9C)
    u16 numSigilCraftMaterialsZenith
        [[name("Number of Zenith Sigil Craft Materials")]];

    // Offset 0x41E: sigil craft recipe material categories (header 0xBA0)
    u16 numSigilCraftRecipeMaterialCategories
        [[name("Number of Sigil Craft Recipe Material Categories")]];

    // Offset 0x420: Mass and Hiden Jewel combine recipes (header 0xBAC)
    u16 numCombineMassJewelRecipes
        [[name("Number of Combine Mass and Hiden Jewel Recipes")]];

} [[name("Important Numbers")]];

ImportantNumbers importantNums @ header.ptrs.important_nums;

struct EquipmentCounts {
	u16 numLegA;
	u16 numEquipType1 [[comment("Equip type 1 (armorStatArray[1] = the head table, no name table): read only through the type index (Equip_flag_ck / Equip_flag_set, type <= 7) and summed by rd_mhfdat into the owned-flag buffer")]];
	u16 numHeadA;
	u16 numBodyA;
	u16 numArmA;
	u16 numWaistA;
	u16 numMeleeW;
	u16 numRangedW;
};

EquipmentCounts equipmentCounts @ header.ptrs.hd_dll_af47af [[name("Equipment Counts")]];
