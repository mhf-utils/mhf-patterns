#pragma once

#include <std/mem.pat>

fn rd8(u32 p) { return std::mem::read_unsigned(p, 1); };
fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };
