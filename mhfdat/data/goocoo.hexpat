#pragma once

/**
	Goocoo (My Garden): food, house-sitting, personalities, remodelling, the
	exchange, the Goocoo Pot, skins and stray Goocoos. Header 0x404 to 0x4E0,
	one count per table at important numbers + 0x146 to + 0x1A8, in header
	order. Only the tables the client code reads are shown; the others (header
	0x4A8) are not.

	House-sitting roll, in order: the mood item (0x434); the grade, from the
	trust plus the personality (0x418, by activity) and mood (0x41C)
	modifiers, through the score ranges of 0x430; whether anything is found
	(0x410); how many items (0x414); their rarity (0x420 to 0x42C, fish,
	bugs, junk, bargains); an item of 0x40C that has the activity flag, an
	unlocked band and the rolled rarity (item 8 when none has).
*/

#include <std/string.pat>
#include <std/core.pat>
#include <std/mem.pat>
#include <misc/s32p.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Food and personalities
// =======================

// Ferias' columns: trust, weight, intelligence, strength, patience, kindness
// =======================
// Goocoo accessories (header 0x3C4 to 0x3FC): one table of rows, one of names
// and one of descriptions per slot, important numbers + 0x126 to + 0x12E rows
// each. The clothing menu tabs (DLL u32 table 0x118E1500: 2, 3, 4, 0, 5) are
// hats, masks, bags, clothes, tails; goocoo_accessory_tab_update copies the
// slot's count and three tables into the menu work and
// goocoo_accessory_list_build lists, 8 a page, the rows whose series is 0 or
// is unlocked (bit series - 1 of save ctx 0x1FE5C, the series of header
// 0x400). The Goocoo's profile holds one row index per slot (+6 clothes, +8
// hat, +0xA mask, +0xC bag, +0xE tail); process_npc_entry resets an index past
// the count to 0 and, when the row's model is not -1, loads
// npc\n37<b|h|f|n|t><model>.bin (DLL table 0x118E18F8).
// Row 0 of each slot is "はずす" (take off), model -1.
// =======================

struct GoocooAccessory {
    u16 unk00 [[comment("The row number; no reader")]];
    s16 model [[comment("npc\\n37<slot letter><model>.bin; -1: none")]];
    u8 unk04 [[comment("1 clothes, 0 hat, 2 mask, 3 bag, 4 tail on every row; no reader")]];
    u8 unk05 [[comment("0-10; no reader")]];
    u8 series [[comment("0: always listed; n: listed when clothing series n is unlocked (header 0x400); 255 on one hat: never")]];
    u8 hatDrawFlag [[comment("Hats only: goocoo_hat_draw_flag returns it != 0 for the model setup FUN_10658530")]];
    u32 unk08 [[comment("1 on 4 rows of each slot; no reader")]];
};

GoocooAccessory goocooHats[importantNums.numGoocooHats] @ header.ptrs.goocooHats [[name("Goocoo Hats")]];
GoocooAccessory goocooClothes[importantNums.numGoocooClothes] @ header.ptrs.goocooClothes [[name("Goocoo Clothes")]];
GoocooAccessory goocooMasks[importantNums.numGoocooMasks] @ header.ptrs.goocooMasks [[name("Goocoo Masks")]];
GoocooAccessory goocooBags[importantNums.numGoocooBags] @ header.ptrs.goocooBags [[name("Goocoo Bags")]];
GoocooAccessory goocooTails[importantNums.numGoocooTails] @ header.ptrs.goocooTails [[name("Goocoo Tail Accessories")]];
s32p goocooHatNames[importantNums.numGoocooHats] @ header.ptrs.goocooHatNames [[name("Goocoo Hat Names")]];
s32p goocooClothesNames[importantNums.numGoocooClothes] @ header.ptrs.goocooClothesNames [[name("Goocoo Clothes Names")]];
s32p goocooMaskNames[importantNums.numGoocooMasks] @ header.ptrs.goocooMaskNames [[name("Goocoo Mask Names")]];
s32p goocooBagNames[importantNums.numGoocooBags] @ header.ptrs.goocooBagNames [[name("Goocoo Bag Names")]];
s32p goocooTailNames[importantNums.numGoocooTails] @ header.ptrs.goocooTailNames [[name("Goocoo Tail Accessory Names")]];
s32p goocooHatDescs[importantNums.numGoocooHats] @ header.ptrs.goocooHatDescs [[name("Goocoo Hat Descriptions")]];
s32p goocooClothesDescs[importantNums.numGoocooClothes] @ header.ptrs.goocooClothesDescs [[name("Goocoo Clothes Descriptions")]];
s32p goocooMaskDescs[importantNums.numGoocooMasks] @ header.ptrs.goocooMaskDescs [[name("Goocoo Mask Descriptions")]];
s32p goocooBagDescs[importantNums.numGoocooBags] @ header.ptrs.goocooBagDescs [[name("Goocoo Bag Descriptions")]];
s32p goocooTailDescs[importantNums.numGoocooTails] @ header.ptrs.goocooTailDescs [[name("Goocoo Tail Accessory Descriptions")]];

