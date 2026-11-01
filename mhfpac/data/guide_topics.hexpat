#pragma once

#include <mhfpac/utils/index.pat>

struct GuideTopic {
    u32 conditionCase;
    u16 altConditionCase;
    u16 unk06;
    u16 bodyPageCount;
    u16 unk0A;
    u32 bodyTextIndex;
    Str title;
};

struct GuideTopics {
    GuideTopic t[while(rd32($ + 0x10) != 0)];
    u8 end[0x14];
};

struct GuideTopicsRef {
    GuideTopics *topics : u32;
};

struct GuideTopicTables {
    GuideTopicsRef e[while(rd32($) != 0)];
    u32 end;
};

struct JumboArticle {
    u32 condition;
    u32 flag;
    Str title;
    Str text;
};

struct JumboArticleTableRef {
    u32 index = ($ - header.ptrs.pJumboArticleTables) / 4;
    u32 n = rd16(header.ptrs.pJumboArticleCounts + index * 2);
    Rows<JumboArticle, n> *table : u32;
};

Rows<JumboArticleTableRef,6> pJumboArticleTables @ header.ptrs.pJumboArticleTables;
GuideTopicTables pGuideTopicTables @ header.ptrs.pGuideTopicTables;
GuideTopicTables pFacilityGuideTopicTables @ header.ptrs.pFacilityGuideTopicTables;
GuideTopicTables pLoreGuideTopicTables @ header.ptrs.pLoreGuideTopicTables;
GuideTopicTables pDailyGuideTopicTables @ header.ptrs.pDailyGuideTopicTables;
