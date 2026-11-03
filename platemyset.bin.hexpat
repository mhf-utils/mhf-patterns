#pragma endian big
#pragma pattern_limit 65536

#include <save/plate.hexpat>

struct PlateMySet {
    BoxSlot rows[3];
};

PlateMySet platemyset[40] @ 0x00;
