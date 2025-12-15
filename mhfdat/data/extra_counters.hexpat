#pragma once

struct ExtraCounters {
  u16 counters[11];
};

u32 ExtraCountersPointer @ 0x910;

ExtraCounters extraCounters @ ExtraCountersPointer [[name("Extra Counters")]];