struct GoocooFood {
    u16 item                    [[format("getItemName")]];
    s16 trust;
    s16 weight;
    s16 stat0;
    s16 stat3;
    s16 stat1;
    s16 stat2;
    padding[2];
};

GoocooFood goocooFoods[importantNums.numGoocooFoods] @ header.ptrs.goocooFoods [[name("Goocoo Foods")]];
s32p goocooFoodTexts[importantNums.numGoocooFoodTexts] @ header.ptrs.goocooFoodTexts [[name("Goocoo Food Texts")]];

struct GoocooStatRange {
    s16 a;
    s16 b;
};

// The client takes the min and the max of each pair
struct GoocooPersonality {
    s16 id;
    GoocooStatRange stats[4];
    padding[2];
};

GoocooPersonality goocooPersonalities[importantNums.numGoocooPersonalities] @ header.ptrs.goocooPersonalities [[name("Goocoo Personalities")]];
s32p goocooPersonalityNames[importantNums.numGoocooPersonalityNames] @ header.ptrs.goocooPersonalityNames [[name("Goocoo Personality Names")]];
s32p goocooCareActions[importantNums.numGoocooCareActions] @ header.ptrs.goocooCareActions [[name("Goocoo Care Actions")]];
s32p goocooCareStyles[importantNums.numGoocooCareStyles] @ header.ptrs.goocooCareStyles [[name("Goocoo Care Styles")]];

// Egg care (header 0x438): row = action x 3 + style (the 0x440 / 0x444 name
// lists). moveEventFarmDuckEgg2ndMenu keeps one choice per egg stage 2-5 in
// profile +0x22 to +0x25; at hatching (setDataDuckBorn) getPersonalityEgg sums
// the personality points of the 4 rows and the highest total (lowest index on a
// tie) becomes the personality (profile +0x28, 0x448 order).
struct GoocooEggCare {
    u16 unk00 [[comment("The row number + 1; no reader")]];
    u8 personalityPoints[7] [[comment("By personality (header 0x448 order)")]];
    padding[3];
};

GoocooEggCare goocooEggCare[importantNums.numGoocooEggCare] @ header.ptrs.goocooEggCare [[name("Goocoo Egg Care")]];

// [0] min, [1] max, [3] and [4] the meal reaction thresholds; the others are not read
s16 goocooTrustParams[importantNums.numGoocooTrustParams] @ header.ptrs.goocooTrustParams [[name("Goocoo Trust Parameters")]];
// [0]: the trust change per day without food; the others are not read
s16 goocooTrustDecay[importantNums.numGoocooTrustDecay] @ header.ptrs.goocooTrustDecay [[name("Goocoo Trust Decay")]];

// =======================
// House-sitting
// =======================

struct GoocooSitItem {
    u16 item                    [[format("getItemName")]];
    u8  band                    [[comment("1 always, 2-5 by HR tier, 6 G rank")]];
    padding[1];
    u8  fish;
    u8  bugs;
    u8  junk;
    u8  bargains;
    padding[8];
};

struct GoocooSitGradeChance {
    u16 grade;
    u8  chance                  [[comment("Percent")]];
    padding[1];
};

struct GoocooSitCount {
    u16 grade;
    u8  weights[5]              [[comment("1 to 5 items")]];
    padding[1];
};

