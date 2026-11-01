#pragma once

#include <mhfpac/utils/index.pat>

struct KeyNameEntry {
    Str name;
    u32 value;
};

struct KeyNameTable<auto N> {
    KeyNameEntry e[N];
};

struct KeyNameTableRef {
    u32 index = ($ - header.ptrs.pKeyNameTables) / 4;
    u32 n = rd16(header.ptrs.pKeyNameCounts + index * 2);
    KeyNameTable<n> *table : u32;
};

struct KeyNameTables {
    KeyNameTableRef e[while(rd32($) != 0)];
    u32 end;
};

struct KeyConfigTreeRow {
    Str name;
    u32 padInput;
    u32 unk08;
    u32 unk0C;
    u8 unk10;
    u8 skipPadBind;
    u16 selectId;
    u32 id;
};

struct KeyConfigTreeRows {
    KeyConfigTreeRow r[while(rd32($) != 0)];
    u32 end;
};

struct KeyConfigTreeRowsRef {
    if (valid(rd32($)))
        KeyConfigTreeRows *rows : u32;
    else
        u32 none;
};

struct KeyConfigTree {
    KeyConfigTreeRowsRef tables[count(0x10)];
};

struct KeyConfigTreeRef {
    if (valid(rd32($)))
        KeyConfigTree *tree : u32;
    else
        u32 none;
};

struct KeyConfigRow {
    Str name;
    s16 actionGroup;
    s16 iconIndex;
    s16 iconX;
    u16 id;
    u16 typeId;
    u16 menuEnable;
};

struct KeyConfigRecord {
    u32 category;
    u32 flag;
    u32 unk08;
    u32 constant3;
    u32 unk10;
    u32 unk14;
    u32 padInput;
};

struct KeyConfigWideRecord {
    u32 unk00;
    u32 category;
    u32 bits08;
    u32 number0C;
    u32 unk10;
    u32 unk14;
    u32 bits18;
    u32 unk1C;
    u32 unk20;
};

struct KeyConfigRecordTableRef {
    u32 index = ($ - header.ptrs.pKeyConfigRecordTables) / 4;
    u32 n = rd8(header.ptrs.pKeyConfigRecordCounts + index);
    Rows<KeyConfigRecord, n> *table : u32;
};

struct InputSequenceRow {
    u8 inputs[16];
};

struct InputSequenceTableRef {
    u32 index = ($ - header.ptrs.pInputSequenceTables) / 4;
    u32 n = rd8(header.ptrs.pInputSequenceRowCounts + index);
    Rows<InputSequenceRow, n> *table : u32;
};

KeyNameTables pKeyNameTables @ header.ptrs.pKeyNameTables;
StrRows<2> pKeyActionTexts @ header.ptrs.pKeyActionTexts;
StrRows<2> pKeyActionTexts2 @ header.ptrs.pKeyActionTexts2;
Rows<KeyConfigTreeRef,5> pKeyConfigTrees @ header.ptrs.pKeyConfigTrees;
Rows<KeyConfigTreeRef,8> pKeyConfigTrees2 @ header.ptrs.pKeyConfigTrees2;
Rows<KeyConfigRow,count(0x11)> pKeyLayoutRows @ header.ptrs.pKeyLayoutRows;
Rows<KeyConfigRow,count(0x12)> pControlTypeRows @ header.ptrs.pControlTypeRows;
Rows<KeyConfigRow,count(0x13)> pPadLayoutRows @ header.ptrs.pPadLayoutRows;
Rows<KeyConfigRow,count(0x14)> pKeyConfigCategoryRows @ header.ptrs.pKeyConfigCategoryRows;
Rows<KeyConfigRecordTableRef,count(0x15)> pKeyConfigRecordTables @ header.ptrs.pKeyConfigRecordTables;
U8s<count(0x15)> pKeyConfigRecordCounts @ header.ptrs.pKeyConfigRecordCounts;
Rows<KeyConfigWideRecord,12> pKeyConfigRecords @ header.ptrs.pKeyConfigRecords;
Rows<InputSequenceTableRef,count(0x18)> pInputSequenceTables @ header.ptrs.pInputSequenceTables;
U8s<count(0x18)> pInputSequenceRowCounts @ header.ptrs.pInputSequenceRowCounts;
Group3 pKeyBindingNameGroups @ header.ptrs.pKeyBindingNameGroups;
