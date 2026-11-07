#pragma once

/**
	Weapon action scripts (header 0x614): one {count, actions} row per weapon
	class, in class order. The only action source of the Tonfa, the Switch Axe
	F and the Magnet Spike; the other classes use them for their Extreme style
	(and the bowguns and the bow for their own acts).
	An action runs its steps: kind 0 / 1 return the hunter to the neutral
	state (entity_action_start_motion / FUN_10A81C20 -> initialize_entity_motion,
	mhf-client ToNormal: actType 0, the game picks the idle motion) with
	blend2x / 2 blend ticks from startFrame (motion unread), 2 calls the
	weapon with motion as argument, 3 / 4 / 5 play motion from startFrame and
	wait waitCount loops (3), waitCount loops then waitFrame (4), or hold (5).
	A cancel opens on input inputId between its window conditions and goes to
	nextActType. An event calls the class handler with (type, arg) when its
	condition holds. A condition: mode 1 true, 2 false, else step / blend /
	frame / loop count.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>

struct ActionCondition {
    u16 step;
    u8  mode;
    s8  blend;
    u16 frame;
    u16 count;
};

struct ActionStep {
    s16 kind;
    u16 motion;
    u16 startFrame;
    s16 blend2x;
    u16 waitFrame;
    u16 waitCount;
};

struct ActionCancel {
    u16 minStep;
    u16 inputId;
    u16 groupBit;
    ActionCondition windowAOpen;
    ActionCondition windowAClose;
    u16 nextActType;
    ActionCondition windowBOpen;
    ActionCondition windowBClose;
};

struct ActionEvent {
    ActionCondition condition;
    u16 handlerType;
    u16 handlerArg;
};

struct WeaponAction {
    s32 stepCount;
    ActionStep *steps[stepCount] : u32;
    s32 cancelCount;
    ActionCancel *cancels[cancelCount] : u32;
    s32 eventCount;
    ActionEvent *events[eventCount] : u32;
};

struct WeaponActionList {
    s32 count;
    WeaponAction *actions[count] : u32;
} [[name(className(std::core::array_index()))]];

WeaponActionList weaponActions[14] @ header.ptrs.weaponActions [[name("Weapon Action Scripts")]];
