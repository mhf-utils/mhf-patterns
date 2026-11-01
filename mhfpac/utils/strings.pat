#pragma once

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfpac/utils/core.pat>

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

struct StrListRef {
    if (valid(rd32($)))
        StrList *list : u32;
    else
        u32 none;
};

struct Group {
    StrListRef e[while(rd32($) != 0)];
    u32 end;
};

struct GroupRef {
    if (valid(rd32($)))
        Group *group : u32;
    else
        u32 none;
};

struct Group3 {
    GroupRef e[while(rd32($) != 0)];
    u32 end;
};

struct StrRow<auto N> {
    Str e[N];
};

struct StrRows<auto N> {
    StrRow<N> r[while(rd32($) != 0)];
    u32 end;
};
