#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfgao/header.hexpat>

fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

/// Whether p looks like a pointer into the data area (after the header)
fn valid(u32 p) { return p >= HEADER_SIZE && p < std::mem::size(); };

/// Number of rows at pointer p before the 0xFFFF terminator
fn rows(u32 p, u32 stride) {
    u32 n = 0;
    while (rd16(p + n * stride) != 0xFFFF)
        n += 1;
    return n;
};

struct Rows<T, auto N> {
    T r[N];
};

struct U8s<auto N> { u8 v[N]; };
struct U16s<auto N> { u16 v[N]; };
struct U32s<auto N> { u32 v[N]; };
struct F32s<auto N> { float v[N]; };

struct U16List {
    u16 v[while(rd16($) != 0)];
    u16 end;
};
