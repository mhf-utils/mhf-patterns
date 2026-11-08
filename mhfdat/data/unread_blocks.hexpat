#pragma once

#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Header 0x4FC, 0x590, 0x6BC, 0x6F4, 0x71C, 0x720: the same bytes on the 3
// files. No reader on HD (no read through the mhfdat global) or Wii U (slots
// 0x528, 0x5BC, 0x6B8, 0x6F0, 0x718, 0x71C); only rd_mhfdat relocates them.
// Row counts from important numbers +0x1B6, +0x1F8, +0x26A, +0x286, +0x28A,
// +0x28C (between the counts of the neighbour slots); widths from the bytes.
// =======================

struct Header4FCRow {
    u32 unk00;
    float unk04;
    u32 unk08;
    u32 unk0C;
    float unk10;
    u32 unk14[7];
};

struct Header590Row {
    u32 unk00;
    u32 unk04;
    u32 unk08;
    u32 unk0C;
};

struct Header6BCRow {
    s32 unk00;
    s32 unk04;
    s32 unk08[9] [[comment("Values, a 0, then -1 to the end of the row")]];
};

struct Header6F4Row {
    u16 unk00[4];
};

struct Header720Row {
    u16 unk00[6];
};

Header4FCRow header4FCRows[importantNums.num4FCRows] @ header.ptrs.hd_dll_af5ce4 [[name("Header 0x4FC Rows")]];
Header590Row header590Rows[importantNums.num590Rows] @ header.ptrs.hd_dll_af669a [[name("Header 0x590 Rows"), comment("Row 0 is zero; a zero row follows the last one")]];
Header6BCRow header6BCRows[importantNums.num6BCRows] @ header.ptrs.hd_dll_af706a [[name("Header 0x6BC Rows")]];
Header6F4Row header6F4Rows[importantNums.num6F4Rows] @ header.ptrs.hd_dll_af73d7 [[name("Header 0x6F4 Rows")]];
u16 header71CValues[importantNums.num71CValues] @ header.ptrs.hd_dll_af7723 [[name("Header 0x71C Values")]];
Header720Row header720Rows[importantNums.num720Rows] @ header.ptrs.hd_dll_af7729 [[name("Header 0x720 Rows")]];

// =======================
// Header 0x82C, 0x8BC, 0x914, 0x9F4, 0xA68, 0xB08: the same bytes on the 3
// files. No reader on HD (no read through the mhfdat global; the Wii U header
// has no slot this far). rd_mhfdat relocates all but 0x82C, which holds a file
// offset it never adds the base to. Counts: important numbers +0x30A (0x82C,
// next to the +0x304-+0x308 counts of the Guild Hall extra item lists 0x820-
// 0x828 it follows), +0x34C (0x8BC), +0x36C (0x914; rd_mhfdat relocates +4 of
// each row), data counters +0 (0xB08); 0x9F4 and 0xA68 fill the gap to the
// next table exactly. Widths from the bytes.
// =======================

struct Header8BCRow {
    if (std::mem::read_unsigned($, 4) != 0)
        std::string::NullString *unk00 : u32 [[comment("Relocated by rd_mhfdat when non-zero")]];
    else
        u32 unk00;
    u16 unk04;
    u16 unk06;
};

struct Header914Entry {
    u32 unk00;
    u32 unk04;
    u32 unk08;
    u32 unk0C;
    u32 unk10;
    float unk14;
    u16 unk18;
    u16 unk1A;
};

struct Header914Row {
    u32 unk00;
    u32 n = std::mem::read_unsigned($ + 4, 4);
    Header914Entry *unk04[n] : u32 [[comment("Relocated by rd_mhfdat; points right after the row; the 28 bytes after the entry are 0")]];
    u32 unk08 [[comment("1: the entries at unk04 (widths of the header 0x918 sound rows)")]];
};

u16 header82CValues[importantNums.num82CValues] @ header.ptrs.header82C [[name("Header 0x82C Values"), comment("All 0xF98B (~0x0674, stored like the 0x820-0x828 lists)")]];
Header8BCRow header8BCRows[importantNums.num8BCRows] @ header.ptrs.hd_dll_af7cec [[name("Header 0x8BC Rows"), comment("105 rows hold a code string (APP_MHHQ, APP_MHX, DDO, BOF6 ...) and unk04 33-670; rows 97-196 hold unk06 1-100; the rest 0")]];
Header914Row header914Rows[importantNums.num914Rows] @ header.ptrs.hd_dll_af818f [[name("Header 0x914 Rows")]];
u32 header9F4Value @ header.ptrs.hd_dll_af86f0 [[name("Header 0x9F4 Value"), comment("0 on the 3 files")]];
u16 headerA68Values[10] @ header.ptrs.hd_dll_af87fe [[name("Header 0xA68 Values"), comment("0xAE, 0, 0, 0, 0xAF, 0xB0, 0xB1, 0xFFFF, 0, 0")]];
u8 headerB08Values[std::mem::read_unsigned(header.ptrs.dataCounters, 2)] @ header.ptrs.hd_dll_af8f07 [[name("Header 0xB08 Values"), comment("82 ascending ids 1-0xB0, then 14 zero bytes")]];
