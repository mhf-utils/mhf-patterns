#pragma once

#include <mhfpac/utils/index.pat>

struct PlayerNameColorEntry {
    u32 color;
    Str name;
};

struct UnlockNoticeRow {
    u8 conditionType;
    u8 unk01;
    u16 conditionValue;
    u32 resultPacEntry;
    Str title;
    Str text;
};

struct HairStyleRow {
    u16 styleId;
    u16 price;
    Str name;
    Str text;
    u16 confirmGroup;
    u16 unk0E;
};

struct CostumeRow {
    Str name;
    s32 eventFlagId;
    u32 unk08;
};

struct CostumeRows {
    CostumeRow r[while(rd32($) != 0)];
    u32 end;
};

struct CookingRecipeGroup {
    u32 rowCount;
    StrRow<9> rows[5];
};

Rows<UnlockNoticeRow,count(0x1B)> pUnlockNoticeRows @ header.ptrs.pUnlockNoticeRows;
Rows<PlayerNameColorEntry,count(0x1C)> pPlayerNameColors @ header.ptrs.pPlayerNameColors;
Rows<HairStyleRow,count(0x0E)> pHairStyleRows @ header.ptrs.pHairStyleRows;
CostumeRows pCostumeRows @ header.ptrs.pCostumeRows;
Rows<CookingRecipeGroup,3> pCookingRecipeRows @ header.ptrs.pCookingRecipeRows;
