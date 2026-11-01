#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfpac/header.hexpat>

fn rd8(u32 p) { return std::mem::read_unsigned(p, 1); };
fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

/// Entry count of section i, stored as a u16 table at header.ptrs.pSectionCounts
fn count(u32 i) { return rd16(header.ptrs.pSectionCounts + i * 2); };

/// Whether p looks like a pointer into the data area (after the header)
fn valid(u32 p) { return p >= HEADER_SIZE && p < std::mem::size(); };

struct Rows<T, auto N> {
    T r[N];
};

struct U8s<auto N> { u8 v[N]; };
struct U16s<auto N> { u16 v[N]; };
struct U32s<auto N> { u32 v[N]; };
struct Words<auto N> { u32 w[N]; };
