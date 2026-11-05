#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Koryo (功猟) point lottery prizes (header 0xB38; mhfpac pKoryoRewardTexts:
// White Lot, Draw Lot (%dP), Prize List). One pointer per lottery, lists 0 to
// importantNums.lastKoryoLotteryList (koryo_lottery_prize_list_get); a list
// ends at an item of 0 (koryo_lottery_prize_count). koryo_lottery_draw_step
// takes a row at random, each row with the same chance, pays the lottery's
// Koryo point cost (server values) through save_and_add_kouryou_point_seq_ex
// and gives the item; koryo_lottery_prize_list_draw shows the list (10 a page)
// and koryo_lottery_result_draw the won row. Identical on the EN, JP and rain
// files (the last pointer is 0).
// =======================

struct KoryoLotteryPrize {
    ItemId item;
    u16 quantity;
    u32 unk04;
};

struct KoryoLotteryPrizes {
    KoryoLotteryPrize prizes[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

struct KoryoLotteryPrizesPtr {
    if (std::mem::read_unsigned($, 4) != 0)
        KoryoLotteryPrizes *list : u32;
    else
        u32 none [[comment("No list (koryo_lottery_prize_count gives 0)")]];
};

KoryoLotteryPrizesPtr koryoLotteryPrizes[importantNums.lastKoryoLotteryList + 1] @ header.ptrs.koryoLotteryPrizes [[name("Koryo Lottery Prizes")]];
