#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Stamp card rewards (header 0xB74, important numbers + 0x416 rows; mhfpac
// pQuestResultTexts [234] "Stamp Card Reward", [236] "%s x %d"). After a quest
// clear that earns stamps (GetStampNum), ntCheck_stampcard_stamp_begin fills
// reward pair rewardSlot (1 or 2; a later matching row wins) from each row
// whose rank range holds the G rank (G rank > 0, rankKind != 1) or the HR
// (G rank 0, rankKind != 2), and sends both pairs with the HR, G rank and
// stamps in MSG_MHF_STAMPCARD_STAMP (CSync_man::putExe_Stamcard_stamp, 0xE5).
// The server picks the reward; setResultScreenStampItem prints the item and
// quantity of its reply. A card holds 30 stamps.
// =======================
struct StampCardReward {
    u16 rankMin;
    u16 rankMax;
    u8 rewardSlot [[comment("Packet reward pair 1 or 2")]];
    u8 unk05 [[comment("no reader, 0")]];
    u16 unk06 [[comment("Sent to the server; the reply word it comes back in is never read. 10 everywhere")]];
    u16 item [[format("getItemName")]];
    u16 quantity;
    u16 rankKind [[comment("1 = HR rows (G rank 0), 2 = G rank rows; another value matches both")]];
};

StampCardReward stampCardRewards[importantNums.numStampCardRewards] @ header.ptrs.stampCardRewards [[name("Stamp Card Rewards")]];
