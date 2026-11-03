#pragma endian little
#pragma pattern_limit 5000000
#pragma array_limit 10000

#include <misc/ItemIDs.hexpat>
#include <save/equip.hexpat>

struct ItemStack {
    ItemID item;
    s16 count;
    u32 unk04;
};

struct EquipSetSlots {
    u16 weapon;
    u16 legs;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
};

struct OptionFlags {
    u16 easyOperationFlags;
    u16 huntSupportFlags;
    u16 cameraFlags;
    u16 questModeDefaultFlags;
    u16 lobbyFlags;
    u8  unk0A[50];
    u16 rastaFlags;
    u8  unk3E[4];
    u16 rastaLowRankFlags;
    u8  unk44[6];
    u16 rastaChatFlags;
    u8  unk4C[14];
    u16 legendRastaFlags;
    u16 halkFlags;
    u8  unk5E[6];
    u16 partnerFlags;
    u16 partnyaaFlags;
    u16 transcendFlags;
    u16 eventInfoFlags;
};

struct PoogieStats {
    u8 intelligenceLevel;
    u8 agilityLevel;
    u8 willpowerLevel;
};

struct MytraData {
    s32 isInitFlag;
    u8  unk04[66];
    u16 poogieSkillCuffs[6];
    u8  unk52[3];
    PoogieStats poogieStats[3];
    u8  unk5E[132];
    s8  sisterFavor[3];
    s8  sisterGauge2[3];
    u8  unkE8[8];
};

bitfield HidenFlags {
    style      : 4;
    unk4       : 2;
    useInQuest : 1;
    owned      : 1;
};

bitfield PioneerBase {
    level        : 3;
    type         : 5;
    working      : 1;
    deteriorated : 1;
    built        : 1;
    unk11        : 5;
};

struct ArenaPet {
    u32 battleMinutes;
    u16 countA;
    u16 countB;
    s16 conditionPoints;
    u16 monster;
    u16 size;
    u8  unk0E[9];
    s8  tameness;
    s8  condition;
    s8  fightingLevel;
    u8  unk1A[2];
};

struct Halk {
    u8   ownedBooks[11];
    u8   unk0B[0x35];
    u8   fullnessDay[3];
    u8   flags;
    u8   intimacyCarry;
    u8   trainingCarry;
    u8   training;
    u8   unk47[3];
    u8   bookPity;
    u8   unk4B[5];
    char name[7];
    u8   fullness;
    u8   level;
    u8   intimacy;
    u8   health;
    u8   attack;
    u8   defense;
    u8   intellect;
    u8   books[3];
    u8   unk61;
    u8   elementNone;
    u8   elementFire;
    u8   elementThunder;
    u8   elementWater;
    u8   elementIce;
    u8   elementDragon;
    u8   statusSleep;
    u8   statusParalysis;
    u8   statusPoison;
};

struct GalleryPiece {
    u16 furniture;
    u16 unk02;
    u8  link;
    u8  flags;
    u8  unk06[14];
};

struct GalleryLuck {
    u16 color;
    u16 furnitureKind;
    u16 place;
    u16 series;
    u16 rule;
    u16 result;
};

struct GalleryEvaluation {
    u32 flags;
    s32 score[4];
    s32 coolPoints[4];
    s32 cutePoints[4];
    u32 unk34;
    u8  rank[4];
    u8  comment[4];
    u8  tip[4];
    u8  unk44[4];
    GalleryLuck luck[4];
};

bitfield RentedToolGrades {
    appraisalTicket   : 1;
    decorDerbyTicket  : 1;
    decorDerbyTicketG : 1;
    wateringCan2      : 1;
    wateringCan3      : 1;
    broom2            : 1;
    broom3            : 1;
    bugnet2           : 1;
    bugnet3           : 1;
    bbqSpit2          : 1;
    bbqSpit3          : 1;
    pickaxe2          : 1;
    pickaxe3          : 1;
    meowkaPot2        : 1;
    meowkaPot3        : 1;
    furnitureDisplay1 : 1;
    furnitureDisplay2 : 1;
    furnitureDisplay3 : 1;
    furnitureDisplay4 : 1;
    furnitureDisplay5 : 1;
    gardenCoupon      : 1;
    unused            : 11;
};

