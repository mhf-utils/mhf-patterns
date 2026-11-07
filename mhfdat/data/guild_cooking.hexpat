#pragma once

/**
	Guild cooking: the recipes (header 0x868, important numbers + 0x324 of
	them, 720 on ZZ), the cooking minigame profile of each ingredient (header
	0x86C, important numbers + 0x326, 27 on ZZ) and the random skill pools
	(header 0x89C, important numbers + 0x33C, 4 on ZZ).
	A recipe matches when its main ingredient comes first and the 3 others
	match in any order (no match falls back to row 0). The result is 1 plus
	the thresholds the score reaches (at least 2), or a great failure when
	the heat ends in the red zone; the skill is skill[result - 1], or a random
	skill of pool[result - 1] for recipe 0.
	The minigame (frames 60 to 360) scores 300 per frame in the blue zone and
	100 in the green one. The difficulty (recipe grade + main ingredient
	difficulty, 0 to 10) indexes a client table of green zone width changes
	and threshold percents (100 to 150).
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct GuildCookingRecipe {
    u16 dish                    [[comment("Index in mhfpac's guild cooking dish names")]];
    u16 mainIngredient          [[format("getItemName")]];
    ItemId otherIngredients[3];
    s16 grade;
    s32 gaugeThreshold1;
    s32 gaugeThreshold2;
    s32 gaugeThreshold3;
    u16 skillGreatFailure;
    u16 skillFailure;
    u16 skillSuccess;
    u16 skillGreatSuccess;
    u16 unk20;
    u16 unk22;
};

GuildCookingRecipe guildCookingRecipes[importantNums.numGuildCookingRecipes]
    @ header.ptrs.guildCookingRecipes
    [[name("Guild Cooking Recipes")]];

// The zone starts at one of 3 options (picked at random) and spans width
struct GuildCookingHeatZone {
    s16 startOptions[3];
    s16 width;
};

struct GuildCookingIngredient {
    u16 item                    [[format("getItemName")]];
    s16 difficulty;
    GuildCookingHeatZone greatSuccessZone;
    GuildCookingHeatZone successZone;
    GuildCookingHeatZone greatFailureZone;
};

GuildCookingIngredient guildCookingIngredients[importantNums.numGuildCookingIngredients]
    @ header.ptrs.guildCookingIngredients
    [[name("Guild Cooking Ingredients")]];

struct GuildCookingSkillPool {
    s32 count;
    u16 *skills[count] : u32;
};

GuildCookingSkillPool guildCookingSkillPools[importantNums.numGuildCookingSkillPools]
    @ header.ptrs.guildCookingSkillPools
    [[name("Guild Cooking Skill Pools")]];
