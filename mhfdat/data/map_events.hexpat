#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Map variant layouts (header 0x808): the map event of maps 0x40 / 0x41
// (map_instantiate_event, vtable 0x119A574C; no Wii U twin) has 16 event spots
// (DLL table 0x116154B0: 3 spots on stage 363, 5 on 365, 4 on 367, 4 on 369,
// each {s16 stage, s16 base event, s16 index}). Row = quest mapVariant, used
// only when below importantNums.numMapVariantRows (else every spot reads 0).
// A spot's value v gives the event base + [0x11615510][v] (v 0 / 1: no event,
// v 2-10: + 0-8), requested on every NSO object and set in the event bits:
// CEventMap40_Init at start, CEventMap40_SpotTimerMain when a spot's respawn
// timer (0x1518 frames, started by FUN_11385970 on events 9, 0x27, 0x59, 0x81,
// 0x8B) runs out, CEventMap40_GetLayoutValue for one spot.
// =======================

struct MapVariantLayout {
    s8 spots[16] [[comment("Value per event spot (MOVSX): 0 / 1 none, 2-10 = event variant 0-8 added to the spot's base event")]];
};

MapVariantLayout mapVariantLayouts[importantNums.numMapVariantRows] @ header.ptrs.mapVariantLayouts [[name("Map Variant Layouts")]];
