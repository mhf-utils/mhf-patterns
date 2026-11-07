#pragma once

/**
	Item lists the client checks an item against.
	Protected items (header 0x33C, important numbers + 0xEA rows, 6756 on ZZ):
	monsters cannot steal them from the pouch, daily missions do not ask for
	them, and a few other pouch scans skip them (tickets, medals, quest
	parts...). Only the item id is read.
	Box search filters (header 0x34C-0x358, counts important numbers +
	0xEC-0xF2): the item box search keeps a choice index per filter, 0 = no
	filter. Item icons (0x34C): the item's icon must equal the entry
	(lb_itembox_search_item); entry 0 (0xFF) is only drawn. For decorations
	(0x350), skill trees (0x354) and Zenith skills (0x358) choice 1 = free text,
	so entries 0 and 1 are placeholders. Decorations: one of the piece's 3
	slotted decorations is that item. Skill trees (pSkillTreeNames ids): one of
	an armor piece's 5 skill tree ids (whatever the points) or a skill of one of
	its decorations equals the entry, weapons through decorations only
	(lb_itembox_search_eq_skill_chk). Zenith skills (pZenithSkillNames ids): the
	tree (+0) of the piece's zenithSkills row (header 0xAA8) must equal the entry
	(equip_has_zenith_skill). Skill trees and Zenith skills: only the low byte is
	compared. The forge search reads them too (lb_kako_search_armor; skill
	trees also lb_kako_search_gem).
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
// BBQ, throwing knives. rd_mhfdat sorts the list at load (insertion sort,
// unsigned), so the file order does not matter.
u16 shortcutCombineBlockedActions[importantNums.numShortcutCombineBlockedActions] @ header.ptrs.shortcutCombineBlockedActions [[name("Shortcut Combine Blocked Actions"), comment("Player actType (actCategory 0)")]];

// Fishing baits (header 0x780; Wii U esa_ck): which fish a bait attracts.
// esa_ck takes the float owner's item (work +0xB32): item 0x91 attracts
// nothing, an item with no row attracts every fish, else the first row with
// that item decides (no list = every fish, an empty list = none, else the
// fish's kind byte, fish work +0x48, read signed, must be in the list).
// uki_serch makes a fish swim to a float
// only when esa_ck passes and the float is inside its radius and angle window.
struct FishingBaitFishList {
    u16 fishKinds[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

struct FishingBait {
    u16 item [[format("getItemName")]];
    u16 unk02 [[comment("no reader, 0")]];
    if (std::mem::read_unsigned($, 4) != 0)
        FishingBaitFishList *fishKinds : u32 [[comment("Null = every fish")]];
    else
        u32 fishKinds [[comment("Null = every fish")]];
};

FishingBait fishingBaits[importantNums.numFishingBaits] @ header.ptrs.fishingBaits [[name("Fishing Baits")]];

// Cat Decoration search skill categories (header 0x908): the Skill System A / B
// choices of the Cat Decoration crafting search (partnyaa_deco_search_disp,
// pItemBoxSearchTitles 0x1D / 0x1E), mhfgao pSkillCategoryNames ids in display
// order. 0 = all, 1 = free text, else partnyaa_deco_search_matches keeps a
// recipe when one of its result item's decoration skills equals the entry.
// Entries 0 and 1 are placeholders.
u16 catDecoSearchSkillCategories[importantNums.numCatDecoSearchSkillCategories] @ header.ptrs.catDecoSearchSkillCategories [[name("Cat Decoration Search: Skill Categories")]];
