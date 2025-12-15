#pragma once

struct Counters {
  u16 unk1;
  u16 unk2;
  u16 catShopItemCounter;
  u16 unk4;
  u16 roadEntries;
};

u32 CounterPointer @ 0xB04;

Counters counters @ CounterPointer [[name("Data")]];
