#pragma once

enum Gender : u8 {
    Male   = 0,
    Female = 1
};

enum EquipType : u8 {
    Legs   = 0,
    Unused = 1,
    Head   = 2,
    Chest  = 3,
    Arms   = 4,
    Waist  = 5,
    Melee  = 6,
    Ranged = 7
};

enum WeaponClass : u8 {
    GreatSword     = 0,
    HeavyBowgun    = 1,
    Hammer         = 2,
    Lance          = 3,
    SwordAndShield = 4,
    LightBowgun    = 5,
    DualBlades     = 6,
    LongSword      = 7,
    HuntingHorn    = 8,
    Gunlance       = 9,
    Bow            = 10,
    Tonfa          = 11,
    SwitchAxeF     = 12,
    MagnetSpike    = 13
};

struct EquipSlot {
    u8  flags;
    EquipType type;
    u16 id;
    u16 level;
    u16 decorations[3];
    u32 unk0C;
};

struct HairColor {
    u8 blue;
    u8 green;
    u8 red;
    u8 alpha;
};
