#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Bond bonus costs (header 0xA44). The quest counter menu of kind 0xC1 sells
// uses of "Ravi Bond Bonus" (mhfpac pQuestCounterTextGroups[1][0xA2]) for
// bond points (save ctx +0x23B8C, capped at 15000). bond_bonus_get_cost
// returns bondPointCost of the row the code range table 0x11887770 gives the
// kind (rows [0, 1)): max uses = min(points / cost, 9, 9 - held uses), the
// menu is refused when points < cost, and a purchase subtracts cost x uses.
// Bytes +0x02 to +0x13 have no reader.
// =======================
struct BondBonusCost {
    s16 bondPointCost [[comment("Read signed: bond_bonus_get_max_uses movsx + idiv, bond_bonus_info_draw / FUN_10392D80 cwde + jge")]];
    u8 unk02[0x12];
};

BondBonusCost bondBonusCosts[1] @ header.ptrs.bondBonusCosts [[name("Bond Bonus Costs")]];
