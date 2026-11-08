#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Great Slaying NPC players (header 0x2A0, important numbers +0x9E rows; Wii U
// slot 0x2CC, count +0xA6 there). Wii U NpcPlayerInit (from game2 / game11)
// runs on a Hasyu (Great Slaying) quest (IsHasyuQuest) and builds 4 NPC players
// with CreateNpcPlayer (0x0253D210): row = NpcPlayerGetPartyId() x 4 + member
// 0-3, name = Wii U text table +0xA28 at the same index, armor colour index 0.
// The player fields are the ones Wii U Lb_set_npcpl fills from a Legend Rasta
// loadout (gender, inner, hairstyle, voice, hair colour). No reader on HD. Same
// bytes on the EN, JP and rain files.
// =======================

struct HasyuNpcPlayer {
    u8 gender [[comment("Player +0x11")]];
    u8 inner [[comment("Player +0xBC7")]];
    u8 faceModel [[comment("Stored as is in the face equipment slot (player +0x3B2); Lb_set_npcpl gets it from GetFceMdlNo instead")]];
    u8 hairstyle [[comment("Player +0x38E")]];
    u8 hairColorR;
    u8 hairColorG;
    u8 hairColorB [[comment("Player +0x704 = 0xFF000000 | R << 16 | G << 8 | B")]];
    u8 voice [[comment("Player +0xB23")]];
    u16 weapon [[comment("Bit 0x8000: ranged (equipment kind 7), else melee (6); id = value & 0x7FFF")]];
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
} [[format("hasyuNpcPlayerName")]];

fn hasyuNpcPlayerName(ref auto p) {
    u8 kind = 6;
    if (p.weapon & 0x8000) kind = 7;
    return getEquipKindName(kind, p.weapon & 0x7FFF);
};

HasyuNpcPlayer hasyuNpcPlayers[importantNums.numHasyuNpcPlayers] @ header.ptrs.hasyuNpcPlayers [[name("Great Slaying NPC Players")]];
