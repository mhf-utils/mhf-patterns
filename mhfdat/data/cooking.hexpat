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

// =======================
// Cooking recipes (header 0x568). cooking_recipe_find looks the 3 ingredients
// up in rows 0-15 (any order) and returns 16 when none matches; rows 16-18 have
// no ingredients. cooking_recipe_effects_get (row < 0x13) decodes the effects
// shown as pCookingTexts "Health", "Stamina", Atk / Def Up / Down. The
// ingredients are stored XOR 0xA55A and the effects with small offsets.
// =======================

struct CookingRecipe {
    u8 nameGroup [[comment("pCaravanTextGroups group of the dish name")]];
    u8 taste [[comment("pDishTasteTexts index")]];
    u16 ingredients[3] [[comment("Item id XOR 0xA55A; 0xA55A: none")]];
    s8 healthCode [[comment("Health = -7 - healthCode")]];
    u8 staminaCode [[comment("Stamina = cookingStatTiers[(code ^ 5) & 0xF], negative when (code ^ 0xAF) & 0xF0")]];
    s8 attackCode [[comment("Attack = attackCode + 3")]];
    s8 defenseCode [[comment("Defense = defenseCode + 3")]];
};

CookingRecipe cookingRecipes[19] @ header.ptrs.cookingRecipes [[name("Cooking Recipes")]];

// =======================
// Cooking menu layout (header 0x58C), read by the dish order / result menus
// (0x103E6500-0x103EA270). Entry 0 is the panel origin, entries 1 and 2 the y of
// the two separator bars (cooking_menu_panel_draw), the others text positions
// drawn by cooking_menu_text_draw (colour | 0xFF000000, font size).
// =======================

struct CookingMenuLayoutEntry {
    s16 x;
    padding[2];
    s16 y;
    padding[2];
    u32 color;
    u8 fontSize;
    padding[7];
};

CookingMenuLayoutEntry cookingMenuLayout[22] @ header.ptrs.cookingMenuLayout [[name("Cooking Menu Layout")]];
