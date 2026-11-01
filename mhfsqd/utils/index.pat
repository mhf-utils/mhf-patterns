#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfsqd/header.hexpat>

fn rd8(u32 p) { return std::mem::read_unsigned(p, 1); };
fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

/// Whether p looks like a pointer into the data area (after the header)
fn valid(u32 p) { return p >= HEADER_SIZE && p < std::mem::size(); };

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
