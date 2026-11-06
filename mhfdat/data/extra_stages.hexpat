#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Extra stages (header 0x4E4, Wii U slot 0x50C). checkExtraStage (Wii U name)
// tells whether a stage id is in the list. drawLotsStrayStage draws the stage
// pl_stray_stage moves the player to, from the current stage, the stages
// linked to the quest map (code table 0x11A45C70) and the other players'
// stages (Map Edit stages 0xD4-0xDB skipped): a player holding the Gook Amulet
// (item 0x1273) gets a random listed candidate when there is one, else any
// other candidate, else the current stage.
// =======================
u16 extraStages[importantNums.numExtraStages] @ header.ptrs.extraStages [[name("Extra Stages")]];
