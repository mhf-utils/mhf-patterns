#pragma once

#include <misc/types.pat>

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