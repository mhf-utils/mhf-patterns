#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/s32p.pat>

// =======================
// Combine shop (NPC menu, lb_mix_type_init): six recipe tables of 0x30-byte
// rows (ComboShop), one per shop type: 1 pays in P (0x264), 2 in CP (0x268),
// 3 to 6 in zenny (0x26C, 0xAEC, 0xB84, 0xBAC; the last three are named after
// what they make: 0xAEC Raw Soul / Ribbon / Merit, 0xB84 Hiden items, 0xBAC the
// weapon Soul / Ribbon / Merit Masses and Hiden Jewels). The menu shows 7 rows
// per page (Wii U lb_mix_type_init / mix_pageInit_ex).
// Row: output item, fee per combine (P / CP / zenny; the CP fee is halved for
// the account flag of 0x119DE00C), recipeCount, then 3 recipes {min, max: items
// made per combine, min + rand % (max - min + 1) (Item_preparation_ex); 3 x
// {item, quantity used per combine}}. Recipes past recipeCount are not read.
// Types 1 and 2 do not list their whole table: they list the daily lineup
// 0x270 / 0x274 [day % count] (rows of 0x264 / 0x268), the day counting from
// 2009-07-24 03:00 UTC (Lb_mix_ex_update prints "Today's Combos
// Updated" when it changes), then the 1 to 3 rows of the first timed bonus of
// 0x278 / 0x27C whose month, day and time window hold the server time (local
// time; start <= now < end, in minutes of the day).
// =======================

struct ComboShop{
	u16 Itemid [[format("getItemName")]];
	u16 Combo_fee;
	u16 recipeCount [[comment("Recipes offered, 1-3 (HD copies the low byte, Wii U mix_pageInit lhz)")]];
	u8 Recipe1_min1 [[
		name("Recipe 1 Min")
		]];
	u8 Recipe1_max2 [[
		name("Recipe 1 Max")
	]];
	u16 Recipe1_Itemid1 [[
		format("getItemName"),
		name("Recipe 1 Item ID 1")
	]];
	u16 Recipe1_Itemid_Qty1 [[name("Recipe 1 Item Id Qty 1")]];

	u16 Recipe1_Itemid2 [[
		format("getItemName"),
		name("Recipe 1 Item ID 2")
	]];
	u16 Recipe1_Itemid_Qty2 [[name("Recipe 1 Item Id Qty 2")]];

	u16 Recipe1_Itemid3 [[
		format("getItemName"),
		name("Recipe 1 Item ID 3")
	]];
	u16 Recipe1_Itemid_Qty3 [[name("Recipe 1 Item Id Qty 3")]];

	u8 Recipe2_min [[
		name("Recipe 2 Min")
		]];
	u8 Recipe2_max [[
		name("Recipe 2 Max")
	]];
	
	u16 Recipe2_Itemid1 [[
		format("getItemName"),
		name("Recipe 2 Item ID 1")
	]];
	u16 Recipe2_Itemid_Qty1 [[name("Recipe 2 Item Id Qty 1")]];

	u16 Recipe2_Itemid2 [[
		format("getItemName"),
		name("Recipe 2 Item ID 2")
	]];
	u16 Recipe2_Itemid_Qty2 [[name("Recipe 2 Item Id Qty 2")]];

	u16 Recipe2_Itemid3 [[
		format("getItemName"),
		name("Recipe 2 Item ID 3")
	]];
	u16 Recipe2_Itemid_Qty3 [[name("Recipe 2 Item Id Qty 3")]];

	u8 Recipe3_min [[
		name("Recipe 3 Min")
		]];
	u8 Recipe3_max [[
		name("Recipe 3 Max")
		]];

	u16 Recipe3_Itemid1 [[
		format("getItemName"),
		name("Recipe 3 Item ID 1")
	]];
	u16 Recipe3_Itemid_Qty1 [[name("Recipe 3 Item Id Qty 1")]];

