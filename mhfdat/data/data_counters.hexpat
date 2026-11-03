#pragma once

struct Counters {
  u16 unk1;
  u16 numRoadMonsterScales; // header 0xB0C
  u16 catShopItemCounter;
  u16 unk4;
  u16 roadEntries;
  u16 unkA;
  u16 unkC;
  u16 numSoloRoadMonsterScales; // header 0xB7C
};

u32 CounterPointer @ 0xB04;

Counters counters @ CounterPointer [[name("Data")]];
