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

// Box search sigil skills (header 0x718): the choices of the two Special
// Effect System filters of the Sigil Search panel (lb_itembox_search_plate_disp,
// pItemBoxTexts 0x44 / 0x45). A filter holds an index here: 0 = all, 1 = free
// text, else this entry, a sigil skill id that one of the sigil's skills must
// equal (lb_itembox_search_eq_plate_skill_chk). Entries 0 and 1 are
// placeholders.
u16 boxSearchSigilSkills[importantNums.numBoxSearchSigilSkills] @ header.ptrs.boxSearchSigilSkills [[name("Box Search: Sigil Skills"), comment("Sigil skill ids (mhfpac +0xC44 names), display order")]];

// Shortcut combine blocked actions (header 0x650): sorted category 0 player
// action types (binary search, shortcut_combine_action_is_blocked); a combine
// shortcut slot (type 2) is disabled while the player is in one of them
// (shortcut_combine_slot_is_disabled, from ShortcutMove, the item HUD and the
// pause menu), e.g. roll, draw / sheathe, eating and drinking, sharpening,
// BBQ, throwing knives.
u16 shortcutCombineBlockedActions[importantNums.numShortcutCombineBlockedActions] @ header.ptrs.shortcutCombineBlockedActions [[name("Shortcut Combine Blocked Actions"), comment("Player actType (actCategory 0)")]];
