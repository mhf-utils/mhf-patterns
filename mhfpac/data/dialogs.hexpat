#pragma once

#include <mhfpac/utils/index.pat>

struct DialogTextEntry {
    u32 type;
    Str text;
};

struct MessageRow {
    u8 speaker;
    u8 nextIndex;
    u8 altIndex;
    u8 windowKind;
    Str text;
};

struct MessageRows {
    MessageRow r[while(rd8($) != 0xFF)];
    u8 end;
};

struct TitlePair {
    Str name;
    Str text;
};

struct TalkRow {
    Str text;
    u8 kind;
    u8 nextIndex;
    u8 altIndex;
    u8 unk07;
    u32 unk08;
};

struct QuestScenarioTalk {
    u32 speaker;
    Str text;
};

struct QuestScenarioTalkTable {
    QuestScenarioTalk e[while(rd32($ + 4) != 0)];
    u32 endSpeaker;
    u32 end;
};

struct QuestScenarioTalkRef {
    if (valid(rd32($)))
        QuestScenarioTalkTable *table : u32;
    else
        u32 none;
};

struct ClanHallHelpRow {
    Str title;
    StrListRef items;
    StrListRef texts;
    u32 unk0C;
    Str text;
    u32 urlIndex;
    u32 unk18;
};

struct Em10TalkRow {
    u8 type;
    u8 value;
    u8 nextRow2;
    u8 action3Branch;
    u8 textKind;
    u8 wait;
    u8 unk06;
    u8 unk07;
    Str text;
};

struct HelpSubItem {
    u32 unk00;
    Str a;
    Str b;
};

struct HelpItem {
    u32 subN = rd32($ + 8);
    Str name;
    Rows<HelpSubItem, subN> *subs : u32;
    u32 subCount;
};

struct HelpItems {
    HelpItem i[while(rd32($) != 0)];
    u32 end;
};

struct U16ListFF {
    u16 v[while(rd8($) != 0xFF)];
    u8 end;
};

struct HelpPageRow {
    Str file;
    Str title;
    HelpItems *items : u32;
    Str extra;
    U16ListFF *pages : u32;
    u32 urlIndex;
};

struct HunterNaviStep {
    u32 unk00;
    Str text;
};

struct HunterNaviTask {
    u32 stepN = rd32($ + 12);
    Str title;
    Str text;
    Rows<HunterNaviStep, stepN> *steps : u32;
    u32 stepCount;
};

struct HunterNaviTasks {
    HunterNaviTask t[while(rd32($) != 0)];
    u32 end;
};

struct HunterNaviCourseRow {
    Str name;
    Str title;
    HunterNaviTasks *tasks : u32;
};

Rows<DialogTextEntry,count(0x02)> pDialogTexts @ header.ptrs.pDialogTexts;
Rows<MessageRow,count(0x03)> pEm10MessageRows @ header.ptrs.pEm10MessageRows;
if (valid(header.ptrs.pQuestNpcMessageRows_0))
    MessageRows pQuestNpcMessageRows_0 @ header.ptrs.pQuestNpcMessageRows_0;
if (valid(header.ptrs.pQuestNpcMessageRows_1))
    MessageRows pQuestNpcMessageRows_1 @ header.ptrs.pQuestNpcMessageRows_1;
if (valid(header.ptrs.pQuestNpcMessageRows_2))
    MessageRows pQuestNpcMessageRows_2 @ header.ptrs.pQuestNpcMessageRows_2;
if (valid(header.ptrs.pQuestNpcMessageRows_3))
    MessageRows pQuestNpcMessageRows_3 @ header.ptrs.pQuestNpcMessageRows_3;
if (valid(header.ptrs.pQuestNpcMessageRows_4))
    MessageRows pQuestNpcMessageRows_4 @ header.ptrs.pQuestNpcMessageRows_4;
if (valid(header.ptrs.pNpcPartyMessageRows_0))
    MessageRows pNpcPartyMessageRows_0 @ header.ptrs.pNpcPartyMessageRows_0;
if (valid(header.ptrs.pNpcPartyMessageRows_1))
    MessageRows pNpcPartyMessageRows_1 @ header.ptrs.pNpcPartyMessageRows_1;
if (valid(header.ptrs.pNpcPartyMessageRows_2))
    MessageRows pNpcPartyMessageRows_2 @ header.ptrs.pNpcPartyMessageRows_2;
if (valid(header.ptrs.pNpcPartyMessageRows_3))
    MessageRows pNpcPartyMessageRows_3 @ header.ptrs.pNpcPartyMessageRows_3;
