#pragma endian little
#pragma pattern_limit 1000000

#include <std/mem.pat>
#include <save/equip.hexpat>

enum PartnerState : u8 {
    None            = 0,
    CreatedByRasta  = 1,
    CreatedOnScreen = 2,
    IntroDone       = 3
};

bitfield WeaponClassBits {
    greatSword     : 1;
    heavyBowgun    : 1;
    hammer         : 1;
    lance          : 1;
    swordAndShield : 1;
    lightBowgun    : 1;
    dualBlades     : 1;
    longSword      : 1;
    huntingHorn    : 1;
    gunlance       : 1;
    bow            : 1;
    tonfa          : 1;
    switchAxeF     : 1;
    magnetSpike    : 1;
    unused         : 2;
};

struct PartnerData {
    u8  voice;
    Gender gender;
    u8  face;
    u8  hairstyle;
    HairColor hairColor;
    char name[0x12];
    u8  inner;
    u8  personality;
    u16 equippedBoxIndex[6];
    EquipSlot legs;
    EquipSlot unusedSlot;
    EquipSlot head;
    EquipSlot chest;
    EquipSlot arms;
    EquipSlot waist;
    EquipSlot weapon;
    u16 rastaNpc;
    WeaponClass startWeaponClass;
    u8  unk9B;
    u16 unk9C;
    u16 unk9E;
    u8  unkA0[0x0E];
    u16 gauge;
    u16 skills[16];
    u8  learnedSkillBits[0x80];
    u32 exp;
    u32 weaponClassExp[14];
    u8  unk18C[8];
    PartnerState state;
    u8  unk195;
    u8  itemSetNormal;
    u8  unk197;
    WeaponClassBits weaponClasses;
    WeaponClassBits weaponClasses2;
    WeaponClassBits masteredClasses;
    u16 level;
    u16 unk1A0[3];
    u8  itemSetUrgent;
    u8  learnedExtraSkillBits[0x10];
    u8  unk1B7[0x61];
    u8  unk218[0x10];
};

struct PartnerBlob {
    u8 compressed;
    if (compressed != 0) {
        u8 nullcompData[std::mem::size() - 1];
    } else {
        be u32 dataSize;
        if (dataSize == 0x228) {
            PartnerData data;
        } else {
            u8 dataRaw[dataSize];
        }
        be u32 boxSize;
        EquipSlot equipBox[boxSize / 16];
    }
};

PartnerBlob partner @ 0x00;
