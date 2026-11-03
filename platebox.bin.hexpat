#pragma endian big
#pragma pattern_limit 65536

#include <std/mem.pat>
#include <save/plate.hexpat>

BoxSlot platebox[std::mem::size() / 16 > 300 ? 300 : std::mem::size() / 16] @ 0x00;
