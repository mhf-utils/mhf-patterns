#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Name display sizes (header 0x364, Wii U slot 0x388). The values the settings
// rows "NPC Name Display" and "Facility Name Display" offer (options 0x14 /
// 0x15, mhfpac pOptionItemNames [20] / [21], INI DISP_NPC_NAME_SIZE /
// DISP_FACILITY_NAME_SIZE). gMenuOptionMv (Wii U Menu_option_mv) binary-searches
// the current option byte in this ascending list and steps left / right
// through it; DisplaySettingText prints 0 as "OFF" (pOptionValueTexts [80] /
// [84]) and any other value with "%d". render_npc_name_tags and
// render_facility_interaction_icon use the value as the name size (0 = not
// drawn).
// =======================
u8 nameDisplaySizes[importantNums.numNameDisplaySizes] @ header.ptrs.nameDisplaySizes [[name("Name Display Sizes")]];
