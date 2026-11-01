#pragma once

#include <mhfgao/utils/index.pat>

struct MytraAdventureRow {
    u16 requiredLevel;
    u16 unk02;
    u16 cost;
    u16 pad;
    u32 unk08;
    u32 unk0C;
};

struct MytraCatMixRow {
    u16 key;
    u16 count;
    u32 entries[3];
};

struct MytraCatMixRows {
    MytraCatMixRow r[while(rd16($) != 0)];
    u16 end;
};

struct CatDecoMaterial {
    u16 itemId;
    u8 count;
    u8 requireOwned;
};

struct CatDecoRecipe {
    u16 resultItemId;
    u16 pad;
    CatDecoMaterial materials[4];
};

Rows<CatDecoRecipe,header.catDecoRecipeCount> pCatDecoRecipes @ header.pCatDecoRecipes;
Rows<MytraAdventureRow,56> pMytraAdventures @ header.pMytraAdventures;
U16List pMytraShopItems0 @ header.pMytraShopItems0;
U16List pMytraShopItems1 @ header.pMytraShopItems1;
U16List pMytraShopItems2 @ header.pMytraShopItems2;
U16List pMytraShopItems3 @ header.pMytraShopItems3;
MytraCatMixRows pMytraCatMixRows0 @ header.pMytraCatMixRows0;
MytraCatMixRows pMytraCatMixRows1 @ header.pMytraCatMixRows1;
MytraCatMixRows pMytraCatMixRows2 @ header.pMytraCatMixRows2;
MytraCatMixRows pMytraCatMixRows3 @ header.pMytraCatMixRows3;
