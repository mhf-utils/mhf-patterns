#pragma once

#include <mhfsqd/utils/index.pat>

struct Pos16 {
    s16 value;
    s16 high;
};

struct ParamRow {
    float fparams[4];
    s32 iparams[4];
};

struct FloatLevelRows {
    float level1to4[4];
    s32 unk10[4];
    float level5to7[3];
    float unk2C;
    s32 unk30[4];
};

struct IntLevelRows {
    float unk00[4];
    s32 level1to4[4];
    float unk20[4];
    s32 level5to7[3];
    s32 unk3C;
};

struct WeaknessLevelRows {
    float unk00[4];
    s32 level1to4[4];
    float unk20[4];
    s32 level5to7[3];
    s32 hitzoneThreshold;
};

struct PosRow {
    float unk00[4];
    Pos16 v[4];
};

struct LevelStepRow {
    float step;
    float unk04[3];
    s32 unk10[4];
};

struct FriendshipRow {
    float unk00[4];
    s32 byPartySize[4];
};

struct AffinityRow {
    float unk00[4];
    s32 byLevel[3];
    s32 unk1C;
};

struct GateRow {
    float unk00[4];
    s32 pointThreshold;
    u8 rollPer10000;
    padding[3];
    s32 unk18[2];
};

struct MonsterBonusRow {
    float flaggedRate;
    float unk04[3];
    s32 bonusPoints;
    s32 unk14[3];
};

struct ResRow {
    float unk00[4];
    s32 byLevel[3];
    s32 unk1C;
};

struct StaminaRateRow {
    float byValue[2];
    float unk08[2];
    s32 unk10[4];
};

/// Rows are present depending on how many the file declares (counts.paramBlock)
struct ParamBlock<auto N> {
    if (N >= 1) ParamRow dummy;
    if (N >= 3) FloatLevelRows tailCutter;
    if (N >= 5) IntLevelRows regenerationUp;
    if (N >= 7) FloatLevelRows earthHeavenStormUp;
    if (N >= 9) FloatLevelRows statusUp;
    if (N >= 11) IntLevelRows rawHitbox;
    if (N >= 13) FloatLevelRows statusDown;
    if (N >= 15) WeaknessLevelRows weaknessExploit;
    if (N >= 17) IntLevelRows elementalUp;
    if (N >= 18) PosRow panelPositions;
    if (N >= 19) PosRow listPositionsA;
    if (N >= 20) PosRow listPositionsB;
    if (N >= 21) LevelStepRow pointLevelStep;
    if (N >= 24) FriendshipRow powerOfFriendship[3];
    if (N >= 25) AffinityRow affinityUp;
    if (N >= 26) GateRow udEventGate;
    if (N >= 27) MonsterBonusRow monsterBonus;
    if (N >= 28) ResRow fireResUp;
    if (N >= 29) ResRow waterResUp;
    if (N >= 30) ResRow iceResUp;
    if (N >= 31) ResRow thunderResUp;
    if (N >= 32) ResRow dragonResUp;
    if (N >= 33) ResRow allResUp;
    if (N >= 34) StaminaRateRow regenStaminaRate;
    if (N > 34) ParamRow extraRows[N - 34];
};

ParamBlock<counts.paramBlock> paramBlock @ header.pParamBlock [[name("Param Block")]];
