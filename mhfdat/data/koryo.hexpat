#pragma once

#include <std/mem.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Koryo (功猟) points: monster points (header 0xB40, below) and lottery prizes
// (header 0xB38; mhfpac pKoryoRewardTexts:
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

// Koryo points by monster (header 0xB40, importantNums.numKoryoMonsterPoints
// rows; koryo_monster_points_get): at quest end koryo_quest_points_sum adds,
// for every large monster, (slain + captured, quest work +0x228 / +0x38A) x
// its points; the quest result lists them by monster. The first row of a
// monster wins (monster 145 has two rows, 500 and 800). The points are doubled
// in UL mode (g_quest_ul_mode).
fn koryoMonster(s16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct KoryoMonsterPoints {
    s16 monster [[format("koryoMonster")]];
    u16 points [[comment("In town, or on a G rank field quest")]];
    u16 pointsLowRank [[comment("On a field quest that is not G rank")]];
    u16 pointsZenith[4] [[comment("HagiLv 9 (Zenith), by quest_get_zenith_star_tier 0-3")]];
};

KoryoMonsterPoints koryoMonsterPoints[importantNums.numKoryoMonsterPoints] @ header.ptrs.koryoMonsterPoints [[name("Koryo Monster Points")]];

// Koryo Porta Card Exchange items (header 0xB3C; Koryo menu entry 6, mhfpac
// pKoryoRewardTexts[0x15] "Porta Card Exchange"): the pouch items the exchange
// takes, until 0. koryo_porta_exchange_item_ok (item 1-0x413C) is the only
// reader: koryo_porta_exchange_pouch_pick refuses an item that is not listed
// (and the list draw greys it); koryo_porta_exchange_step then swaps the whole
// stack for the same quantity of item 0x1F28 when the pouch has room
// (pKoryoRewardTexts [0x1C] / [0x1D]). The list holds the same 224 items as the
// lottery prize lists above.
struct KoryoPortaExchangeItems {
    ItemId items[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

KoryoPortaExchangeItems koryoPortaExchangeItems @ header.ptrs.koryoPortaExchangeItems [[name("Koryo Porta Card Exchange Items")]];
