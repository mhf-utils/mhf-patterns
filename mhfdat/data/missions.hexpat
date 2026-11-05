#pragma once

#include <misc/types.pat>
#include <misc/MonsterIDs.hexpat>

struct Objective {
  u8 unk00;
  u8 id;          // mission ID
  u16 monster_id; // monster ID
  u16 unk04;
  u16 unk06;
  u16 unk08;
  u16 unk0A;
  u16 HR_GR;      // probably both hr gr
  u8 amount_monster;
  u8 is_HC;       //is hardcore
  u16 unk10;
  u8 amount_payement_ticket;
  u8 is_GR;       // is GR ou HR
};

struct Data {
  u16 is_GR          [[comment("G-Rank flag"), name("is GR")]];
  u16 sr_requirement [[comment("SR requirement"), name("SR Requirement")]];
  u8 id              [[comment("Objective ID"), name("Objective ID")]];
  u8 buff_id         [[comment("Buff ID"), name("Buff ID")]];
};

Objective  objective[250] @ header.ptrs.my_mission_objective [[name("Objectives")]];
Data       data[251]      @ header.ptrs.my_mission_data      [[name("Data")]];

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
// block 3. Identical on the EN, JP and rain files.
// =======================

fn myMissionMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

bitfield MyMissionSetFlags {
    srQuestOnly : 1;
    padding : 7;
};

struct MyMissionSetObjective {
    u8 unk00 [[comment("The block number; no reader")]];
    u8 unk01 [[comment("The row number in the block; no reader")]];
    u16 monster [[format("myMissionMonster")]];
    u16 unk04;
    u16 unk06;
    u16 unk08;
    u16 unk0A;
    u16 minJoinRank [[comment("Not checked on G rank quests")]];
    u8 unk0E;
    MyMissionSetFlags flags;
    u16 unk10;
    u8 unk12;
    u8 unk13;
};

struct MyMissionSet {
    MyMissionSetObjective objectives[10];
};

MyMissionSet myMissionSets[5] @ header.ptrs.myMissionSetObjectives [[name("My Mission Set Objectives")]];
