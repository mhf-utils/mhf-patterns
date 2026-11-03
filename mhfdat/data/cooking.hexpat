#pragma once

/**
	Cooking (the kitchen meal): ingredient categories (header 0x188, a list
	of lists ending at a null pointer), the stat each category value goes to
	(0x18C, 11 categories), the stat value of each tier (0x190) and the 16
	special cooked dishes (0x558).
	A pair of ingredients adds two signed values per ingredient to two stats;
	each total gives a tier 0-5 (|points| < 6, < 11, < 16, < 21, <= 25, > 25)
	and the tier's value keeps the total's sign.
	A special dish's effect bytes are encoded: health = -7 - (s8) byte 8,
	stamina = dishStamina[(byte 9 ^ 5) & 0xF] (negative when
	(byte 9 ^ 0xAF) & 0xF0 is not 0), attack = byte 10 + 3, defense =
	byte 11 + 3.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

enum MealStat : u8 {
    Stamina = 0,
    Health  = 1,
    Attack  = 2,
    Defense = 3,
    None    = 4
};

struct CookingIngredientValues {
    s8 first;
    s8 second;
};

// 3 variants of the pair; which one is used is set by the caller (not traced)
struct CookingIngredient {
    u16 item                    [[format("getItemName")]];
    CookingIngredientValues variants[3];
};

struct CookingCategory {
    CookingIngredient ingredients[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

ptVar<CookingCategory> cookingCategories[while(std::mem::read_unsigned($, 4) != 0)]
    @ header.ptrs.cookingCategories
    [[name("Cooking Ingredient Categories")]];

struct CookingCategoryStats {
    MealStat first;
    MealStat second;
};

CookingCategoryStats cookingCategoryStats[11] @ header.ptrs.cookingCategoryStats [[name("Cooking Category Stats")]];

struct CookingStatTiers {
    s16 stamina[6];
    s16 health[6];
    s16 attack[6];
    s16 defense[6];
    s16 dishStamina[6]          [[comment("Special dishes' stamina")]];
};

CookingStatTiers cookingStatTiers @ header.ptrs.cookingStatTiers [[name("Cooking Stat Tiers")]];

struct CookedDish {
    u8  name                    [[comment("Index in mhfpac's cooking dish names")]];
    u8  taste;
    u16 unk02[3];
    u8  healthEncoded;
    u8  staminaEncoded;
    u8  attackMinus3;
    u8  defenseMinus3;
};

CookedDish cookedDishes[16] @ header.ptrs.cookedDishes [[name("Special Cooked Dishes")]];
