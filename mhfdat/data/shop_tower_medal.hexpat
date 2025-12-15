#pragma once

struct ShopTowerMedal {
  u16 item;
  u16 randomValue;
  u8 quantity;
  u8 pad1;
  u8 pad2;
  u8 pad3;
  u16 price;
  u16 pad4;
};

u32 ShopTowerMedalPointer @ 0x948;

ShopTowerMedal shopTowerMedal[while (std::mem::read_unsigned($, 2) != 0)] @ ShopTowerMedalPointer [[name("Data")]];
