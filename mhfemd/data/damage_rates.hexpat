#pragma once

#include <mhfemd/utils/index.pat>

struct EmDamageRateRow {
    u16 rate[8];
    u16 monsterId;
};

EmDamageRateRow damageRates[counts.damageRateRowCount] @ header.pDamageRates [[name("Damage Rates")]];