	u16 Recipe3_Itemid2 [[
		format("getItemName"),
		name("Recipe 3 Item ID 2")
	]];
	u16 Recipe3_Itemid_Qty2 [[name("Recipe 3 Item Id Qty 2")]];

	u16 Recipe3_Itemid3 [[
		format("getItemName"),
		name("Recipe 3 Item ID 3")
	]];
	u16 Recipe3_Itemid_Qty3 [[name("Recipe 3 Item Id Qty 3")]];

};

fn combineRecipeItem(u32 table, s16 row) {
    if (row < 0) return "none";
    return std::format("row {} | {}", row, getItemName(std::mem::read_unsigned(table + row * 0x30, 2)));
};

struct CombineRow<auto Kind> {
    s16 row [[comment("Row of the point (0x264) or CP (0x268) recipes; -1 = none")]];
} [[format("combineRowName")]];

fn combineRowName(ref auto r) {
    if (r.Kind == 0) return combineRecipeItem(header.ptrs.combinePointRecipes, r.row);
    return combineRecipeItem(header.ptrs.combineCpRecipes, r.row);
};

struct CombineDailyLineup<auto Kind> {
    CombineRow<Kind> rows[while(std::mem::read_signed($, 2) != -1)];
    s16 end;
};

struct CombineDailyLineupPtr<auto Kind> {
    CombineDailyLineup<Kind> *lineup : u32;
};

struct CombineTimedBonus<auto Kind> {
    u8 month;
    u8 day;
    u8 startHour;
    u8 startMinute;
    u8 endHour;
    u8 endMinute;
    CombineRow<Kind> extraRows[3] [[comment("Shown after the daily lineup")]];
} [[format("combineTimedBonusName")]];

fn combineTimedBonusName(ref auto b) {
    return std::format("{:02d}-{:02d} {:02d}:{:02d}-{:02d}:{:02d}", b.month, b.day, b.startHour, b.startMinute, b.endHour, b.endMinute);
};

ComboShop combinePointRecipes[88] @ header.ptrs.combinePointRecipes [[name("Combine Point Recipes"), comment("No count: 88 rows fill the block; the lineups use rows 0-87")]];
ComboShop combineCpRecipes[140] @ header.ptrs.combineCpRecipes [[name("Combine CP Recipes"), comment("No count: 140 rows fill the block; the lineups use rows 0-139")]];
ComboShop combineZennyRecipes[importantNums.numCombineZennyRecipes] @ header.ptrs.combineZennyRecipes [[name("Combine Zenny Recipes")]];
ComboShop combineSoulRecipes[importantNums.numCombineSoulRecipes] @ header.ptrs.combineSoulRecipes [[name("Combine Soul Recipes"), comment("Raw Soul / Ribbon / Merit")]];
ComboShop combineHidenRecipes[importantNums.numCombineHidenRecipes] @ header.ptrs.combineHidenRecipes [[name("Combine Hiden Recipes")]];
ComboShop combineMassJewelRecipes[importantNums.numCombineMassJewelRecipes] @ header.ptrs.combineMassJewelRecipes [[name("Combine Mass and Hiden Jewel Recipes")]];
CombineDailyLineupPtr<0> combinePointDailyLineups[importantNums.numCombinePointDailyLineups] @ header.ptrs.combinePointDailyLineups [[name("Combine Point Daily Lineups")]];
CombineDailyLineupPtr<1> combineCpDailyLineups[importantNums.numCombineCpDailyLineups] @ header.ptrs.combineCpDailyLineups [[name("Combine CP Daily Lineups")]];
CombineTimedBonus<0> combinePointTimedBonuses[importantNums.numCombinePointTimedBonuses] @ header.ptrs.combinePointTimedBonuses [[name("Combine Point Timed Bonuses")]];
CombineTimedBonus<1> combineCpTimedBonuses[importantNums.numCombineCpTimedBonuses] @ header.ptrs.combineCpTimedBonuses [[name("Combine CP Timed Bonuses")]];
