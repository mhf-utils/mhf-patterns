#pragma once

/**
	Equipment visual effects: sprites drawn on worn gear (glows, sparks,
	auras). A weapon's visualEffects field (+0x24) picks a set in header 0x280:
	up to 8 effect ids (0 ends them), each a 0x80-byte row of header 0x284,
	run by equip_effect_update. Header 0x294 lists effects by worn model: from
	row 1 until a part of 0, a weapon of a class or an armor piece with a model
	id, worn by a male (0), a female (1) or an NPC (2), gives up to 8 ids of
	0xB4-byte rows of header 0x298, run by model_effect_update.

	An effect shows while its trigger holds. It starts after startDelay
	frames, sits at an offset from a bone, and animates channels: a channel
	goes from start to end over period frames, loops times (-1 forever), as a
	ramp or back and forth (pingPong); with loops or period at 0 it stays at
	its start value (the texture channel shows texture). Angles are in
	degrees, rotations applied X then Y then Z. The texture channel steps
	through texture ids every textureFrames frames. The UV channel scrolls the
	texture by 1/uvStepsU and 1/uvStepsV. renderMode & 0xE picks the
	translucency mode. A hide condition (hideMode 1 or 2, hideFlags) sets the
	alpha to 0, for instance by day or night. Model effects can speed up some
	channels during charge motions (accel flags, speedMul).
	Charge level = the charge timer (PlayerWork +0xB24) / the class's charge
	step; "in quest" = gameState1 2 or 3.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>

enum EffectTrigger : u8 {
    Always                  = 0x00,
    OutsideTown             = 0x01,
    InQuest                 = 0x02,
    WeaponDrawn             = 0x03,
    ChargeAbove1            = 0x04,
    WeaponSheathed          = 0x05,
    MotionsA                = 0x08,
    DrawnSpecialState       = 0x09,
    MotionsB                = 0x0A,
    Charging                = 0x0B,
    ChargeAtLeast3          = 0x0C,
    DrawnNotCharging        = 0x0D,
    Unk0E                   = 0x0E,
    DrawnNoSpecialState     = 0x0F,
    ChargeLevel2            = 0x10,
    ChargeLevel4            = 0x11,
    ChargeLevel1            = 0x12,
    DualBladesMotionsC      = 0x13,
    DualBladesNotMotionsC   = 0x14,
    DualBladesStateOff      = 0x15,
    DualBladesStateOn       = 0x16,
    MotionsD                = 0x17,
    ChargeAtLeast1          = 0x18,
    ChargeAtLeast2          = 0x19,
    ChargeAtLeast3b         = 0x1A,
    NotMotionsA             = 0x1B,
    LongSwordStateOff       = 0x1C,
    LongSwordStateOn        = 0x1D,
    LanceStateA             = 0x1E,
    LanceStateB             = 0x1F,
    SpecialState            = 0x20,
    EntityAction            = 0x21,
    NoEntityAction          = 0x22,
    GunlanceTimer           = 0x23,
    Unk24                   = 0x24,
    Weapon6SpecialMode      = 0x25,
    Unk26                   = 0x26,
    SwitchAxeMode1          = 0x27,
    SwitchAxeMode2          = 0x28,
    LongSwordCharge100      = 0x29,
    ActCategory3            = 0x2A,
    Unk2B                   = 0x2B,
    LongSwordMotion57C      = 0x2C,
    LongSwordMotion57E      = 0x2D,
    LongSwordMotion580      = 0x2E,
    MagnetSpikeHeatOff      = 0x2F,
    MagnetSpikeHeatOn       = 0x30,
    WeaponSheathedB         = 0x31,
    WeaponDrawnB            = 0x32,
    ChargingB               = 0x33
};

enum EffectAttach : u8 {
    PartModel = 0,
    Root      = 4
};

enum GunPart : u8 {
    None    = 0,
    Part1   = 1,
    Part2   = 2,
    Part3   = 3,
    Part4   = 4,
    Part5   = 5
};

struct AngleChannel {
    s16 start;
    s16 end;
    s16 loops;
    u16 period;
};

// =======================
// Weapon effects
// =======================

struct WeaponEffectSet {
    u8  unk00;
    u8  unk01;
    u16 effects[8];
};

WeaponEffectSet weaponEffectSets[(nextTable(header.ptrs.weaponEffectSets) - header.ptrs.weaponEffectSets) / 0x12]
    @ header.ptrs.weaponEffectSets
    [[name("Weapon Effect Sets")]];

struct WeaponEffect {
    float  offset[3];
    EffectTrigger trigger;
    u8     bone;
    EffectAttach attach;
    u8     unk0F;
    u16    texture                [[comment("Shown when the texture channel does not loop")]];
    u16    startDelay;
    u16    firstTexture;
    u16    lastTexture;
    s16    textureLoops;
    u16    textureFrames;
    AngleChannel rotationX;
    AngleChannel rotationY;
    AngleChannel rotationZ;
    float  scaleStart;
    float  scaleEnd;
    s16    scalePingPong;
    s16    scaleLoops;
    u16    scalePeriod;
    u8     unk42[4];
    u8     renderMode;
    u8     billboard[3]           [[comment("All three set: faces the camera fully")]];
    u8     colorStart[3];
    u8     colorEnd[3];
    s16    colorPingPong;
    s16    colorLoops;
    u16    colorPeriod;
    u16    alphaStart;
    u16    alphaEnd;
    s16    alphaLoops;
    u16    alphaPeriod;
    u8     alphaPingPong;
    u8     unk5F;
    u16    unk60;
    s16    uvStepsU;
    s16    uvStepsV;
    u16    uvPeriod;
    s16    uvLoops;
    u16    unk6A;
    float  cameraPull             [[comment("Moves the sprite toward the camera")]];
    u8     extraDraw              [[comment("1 or 2: a second draw pass, in extraColor")]];
    u8     extraColor[3];
    GunPart gunPart               [[comment("Ranged weapons: shown only while this part is there")]];
    u8     hideMode;
    u8     hideFlags;
    u8     unk77;
    u8     unk78;
    u8     skipLoops              [[comment("Spawned with every loop counter at 0")]];
    u8     unk7A[6];
};

WeaponEffect weaponEffects[(nextTable(header.ptrs.weaponEffects) - header.ptrs.weaponEffects) / 0x80]
    @ header.ptrs.weaponEffects
    [[name("Weapon Effects")]];

// =======================
// Model effects
// =======================

enum EffectPart : u16 {
    End    = 0,
    Weapon = 1,
    Head   = 2,
    Chest  = 3,
    Arms   = 4,
    Waist  = 5,
    Legs   = 6
};

enum EffectWearer : u16 {
    Male   = 0,
    Female = 1,
    Npc    = 2
};

struct ModelEffectSet {
    EffectPart   part;
    u16          weaponClass;
    EffectWearer wearer;
    u16          modelId;
    u16          effects[8];
};

struct ModelEffectSets {
    ModelEffectSet unused;
    ModelEffectSet sets[while(std::mem::read_unsigned($, 2) != 0)];
    ModelEffectSet end;
};

ModelEffectSets modelEffectSets @ header.ptrs.modelEffectSets [[name("Model Effect Sets")]];

struct ModelAngleChannel {
    AngleChannel channel;
    float speedMul;
};

// Only the Z channel's accel byte is read
struct ModelScaleChannel {
    float start;
    float end;
    float speedMul;
    s16   loops;
    u16   period;
    u8    accel;
    u8    pingPong;
    u16   unk12;
};

struct ModelEffect {
    float  offset[3];
    EffectTrigger trigger;
    u8     mesh;
    u8     meshPart;
    u8     bone;
    u16    startDelay;
    u16    unk12;
    u8     accelRotationX;
    u8     accelRotationY;
    u8     accelRotationZ;
    u8     unk17;
    ModelAngleChannel rotationX;
    ModelAngleChannel rotationY;
    ModelAngleChannel rotationZ;
    ModelScaleChannel scaleX;
    ModelScaleChannel scaleY;
    ModelScaleChannel scaleZ;
    u8     renderMode;
    u8     unk79[3];
    u8     colorStart[3];
    u8     colorEnd[3];
    s16    colorPingPong;
    s16    colorLoops;
    u16    colorPeriod;
    u16    alphaStart;
    u16    alphaEnd;
    s16    alphaLoops;
    u16    alphaPeriod;
    u8     alphaPingPong;
    u8     unk91;
    u16    unk92;
    s16    uvStepsU;
    s16    uvStepsV;
    u16    uvPeriod;
    s16    uvLoops;
    u16    unk9C;
    u16    unk9E;
    u8     uvMode;
    u8     unkA1[7];
    GunPart gunPart;
    u8     hideMode;
    u8     hideFlags;
    u8     unkAB;
    u8     startActive;
    u8     unkAD;
    u8     unkAE[6];
};

ModelEffect modelEffects[(nextTable(header.ptrs.modelEffects) - header.ptrs.modelEffects) / 0xB4]
    @ header.ptrs.modelEffects
    [[name("Model Effects")]];

/**
	Equipment model effects (headers 0xADC / 0xAD8): 10 lists of {model id,
	effect row}, sorted by model id at load (rd_mhfdat) and searched by
	equip_model_effect_row_find. List 4 + gender is read with the body model
	(entity +0x398), 6 + gender with the waist model (+0x39C), 8 with the weapon
	model; lists 0-3 and 9 have no reader found. An effect row of 0xAD8 holds 4
	{effect, param}; effect indexes DLL table 0x118DEA08 (0x14-byte rows; above
	0x70 ends the row) whose kind picks a handler of 0x118DF2DC. 110 rows on
	the EN / JP files (the highest index used is 109).
*/

struct EquipModelEffectKey {
    u16 model;
    u16 effectRow;
};

struct EquipModelEffectList {
    u32 count;
    EquipModelEffectKey *keys[count] : u32;
};

struct EquipModelEffectLists {
    EquipModelEffectList unk0[4];
    EquipModelEffectList bodyMale;
    EquipModelEffectList bodyFemale;
    EquipModelEffectList waistMale;
    EquipModelEffectList waistFemale;
    EquipModelEffectList weapon;
    EquipModelEffectList unk9;
};

struct EquipModelEffect {
    s16 effect;
    u16 param;
};

struct EquipModelEffectRow {
    EquipModelEffect effects[4];
};

EquipModelEffectLists equipModelEffectLists @ header.ptrs.equipModelEffectLists [[name("Equip Model Effect Lists")]];
EquipModelEffectRow equipModelEffectRows[110] @ header.ptrs.equipModelEffectRows [[name("Equip Model Effect Rows")]];
