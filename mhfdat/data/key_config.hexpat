#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Key configuration defaults (header 0x6F8-0x714). keyconfig_parse_buffer
// (0x108D6420) reads the ini-like key config (ver, name, pattern, config,
// operate_type, assign%02u ...); these tables give the default bindings. The
// bindings are grouped by input context: 0x6F8 is the group count (21), 0x6FC
// the action count of each group, and every table below holds one pointer per
// group to that many action rows (rd_mhfdat relocates them with these counts).
// - 0x708: 8 keyboard presets, rows of 9 {key, subKey} (0x48 bytes,
//   keyconfig_key_group_copy_preset; the parser passes ini pattern 0 / 1 / 2 / 4
//   as preset 1 / 3 / 2 / 4).
// - 0x70C: 5 presets by operate type, rows of 8 {key, subKey} (0x40 bytes,
//   keyconfig_apply_operate_type, which then adds the ASSIGN_* mouse slots).
// - 0x700: pad assign slots, {u16 slot, u16 slot2} per action (slots 0-27,
//   >= 0x1C = none; keyconfig_pad_slot_action_map_build,
//   keyconfig_group_bindings_from_slots).
// - 0x704: 5 pad presets (index = ini pattern, keyconfig_pad_preset_apply),
//   2 {u32 buttons, u32 buttons2} per action.
// - 0x710: 5 mouse assign sets by operate type, s32[8] = the action (index into
//   the 50 action names at DLL 0x11889C30) of MOVE / LB / RB / CB / WU / WD /
//   CBWU / CBWD (keyconfig_operate_type_load_mouse_assign).
// - 0x714: DirectInput key codes a character can be typed with while the key
//   config edit mode is 6 (keyconfig_char_key_poll), 0-terminated.
// key: a DirectInput scan code (17 = DIK_W) or a mouse bit (0x40, 0x80, 0x100,
// 0x10, 0x20, 0x1000, 0x2000); subKey: 29 DIK_LCONTROL / 42 DIK_LSHIFT, else 0.
// The 21 group names (input contexts) are not known.
// =======================

struct KeyBinding {
    u32 key;
    u32 subKey;
};

struct KeyPresetAction {
    KeyBinding bindings[9];
};

struct KeyOperateAction {
    KeyBinding bindings[8];
};

struct PadSlotAction {
    u16 slot [[comment("Pad assign slot 0-27 (ASSIGN_DLU ... at DLL 0x11889BB0); >= 0x1C: none")]];
    u16 slot2;
};

struct PadButtons {
    u32 buttons;
    u32 buttons2;
};

struct PadPresetAction {
    PadButtons buttons[2];
};

fn keyGroupCount() {
    return std::mem::read_unsigned(header.ptrs.keyConfigGroupCount, 1);
};

fn keyActionCount(u32 group) {
    return std::mem::read_unsigned(header.ptrs.keyConfigActionCounts + group, 1);
};

struct KeyGroup<T> {
    u32 group = std::core::array_index();
    T *actions[keyActionCount(group)] : u32;
};

struct KeyPreset<T> {
    KeyGroup<T> *groups[keyGroupCount()] : u32;
};

struct MouseAssignSet {
    s32 *actions[8] : u32 [[comment("Action of MOVE / LB / RB / CB / WU / WD / CBWU / CBWD")]];
};

u8 keyConfigGroupCount @ header.ptrs.keyConfigGroupCount [[name("Key Config Group Count")]];
u8 keyConfigActionCounts[keyGroupCount()] @ header.ptrs.keyConfigActionCounts [[name("Key Config Action Counts")]];
KeyGroup<PadSlotAction> keyConfigPadSlots[keyGroupCount()] @ header.ptrs.keyConfigPadSlots [[name("Key Config Pad Slots")]];
KeyPreset<PadPresetAction> keyConfigPadPresets[5] @ header.ptrs.keyConfigPadPresets [[name("Key Config Pad Presets")]];
KeyPreset<KeyPresetAction> keyConfigKeyPresets[8] @ header.ptrs.keyConfigKeyPresets [[name("Key Config Keyboard Presets")]];
KeyPreset<KeyOperateAction> keyConfigOperatePresets[5] @ header.ptrs.keyConfigOperatePresets [[name("Key Config Operate Type Presets")]];
MouseAssignSet keyConfigMouseAssign[5] @ header.ptrs.keyConfigMouseAssign [[name("Key Config Mouse Assign")]];
u8 keyConfigCharKeys[while(std::mem::read_unsigned($, 1) != 0)] @ header.ptrs.keyConfigCharKeys [[name("Key Config Character Keys")]];
