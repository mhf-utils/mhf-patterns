#pragma once

#include <misc/types.pat>

// The block header 0x10 points to: the counts of tables that have no end marker
struct ImportantNumbers {
    padding[0x1A];

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

    padding[0x18];

    // Offset 0x3C: beginner quest ids (header 0x1B8)
    u16 numBeginnerQuests
        [[name("Number of Beginner Quests")]];

    padding[0xA];

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

    padding[0xC];

    // Offset 0x5E: Caravan gem skill lists, one per tier (header 0xF4) [mhfo-hd.dll + 0xaf4d91]
    u16 numHunterPearlSkillLists
        [[name("Number of Hunter Pearl Skill Lists")]];

    padding[0x2];

    // Offset 0x62: My House renovation themes (header 0x260)
    u16 numMyHouseThemes
        [[name("Number of My House Themes")]];

    padding[0x50];

    // Offset 0xB4: evolution weapon series (header 0x2CC melee, 0x2D0 ranged)
    u16 numEvoMeleeWeapons
        [[name("Number of Evolution Melee Weapons")]];

    u16 numEvoRangedWeapons
        [[name("Number of Evolution Ranged Weapons")]];

    padding[0x22];

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

    padding[0x2];

    // Offset 0xF6: Legend Rasta groups (header 0x360)
    u16 numLegendRastaGroups
        [[name("Number of Legend Rasta Groups")]];

    padding[0x1A];

    // Offset 0x112: G quest party size rates (header 0x39C)
    u16 numGQuestPartySizeRates
        [[name("Number of G Quest Party Size Rates")]];

    padding[0x32];

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

    padding[0x2];

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

    padding[0x2];

    u16 numGoocooTrustParams
        [[name("Number of Goocoo Trust Parameters")]];

    u16 numGoocooTrustDecay
        [[name("Number of Goocoo Trust Decay Steps")]];

    padding[0x8];

    u16 numGoocooExchanges
        [[name("Number of Goocoo Exchanges")]];

    u16 numGoocooClothesCosts
        [[name("Number of Goocoo Clothes Costs")]];

    u16 numGoocooRemodelCosts
        [[name("Number of Goocoo Remodel Costs")]];

    padding[0xA];

    u16 numGoocooPotMaterials
        [[name("Number of Goocoo Pot Materials")]];

    padding[0x2];

    // Offset 0x1A0: Goocoo farm timer values (header 0x4C4), u32
    u16 numGoocooFarmTimerValues
        [[name("Number of Goocoo Farm Timer Values")]];

    padding[0x1E];

    // Offset 0x1C0: Halk foods (header 0x510)
    u16 numHalkFoods
        [[name("Number of Halk Foods")]];

    padding[0x16];

    // Offset 0x1D8: sound distance curves 2 (header 0x544, apply_sound_and_shake)
    u16 numSoundCurves2
        [[name("Number of Sound Curves 2")]];

    // Offset 0x1DA: seasonal event timings (header 0x54C)
    u16 numSeasonalEvents
        [[name("Number of Seasonal Events")]];

    padding[0x14];

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

    padding[0x1A];

    u16 g50MeleeWeaponUpgradesCounter
        [[name("g50 melee weapons upgrades counter")]];

    u16 g50RangedWeaponUpgradesCounter
        [[name("g50 ranged weapon updrades counter")]];

    padding[0x1C];

    // Offset 0x24A: Road floor milestones (header 0x64C)
    u16 numRoadMilestones
        [[name("Number of Road Floor Milestones")]];

    padding[0x4];

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

    padding[0x2];

    // Offset 0x25C: gunlance shells (header 0x678)
    u16 numGunlanceShells
        [[name("Number of Gunlance Shell Rows")]];

    padding[0x6];

    // Offset 0x264: Partner starter weapons (header 0x6B0)
    u16 numPartnerStarterWeapons
        [[name("Number of Partner Starter Weapons")]];

    padding[0x2C];

    // Offset 0x292: player unique parameters (header 0x72C, pl_get_unq_prm)
    u16 numPlayerUniqueParams
        [[name("Number of Player Unique Parameter Rows")]];

    padding[0x30];

    // Offset 0x2C4: super rapid fire power rows (header 0x794)
    u16 numSuperRapidFirePowers
        [[name("Number of Super Rapid Fire Powers")]];

    padding[0x4];

    // Offset 0x2CA: lobby NPC motion sounds (header 0x7A8), the last row is the 0 end row
    u16 numNpcMotionSounds
        [[name("Number of NPC Motion Sound Rows")]];

    padding[0x12];

    // Offset 0x2DE: Diva Story gift liking (header 0x7D0): u16 values, so pairs = this / 2
    u16 numDivaStoryGiftLikingValues
        [[name("Number of Diva Story Gift Liking u16 Values")]];

    padding[0x2];

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

    padding[0x12];

    // Offset 0x30C: Partner skills (header 0x838)
    u16 numPartnerSkills
        [[name("Number of Partner Skills")]];

    padding[0x16];

    // Offset 0x324: guild cooking recipes and ingredients (header 0x868, 0x86C)
    u16 numGuildCookingRecipes
        [[name("Number of Guild Cooking Recipes")]];

    u16 numGuildCookingIngredients
        [[name("Number of Guild Cooking Ingredients")]];

    padding[0x10];

    // Offset 0x338: sigil crafting skill lists (header 0x894, 0x898)
    u16 numSigilCraftUniqueSkills
        [[name("Number of Sigil Craft Unique Skills")]];

    u16 numSigilCraftValueNamedSkills
        [[name("Number of Sigil Craft Value-Named Skills")]];

    padding[0x14];

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

    padding[0x8];

    // Offset 0x370: 11 on ZZ, the Caravan ranking route groups that are used (header 0x91C)
    u16 numRankingGroups
        [[name("Number of Caravan Ranking Groups")]];

    u16 unk372 [[comment("7 on ZZ, use unknown")]];

    padding[0x16];

    // Offset 0x38A: tower jewel recipes (header 0x938)
    u16 numTowerJewelRecipes
        [[name("Number of Tower Jewel Recipes")]];

    padding[0x1C];

    // Offset 0x3A8: Transcend depths (header 0x990)
    u16 numTranscendDepths
        [[name("Number of Transcend Depths")]];

    padding[0x26];

    // Offset 0x3D0: clan mission part targets (header 0xA28)
    u16 numClanMissionTargets
        [[name("Number of Clan Mission Targets")]];

    padding[0x2E];

    // Offset 0x400: Conquest quest ids (header 0xB30)
    u16 numConquestQuests
        [[name("Number of Conquest Quests")]];

    // Offset 0x402: Shiten quest ids (header 0xB34)
    u16 numShitenQuests
        [[name("Number of Shiten Quests")]];

} [[name("Important Numbers")]];

ImportantNumbers importantNums @ header.ptrs.important_nums;

struct EquipmentCounts {
	u16 numLegA;
	u16 numUnk;
	u16 numHeadA;
	u16 numBodyA;
	u16 numArmA;
	u16 numWaistA;
	u16 numMeleeW;
	u16 numRangedW;
};

EquipmentCounts equipmentCounts @ header.ptrs.hd_dll_af47af [[name("Equipment Counts")]];