if (valid(header.ptrs.pNpcPartyMessageRows_4))
    MessageRows pNpcPartyMessageRows_4 @ header.ptrs.pNpcPartyMessageRows_4;
if (valid(header.ptrs.pNpcPartyMessageRows_5))
    MessageRows pNpcPartyMessageRows_5 @ header.ptrs.pNpcPartyMessageRows_5;
if (valid(header.ptrs.pNpcPartyMessageRows_6))
    MessageRows pNpcPartyMessageRows_6 @ header.ptrs.pNpcPartyMessageRows_6;
if (valid(header.ptrs.pNpcPartyMessageRows_7))
    MessageRows pNpcPartyMessageRows_7 @ header.ptrs.pNpcPartyMessageRows_7;
if (valid(header.ptrs.pNpcPartyMessageRows_8))
    MessageRows pNpcPartyMessageRows_8 @ header.ptrs.pNpcPartyMessageRows_8;
if (valid(header.ptrs.pNpcPartyMessageRows_9))
    MessageRows pNpcPartyMessageRows_9 @ header.ptrs.pNpcPartyMessageRows_9;
if (valid(header.ptrs.pNpcPartyMessageRows_10))
    MessageRows pNpcPartyMessageRows_10 @ header.ptrs.pNpcPartyMessageRows_10;
if (valid(header.ptrs.pNpcPartyMessageRows_11))
    MessageRows pNpcPartyMessageRows_11 @ header.ptrs.pNpcPartyMessageRows_11;
if (valid(header.ptrs.pNpcPartyMessageRows_12))
    MessageRows pNpcPartyMessageRows_12 @ header.ptrs.pNpcPartyMessageRows_12;
if (valid(header.ptrs.pNpcPartyMessageRows_13))
    MessageRows pNpcPartyMessageRows_13 @ header.ptrs.pNpcPartyMessageRows_13;
if (valid(header.ptrs.pNpcPartyMessageRows_14))
    MessageRows pNpcPartyMessageRows_14 @ header.ptrs.pNpcPartyMessageRows_14;
if (valid(header.ptrs.pNpcPartyMessageRows_15))
    MessageRows pNpcPartyMessageRows_15 @ header.ptrs.pNpcPartyMessageRows_15;
if (valid(header.ptrs.pNpcPartyMessageRows_16))
    MessageRows pNpcPartyMessageRows_16 @ header.ptrs.pNpcPartyMessageRows_16;
if (valid(header.ptrs.pNpcPartyMessageRows_17))
    MessageRows pNpcPartyMessageRows_17 @ header.ptrs.pNpcPartyMessageRows_17;
if (valid(header.ptrs.pNpcPartyMessageRows_18))
    MessageRows pNpcPartyMessageRows_18 @ header.ptrs.pNpcPartyMessageRows_18;
if (valid(header.ptrs.pNpcPartyMessageRows_19))
    MessageRows pNpcPartyMessageRows_19 @ header.ptrs.pNpcPartyMessageRows_19;
if (valid(header.ptrs.pNpcPartyMessageRows_20))
    MessageRows pNpcPartyMessageRows_20 @ header.ptrs.pNpcPartyMessageRows_20;
if (valid(header.ptrs.pNpcPartyMessageRows_21))
    MessageRows pNpcPartyMessageRows_21 @ header.ptrs.pNpcPartyMessageRows_21;
if (valid(header.ptrs.pNpcPartyMessageRows_22))
    MessageRows pNpcPartyMessageRows_22 @ header.ptrs.pNpcPartyMessageRows_22;
if (valid(header.ptrs.pNpcPartyMessageRows_23))
    MessageRows pNpcPartyMessageRows_23 @ header.ptrs.pNpcPartyMessageRows_23;
if (valid(header.ptrs.pNpcPartyMessageRows_24))
    MessageRows pNpcPartyMessageRows_24 @ header.ptrs.pNpcPartyMessageRows_24;
if (valid(header.ptrs.pNpcPartyMessageRows_25))
    MessageRows pNpcPartyMessageRows_25 @ header.ptrs.pNpcPartyMessageRows_25;
if (valid(header.ptrs.pNpcPartyMessageRows_26))
    MessageRows pNpcPartyMessageRows_26 @ header.ptrs.pNpcPartyMessageRows_26;
if (valid(header.ptrs.pNpcPartyMessageRows_27))
    MessageRows pNpcPartyMessageRows_27 @ header.ptrs.pNpcPartyMessageRows_27;
if (valid(header.ptrs.pNpcPartyMessageRows_28))
    MessageRows pNpcPartyMessageRows_28 @ header.ptrs.pNpcPartyMessageRows_28;
