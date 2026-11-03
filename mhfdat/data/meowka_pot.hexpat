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
