#pragma once

/**
	Halk food (header 0x510, important numbers + 0x1C0 of them, 1,157 on ZZ):
	what each material gives the Halk. Feeding n of a food adds row x n to
	each of the 9 point counters (capped at 100) and to the fullness (0-100).
	The tier is the feed menu tab.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum HalkFoodCategory : u8 {
    Other        = 0,
    BirdWyvern   = 1,
    FlyingWyvern = 2,
    FangedBeast  = 3,
    Piscine      = 4,
    Carapaceon   = 5,
    ElderDragon  = 6,
    Misc         = 7,
    Herbivore    = 8,
    Neopteron    = 9,
    BruteWyvern  = 10,
    Leviathan    = 11
};

struct HalkFood {
    u16 item                    [[format("getItemName")]];
    HalkFoodCategory category   [[comment("Labels from the item names")]];
    u8  tier                    [[comment("1-4")]];
    u8  none;
    u8  fire;
    u8  water;
    u8  thunder;
    u8  ice;
    u8  dragon;
    u8  poison;
    u8  sleep;
    u8  paralysis;
    s8  fullness;
    padding[2];
};

HalkFood halkFoods[importantNums.numHalkFoods] @ header.ptrs.halkFoods [[name("Halk Foods")]];

// Halk skill book order (header 0xA78, header 0xA74 ids): the display order of
// the Halk skill book list. halk_book_list_build keeps the ids whose bit is set
// in the owned-book save bits (ctx 0x2132C) and that are not one of the Halk's
// 3 equipped books, 7 per page; each id is printed with pHalkTacticNames.
u16 halkSkillBookOrder[header.ptrs.halkSkillBookOrderCount] @ header.ptrs.halkSkillBookOrder [[name("Halk Skill Book Order")]];
