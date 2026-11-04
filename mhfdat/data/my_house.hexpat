#pragma once

#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// My House renovation themes (header 0x260, docs/reverse/my_house.md §3).
// Purchase costs `cost` GCP and sets bit theme - 1 of g_houseOwnedThemes;
// theme 0 is always owned. Each theme gives one model id per part
// (pFacilityRenovationTextGroups[0]), read by my_house_interior_set_part and
// the renovation menus.
// =======================

struct MyHouseThemeName {
    std::string::NullString *name : u32;
} [[inline]];

struct MyHouseTheme {
    MyHouseThemeName name;
    u32 cost [[comment("GCP")]];
    u16 floorWallCeiling;
    u16 tableSmall;
    u16 tableLarge;
    u16 kitchen;
    u16 bed;
    u16 bookshelf;
};

MyHouseTheme myHouseThemes[importantNums.numMyHouseThemes] @ header.ptrs.myHouseThemes [[name("My House Themes")]];
