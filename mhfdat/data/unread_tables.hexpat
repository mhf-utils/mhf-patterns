#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Header slots with no reader: nothing reads them through the mhfdat global on
// HD or on Wii U. Shapes from rd_mhfdat (HD) and the Wii U rd_mhfdat
// (0x0253ED44), whose endian types give the widths (0xE s16, 0x10 u16, 0x14
// u32). The same bytes on the EN, JP and rain files unless noted.
// 0x118 / 0x11C: Wii U slots 0x11C / 0x120; both loaders stop at the first
// row whose first value is 0xFFFF.
// 0x170 - 0x17C: not relocated; file offsets of 4 texts, the rest of each gap
// is zero. The JP file has other bytes in the first 4 of 0x170 (0) and 0x174
// (0x00036DC2); the name tables before them end where they start.
// 0x1CC / 0x1D0: Wii U slots 0x1F4 / 0x1F8 (counts +0x9A / +0x9C there).
// 0x21C / 0x220: Wii U slots 0x24C / 0x250; the Wii U loader swaps u16 values
// up to a 0.
// =======================

struct Header118Pair {
    u16 unk00;
    u16 unk02;
};

struct Header118Pairs {
    Header118Pair rows[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    Header118Pair end;
};

struct Header11CTriple {
    s16 unk00;
    s16 unk02;
    s16 unk04;
};

struct Header11CTriples {
    Header11CTriple rows[while(std::mem::read_signed($, 2) != -1)];
    Header11CTriple end;
};

struct UnreadU16List {
    u16 values[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

Header118Pairs header118Pairs @ header.ptrs.hd_dll_af4e0f [[name("Header 0x118 Pairs")]];
Header11CTriples header11CTriples @ header.ptrs.hd_dll_af4e3a [[name("Header 0x11C Triples")]];
char header170Text[11] @ header.ptrs.unk_0x170 [[name("Header 0x170 Text"), comment("2018/12/14 (EN, rain)")]];
char header174Text[11] @ header.ptrs.unk_0x174 [[name("Header 0x174 Text"), comment("2019/02/06 (EN, rain)")]];
char header178Text[11] @ header.ptrs.unk_0x178 [[name("Header 0x178 Text"), comment("2019/02/06")]];
char header17CText[11] @ header.ptrs.unk_0x17c [[name("Header 0x17C Text"), comment("2018/12/06")]];
u32 header1CCValues[importantNums.num1CCValues] @ header.ptrs.hd_dll_af583d [[name("Header 0x1CC Values"), comment("The last one is 0xFFFFFFFF")]];
u32 header1D0Values[importantNums.num1D0Values] @ header.ptrs.hd_dll_af5843 [[name("Header 0x1D0 Values"), comment("The last one is 0xFFFFFFFF")]];
UnreadU16List header21CList @ header.ptrs.hd_dll_af5849 [[name("Header 0x21C List"), comment("Empty: the end value only")]];
UnreadU16List header220List @ header.ptrs.hd_dll_af584f [[name("Header 0x220 List")]];
