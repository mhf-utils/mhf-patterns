#pragma once

#include <mhfgao/utils/index.pat>

struct CraftMaterial {
    u16 itemId;
    u16 count;
    padding[4];
};

struct ForgingRecipe {
    u8 equipType;
    u8 purchasable;
    u16 equipId;
    CraftMaterial materials[4];
    u16 unk24;
    padding[2];
    u16 hrRequired;
    u16 unk2A;
    u8 previewable;
    padding[3];
    u8 unk30;
    padding[3];
    u8 unk34;
    padding[3];
};

Rows<ForgingRecipe,header.armorForgingCount> pArmorForging @ header.pArmorForging;
Rows<ForgingRecipe,header.premiumArmorForgingCount> pPremiumArmorForging @ header.pPremiumArmorForging;
Rows<ForgingRecipe,header.weaponForgingCount> pWeaponForging @ header.pWeaponForging;
Rows<ForgingRecipe,header.premiumWeaponForgingCount> pPremiumWeaponForging @ header.pPremiumWeaponForging;
