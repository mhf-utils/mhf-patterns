#pragma once

#include <mhfgao/utils/index.pat>

struct MhfGaoParamRow {
    float f[4];
    s32 i[4];
};

struct ItemValue {
    u16 itemId;
    u16 value;
};

struct ItemValues {
    ItemValue r[while(rd16($) != 0)];
    u32 end;
};

struct MhfGaoLevelValue {
    u16 level;
    u16 value;
};

struct MonsterTargetSphere {
    float height;
    float radius;
};

struct PartnyaaAiTypeRow {
    u8 aiClass;
    u8 unk1;
    u8 unk2;
    u8 unk3;
};

struct PartnyaaActionTrigger {
    u8 startChance;
    u8 chanceStep;
    u8 chanceAfterFire;
    u8 actionKind;
};

struct PartnyaaActionTriggers {
    PartnyaaActionTrigger triggers[19];
};

struct PartnyaaAiChanceRow {
    u8 unk00[7];
    u8 lowHpReactChance;
    u8 unk08[14];
};

struct StatCurveSegment {
    s16 levelCap;
    u16 pad;
    u32 perLevel;
};

struct StatCurve {
    u32 count;
    Rows<StatCurveSegment, count> *segments : u32;
};

struct PartnyaaStatCurveSet {
    StatCurve attack;
    StatCurve defense;
    StatCurve health;
    StatCurve reflexes;
    StatCurve bravery;
    StatCurve luck;
};

struct StatCurveSetRef {
    if (valid(rd32($)))
        PartnyaaStatCurveSet *set : u32;
    else
        u32 none;
};

struct StatCurveSetRefs<auto N> {
    StatCurveSetRef r[N];
};

struct PartnyaaSpecialTrainingRow {
    u8 kind;
    u8 unk01;
    u8 unk02;
    u8 unk03;
    u32 unk04;
    u16 costItemId;
    u16 costCount;
    u32 unk0C;
};

struct PartnyaaStatGrade {
    u8 growthType;
    u8 stat;
    u8 grade;
    u8 pad;
};

struct SkillTreeLevel {
    s16 points;
    u16 skillId;
};

struct SkillTreeRow {
    u16 categoryId;
    SkillTreeLevel levels[8];
};

struct PartnyaaLuckRollRow {
    u16 maxLuck;
    u16 pad;
    u8 weights[16];
};

Rows<MhfGaoParamRow,header.paramRowCount> pParamRows @ header.pParamRows;
StatCurveSetRefs<header.statCurveSetCount> pStatCurveSets @ header.pStatCurveSets;
Rows<PartnyaaSpecialTrainingRow,7> pSpecialTrainingRows @ header.pSpecialTrainingRows;
ItemValues pPresentItems @ header.pPresentItems;
StrList pTalkTexts_0 @ header.pTalkTexts_0;
StrList pTalkTexts_1 @ header.pTalkTexts_1;
StrList pTalkTexts_2 @ header.pTalkTexts_2;
StrList pTalkTexts_3 @ header.pTalkTexts_3;
StrList pTalkTexts_4 @ header.pTalkTexts_4;
StrList pTalkTexts_5 @ header.pTalkTexts_5;
StrList pTalkTexts_6 @ header.pTalkTexts_6;
StrList pTalkTexts_7 @ header.pTalkTexts_7;
Rows<PartnyaaStatGrade,header.statGradeCount> pStatGrades @ header.pStatGrades;
ItemValues pDispatchItems @ header.pDispatchItems;
U32s<header.unk0ECCount> unk0EC @ header.unk0EC;
F32s<header.unk0F0Count> unk0F0 @ header.unk0F0;
Rows<MonsterTargetSphere,header.monsterTargetSphereCount> pMonsterTargetSpheres @ header.pMonsterTargetSpheres;
F32s<8> pLowHpRatios @ header.pLowHpRatios;
F32s<8> pLowHpCooldowns @ header.pLowHpCooldowns;
F32s<8> unk100 @ header.unk100;
Rows<PartnyaaAiTypeRow,16> pAiTypeRows @ header.pAiTypeRows;
Rows<PartnyaaActionTriggers,8> pActionTriggers @ header.pActionTriggers;
Rows<PartnyaaAiChanceRow,4> pAiChanceRows @ header.pAiChanceRows;
Strs<header.skillCount> pSkillNames @ header.pSkillNames;
Strs<header.skillCategoryCount> pSkillCategoryNames @ header.pSkillCategoryNames;
Strs<header.skillCategoryHelpCount> pSkillCategoryHelps @ header.pSkillCategoryHelps;
Strs<header.melodyEffectCount> pMelodyEffectNames @ header.pMelodyEffectNames;
U16s<6> pStatMultipliers @ header.pStatMultipliers;
Rows<PartnyaaLuckRollRow,header.luckRollRowCount> pLuckRollRows @ header.pLuckRollRows;
Rows<PartnyaaLuckRollRow,header.specialQuestLuckRollRowCount> pSpecialQuestLuckRollRows @ header.pSpecialQuestLuckRollRows;
Rows<SkillTreeRow,header.skillTreeRowCount> pSkillTrees @ header.pSkillTrees;
U16s<8> pTrainingCaps @ header.pTrainingCaps;
Rows<MhfGaoLevelValue,header.levelValueCount> pLevelValues @ header.pLevelValues;
