#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfinf/header.hexpat>

fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

fn sectionCount() { return rd16(header.ptrs.pCounts); };
fn listCount(u32 i) { return rd16(header.ptrs.pCounts + 2 + i * 2); };

struct CStr {
    char s[while(std::mem::read_unsigned($, 1) != 0)];
    u8 end;
} [[sealed]];

struct Str {
    if (rd32($) == 0)
        u32 none;
    else
        CStr *s : u32;
} [[sealed]];