struct RentedToolUses {
    s8 wateringCan;
    s8 broom;
    s8 bbqSpit;
    s8 pickaxe;
    s8 bugnet;
    s8 meowkaPot;
};

struct DivaStoryProgress {
    u8  chapter;
    u8  episode;
    u8  step;
    u8  objectiveCount;
    ItemID pendingRewardItem;
    u8  unk06[2];
};

struct DivaStory {
    u8  chapterClearFlags[16];
    u8  clearedEpisodes[128];
    DivaStoryProgress progress[2];
    s16 liking;
    u16 giftCount;
    u32 songTimeHigh;
    u32 songTime;
    u8  pendingRewardCounts[4];
    u8  unkB0[4];
};

bitfield LegendRastaBits {
    flora   : 1;
    ginel   : 1;
    natasha : 1;
    tiara   : 1;
    yuwel   : 1;
    frau    : 1;
    taizou  : 1;
    ria     : 1;
    keith   : 1;
    chilka  : 1;
    edward  : 1;
    leila   : 1;
    chloe   : 1;
    graham  : 1;
    unused  : 2;
};

struct LegendRastaStoryFlags {
    LegendRastaBits firstStoryCleared;
    LegendRastaBits genericStoryClearedToday;
    LegendRastaBits storyDoneToday;
    LegendRastaBits joinsNextQuest;
};

struct ResetDate {
    u8 year;
    u8 month;
    u8 day;
};

bitfield LegendRastaPersonalItems {
    lifepowder      : 1;
    detoxPowder     : 1;
    awakeningPowder : 1;
    paralysisPowder : 1;
    terrainPowder   : 1;
    demonFlute      : 1;
    armorFlute      : 1;
    poisonKnife     : 1;
    sleepKnife      : 1;
    paralysisKnife  : 1;
    revivalBall     : 1;
    unused          : 21;
};

struct LegendRastaContract {
    char name[0x12];
    u16  loadout;
    u16  npc;
    LegendRastaPersonalItems normalItems;
};

struct NaviTabProgress {
    u8  flags;
    padding[1];
    u16 taskBits[16];
};

struct HunterNavi {
    u8 header[8];
    NaviTabProgress tabs[8];
};

struct PlayerLevel {
    s16 key;
    s16 level;
};

bitfield TranscendEffect {
    exp    : 24;
    depth  : 7;
    locked : 1;
};

struct PresetName {
    char name[20];
};

struct PresetItems {
    ItemID items[30];
};

struct PresetQuantities {
    u8 quantities[30];
};

Gender gender @ 0x51;
char name[16] @ 0x58;
u32 hrp @ 0xAC;
u32 zenny @ 0xB0;
u8 questCompletedHr[0x70] @ 0xB4;
OptionFlags optionFlags @ 0xB4;

EquipSlot equipmentBox[4500] @ 0x124;
ItemStack itemBox[7000] @ 0x11A64;

u32 progressFlagBits[8] @ 0x1F524;
u32 playtime @ 0x1F564;
EquipSlot equipped[6] @ 0x1F608;
u8 saveVersion @ 0x1F669;
u8 characterCommentPrefix[3] @ 0x1F6B0;
char characterComment[0x1D] @ 0x1F6B3;
WeaponClass weaponClass @ 0x1F715;
EquipSetSlots equipSet @ 0x1F716;
u16 absRanSuuSeeds[4] @ 0x1F722;
u8 houseTier[5] @ 0x1FB6C;
MytraData mytra @ 0x1FCB4;

u32 hunterGemColorTime @ 0x1FDA4;
u32 hunterGemRainbowTime @ 0x1FDA8;
u32 hunterGemMainteTime @ 0x1FDAC;
u16 hunterGemPoints[7] @ 0x1FDB0;
u16 hunterGemPoint8 @ 0x1FDBE;
u16 hunterGemSkills[6] @ 0x1FDC0;
u8 hunterGemColor @ 0x1FDCC;
u8 hunterGemLevel @ 0x1FDCD;

u32 rastaUnlockBits @ 0x1FDDC;
u8 rastaGuildLoyalty @ 0x1FDE0;
u8 rastaGuildCred @ 0x1FDE1;
u8 rastaHuntBits[6] @ 0x1FDE2;

