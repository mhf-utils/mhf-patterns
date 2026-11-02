#include <misc/MapIDs.hexpat>
#include <misc/MonsterIDs.hexpat>
#include <misc/ItemIDs.hexpat>
#include <misc/types.pat>
#include <misc/s32p.pat>

#include <quest/objective.hexpat>
#include <quest/block.hexpat>

struct RewardItem {
    u16 rate;
    ItemID item;
    u16 quantity;
} [[single_color]];

struct SupplyItem {
    if (std::mem::read_signed($,2)==0) {
        padding[4];
        continue;
    } else {
        ItemID item;
        u16 quantity;
    }
} [[single_color]];

struct GatherItem {
    u16 rate;
    ItemID item;
} [[single_color]];

struct RewardTable {
    u8 tableId [[comment("1: main objective (every quest), 2: sub A, 3: sub B; 0, 4, 5, 8, 41-47 are rarer, role unknown")]];
    u8 flags [[comment("0x80 on most")]];
    u16;
    u32 tableOffset;
    RewardItem items[while(std::mem::read_signed($,2)!=-1)] @ tableOffset;
} [[single_color]];

struct LargeMonsterSpawn {
    MonsterID monster [[comment("A u16, 0xFFFF: no monster")]];
    if(monster == 0xFF) {continue;}
    padding[1];
    u16 variant;
    u32 spawnAmount;
    u32 spawnStage [[comment("A stage id, as the loaded stages name them (not an area index)")]];
    padding[0x10];
    u32 orientation;
    float xPos;
    float yPos;
    float zPos;
    padding[0x10];
};

struct MinionSpawn {
    MonsterID monster;
    padding[1];
    u16 spawnToggle;
    u32 spawnAmount;
    u32;
    padding[0x10];
    u32;
    float xPos;
    float yPos;
    float zPos;
    padding[0x10];
};

// The first loaded stage is where the quest starts. Night variants (n0-n2)
// load other stage ids for the same areas, but their doors still name the
// day ids.
struct Stage {
    u32 stageID;
    padding[12];
};

struct mapSection {
    u32 loadedStage;
    u32;
    ptr spawnTypes;
    ptr spawnStats;

    varPaddT<MonsterID,3> monsterSpawns[while(std::mem::read_signed($,2)!=-1)]
        @ spawnTypes;

    MinionSpawn minionSpawns[while(std::mem::read_signed($,2)!=-1)]
        @ spawnStats;
};

struct ptMapSection {
    ptr ptr;
    mapSection section[while(std::mem::read_unsigned($,4)!=0)] @ ptr;
    u16 unk @ (addressof(section) + sizeof(section) + 4);
};

// Small monsters: 3 sets (or none) of sections, one per stage; the sets often
// point to the same sections, and sections may share their spawn lists
struct MapZones {
    ptMapSection mapSections[while(std::mem::read_unsigned($,4)!=0)];
};

struct largeMonsterPointers{
    padding[8];
    ptr largeMonsterIDs;
    ptr largeMonsterSpawns;

    varPaddT<MonsterID,3> monsterIDs[5] @ largeMonsterIDs;
    LargeMonsterSpawn monsterSpawns[5] @ largeMonsterSpawns;
};

// A door: the stage it leads to (doors go both ways, which tells which area
// row is which stage when the rows don't follow the stage ids' order: forest
// and hills, snowy mountains)
struct floatSet {
    s16 targetStageId1;
    if (targetStageId1 == -1) {
        break;
    }
    s16 stageVariant;
    float This_xPos;
    float This_yPos;
    float This_zPos;
    float transitionBox[5];
    float Target_xPos;
    float Target_yPos;
    float Target_zPos;
    // It's definitely a rotation, but the datatype is unknown
    s16 Target_rotation[2];
};

struct playerAreaChange {
    ptr floatsPtr;
    
    // Don't place floats if pointer is null
    if (floatsPtr) {
        floatSet floats[while(std::mem::read_signed($,4)!=-1)] @ floatsPtr;
    }
};

// One row per area, row 0 being the start area; they end where the
// transitions start (header 0x1C). The rows follow the stage ids in increasing
// order on most maps.
struct AreaMappings {
    float Area_xPos;
    float Area_zPos;
    padding[8];
    float Base_xPos;
    float Base_zPos;
    float kn_Pos;
    padding[4];
};

struct gatheringPoint{
    // I'm not aware of another way of reading a float without placing a pat
    // If xPos would be float(-1.0), don't place anything
    if (std::mem::read_unsigned($,4) == 0xBF800000) {
        return;
    } 
    float xPos;
    float yPos;
    float zPos;
    float range;
    u16 gatheringID;
    u16 maxCount;
    padding[2];
    u16 minCount;
};

// an area row's gathering points, until an X of -1.0 (0 to 6 on the quest dump)
struct ptGatheringPoint {
    ptr ptr;

    // Ignore null pointers
    if (ptr != 0) {
        gatheringPoint point[while(std::mem::read_unsigned($, 4) != 0xBF800000)] @ ptr;
    }
};

enum SpecAc : u16 {
    cooking = 1,
    fishing = 2,
    bluebox = 3,
    digging = 4,
    bed = 5,
    kn6 = 6,
    redbox = 7,
    kn8 = 8
};

