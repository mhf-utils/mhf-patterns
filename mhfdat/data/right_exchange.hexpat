#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Right exchange (header 0x9AC; shop mode 6, mhfpac pRightExchangeTexts):
// rights bought with Gold Koban G. right_exchange_list_build lists only row 0
// (the Daily Quest Right) and the list buys only at cursor 0; the detail panel
// of shop_draw_list_and_detail prints any row (name and period with amount,
// restriction with dailyLimit, rank line with hrAllowed / grAllowed).
// right_exchange_check refuses when the Koban are below price, a right is
// already held or today's count (save +0x23B25) reached row 0 dailyLimit.
// The texts hold 7 rows; row 7 is all zero.
// =======================
struct RightExchange {
    u32 price [[comment("Gold Koban G")]];
    u32 amount [[comment("Count, days or minutes in the name and period texts")]];
    u32 dailyLimit;
    u8 hrAllowed [[comment("Index into the x / o list of the HR line")]];
    u8 grAllowed [[comment("Same, GR line")]];
    padding[2];
};

RightExchange rightExchanges[8] @ header.ptrs.rightExchanges [[name("Right Exchanges")]];
