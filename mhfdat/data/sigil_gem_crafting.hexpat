#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Sigil and gem crafting recipes (header 0x99C and 0x9C8). Same 20-byte rows,
// each list ends at a result of 0 (the fill functions stop there).
// 0x99C: 10 sigil recipes (Sharp UP Sigil ...), the list of
// tower_armor_stone_craft_fill_recipes / tower_armor_stone_craft_dispatch. The
// EN file alone has 63 more sigil recipes after the end row (+224: Fire Sigil
// from Ancient Gold Shard ...); no header slot points to them and the list
// stops before them.
// 0x9C8: 50 gem recipes (Herbal Science Gem ...), the list of
// tower_weapon_stone_craft_fill_recipes / tower_weapon_stone_craft_dispatch;
// header value 0x9C4 = 51 = its rows with the end row (no reader found).
// A recipe is listed when craft_recipe_unlock_flags_ok passes. Price: the
// result's buyPrice / 2 (at least 1) per craft, in zenny, or in the save
// currency ctx +0x1FE44 for an isGz result (gem list check); at most 99 crafts
// and 999 results owned. Identical on the EN, JP and rain files.
// =======================

struct CraftRecipeMaterial {
    ItemId item;
    u8 quantity [[comment("Per craft")]];
    u8 mustOwn [[comment("When Seisan_flag_ck passes, the recipe is hidden unless inventory_query_item_owned says owned")]];
};

struct CraftRecipe {
    ItemId result;
    u16 unk02;
    CraftRecipeMaterial materials[4];
};

struct CraftRecipeList {
    CraftRecipe recipes[while(std::mem::read_unsigned($, 2) != 0)];
    u8 end[20];
};

CraftRecipeList sigilCraftRecipes @ header.ptrs.sigilCraftRecipes [[name("Sigil Craft Recipes")]];
CraftRecipeList gemCraftRecipes @ header.ptrs.gemCraftRecipes [[name("Gem Craft Recipes")]];