struct facPoint {
    padding[2];
    SpecAc type;
    float xPos;
    float yPos;
    float zPos;
    float range;
    u16 kn4; // ID/fishing code
    padding[2];
};

struct facPointBlock {
    facPoint points [while(std::mem::read_unsigned($+4,4) != 0xBF800000)] 
        [[inline]];
    padding[0xC];
    float;
    float;
} [[inline]];

struct gatheringTable {
    GatherItem items[while(std::mem::read_signed($,2)!=-1)];
} [[inline]];

struct generalQuestProperties {
    u16 questSizeMulti
        [[name("Quest Monster size multiplier"),
        comment("% of normal size. Decimal 100 = 100%")]];
    u16 unk46 [[hidden]]; //SizeRange
    u32 monsterStatRow [[comment("The row of mhfemd's stat blocks the monsters use (HP, attack...): 0-80 in the quest dump")]]; //MonsStatTable1
    u32 mainRankPoints; 
    u32 unk50 [[hidden]]; //kn
    u32 subARankPoints;
    u32 subBRankPoints;
    u32 unk5C [[hidden]]; //QuestTypeID MonsterClassID
    padding[1];
    u8 statTable2;

    padding[0x11];

    u8 questKn1;
    u16 questKn2;
    u16 questKn3;

    // qua
    u16 gatheringTablesQty;
    u16 unk7A [[hidden]];
    u8 area1zones [[comment("The number of areas")]];
    u8 area2zones;
    u8 area3zones;
    u8 area4zones;

    u16 unk80 [[hidden]];
    u16 unk82 [[hidden]];
    u16 unk84 [[hidden]];
};

struct QuestFileHeader {
    ptr questTypeFlagsPtr;
    ptr loadedStagesPtr;
    ptr supplyBoxPtr;
    ptr rewardPtr;
    u16 subSupplyBoxPtr; //EndMessagePtr?
    u8 [[hidden]];
    u8 subSupplyBoxLen;
    ptr questAreaPtr;
    ptr largeMonsterPtr;
    ptr areaTransitionsPtr;
    ptr areaMappingPtr;
    ptr mapInfoPtr;
    ptr gatheringPointsPtr;
    ptr areaFacilitiesPtr;
    ptr unk30; //someStrings
    ptr unk34; //FixedCords1
    ptr gatheringTablesPtr; 
    ptr unk3C; //fixedCords2
    ptr unk40; //FixedInf
};

QuestFileHeader header @ 0x0;

// 1.1 General Quest Properties
generalQuestProperties genQuestProp @ $;

// 1.2 Main Quest Properties
QuestBlock MainQuestProperties @ header.questTypeFlagsPtr;

// 2.0 Loaded Stages
Stage loadedStages[while($ < header.unk34)] @ header.loadedStagesPtr; //Player slot spawns?

// 3.0 Supply Box
// The two 8-item boxes are not tied to the sub objectives (1,044 quests of
// the dump use them without any): box 3 almost only comes with box 2, extra
// supplies most likely delivered during the quest.
SupplyItem supplies[24] @ header.supplyBoxPtr [[name("Supply box")]];
SupplyItem supplyBox2[8] @ (header.supplyBoxPtr + 0x60) [[name("Supply box 2")]];
SupplyItem supplyBox3[8] @ (header.supplyBoxPtr + 0x80) [[name("Supply box 3")]];

// 4.0 Reward
RewardTable rewards[while(std::mem::read_signed($,2)!=-1)] 
    @ header.rewardPtr;

// 6.0 Quest Area
MapZones mapZones @ header.questAreaPtr;

// 7.0 Large Monster
largeMonsterPointers largeMonsterPointers @ header.largeMonsterPtr;

// 8.0 Area Change
playerAreaChange PlayerAreaChange[genQuestProp.area1zones] 
    @ header.areaTransitionsPtr;

// 9.0 AreaMappingFloats

// This while loop probably isn't the best way to do this,
// but it's what the 010 pattern does.
AreaMappings areaMappings[while($<header.areaTransitionsPtr)] 
    @ header.areaMappingPtr;

// 10.0 Map Information
qMapID mapID @ header.mapInfoPtr;
u32 returnBC_ID @ header.mapInfoPtr + sizeof(qMapID);

// 11.0 Gathering Points per Area

// One list per area row, in the area mappings' order, in the area's
// coordinates like the monsters (checked on the quest dump: placed on the
// maps' plans with the rows' stages, they fall on the drawn areas)
ptGatheringPoint gatheringPerArea[genQuestProp.area1zones] 
    @ header.gatheringPointsPtr;

// 12.0 Facilities per Area

// One list per area row, as the gathering points (types 3, 5 and 7 come once
// a quest: blue box, bed, red box)
ptVar<facPointBlock> facilities[genQuestProp.area1zones] 
    @ header.areaFacilitiesPtr;

// 13.0 Some Strings
ptr someStringPtr @ header.unk30;
ptr questTypePtr @ header.unk30 + 4;

// 14.0 

// 15.0 Gathering Tables

ptVar<gatheringTable> gatheringTables[genQuestProp.gatheringTablesQty] 
    @ header.gatheringTablesPtr;
