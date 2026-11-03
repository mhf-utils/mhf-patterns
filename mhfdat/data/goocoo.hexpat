#pragma once

/**
	Goocoo (My Garden): food, house-sitting, personalities, remodelling, the
	exchange and the Goocoo Pot. Header 0x404 to 0x4C4, one count per table at
	important numbers + 0x146 to + 0x1A0, in header order. Only the tables the
	client code reads are shown; the others (header 0x438, 0x474, 0x480 to
	0x490, 0x4A0 to 0x4B8, 0x4C4) are not.

	House-sitting roll, in order: the mood item (0x434); the grade, from the
	trust plus the personality (0x418, by activity) and mood (0x41C)
	modifiers, through the score ranges of 0x430; whether anything is found
	(0x410); how many items (0x414); their rarity (0x420 to 0x42C, fish,
	bugs, junk, bargains); an item of 0x40C that has the activity flag, an
	unlocked band and the rolled rarity (item 8 when none has).
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <misc/s32p.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Food and personalities
// =======================

// Ferias' columns: trust, weight, intelligence, strength, patience, kindness
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
    u16 unk06;
    u16 unk08;
    u16 bonusItem               [[format("getItemName")]];
    u16 unk0C;
    u16 bonusChance             [[comment("Percent")]];
};

GoocooPotMaterial goocooPotMaterials[importantNums.numGoocooPotMaterials] @ header.ptrs.goocooPotMaterials [[name("Goocoo Pot Materials")]];
ItemId goocooPotSoups[3] @ header.ptrs.goocooPotSoups [[name("Goocoo Pot Soups"), comment("Thin, Tasty and Rich Gook Soup; the rest of the table is not mapped")]];