if (valid(header.ptrs.pNpcPartyMessageRows_29))
    MessageRows pNpcPartyMessageRows_29 @ header.ptrs.pNpcPartyMessageRows_29;
if (valid(header.ptrs.pNpcPartyMessageRows_30))
    MessageRows pNpcPartyMessageRows_30 @ header.ptrs.pNpcPartyMessageRows_30;
if (valid(header.ptrs.pNpcPartyMessageRows_31))
    MessageRows pNpcPartyMessageRows_31 @ header.ptrs.pNpcPartyMessageRows_31;
if (valid(header.ptrs.pNpcPartyMessageRows_32))
    MessageRows pNpcPartyMessageRows_32 @ header.ptrs.pNpcPartyMessageRows_32;
if (valid(header.ptrs.pNpcPartyMessageRows_33))
    MessageRows pNpcPartyMessageRows_33 @ header.ptrs.pNpcPartyMessageRows_33;
if (valid(header.ptrs.pNpcPartyMessageRows_34))
    MessageRows pNpcPartyMessageRows_34 @ header.ptrs.pNpcPartyMessageRows_34;
if (valid(header.ptrs.pNpcPartyMessageRows_35))
    MessageRows pNpcPartyMessageRows_35 @ header.ptrs.pNpcPartyMessageRows_35;
if (valid(header.ptrs.pNpcPartyMessageRows_36))
    MessageRows pNpcPartyMessageRows_36 @ header.ptrs.pNpcPartyMessageRows_36;
if (valid(header.ptrs.pNpcPartyMessageRows_37))
    MessageRows pNpcPartyMessageRows_37 @ header.ptrs.pNpcPartyMessageRows_37;
if (valid(header.ptrs.pNpcPartyMessageRows_38))
    MessageRows pNpcPartyMessageRows_38 @ header.ptrs.pNpcPartyMessageRows_38;
if (valid(header.ptrs.pNpcPartyMessageRows_39))
    MessageRows pNpcPartyMessageRows_39 @ header.ptrs.pNpcPartyMessageRows_39;
if (valid(header.ptrs.pNpcPartyMessageRows_40))
    MessageRows pNpcPartyMessageRows_40 @ header.ptrs.pNpcPartyMessageRows_40;
if (valid(header.ptrs.pNpcPartyMessageRows_41))
    MessageRows pNpcPartyMessageRows_41 @ header.ptrs.pNpcPartyMessageRows_41;
if (valid(header.ptrs.pNpcPartyMessageRows_42))
    MessageRows pNpcPartyMessageRows_42 @ header.ptrs.pNpcPartyMessageRows_42;
if (valid(header.ptrs.pNpcPartyMessageRows_43))
    MessageRows pNpcPartyMessageRows_43 @ header.ptrs.pNpcPartyMessageRows_43;
Rows<TitlePair,0x1A7> pTitleTexts @ header.ptrs.pTitleTexts;
Rows<HunterNaviCourseRow,14> pHunterNaviCourseRows @ header.ptrs.pHunterNaviCourseRows;
Rows<StrRow<3>,count(0x35)> pHunterNaviRankTexts @ header.ptrs.pHunterNaviRankTexts;
Rows<TalkRow,count(0x29)> pGuideFelyneTalkRows @ header.ptrs.pGuideFelyneTalkRows;
Rows<TalkRow,count(0x2A)> pArrivalTalkRows @ header.ptrs.pArrivalTalkRows;
Rows<TalkRow,count(0x2D)> pTowerLoreTalkRows @ header.ptrs.pTowerLoreTalkRows;
Rows<TalkRow,count(0x2E)> pRescuedFelyneTalkRows @ header.ptrs.pRescuedFelyneTalkRows;
Rows<QuestScenarioTalkRef,count(0x30)> pQuestScenarioTalkTables @ header.ptrs.pQuestScenarioTalkTables;
Rows<TalkRow,count(0x31)> pMasterTalkRows @ header.ptrs.pMasterTalkRows;
Rows<ClanHallHelpRow,count(0x32)> pClanHallHelpRows @ header.ptrs.pClanHallHelpRows;
Rows<Em10TalkRow,count(0x33)> pEm10TalkRowsMale @ header.ptrs.pEm10TalkRowsMale;
Rows<Em10TalkRow,count(0x34)> pEm10TalkRowsFemale @ header.ptrs.pEm10TalkRowsFemale;
Rows<TalkRow,count(0x36)> pFelyneThanksTalkRows @ header.ptrs.pFelyneThanksTalkRows;
Rows<HelpPageRow,count(0x37)> pHelpPageTable @ header.ptrs.pHelpPageTable;