u16 hr @ 0x1FDF6;
u8 currentSeason @ 0x1FDF8;
u8 currentDay @ 0x1FDF9;
u32 grp @ 0x1FDFC;
u8 itemFlagBits[0xC0] @ 0x1FE04;

PioneerBase pioneerBases[20] @ 0x1FF18;
u32 pioneerWageLockHour @ 0x1FF40;
u32 pioneerLastVisitHour @ 0x1FF44;
u16 pioneerBuildPoints @ 0x1FF48;
u8 pioneerMap @ 0x1FF56;
u8 pioneerWage @ 0x1FF58;
u16 pioneerPublicMinutes @ 0x1FF5A;

u32 gZenny @ 0x1FF64;
u8 grEntryFlag @ 0x1FF68;
LegendRastaContract legendRastaContract0 @ 0x1FFA6;
u32 hasyuCPoints @ 0x20014;

ArenaPet arenaPets[3] @ 0x20098;
u16 arenaCounts[2] @ 0x200EC;
u32 arenaTotalMinutes @ 0x200F0;

s32 dojoTrainingPoints @ 0x200F4;
s32 dojoBestScores[28] @ 0x20394;
u32 dojoBestTimes[28] @ 0x20438;

u32 cp @ 0x212E4;
u32 famousPoints @ 0x212E8;
u8 reputationRankMax @ 0x212EC;
u8 chestArmorSwayType @ 0x21376;
Halk halk @ 0x2137C;
EquipSetSlots lobbyEquipSet @ 0x21548;
u8 lobbyEquipMode @ 0x21554;

GalleryPiece galleryPieces[50] @ 0x2232C;
RentedToolGrades rentedToolGrades @ 0x22C4C;
u16 loungePoints @ 0x22C54;
u32 gardenFlags @ 0x22C58;
u32 meowkaPotRentedBits @ 0x22C5C;
u32 gardenDirtyFlags @ 0x22C60;
ItemID meowkaPotItems[6] @ 0x22C68;
RentedToolUses rentedToolUses @ 0x22C74;
u8 meowkaPotStages[6] @ 0x22C96;
GalleryEvaluation galleryEvaluation @ 0x22C9C;
u16 ryoudanPoints @ 0x22D16;
DivaStory divaStory @ 0x22D58;
u16 title @ 0x23012;

LegendRastaStoryFlags legendRastaStory @ 0x2385C;
HunterNavi hunterNavi @ 0x23868;
ResetDate legendRastaStoryResetDate @ 0x23980;
PlayerLevel playerLevels[20] @ 0x23A8C;
TranscendEffect transcendEffects[20] @ 0x23B20;
LegendRastaPersonalItems legendRastaContract0Urgent @ 0x23B70;
u8 lockOnCamera @ 0x23BA7;
LegendRastaContract legendRastaContract1 @ 0x23BBA;
LegendRastaPersonalItems legendRastaContract1Urgent @ 0x23BD4;
u32 secretBookSrp[14] @ 0x23C0C;
HidenFlags secretBookFlags[14] @ 0x23C4C;
u8 secretBookEffectBases[14] @ 0x23C5C;

u8 keyQuestFlag[8] @ 0x23D20;
u8 questCompletedGr[0x80] @ 0x23D2C;
u16 secretBookMissionClearCount @ 0x23DAC;
u8 myMissionKills @ 0x23DAE;
u16 divaSkill @ 0x23DB8;
s16 divaSkillUses @ 0x23DBA;
LegendRastaContract legendRastaContract2 @ 0x23DDA;
LegendRastaPersonalItems legendRastaContract2Urgent @ 0x23DF4;
u8 storageGuideExtreme @ 0x23E41;
u8 itemBoxExtraPages @ 0x23E42;
u8 equipBoxExtraPages @ 0x23E43;
u32 duremudiraSlays @ 0x23E64;
u32 monster91Slays @ 0x23E68;
u32 whiteFatalisSlays @ 0x23E6C;

ItemStack pouchItems[20] @ 0x23E78;
ItemStack pouchAmmo[10] @ 0x23F18;
PresetName presetNames[24] @ 0x23F68;
PresetItems presetItems[24] @ 0x24148;
PresetQuantities presetQuantities[24] @ 0x246E8;
