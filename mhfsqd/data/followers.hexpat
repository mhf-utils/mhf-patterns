#pragma once

#include <mhfsqd/utils/index.pat>

enum Gender : u8 {
    Male = 0,
    Female = 1
};

enum EquipType : u8 {
    Leg = 0,
    Head = 2,
    Body = 3,
    Arm = 4,
    Waist = 5,
    Melee = 6,
    Ranged = 7
};

struct FollowerOption {
    Str pLabel;
    u16 unk04;
    u16 cost;
};

struct FollowerName {
    Str pName;
    Gender gender;
    u8 unk05;
    u16 unk06;
};

/// Loadouts are ordered by weapon, then rank, then gender
struct FollowerLoadout<auto Base, auto Ranks> {
    u32 index = (addressof(this) - Base) / 0x50;
    u32 weapon = index / (Ranks * 2);
    u32 rank = (index / 2) % Ranks;
    Gender gender = index % 2;
    u8 unk00;
    u8 unk01;
    u8 unk02;
    u8 unk03;
    u8 unk04;
    EquipType weaponEquipType;
    u16 weaponId;
    u16 headId;
    u16 bodyId;
    u16 armId;
    u16 waistId;
    u16 legId;
    u16 weaponLevel;
    u16 headLevel;
    u16 bodyLevel;
    u16 armLevel;
    u16 waistLevel;
    u16 legLevel;
    u16 weaponDecos[3];
    u16 headDecos[3];
    u16 bodyDecos[3];
    u16 armDecos[3];
    u16 waistDecos[3];
    u16 legDecos[3];
    u16 unk42;
    u8 unk44[4];
    u8 unk48;
    u8 pad49;
    u8 unk4A;
    u8 pad4B;
    u8 unk4C;
    u8 pad4D[3];
};

struct FollowerSkill {
    u16 skillId;
    u16 enabled;
};

/// Skill lists are ordered by weapon class, then rank
struct FollowerSkillList<auto Base, auto Ranks> {
    u32 index = (addressof(this) - Base) / 4;
    u32 weaponClass = index / Ranks;
    u32 rank = index % Ranks;
    u32 pSkills;
    if (pSkills != 0) FollowerSkill skills[while(rd16($) != 0)] @ pSkills;
};

FollowerOption followerWeapons[counts.followerWeapons] @ header.pFollowerWeapons [[name("Follower Weapons")]];
FollowerOption followerRanks[counts.followerRanks] @ header.pFollowerRanks [[name("Follower Ranks")]];
FollowerName followerNames[counts.followerNames] @ header.pFollowerNames [[name("Follower Names")]];
FollowerLoadout<header.pFollowerLoadouts, counts.followerRanks> followerLoadouts[counts.followerLoadouts] @ header.pFollowerLoadouts [[name("Follower Loadouts")]];
FollowerSkillList<header.pFollowerSkills, counts.followerRanks> followerSkills[counts.followerSkills] @ header.pFollowerSkills [[name("Follower Skills")]];