struct GoocooSitModifier {
    u16 keyPlus1                [[comment("Personality or mood + 1")]];
    s8  fish;
    s8  bugs;
    s8  junk;
    s8  bargains;
    padding[2];
};

struct GoocooSitRarity {
    u16 grade;
    u8  weights[7];
    padding[3];
};

struct GoocooSitGrade {
    u16 grade;
    s16 scoreMin;
    s16 scoreMax;
    padding[2];
};

struct GoocooSitMoodItem {
    u16 moodPlus1;
    u16 item                    [[format("getItemName")]];
    u8  chance                  [[comment("Percent")]];
    u8  count;
    padding[2];
};

GoocooSitItem goocooSitItems[importantNums.numGoocooSitItems] @ header.ptrs.goocooSitItems [[name("Goocoo House-Sitting Items")]];
GoocooSitGradeChance goocooSitGradeChances[importantNums.numGoocooSitGradeChances] @ header.ptrs.goocooSitGradeChances [[name("Goocoo House-Sitting Grade Chances")]];
GoocooSitCount goocooSitCounts[importantNums.numGoocooSitCounts] @ header.ptrs.goocooSitCounts [[name("Goocoo House-Sitting Counts")]];
GoocooSitModifier goocooSitPersonalityMods[importantNums.numGoocooSitPersonalityMods] @ header.ptrs.goocooSitPersonalityMods [[name("Goocoo House-Sitting Personality Modifiers")]];
GoocooSitModifier goocooSitMoodMods[importantNums.numGoocooSitMoodMods] @ header.ptrs.goocooSitMoodMods [[name("Goocoo House-Sitting Mood Modifiers")]];
GoocooSitRarity goocooSitFishRarity[importantNums.numGoocooSitFishRarity] @ header.ptrs.goocooSitFishRarity [[name("Goocoo House-Sitting Fish Rarity")]];
GoocooSitRarity goocooSitBugsRarity[importantNums.numGoocooSitBugsRarity] @ header.ptrs.goocooSitBugsRarity [[name("Goocoo House-Sitting Bugs Rarity")]];
GoocooSitRarity goocooSitJunkRarity[importantNums.numGoocooSitJunkRarity] @ header.ptrs.goocooSitJunkRarity [[name("Goocoo House-Sitting Junk Rarity")]];
GoocooSitRarity goocooSitBargainsRarity[importantNums.numGoocooSitBargainsRarity] @ header.ptrs.goocooSitBargainsRarity [[name("Goocoo House-Sitting Bargains Rarity")]];
GoocooSitGrade goocooSitGrades[importantNums.numGoocooSitGrades] @ header.ptrs.goocooSitGrades [[name("Goocoo House-Sitting Grades")]];
GoocooSitMoodItem goocooSitMoodItems[importantNums.numGoocooSitMoodItems] @ header.ptrs.goocooSitMoodItems [[name("Goocoo House-Sitting Mood Items")]];

// =======================
// Remodelling: the pieces of kind 0 / 1 / 2 (bed / pool / ground), their
// names and texts, the series names and the cost of each series
// =======================

struct GoocooRemodelPiece {
    u16 index;
    u16 unk02;
    u8  kind;
    u8  unk05;
    u16 unk06;
    u32 unk08;
};

GoocooRemodelPiece goocooRemodelBeds[importantNums.numGoocooRemodelBeds] @ header.ptrs.goocooRemodelBeds [[name("Goocoo Remodel Beds")]];
GoocooRemodelPiece goocooRemodelPools[importantNums.numGoocooRemodelPools] @ header.ptrs.goocooRemodelPools [[name("Goocoo Remodel Pools")]];
GoocooRemodelPiece goocooRemodelGrounds[importantNums.numGoocooRemodelGrounds] @ header.ptrs.goocooRemodelGrounds [[name("Goocoo Remodel Grounds")]];
s32p goocooBedNames[importantNums.numGoocooBedNames] @ header.ptrs.goocooBedNames [[name("Goocoo Bed Names")]];
s32p goocooPoolNames[importantNums.numGoocooPoolNames] @ header.ptrs.goocooPoolNames [[name("Goocoo Pool Names")]];
s32p goocooGroundNames[importantNums.numGoocooGroundNames] @ header.ptrs.goocooGroundNames [[name("Goocoo Ground Names")]];
s32p goocooBedTexts[importantNums.numGoocooBedTexts] @ header.ptrs.goocooBedTexts [[name("Goocoo Bed Texts")]];
s32p goocooPoolTexts[importantNums.numGoocooPoolTexts] @ header.ptrs.goocooPoolTexts [[name("Goocoo Pool Texts")]];
s32p goocooGroundTexts[importantNums.numGoocooGroundTexts] @ header.ptrs.goocooGroundTexts [[name("Goocoo Ground Texts")]];
s32p goocooSeriesNames[importantNums.numGoocooSeriesNames] @ header.ptrs.goocooSeriesNames [[name("Goocoo Series Names")]];

