#pragma once

#include <misc/types.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>

bitfield MyMissionObjectiveFlags {
  hcOnly : 1 [[comment("pMyMissionTexts[2][0x30]; the quest must run in HC (quest_hc_is_active)")]];
  padding : 7;
};

struct MyMissionObjective {
  u8 unk00 [[comment("No reader")]];
  u8 missionIndex [[comment("Mission number - 1: my_mission_draw_detail prints it + 1 with pMyMissionTexts[2][0x23]")]];
  u16 monster [[format("fmtMonsterIdU16")]];
  u16 unk04[4] [[comment("35, 36, 37, 42 on every row; no reader")]];
  u16 minRank [[comment("my_mission_validate_objective_conditions: <= quest +0x4E; HR band text, or GSR text when gRankOnly")]];
  u8 huntCount [[comment("Number of monster to hunt")]];
  MyMissionObjectiveFlags flags;
  ItemId payItem [[comment("Item to hand in: LbSecretbookMove, my_mission_draw_detail")]];
  u8 payItemCount [[comment("The pMyMissionTexts[2][0x33] option asks ceil(count / 2)")]];
  u8 gRankOnly [[comment("The quest must be G rank (quest_is_g_rank)")]];
};

struct Sr500Ability {
  u8 isGsr           [[comment("my_mission_check_requirements: 0 = srRequirement <= PlayerWork +0xD40, else FUN_10B395D0 and GsbGetRank")]];
  padding[1];
  u16 srRequirement  [[comment("10000 ends the list (sb_sr500_abi_get, gsb_sr500_abi_get)")]];
  u8 missionNumber   [[comment("Counted when <= the cleared mission count")]];
  u8 abilityType     [[comment("sb_sr500_abi_get adds 1 (types 1, 4, 5), 5 (type 2) or 40 (type 3) per row")]];
};

MyMissionObjective myMissionObjectives[250] @ header.ptrs.my_mission_objective [[name("My Mission Objectives")]];
Sr500Ability sr500Abilities[251] @ header.ptrs.my_mission_data [[name("SR500 Abilities")]];

// =======================
// My Mission set objectives (header 0x534): blocks of 10 rows of 20 bytes, the
// block picked by DAT_1E76AE93 (the menu work +0x3E of the side with work
// +0x20 set; the other side uses DAT_1E76AE92). my_mission_set_board_check
// marks in work +0x48 + n the rows that a quest of the current quest board can
// fulfil: a target of the quest (quest +0x34, 3 targets) is the row's monster,
// and outside G rank (quest_is_g_rank) the quest's joinRankMin (+0x4A) is at
// least minJoinRank; a row with srQuestOnly also needs quest variant1 bit 0x01
// (SR requirement) or bit 8 of the board entry +0x30. A board entry whose byte
// +6 is '#' marks nothing. 5 blocks fit before the next table; block 4 repeats
// block 3. selsmission__10cLBMISSIONFv stores the chosen row in menu work +0xB0;
// selmmission__10cLBMISSIONFv does the same from header 0x530 (myMissionMSets:
// same layout, block DAT_1E76AE92, no board check reads it; Wii U selmmission
// reads slot 0x55C); FUN_1035EC60 and my_mission_load_active_data read the row
// there. Identical on the EN, JP and rain files.
// =======================

bitfield MyMissionSetFlags {
    srQuestOnly : 1;
    padding : 7;
};

struct MyMissionSetObjective {
    u8 unk00 [[comment("The block number; no reader")]];
    u8 unk01 [[comment("No reader: the row number in the block; FUN_1035EC60 pushes it + 1 to FUN_10B387B0, which ignores it")]];
    u16 monster [[format("fmtMonsterIdU16")]];
    u16 talkId [[comment("NPC talk line (DAT_1EE24530) when the mission is taken: FUN_1035EC60")]];
    u16 unk06 [[comment("No reader; 36 on every row of the 3 files")]];
    u16 unk08 [[comment("No reader; 37 on every row of the 3 files")]];
    u16 talkIdActive [[comment("NPC talk line (DAT_1EE24530) from my_mission_load_active_data")]];
    u16 minJoinRank [[comment("Board: <= quest joinRankMin, not checked on G rank quests; menu: SbGetRank() must reach it (FUN_1035EC60)")]];
    u8 unk0E [[comment("No reader; values 2 x45, 3 x37, 1 x18")]];
    MyMissionSetFlags flags;
    u16 payItem [[format("getItemName"), comment("0 = nothing to hand in (FUN_1035EC60)")]];
    u8 payItemCount;
    padding[1];
};

struct MyMissionSet {
    MyMissionSetObjective objectives[10];
};

MyMissionSet myMissionSets[5] @ header.ptrs.myMissionSetObjectives [[name("My Mission Set Objectives")]];
MyMissionSet myMissionMSets[5] @ header.ptrs.myMissionMSetObjectives [[name("My Mission (selmmission) Set Objectives")]];
