#pragma once

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfgao/utils/core.pat>

struct CStr {
    char s[while(std::mem::read_unsigned($, 1) != 0)];
    padding[1];
} [[sealed, format("fmt_cstr")]];

fn fmt_cstr(ref CStr c) { return c.s; };

struct Str {
    if (valid(rd32($)))
        CStr *s : u32;
    else
        u32 none;
} [[sealed, format("fmt_str")]];

fn fmt_str(ref Str x) {
    if (std::core::has_member(x, "s"))
        return x.s.s;
    return "";
};

struct StrList {
    Str e[while(rd32($) != 0)];
    u32 end;
};

struct Strs<auto N> {
    Str e[N];
};
