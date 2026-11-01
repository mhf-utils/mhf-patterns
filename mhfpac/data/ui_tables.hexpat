#pragma once

#include <mhfpac/utils/index.pat>

struct StagePoint {
    u8 kind;
    u8 unk01;
    u16 objectId;
    s16 linkedObjects[9];
    u16 unk16;
    float x;
    float y;
    float z;
    Str name;
};

struct StagePointRow {
    u32 stageId;
    u32 pointCount;
    Rows<StagePoint, pointCount> *points : u32;
};

struct PanelData {
    u32 type;
    s32 width;
    s32 height;
    u32 direction;
    s32 margin[4];
    s32 innerPadding[4];
    s32 unk48;
    u32 color;
    u32 stringerType;
    s32 stringId;
    s32 unk64[2];
    s32 unk72;
    u32 id;
    s32 unk80[4];
};

struct PanelDataTableRef {
    u32 index = ($ - header.ptrs.pPanelData) / 4;
    u32 n = rd8(header.ptrs.pPanelDataCounts + index);
    Rows<PanelData, n> *table : u32;
};

struct WallpaperRow {
    u32 wallpaperId;
    u32 unk04;
    u32 flags;
    u32 sefPacEntry;
    u32 sortKey;
    u32 conditionKind;
    u32 monsterId;
    u32 requiredCount;
    u32 unk20;
    u32 unk24;
    u32 listFlags;
};

struct WallpaperColorTableRef {
    u32 index = ($ - header.ptrs.pWallpaperColors) / 4;
    u32 n = rd32(header.ptrs.pWallpaperColorCounts + index * 4);
    U32s<n> *colors : u32;
};

struct Han2ZenChar {
    char sjis[2];
} [[sealed, format("fmt_han2zen")]];

fn fmt_han2zen(ref Han2ZenChar c) { return c.sjis; };

U16s<64> pSectionCounts @ header.ptrs.pSectionCounts;
U16s<18> pEventScreenLineCounts @ header.ptrs.pEventScreenLineCounts;
U16s<32> pEventCodeStateValues @ header.ptrs.pEventCodeStateValues;
U16s<5> pGalleryHelpPageCounts @ header.ptrs.pGalleryHelpPageCounts;
U16s<5> pKeyNameCounts @ header.ptrs.pKeyNameCounts;
U16s<6> pJumboArticleCounts @ header.ptrs.pJumboArticleCounts;
Words<24> unk12C @ header.ptrs.unk12C;
Rows<Han2ZenChar,128> pHan2ZenTable @ header.ptrs.pHan2ZenTable;
Rows<StagePointRow,count(0x1A)> pStagePointRows @ header.ptrs.pStagePointRows;
Rows<PanelDataTableRef,count(0x22)> pPanelData @ header.ptrs.pPanelData;
U8s<count(0x22)> pPanelDataCounts @ header.ptrs.pPanelDataCounts;
Rows<WallpaperRow,count(0x24)> pWallpaperRows @ header.ptrs.pWallpaperRows;
Rows<WallpaperColorTableRef,count(0x25)> pWallpaperColors @ header.ptrs.pWallpaperColors;
U32s<count(0x25)> pWallpaperColorCounts @ header.ptrs.pWallpaperColorCounts;
