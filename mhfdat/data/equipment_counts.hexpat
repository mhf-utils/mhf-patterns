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

    padding[0x2];

    // Offset 0x26: Hunting Horn melody book pages (header 0x180, 0x184)
    u16 numHuntingHornSongPages
        [[name("Number of Hunting Horn Song Pages")]];

    u16 numAncientHuntingHornScorePages
        [[name("Number of Ancient Hunting Horn Score Pages")]];

    padding[0x2];

    // Offset 0x2C: Hunter Dojo rule pages (header 0x1A8 online, 0x1AC offline)
    u16 numDojoRulePagesOnline
        [[name("Number of Dojo Rule Pages (Online)")]];

    u16 numDojoRulePagesOffline
        [[name("Number of Dojo Rule Pages (Offline)")]];

    // Offset 0x30: Hunter Basics pages (header 0x1A4)
    u16 numHunterBasicsPages
        [[name("Number of Hunter Basics Pages")]];

    padding[0x6];

    // Offset 0x38: Instructor tutorial (header 0x1B0, 0x1B4)
    u16 numTutorialLessons
        [[name("Number of Tutorial Lessons")]];

    u16 numTutorialLessonGroups
        [[name("Number of Tutorial Lesson Groups")]];

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

    padding[0x2];

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

    padding[0x38];

    // Offset 0xB4: evolution weapon series (header 0x2CC melee, 0x2D0 ranged)
    u16 numEvoMeleeWeapons
        [[name("Number of Evolution Melee Weapons")]];

    u16 numEvoRangedWeapons
        [[name("Number of Evolution Ranged Weapons")]];

    padding[0xC];

    // Offset 0xC4: Pioneer quest bonus rewards (header 0x2F0)
    u16 numPioneerQuestBonusRewards
        [[name("Number of Pioneer Quest Bonus Rewards")]];

    padding[0x14];

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

    padding[0x16];

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

    padding[0xC];

    // Offset 0x1D4: monster hitzone effect scales (header 0x53C)
    u16 numMonsterHitzoneEffectScales
        [[name("Number of Monster Hitzone Effect Scales")]];

    padding[0x2];

    // Offset 0x1D8: sound distance curves 2 (header 0x544, apply_sound_and_shake)
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

    padding[0x1A];

    u16 g50MeleeWeaponUpgradesCounter
        [[name("g50 melee weapons upgrades counter")]];

    u16 g50RangedWeaponUpgradesCounter
        [[name("g50 ranged weapon updrades counter")]];

    padding[0x12];

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

    padding[0x1A];

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

    padding[0x26];

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

    padding[0x4];

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

    padding[0xE];

    // Offset 0x338: sigil crafting skill lists (header 0x894, 0x898)
    u16 numSigilCraftUniqueSkills
        [[name("Number of Sigil Craft Unique Skills")]];

    u16 numSigilCraftValueNamedSkills
        [[name("Number of Sigil Craft Value-Named Skills")]];

    padding[0xA];

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

    padding[0x4];

    // Offset 0x370: 11 on ZZ, the Caravan ranking route groups that are used (header 0x91C)
    u16 numRankingGroups
        [[name("Number of Caravan Ranking Groups")]];

    u16 unk372 [[comment("7 on ZZ, use unknown")]];

    padding[0x16];

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

    padding[0x10];

    // Offset 0x3E2: experience quests (header 0xA9C)
    u16 numExperienceQuests
        [[name("Number of Experience Quests")]];

    padding[0x18];

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

    // Offset 0x404: last Koryo lottery prize list index (header 0xB38, lists 0 to this)
    u16 lastKoryoLotteryList
        [[name("Last Koryo Lottery List")]];

    padding[0x2];

    // Offset 0x408: Koryo points by monster (header 0xB40)
    u16 numKoryoMonsterPoints
        [[name("Number of Koryo Monster Points")]];

    padding[0x4];

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

    padding[0x2];

    // Offset 0x41C: Zenith sigil craft material catalog (header 0xB9C)
    u16 numSigilCraftMaterialsZenith
        [[name("Number of Zenith Sigil Craft Materials")]];

    // Offset 0x41E: sigil craft recipe material categories (header 0xBA0)
    u16 numSigilCraftRecipeMaterialCategories
        [[name("Number of Sigil Craft Recipe Material Categories")]];

    // Offset 0x420: cuff combine recipes (header 0xBAC)
    u16 numCombineCuffRecipes
        [[name("Number of Combine Cuff Recipes")]];

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
