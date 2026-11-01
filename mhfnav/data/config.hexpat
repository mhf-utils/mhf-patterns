#pragma once

#include <mhfnav/utils/index.pat>
#include <mhfnav/header.hexpat>

struct NaviConfig {
    float fparams[4];
    u32 iparams[4];
};

struct MenuRow {
    float unused00[4];
    u32 boardEnabled;
    u32 screenInputDelay;
    u32 menuOpenDelay;
    u32 menuInputDelay;
};

struct HrMinRow {
    float unused00[4];
    u32 hrMin;
    u32 unk14;
    u32 unused18[2];
};

struct GrRangeRow {
    float unused00[4];
    u32 grMin;
    u32 grMax;
    u32 unused18[2];
};

struct WindowColorRow {
    float unused00[4];
    u32 red;
    u32 green;
    u32 blue;
    u32 alpha;
};

struct AnimationRow {
    float startScale;
    float scaleSpeed;
    float scaleAccel;
    float unused0C;
    u32 holdFrames;
    u32 unused14[3];
};

struct PopupMotionRow {
    float openSpeed;
    float openAccel;
    float closeSpeed;
    float closeAccel;
    u32 openStartPercent;
    u32 closeStartPercent;
    u32 unused18[2];
};

struct TabCompleteRow {
    float unused00[4];
    u32 showMessage;
    u32 unused14[3];
};

struct UnusedRow {
    float unused00[4];
    u32 unused10[4];
};

struct DivaWeaponRows {
    float unused0[4];
    u32 greatSword;
    u32 heavyBowgun;
    u32 hammer;
    u32 lance;
    float unused1[4];
    u32 swordAndShield;
    u32 lightBowgun;
    u32 dualBlades;
    u32 longSword;
    float unused2[4];
    u32 huntingHorn;
    u32 gunlance;
    u32 bow;
    u32 tonfa;
    float unused3[4];
    u32 switchAxeF;
    u32 magnetSpike;
    u32 unused12_2;
    u32 unused12_3;
};

struct PopupRow {
    float scrollSpeed;
    float unused04[3];
    u32 waitFrames;
    u32 waitRandomFrames;
    u32 holdFrames;
    u32 fadeStep;
};

struct GWeaponRows {
    float unused0[4];
    u32 greatSword;
    u32 heavyBowgun;
    u32 hammer;
    u32 lance;
    float unused1[4];
    u32 swordAndShield;
    u32 lightBowgun;
    u32 dualBlades;
    u32 longSword;
    float unused2[4];
    u32 huntingHorn;
    u32 gunlance;
    u32 bow;
    u32 tonfa;
    float unused3[4];
    u32 switchAxeF0;
    u32 switchAxeF1OrMagnetSpike;
    u32 switchAxeF2;
    u32 unused18_3;
};

/// Rows are present depending on how many the file declares (naviConfigCount)
struct NaviConfigTable<auto N> {
    if (N >= 1) MenuRow menu;
    if (N >= 2) HrMinRow hrUnlock;
    if (N >= 3) GrRangeRow grRange;
    if (N >= 4) HrMinRow hrUnlock2;
    if (N >= 5) WindowColorRow windowColor;
    if (N >= 6) AnimationRow stampAnimation;
    if (N >= 7) PopupMotionRow popupMotion;
    if (N >= 8) TabCompleteRow tabComplete;
    if (N >= 9) UnusedRow unusedRow8;
    if (N >= 13) DivaWeaponRows divaWeapons;
    if (N >= 14) UnusedRow unusedRow13;
    if (N >= 15) PopupRow tipTicker;
    if (N >= 19) GWeaponRows gWeapons;
    if (N > 19) NaviConfig extraRows[N - 19];
};

NaviConfigTable<header.naviConfigCount> naviConfig @ header.pNaviConfig [[name("Navi Config")]];
