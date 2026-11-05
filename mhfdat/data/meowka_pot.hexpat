#pragma once

/**
	Garden Meowka Pot recipes (header 0x200, important numbers + 0x50 of
	them, 76 on ZZ). The harvest takes the row whose first output is the
	pot's input and gives count x the item of the current color (white to
	rainbow). The Mocha Pot (quest) rewards are in part_breaks.hexpat.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct MeowkaPotOutput {
    u8  count;
    padding[1];
    u16 item                    [[format("getItemName")]];
};

struct MeowkaPotRecipe {
    u32 unk00;
    MeowkaPotOutput *outputs[7] : u32 [[comment("One per color, white to rainbow")]];
    u32 unk08                   [[comment("7 on ZZ")]];
};

MeowkaPotRecipe meowkaPotRecipes[importantNums.numMeowkaPotRecipes]
    @ header.ptrs.meowkaPotRecipes
    [[name("Meowka Pot Recipes")]];

// Farm cat quest-failure items (header 0x204, 0x208, 0x20C, 0x210; Wii U
// Lb_farmcat_check_fail_talk). A quest that ends without a clear sets ctx
// +0x22C08 bit 0x400000. In the player's own My House, Lb_farmcat_init (NPC
// dialogue case 0x94, menu mode 0x54) calls Lb_farmcat_check_fail_talk: with
// the bit set, the cat draws one uniform random row of the list for the
// hunter's tier (hr_rank_threshold_table: HR 1, 2-30, 31-50, 51-99; nothing
// from HR 100). After the talk Lb_farmcat clears the bit and
// lb_help_cat_item_set gives count x item. Item ids are stored inverted; the
// counts are u16 value counts (2 per row).
fn farmCatFailItem(u16 v) { return getItemName(u16(~v)); };

struct FarmCatFailItem {
    u16 item [[format("farmCatFailItem"), comment("Stored as ~item id")]];
    u16 count;
};

FarmCatFailItem farmCatFailItemsHr1[importantNums.numFarmCatFailItemsHr1Values / 2] @ header.ptrs.farmCatFailItemsHr1 [[name("Farm Cat Fail Items HR 1")]];
FarmCatFailItem farmCatFailItemsHr2[importantNums.numFarmCatFailItemsHr2Values / 2] @ header.ptrs.farmCatFailItemsHr2 [[name("Farm Cat Fail Items HR 2-30")]];
FarmCatFailItem farmCatFailItemsHr31[importantNums.numFarmCatFailItemsHr31Values / 2] @ header.ptrs.farmCatFailItemsHr31 [[name("Farm Cat Fail Items HR 31-50")]];
FarmCatFailItem farmCatFailItemsHr51[importantNums.numFarmCatFailItemsHr51Values / 2] @ header.ptrs.farmCatFailItemsHr51 [[name("Farm Cat Fail Items HR 51-99")]];
