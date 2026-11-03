#pragma once

/**
	Item lists the client checks an item against.
	Protected items (header 0x33C, important numbers + 0xEA rows, 6756 on ZZ):
	monsters cannot steal them from the pouch, daily missions do not ask for
	them, and a few other pouch scans skip them (tickets, medals, quest
	parts...). Only the item id is read.
	Box search filters (entry 0 = no filter): item icons (header 0x34C,
	important numbers + 0xEC), decoration items (0x350, + 0xEE), skill trees
	(0x354, + 0xF0; a piece matches when it has points in the tree) and Zenith
	skills (0x358, + 0xF2; matched against the piece's zenithSkill).
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct ProtectedItem {
    u16 item                    [[format("getItemName")]];
    u16 unk02[4];
};

ProtectedItem protectedItems[importantNums.numProtectedItems]
    @ header.ptrs.protectedItems
    [[name("Protected Items")]];

u8 boxSearchIcons[importantNums.numBoxSearchIcons] @ header.ptrs.boxSearchIcons [[name("Box Search: Item Icons")]];
ItemId boxSearchDecorations[importantNums.numBoxSearchDecorations] @ header.ptrs.boxSearchDecorations [[name("Box Search: Decorations")]];
u16 boxSearchSkillTrees[importantNums.numBoxSearchSkillTrees] @ header.ptrs.boxSearchSkillTrees [[name("Box Search: Skill Trees")]];
u16 boxSearchZenithSkills[importantNums.numBoxSearchZenithSkills] @ header.ptrs.boxSearchZenithSkills [[name("Box Search: Zenith Skills")]];
