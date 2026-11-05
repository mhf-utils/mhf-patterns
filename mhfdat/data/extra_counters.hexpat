#pragma once

struct ExtraCounters {
  u16 numFelyneGmShopItems; // header 0x90C
  u16 counter02;
  u16 numBlueNpcGmShopItems; // header 0x924
  u16 counters06[8];
};

u32 ExtraCountersPointer @ 0x910;

ExtraCounters extraCounters @ ExtraCountersPointer [[name("Extra Counters")]];
