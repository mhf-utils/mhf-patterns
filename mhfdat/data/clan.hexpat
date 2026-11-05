#pragma once

/**
	Clan missions: the part a mission asks to break or cut (header 0xA28,
	important numbers + 0x3D0 of them) and, per Caravan ranking group (11),
	the weights the client rolls a mission with: the slay chance (0xA2C), the
	time limit (0xA30), the reward (0xA34) and its multiplier (0xA38).
	Read by the clan mission roll of mhfo-hd.dll.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <std/string.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum ClanTargetAction : u8 {
    Break = 0,
    Cut   = 1
};

struct ClanMissionTarget {
    u8 monster;
    u8 partCode;
    u8 partNameIndex;
    ClanTargetAction action;
};

struct ClanMissionTimeWeights {
    u8 min5;
    u8 min10;
    u8 min15;
    u8 min20;
};

struct ClanMissionRewardWeights {
    u8 hunterGem;
    u8 zenny;
    u8 cp;
    u8 greatLuck;
    u8 superLuck;
};

struct ClanMissionMultiplierWeights {
    u8 x2;
    u8 x3;
    u8 x4;
    u8 x5;
};

ClanMissionTarget clanMissionTargets[importantNums.numClanMissionTargets]
    @ header.ptrs.clanMissionTargets
    [[name("Clan Mission Targets")]];

u8 clanMissionSlayChances[11] @ header.ptrs.clanMissionSlayChances [[name("Clan Mission Slay Chances"), comment("Percent, per ranking group")]];

ClanMissionTimeWeights clanMissionTimeWeights[11] @ header.ptrs.clanMissionTimeWeights [[name("Clan Mission Time Weights")]];

ClanMissionRewardWeights clanMissionRewardWeights[11] @ header.ptrs.clanMissionRewardWeights [[name("Clan Mission Reward Weights")]];

ClanMissionMultiplierWeights clanMissionMultiplierWeights[11] @ header.ptrs.clanMissionMultiplierWeights [[name("Clan Mission Multiplier Weights")]];

// Guild icon monster icons (header 0x6A4): the monster icons of the guild icon
// (emblem) editor. guild_icon_editor_statemachine (case 0) lists, from the first
// min(count, g_player_hr_cache) rows, each id until 0xFFFF as a kind 1 cell of
// the 6 x 6 part grid (36 a page); kind 1 is drawn as monsterIconIndexTable[id]
// (header 0x51C, guild_icon_editor_draw, guild_icon_part_draw). Pages below
// guild_icon_monster_icon_page_count print pClanMenuItemTexts[0x6A] "Monster
// Icons", the others [0x69] "Item Icons" (the item icons are built in code).
// What g_player_hr_cache holds was not proven. On rain row 10 starts with
// 0xBEFE, 0x01B5 instead of 21, 35.
struct GuildIconMonsterIconRow {
    u16 monsterIds[12] [[comment("Until the first 0xFFFF; the rest is 0")]];
};

GuildIconMonsterIconRow guildIconMonsterIcons[importantNums.numGuildIconMonsterIconRows] @ header.ptrs.guildIconMonsterIcons [[name("Guild Icon Monster Icons"), comment("Row r is listed when r < g_player_hr_cache")]];

// Clan Conquest points. Header 0xA54: the clan points for slaying a Conquest
// target monster, until points <= 0 (clan_conquest_points_help_page_draw,
// page "猟団実績pt", pClanConquestTexts[0x3E] "%s1体 %d"); at quest end
// quest_complete_idle_update sends the row of the quest monster when it is the
// live target (clan_conquest_target_monster_get) and at least 2 non-mercenary
// party members share the player's PlayerWork +0xC94 value. Header 0xA58: the
// 25 support conditions (支援条件); the active row is
// clan_conquest_support_condition_index() % 25, each kill of its monster
// counts (clan_conquest_support_condition_count_kill) and every count kills
// give points personal points (個人実績pt) at quest end
// (clan_conquest_support_condition_points_settle). Shown as "支援条件:%s %d%s"
// (monster name, count, suffix). The loader relocates suffix until points < 0.
fn conquestMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct ClanConquestTargetSlayPoints {
    u16 monster [[format("conquestMonster")]];
    s16 points;
};

struct ClanConquestTargetSlayPointList {
    ClanConquestTargetSlayPoints rows[while(std::mem::read_signed($ + 2, 2) > 0)];
    ClanConquestTargetSlayPoints terminator [[comment("0xFFFF, -1")]];
};

struct ClanConquestSupportCondition {
    u16 monster [[format("conquestMonster")]];
    u16 count [[comment("Kills per completion")]];
    s16 points [[comment("Personal points per completion")]];
    u16 unk06 [[comment("Only read as the dropped high half of the points dword; 0 everywhere")]];
    std::string::NullString *suffix : u32;
};

struct ClanConquestSupportConditionEnd {
    s16 monster;
    s16 count;
    s16 points;
    u16 unk06;
    u32 suffix [[comment("Not relocated")]];
};

struct ClanConquestSupportConditionList {
    ClanConquestSupportCondition rows[while(std::mem::read_signed($ + 4, 2) >= 0)];
    ClanConquestSupportConditionEnd terminator;
};

ClanConquestTargetSlayPointList clanConquestTargetSlayPoints @ header.ptrs.clanConquestTargetSlayPoints [[name("Clan Conquest Target Slay Points")]];
ClanConquestSupportConditionList clanConquestSupportConditions @ header.ptrs.clanConquestSupportConditions [[name("Clan Conquest Support Conditions")]];

// Guild message board post icon animations (header 0xB8C):
// guild_msg_board_icon_anim_tick gives each of the 10 post rows of a page an
// idle timer (1/30 a frame); past idleSeconds the row rolls rand % 100 <
// startChance and plays pattern rand % patternCount until the time of its last
// key. guild_msg_board_icon_draw blends the two keys around the timer (from a
// zero rest key before key 0) into the post icon quad. The same root holds the
// delays of guild_msg_board_update_poll (CSync_man::putIs_update_guild_msg_board,
// 0x1A3), sent while the board is closed. A zero sixth key after each pattern is
// not read.
struct GuildMsgBoardIconKey {
    float time [[comment("Seconds from the pattern start")]];
    s16 offsetX;
    s16 offsetY;
    s16 growWidth [[comment("Added to the icon width, x moves left by half of it")]];
    s16 growHeight [[comment("Added to the icon height, y moves up by half of it")]];
    float rotation [[comment("Degrees")]];
};

struct GuildMsgBoardIconPattern {
    GuildMsgBoardIconKey *keys[std::mem::read_signed(header.ptrs.guildMsgBoardIconAnims + 2, 2)] : u32;
};

struct GuildMsgBoardIconAnims {
    s16 patternCount;
    s16 keyCount [[comment("Keys per pattern")]];
    float idleSeconds [[comment("Idle time before a start roll")]];
    s16 startChance [[comment("Percent")]];
    s16 firstPollSeconds [[comment("Board update poll delay after a reset")]];
    s16 pollSeconds [[comment("Board update poll delay after that")]];
    s16 unk0E [[comment("no reader")]];
    GuildMsgBoardIconPattern *patterns[patternCount] : u32;
};

GuildMsgBoardIconAnims guildMsgBoardIconAnims @ header.ptrs.guildMsgBoardIconAnims [[name("Guild Message Board Icon Animations")]];