// Goocoo quests (header 0x474, Wii U slot 0x49C): one 0-terminated quest id
// list per Goocoo quest type (the index). getOpenDuckQuestTypeBit opens type n
// when bit n is set: 0 egg quests (farm scenario byte 3, 0x17 or 0x1D), 1 the
// search quest (farm state +0x2D == 2), 2 scenario 6, 3 scenario 0x10, 4 food
// quests (farm flag 3). getDuckQuestType / lb_duck_quest_chk / IsDuckQuest look
// a quest id up (the readers loop to a fixed 5); make_duck_quest_list copies the
// open lists for the quest counter. On clear, duck_quest_clr_chk stores a type 0
// quest's position in list 0 as the egg type (farm state +0x21, held to 5) and
// runs setQuestClearDuckLeaveScenario for type 1.
struct GoocooQuestList {
    u16 questIds[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

struct GoocooQuestListPtr {
    GoocooQuestList *list : u32;
};

GoocooQuestListPtr goocooQuestLists[importantNums.numGoocooQuestLists] @ header.ptrs.goocooQuestLists [[name("Goocoo Quest Lists"), comment("Index = Goocoo quest type")]];

// =======================
// Exchange and costs. Item 0 in a cost is My Tore points.
// =======================

struct GoocooItemCount {
    u16 item                    [[format("getItemName")]];
    u16 count;
};

struct GoocooExchangeCost {
    u16 item                    [[format("getItemName")]];
    u16 count;
    u16 flags                   [[comment("Bit 0: must be owned")]];
};

fn goocooLabel(u32 p) {
    if (p == 0) return "(the name of the first item received)";
    return rPS(p);
};

struct GoocooExchange {
    u32 label                   [[format("goocooLabel")]];
    GoocooItemCount received[6];
    GoocooExchangeCost costs[6];
};

GoocooExchange goocooExchanges[importantNums.numGoocooExchanges] @ header.ptrs.goocooExchanges [[name("Goocoo Exchanges")]];
GoocooItemCount goocooClothesCosts[importantNums.numGoocooClothesCosts] @ header.ptrs.goocooClothesCosts [[name("Goocoo Clothes Costs"), comment("Per clothing series")]];
GoocooItemCount goocooRemodelCosts[importantNums.numGoocooRemodelCosts] @ header.ptrs.goocooRemodelCosts [[name("Goocoo Remodel Costs"), comment("Per remodel set")]];

// =======================
// Goocoo Pot
// =======================

struct GoocooPotMaterial {
    u16 item                    [[format("getItemName")]];
    u8  type                    [[comment("Category filter")]];
    u8  band;
    u8  quantity                [[comment("Needed")]];
    u8  soups                   [[comment("Count of each of the 3 Gook Soups")]];
    u16 welldoneItem            [[format("getItemName"), comment("Default well-done item (getWelldoneItem)")]];
    u16 welldoneItemColumn      [[comment("Column of goocooPotWelldoneItems; 12 or more: no swap")]];
    u16 bonusItem               [[format("getItemName")]];
    u8  welldoneQuantity        [[comment("Quantity of welldoneItem")]];
    u8  secretBookQuantity      [[comment("Quantity of the Secret Book item; 0: no swap")]];
    u16 bonusChance             [[comment("Percent")]];
};

GoocooPotMaterial goocooPotMaterials[importantNums.numGoocooPotMaterials] @ header.ptrs.goocooPotMaterials [[name("Goocoo Pot Materials")]];

// Goocoo Pot well-done items (header 0x4B8): one row per weapon class
// (className order, row = PlayerWork hidenBookNo - 1), 14 rows, no count (the
// rows fill the gap to header 0x4C0). getWelldoneItem swaps a pot material's
// well-done item (welldoneItem x welldoneQuantity) for item [welldoneItemColumn]
// of the equipped Secret Book's class (x secretBookQuantity) when the column is
// below 12, secretBookQuantity is set, a book is equipped and: columns 0-3, the
// equipped book's SR is at least 1 / 31 / 100 for band 3 / 4 / 5; columns 4-7,
// GR at least 500; columns 8-11, the book's GSR at least 1. Columns 7 and 11
// repeat 6 and 10; no material uses them.
struct GoocooPotWelldoneItems {
    ItemId soul[4]   [[comment("Columns 0-3, SR bands 3 / 4 / 5")]];
    ItemId merit[4]  [[comment("Columns 4-7, GR 500")]];
    ItemId ribbon[4] [[comment("Columns 8-11, book GSR 1")]];
} [[name(className(std::core::array_index()))]];

GoocooPotWelldoneItems goocooPotWelldoneItems[14] @ header.ptrs.goocooPotWelldoneItems [[name("Goocoo Pot Well-Done Items")]];
ItemId goocooPotSoups[3] @ header.ptrs.goocooPotSoups [[name("Goocoo Pot Soups"), comment("Thin, Tasty and Rich Gook Soup; the rest of the table is not mapped")]];

// Clothing series names (header 0x400): name 0 then one per clothing series
// (important numbers + 0x18E, numGoocooClothesCosts). The Goocoo clothing menu (FUN_1064C500) lists
// name 0 when FUN_1078FA10(0) (a bit of DLL table 0x118E19AC for the farm
// stage) is set and name i when bit i - 1 of save +0x1FE5C is set, 10 per page.
struct GoocooClothingSeriesName {
    std::string::NullString *name : u32;
} [[inline]];

GoocooClothingSeriesName goocooClothingSeriesNames[importantNums.numGoocooClothesCosts + 1] @ header.ptrs.goocooClothingSeriesNames [[name("Goocoo Clothing Series Names")]];

// Goocoo farm timers (header 0x4C4, important numbers + 0x1A0 u32 values),
// read by goocoo_farm_timers_update and initialize_npc_data: 4 timers (npc
// +0x4E8) start at random % interval and fire every interval seconds; each
// firing raises its counter (npc +0x508..+0x50B) up to counterCap. While a
// counter is above 0 and its flag (npc +0x4C0..+0x4CC) is set, one is spent to
// place an object (FUN_1078DD70) with that timer's slot value (stored at npc
// +0x49C; the values look like colours with alpha 0xFF).
struct GoocooFarmTimers {
    u32 interval [[comment("Seconds")]];
    u32 counterCap;
    u32 slotValues[4] [[comment("One per timer 0-3")]];
    u32 unk18;
};

GoocooFarmTimers goocooFarmTimers @ header.ptrs.goocooFarmTimers [[name("Goocoo Farm Timers")]];

// Goocoo farm harvests (header 0x4C8, goocoo_farm_harvest_roll): what a farm
// timer firing places (goocoo_farm_timers_update -> FUN_1078DD70). 4 farms
// (timers 0-3; the items are fish, mushrooms, honey and husks, bugs) x 5 rank
// bands: from the HR thresholds (hr_rank_threshold_table) bands 1-2 -> 0,
// 3-4 -> 1, 5 -> 2, 6-7 -> 3; G rank -> 4. A row is drawn by weight; an item
// or quantity of 0 gives nothing. The row lists start on 0x20 boundaries.
// Identical on the EN, JP and rain files.
struct GoocooFarmHarvestRow {
    ItemId item;
    u16 quantity;
    u8 weight;
    u8 unk05;
};

struct GoocooFarmHarvestBand {
    u32 count;
    GoocooFarmHarvestRow *rows[count] : u32;
};

struct GoocooFarmHarvestFarm {
    GoocooFarmHarvestBand bands[5] [[comment("HR bands 1-2, 3-4, 5, 6-7, then G rank")]];
};

GoocooFarmHarvestFarm goocooFarmHarvests[4] @ header.ptrs.goocooFarmHarvests [[name("Goocoo Farm Harvests")]];

// Goocoo group gathering (header 0x4A0 / 0x4B0): quest_complete_idle_update
// sets getFarmDuckStaticStruct() +0x2E; at the next garden start
// init_npc_subsystem_2 rolls n in [2, N] of the Goocoos present (FUN_10792820:
// profile +4 is 6 or 8-11), gives each a slot 0..n-1, rolls a spot set of
// 0x4A0 row [n - 2] (count / n sets) and adds a random [min, max] of 0x4B0 to
// each participant's profile +0x29 (kept in 0-100). Goocoo action 0x1A
// (FUN_107871D0) places the Goocoo at spot [set x n + slot]. When two or more
// reach 100, layEgg rolls an egg's skin (header 0x484 to 0x490).
struct GoocooGroupSpot {
    float x;
    float y;
    float z;
    u16 rotation;
    u16 unk0E [[comment("no reader")]];
};

struct GoocooGroupSpotList {
    s32 count [[comment("Participants x spot sets")]];
    GoocooGroupSpot *spots[count] : u32;
};

struct GoocooGroupGaugeGain {
    u8 min;
    u8 max;
};

GoocooGroupSpotList goocooGroupSpots[importantNums.numGoocooGroupSpotLists] @ header.ptrs.goocooGroupSpots [[name("Goocoo Group Spots"), comment("Row i: i + 2 participants")]];
GoocooGroupGaugeGain goocooGroupGaugeGain @ header.ptrs.goocooGroupGaugeGain [[name("Goocoo Group Gauge Gain")]];

// Goocoo talk items (header 0x4A4 / 0x4AC; Wii U getFarmDuckTalkItem /
// enableFarmDuckTalkItem, Wii U slots 0x4CC / 0x4D4): a Goocoo whose profile +4
// is 6-11 has a gift when its group gauge (profile +0x29, raised by the group
// gathering, 0x4B0) has passed a threshold of 0x4AC above its last paid one
// (profile +0x2A). moveEventFarmCareCatNoticeGetTalkItem01 runs
// getFarmDuckTalkItem for the 5 Goocoos: one row of 0x4A4 drawn by weight per
// threshold passed, the quantity cut to the room left (Lb_getItemStackEx), given
// by Item_into_any_pouch, and profile +0x2A set to the threshold.
struct GoocooTalkItem {
    ItemId item;
    u16 quantity [[comment("Given: min(quantity, room for the item)")]];
    u8 weight;
    u8 unk05 [[comment("no reader")]];
};

GoocooTalkItem goocooTalkItems[importantNums.numGoocooTalkItems] @ header.ptrs.goocooTalkItems [[name("Goocoo Talk Items")]];
u8 goocooTalkItemThresholds[importantNums.numGoocooTalkItemThresholds] @ header.ptrs.goocooTalkItemThresholds [[name("Goocoo Talk Item Thresholds"), comment("Group gauge (profile +0x29) values, ascending")]];

// Goocoo emote delays (header 0x4B4; Wii U updateEmote, Wii U slot 0x4DC): one
// row per mood (0-6, pCostumeShopTexts[6]; getFarmDuckMood, 3 on another
// hunter's farm). updateEmote shows an emote icon for (rand % 3 + 4) x 30 ticks,
// draws the next one (drawLotsEmoteIcon, DLL table 0x118E29E0) and waits before
// showing it (npc work +0x100): 1 tick when rand % 100 < instantChance, else a
// random [delayMin, delayMax] x 30 ticks.
struct GoocooEmoteDelay {
    s16 delayMin [[comment("x 30 ticks")]];
    s16 delayMax [[comment("x 30 ticks")]];
    u8 instantChance [[comment("Percent: the next icon shows after 1 tick")]];
    u8 unk05 [[comment("no reader")]];
};

GoocooEmoteDelay goocooEmoteDelays[importantNums.numGoocooEmoteDelays] @ header.ptrs.goocooEmoteDelays [[name("Goocoo Emote Delays"), comment("Row = mood")]];

// =======================
// Goocoo skins and stray Goocoos (header 0x480 to 0x490, 0x4D0 to 0x4E0).
// Every table is a list of u8 lot weights drawn by drawLotsSubFunction (roll r
// in [0, sum), the result is the first index whose running weight passes r).
// New Goocoo (updateEventFarmCareCatSubFunctionEgg): its skin (profile +5) is
// drawn from 0x480 row [farm state +0x21]. Egg (layEgg, when two Goocoos reach
// a group gauge of 100): each parent's skin -> class (0x484) -> score (0x488);
// row score A + score B of 0x48C (clamped to count - 1) draws a class; row
// (class A == drawn) + 2 x (class B == drawn) of 0x490 draws whether the egg
// (npc +0x385) takes parent A's skin, parent B's, or any skin of that class.
// Stray Goocoos: equipment mesh pair (0x4D0: row 0 My House, rows 1-2 the
// Workshop, rows 3-6 MyHawk; DLL pairs 0x11998B7C) and first action in My
// House (0x4D4), the Workshop (0x4D8 / 0x4DC, one weight cleared below HR 100)
// and the MyHawk area (stage 0x11B: 0x4E0 draws the layout).
// =======================
struct GoocooNewSkinLots {
    u8 skinWeights[5];
};

struct GoocooEggClassLots {
    u8 classWeights[6];
};

struct GoocooEggSkinSourceLots {
    u8 parentAWeight;
    u8 parentBWeight;
    u8 randomSkinWeight [[comment("Any skin of the drawn class, equal weights")]];
};

struct StrayGoocooEquipMeshLots {
    u8 meshPairWeights[5] [[comment("Index into the DLL pairs 0x11998B7C")]];
};

GoocooNewSkinLots goocooNewSkinLots[importantNums.numGoocooNewSkinLots] @ header.ptrs.goocooNewSkinLots [[name("Goocoo New Skin Lots"), comment("Row = farm state +0x21")]];
u8 goocooSkinClasses[importantNums.numGoocooSkinClasses] @ header.ptrs.goocooSkinClasses [[name("Goocoo Skin Classes"), comment("Class 0-5 of each skin")]];
u8 goocooSkinClassScores[6] @ header.ptrs.goocooSkinClassScores [[name("Goocoo Skin Class Scores"), comment("Index = class")]];
GoocooEggClassLots goocooEggClassLots[importantNums.numGoocooEggClassLots] @ header.ptrs.goocooEggClassLots [[name("Goocoo Egg Class Lots"), comment("Row = score A + score B")]];
GoocooEggSkinSourceLots goocooEggSkinSourceLots[importantNums.numGoocooEggSkinSourceLots] @ header.ptrs.goocooEggSkinSourceLots [[name("Goocoo Egg Skin Source Lots")]];

StrayGoocooEquipMeshLots strayGoocooEquipMeshLots[7] @ header.ptrs.strayGoocooEquipMeshLots [[name("Stray Goocoo Equip Mesh Lots"), comment("No count: rows 0-6 are constants in the readers")]];
u8 strayGoocooMyHouseActionLots[importantNums.numStrayGoocooMyHouseActions] @ header.ptrs.strayGoocooMyHouseActionLots [[name("Stray Goocoo My House Action Lots"), comment("Actions: DLL 0x11999A80")]];
u8 strayGoocooWorkshopActionLots0[importantNums.numStrayGoocooWorkshopActions0] @ header.ptrs.strayGoocooWorkshopActionLots0 [[name("Stray Goocoo Workshop Action Lots 0"), comment("Actions: DLL 0x11999C10; [3] is 0 below HR 100")]];
u8 strayGoocooWorkshopActionLots1[importantNums.numStrayGoocooWorkshopActions1] @ header.ptrs.strayGoocooWorkshopActionLots1 [[name("Stray Goocoo Workshop Action Lots 1"), comment("Actions: DLL 0x11999C38; [1] is 0 below HR 100")]];
u8 strayGoocooMyHawkLayoutLots[importantNums.numStrayGoocooMyHawkLayouts] @ header.ptrs.strayGoocooMyHawkLayoutLots [[name("Stray Goocoo MyHawk Layout Lots"), comment("Layout L: stray i action DLL 0x11999E30[L x 4 + i]")]];
