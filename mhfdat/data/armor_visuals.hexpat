#pragma once

#include <std/mem.pat>

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Armor model id limits (header 0x0E4): one row per gender (player +0x11: 0
// male, 1 female; rows 2 and 3 are 0). The slots follow the equipment counts
// order. When the model id resolved for a slot (modelIdMale / modelIdFemale of
// the worn piece) is >= the limit, the model shown is 0 (armor_model_ids_resolve);
// a preset with -1 for a slot takes random % limit + 1 (player_preset_model_roll).
// Armor colors (header 0x140): 0xAARRGGBB, index = player +0xCA2 (0xFF: none,
// 0xB: FUN_10B86850 instead), turned into RGB floats by
// armor_unk0A_bit0_set_rgb_from_color_table.
// =======================

struct ArmorModelIdLimits {
    u16 leg;
    u16 face [[comment("Slot 1 (equips[1], the face): not checked against the model id; a preset face is random % face + 1")]];
    u16 head;
    u16 body;
    u16 arm;
    u16 waist;
    u16 unk0C [[comment("Slot 6: limit of a byte value in FUN_105E05E0 / FUN_11521B60")]];
};

ArmorModelIdLimits armorModelIdLimits[4] @ header.ptrs.armorModelIdLimits [[name("Armor Model Id Limits")]];

struct ArmorColor {
    u8 b;
    u8 g;
    u8 r;
    u8 a;
};

ArmorColor armorColors[112] @ header.ptrs.armorColors [[name("Armor Colors")]];

// Inner body models (header 0x31C): the body model shown under an empty leg,
// body or arm slot. inner_body_model_get finds the row whose skin tone 0 model
// is the resolved model id and returns the model of the player's inner
// (+0xC4F), gender (+0x11) and skin tone (+0x710, from the face row of header
// 0x320). One block per inner (important numbers + 0xDA).

struct InnerBodyModelsGender {
    u16 bySkinTone[4];
};

struct InnerBodyModelsPart {
    InnerBodyModelsGender byGender[2];
};

struct InnerBodyModels {
    InnerBodyModelsPart leg;
    InnerBodyModelsPart body;
    InnerBodyModelsPart arm;
};

InnerBodyModels innerBodyModels[importantNums.numInners] @ header.ptrs.innerBodyModels [[name("Inner Body Models")]];

// Equipment without a preview (header 0x7E0): equip_has_preview returns 0 for
// a listed (kind, id). The forge previews (forge_armor_preview_update ...) and
// the equipment shop (Lb_equip_app_shop_move) then do not load the model and
// the forge shows mhfpac pKakoTexts[65] "There is no preview" (the same as for
// a head piece with no model for its genders). Ends at a kind or id of 0;
// 522 rows, all waist pieces, on the EN, JP and rain files.
struct NoPreviewEquipment {
    u16 kind [[format("getEquipType")]];
    u16 id;
} [[format("noPreviewEquipmentName")]];

fn noPreviewEquipmentName(ref auto e) {
    return std::format("{} | {}", getEquipType(e.kind), getEquipKindName(e.kind, e.id));
};

struct NoPreviewEquipmentList {
    NoPreviewEquipment items[while(std::mem::read_unsigned($, 2) != 0 && std::mem::read_unsigned($ + 2, 2) != 0)];
    u32 end;
};

NoPreviewEquipmentList noPreviewEquipment @ header.ptrs.noPreviewEquipment [[name("No Preview Equipment")]];
