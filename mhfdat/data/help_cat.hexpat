#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Help cat items (header 0x218, important numbers + 0x5C rows; Wii U
// lb_help_cat_*). Lb_help_cat_init (NPC dialogue cases 0xA2 / 0xC5, menu mode
// 0x74) tries a gift in the player's own My House or when the NPC menu kind is
// 0xC5. lb_help_cat_check_item: NPC kinds 0x8E-0x91 give only while their save
// bit (ctx +0x22C08 bits 0x40000 to 0x200000) is set and clear it; other kinds
// always give. lb_help_cat_choose_item picks a uniform random row among those
// with minHr <= HR (row 0 when none); lb_help_cat_item_set adds count x item
// to the pouch, the rest to the item box (pFarmTaskTexts [7] "Got %s").
// =======================
struct HelpCatItem {
    s8 minHr [[comment("Eligible when <= HR; -1 on every ZZ row")]];
    u8 count;
    u16 item [[format("getItemName")]];
};

HelpCatItem helpCatItems[importantNums.numHelpCatItems] @ header.ptrs.helpCatItems [[name("Help Cat Items")]];
