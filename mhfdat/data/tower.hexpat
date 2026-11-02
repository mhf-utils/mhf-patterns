#pragma once

/**
	Tower weapons: the jewel recipes (header 0x938) and the upgrade cost tables
	(header 0x93C). Layouts from ezemania2/mhf-file-editor. Checked on the ZZ JP
	and EN files: 1,371 recipes (important numbers + 0x38A), the table ends
	where the next one starts; 65 cost tables of 100 steps, each followed by an
	all-zero step.
	The Tower sigil forging (header 0x944) is in crafting.hexpat.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct TowerJewelMaterial {
    u16 item                    [[format("getItemName")]];
    u16 quantity;
    u32 unk04;
};

struct TowerJewelRecipe {
    u16 jewel                   [[comment("Item id of the jewel (a \"PC\"); 63 distinct on ZZ, some above the item count")]];
    u16 levelMin;
    u16 levelMax;
    u8  stat;
    u8  equipType               [[format("getEquipType")]];
    TowerJewelMaterial materials[3];
};

TowerJewelRecipe towerJewelRecipes[importantNums.numTowerJewelRecipes]
    @ header.ptrs.towerJewelRecipes
    [[name("Tower Jewel Recipes")]];

// One upgrade step: ten (ok, cost) pairs, in this order: raw, gunner,
// affinity, element, seal 7, seal 5, seal 6, extra 5/6, extra C, extra B;
// then four bytes for bows. A table ends at an all-zero step.
struct TowerUpgradeCost {
    u8 okCost[20];
    u8 bow[4];
};

fn isZeroStep(u32 at) {
    u32 i = 0;
    while (i < 24) {
        if (std::mem::read_unsigned(at + i, 1) != 0) return false;
        i += 1;
    }
    return true;
};

struct TowerUpgradeCostTable {
    TowerUpgradeCost steps[while(!isZeroStep($))];
};

struct ptTowerUpgradeCostTable {
    TowerUpgradeCostTable *table : u32 [[inline]];
};

ptTowerUpgradeCostTable towerUpgradeCosts[while(std::mem::read_unsigned($, 4) != 0)]
    @ header.ptrs.towerUpgradeCosts
    [[name("Tower Weapon Upgrade Costs")]];
