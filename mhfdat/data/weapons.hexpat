#pragma once

#include <misc/s32p.pat>
#include <std/core.pat>
#include <mhfdat/utils/index.pat>

// Multiply n by 10 (Used for pattern formatting)
fn timesten (u8 n) {
	return n*10;
};

// 0x34 is the size of MeleeWeaponEntry
fn meleeNameWE (auto n) {
	u16 weapon_id = (($-header.ptrs.meleeWeapons) / 0x34);
	str weapon_name = rIPPS(header.ptrs.meleeWeaponNames, weapon_id);
	return std::format("{:04X} | {}", weapon_id, weapon_name);
};

// 0x3C is the size of RangedWeaponEntry
fn rangedNameWE (auto n) {
	u16 weapon_id = (($-header.ptrs.rangedWeapons) / 0x3C);
	str weapon_name = rIPPS(header.ptrs.rangedWeaponNames, weapon_id);
	return std::format("{:04X} | {}", weapon_id, weapon_name);
};
	
// TODO: Maybe replace these functions with enums?
// It won't look as pretty but it'd make a bit more sense
fn elementName (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "None";
		(0x01): ret = "Fire";
		(0x02): ret = "Water";
		(0x03): ret = "Thunder";
		(0x04): ret = "Dragon";
		(0x05): ret = "Ice";
		(0x06): ret = "Flame";
		(0x07): ret = "Light";
		(0x08): ret = "Thunder Pole";
		(0x09): ret = "Tenshou";
		(0x0A): ret = "Okiko";
		(0x0B): ret = "Black Flame";
		(0x0C): ret = "Kanade";
		(0x0D): ret = "Darkness";
		(0x0E): ret = "Crimson Demon";
		(0x0F): ret = "Wind";
		(0x10): ret = "Sound";
		(0x11): ret = "Burning Zero";
		(0x12): ret = "Emperor's Roar";
	}
	
	return ret;
};
	
fn ailmentName (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "None";
		(0x01): ret = "Poison";
		(0x02): ret = "Paralysis";
		(0x03): ret = "Sleep";
		(0x04): ret = "Blast";
	}

	return ret;
};
	
fn eqType (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "General";
		(0x01): ret = "SP";
		(0x02): ret = "Gou";
		(0x04): ret = "Evolution";
		(0x08): ret = "HC";
		(0x12): ret = "Random Weapon";
		(0x24): ret = "Ravi";
		(0x40): ret = "G50";
	}
	
	return ret;
};

fn weaponType (u32 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00000000): ret = "General";
		(0x00000800): ret = "Prayer LR";
		(0x00000808): ret = "Prayer GR";
		(0x00000200): ret = "Exotique";
		(0x00001000): ret = "Zenith";
		(0x00000002): ret = "Gou HR1";
		(0x00000004): ret = "Gou HR2";
		(0x00000010): ret = "Gou GR1";
		(0x00000020): ret = "Gou GR2";
		(0x00000100): ret = "Gou GR3";
		(0x00000008): ret = "GR Gunner";
		(0x08000000): ret = "GR Simple upgrade";
		(0x00000041): ret = "Finess weapon";
		(0x00004000): ret = "Ravi GR+";
		(0x00000080): ret = "Tower";
	}

	return ret;
};

fn zenithSkill (u16 n){
	str ret = "!!Unknown!!";

	match (n){
		(0x0000): ret = "None";
		(0x0001): ret = "Skill Slot UP +1"; //1
		(0x0002): ret = "Skill Slot UP +2"; //2
		(0x0003): ret = "Skill Slot UP +3"; //3
		(0x0004): ret = "Skill Slot UP +4"; //4
		(0x0005): ret = "Skill Slot UP +5"; //5
		(0x0006): ret = "Skill Slot UP +6"; //6
		(0x0007): ret = "Skill Slot UP +7"; //7
		(0x0008): ret = "Crit Conv UP +1"; //8
		(0x0009): ret = "Crit Conv UP +2"; //9
		(0x000A): ret = "Stylish Assault UP +1"; //10
		(0x000B): ret = "Stylish Assault UP +2"; //11
		(0x000C): ret = "Disolver UP"; //12
		(0x000D): ret = "ThunderClad UP +1"; //13
		(0x000E): ret = "ThunderClad UP +2"; //14
		(0x000F): ret = "Ice Age UP"; //15
		(0x0011): ret = "Earplug UP +1"; //16
		(0x0012): ret = "Earplug UP +2"; //17
		(0x0013): ret = "Earplug UP +3"; //18
		(0x0014): ret = "Wind Res UP +1"; //19
		(0x0015): ret = "Wind Res UP +2"; //20
		(0x0016): ret = "Wind Res UP +3"; //21
		(0x0017): ret = "Wind Res UP +4"; //22
		(0x0018): ret = "Quake Res UP +1"; //23
		(0x0019): ret = "Quake Res UP +2"; //24
		(0x001A): ret = "Poison Res UP +1"; //25
		(0x001B): ret = "Poison Res UP +2"; //26
		(0x001C): ret = "Para Res UP +1"; //27
		(0x001D): ret = "Para Res UP +2"; //28
		(0x001E): ret = "Sleep Res UP +1"; //29
		(0x001F): ret = "Sleep Res UP +2"; //30
		(0x0020): ret = "Vampirism UP +1"; //31
		(0x0021): ret = "Vampirism UP +2"; //32
		(0x0022): ret = "DrugKnowledge UP"; //33
		(0x0023): ret = "Assistance UP"; //34
		(0x0024): ret = "Bullet Shaver UP +1"; //35
		(0x0025): ret = "Bullet Shaver UP +2"; //36
		(0x0026): ret = "Guard UP +1"; //37
		(0x0027): ret = "Guard UP +2"; //38
		(0x0028): ret = "Adaptation UP +1"; //39
		(0x0029): ret = "Adapdation UP +2"; //40
		(0x002A): ret = "Encourage UP +1"; //41
		(0x002B): ret = "Encourage UP +2"; //42
		(0x002C): ret = "Reflect UP +1"; //43
		(0x002D): ret = "Reflect UP +2"; //44
		(0x002E): ret = "Reflect UP +3"; //45
		(0x002F): ret = "Stylish UP"; //46
		(0x0030): ret = "Vigorous UP"; //47
		(0x0031): ret = "Obscurity UP"; //48
		(0x0032): ret = "Soul UP"; //49
		(0x0033): ret = "Ceaseless UP"; //50
		(0x0034): ret = "Rush UP"; //51

	}
	return ret;
};
	
// Equip type bits (melee +0x1A, ranged +0x06), each tested on its own:
// 1 Weapon_sp_eqtype_ck, 2 WeaponHcGousyuChk_*, 4 get_equiptype_or_ammo_type
// (evolution), 8 weapon_equip_block_has_flag8, 0x10 chk_ex_g_weapon, 0x20
// FUN_104FE940, 0x40 Weapon_g_class_check; 0x80 has no tester.
bitfield MeleeEquipType {
    sp : 1;
    hcGousyu : 1;
    evolution : 1;
    bit3 : 1;
    exG : 1;
    bit5 : 1;
    gClass : 1;
    bit7 : 1;
};

// Weapon category bits (melee +0x20, ranged +0x0C): named after their
// Weapon_g_class_*_check testers; the other bits are tested by unnamed code.
bitfield WeaponCategoryBits {
    bit0 : 1;
    bit1 : 1;
    bit2 : 1;
    bit3 : 1;
    hasyu : 1 [[comment("0x10 Weapon_g_class_hasyu_check")]];
    retsusyu : 1 [[comment("0x20 Weapon_g_class_retsusyu_check")]];
    finessExt : 1 [[comment("0x40 Weapon_g_class_finess_ext_check")]];
    tower : 1 [[comment("0x80 Weapon_g_class_tower_check")]];
    gousyuGr3 : 1 [[comment("0x100 Weapon_g_class_gousyu_gr3_check")]];
    exotique : 1 [[comment("0x200 Weapon_g_class_exotique_check")]];
    bit10 : 1 [[comment("0x400, tested by 34 functions")]];
    prayer : 1 [[comment("0x800 Weapon_g_class_prayer_check")]];
    zenith : 1 [[comment("0x1000 Weapon_g_class_zenith_check")]];
    unused : 19;
};

struct MeleeItem {
	u16 modelId [[color("0088FF")]];
	u8 rarity [[format("plusone"), color("22FF22")]];
	u8 classId [[format("className"), color("0088FF")]];
	u32 zennyCost [[comment("Forge cost and sell price are zennyCost / 2"), color("22FF22")]];
	u8 sharpnessId [[color("FFFF00"), comment("Row of SharpnessIds[class] (weapon_melee_sharpness_color_tier)")]];
	u8 sharpnessMax [[color("FFF000"), comment("Max sharpness = (v + 3) x 50 (weapon_max_sharpness_value_compute)")]];
	u16 rawDamage [[comment("Attack = raw x weaponDamageCoefficients[class] +0xC / 100"), color("22FF22")]];
	s16 defense [[color("22FF22"), comment("Added to the armor defense sum (WeaponStat_GetPreviewValue); negative on some rows")]];
	s8 affinity [[color("22FF22")]];
	u8 elementId [[format("elementName"), color("00FF00")]];
	u8 eleDamage [[format("timesten"), color("00FF00")]];
	u8 ailmentId [[format("ailmentName"), color("00FF00")]];
	u8 ailDamage [[format("timesten"), color("00FF00")]];
	u8 slots [[color("00FF00"), comment("Also the seal slot count of tower weapons (get_tower_seal_slot_count)")]];
	u8 weaponAttribute [[comment("By class: Switch Axe F phial type (get_switchaxe_phial), horn notes, gunlance shell ...")]];
	u8 seisanFlag [[comment("Seisan_flag_ck code (equip_ok_ck, the forge upgrade lists)")]];
	u8 sortOrder [[comment("equip_sort_value rank inside the class; 255 = none")]];
	u8 unk17 [[comment("No reader, always 0")]];
	u16 unk18 [[comment("No reader found (full DLL sweep); often the row's own modelId")]];
	MeleeEquipType equipType;
	u8 unk1B [[comment("No reader, always 0")]];
	u8 length [[comment("Reach class 0-5 (get_melee_weapon_length, wpn_apply_reach_mismatch_coef)")]];
	u8 periodEquipFlag [[comment("equipbox_apply_post_festi_id_shift: 1 = box id + 1, 2 = box id - 1 (Wii U chg_period_equip_arg); all 0")]];
	u8 unk1E[2] [[comment("No reader, always 0")]];
	WeaponCategoryBits weaponCategory;
	u16 visualEffects [[comment("weapon_effect_init: row of weaponEffectSets (header 0x280)")]];
	u16 Tower_G50_Param_ID [[name("Tower/G50 Param ID"), comment("g50_tower_params_pointers list index")]];
	u16 gRank [[name("G Rank"), color("FF0000"), comment("Read as a u16 (get_ex_g_weapon_rank)")]];
	u8 decoSpecialSlot [[comment("Deco_item_check: special decorations need 1, the others 0")]];
	u8 modelVariant [[comment("pl_weapon_model_init model variant; 9 = the -so model")]];
	u16 towerMaxCost [[comment("get_tower_weapon_max_cost")]];
	u16 motionBankType [[comment("get_weapon_motion_bank_path: Switch Axe F motion type A-E")]];
	u16 zenithSkill [[name("Zenith Skills"), format("zenithSkill")]];
	padding[2];
};

fn reload (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Very Slow";
		(0x01): ret = "Slow";
		(0x02): ret = "Normal";
		(0x03): ret = "Fast";
		(0x04): ret = "Very Fast";
	}
	return ret;
};

fn recoil (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Very High";
		(0x01): ret = "High";
		(0x02): ret = "Normal";
		(0x03): ret = "Low";
		(0x04): ret = "Very Low";
	}
	return ret;
};
	
struct RangedItem {
	u16 modelId;
	u8 rarity [[format("plusone")]];
	u8 levelModGroup [[comment("Bowgun level modifier group: header 0xB0 row = levelModGroup x 5 + (equipment level & 0xF) (gunner_load_coating_modifier_row, get_ranged_effective_raw_damage): a raw bonus and shot speed / gravity multipliers. 0 on bows")]];
	u8 classId [[format("className")]];
	u8 unk05 [[comment("No reader, always 0")]];
	u8 eq [[name("Equip Type"), format("eqType"), color("FFFF00")]];
	u8 unk07 [[comment("No reader, always 0")]];
	u16 unk08 [[comment("No reader; always the modelId of some ranged row (like melee otherModelId)")]];
	u8 postFestiShift [[comment("equipbox_apply_post_festi_id_shift: 1 = box id + 1, 2 = box id - 1; always 0")]];
	u8 unk0B [[comment("No reader, always 0")]];
	u32 Weapon_type [[name("Weapon Category"), format("weaponType"), comment("Category bits (zenith 0x1000, prayer 0x800, exotic 0x200, tower 0x80, ...), the bits of melee +0x20")]];
	u16 visualEffects [[comment("weapon_effect_init: row of weaponEffectSets (header 0x280)")]];
	u16 unk12 [[comment("No reader, always 0")]];
	u32 zennyCost [[comment("Create / sell price is zennyCost / 2")]];
	u16 rawDamage;
	s16 defense [[comment("Added to the armor defense sum (WeaponStat_GetPreviewValue); 7 rows are negative")]];
	u8 recoil [[format("recoil")]];
	u8 slots;
	s8 affinity;
	u8 sortOrder [[comment("equip_sort_value rank (melee +0x16)")]];
	u8 shotSetId [[comment("Bowgun: BulletSets (header 0xA4) row, the clip size of each ammo; bow: header 0xA8 row, 4 charge level shots (pBowChargeTexts)")]];
	u8 elementId [[format("elementName")]];
	u8 eleDamage [[format("timesten")]];
	u8 reload [[format("reload")]];
	u8 seisanFlag [[comment("Seisan_flag_ck argument (melee +0x15)")]];
	u8 unk25 [[comment("No reader, always 0")]];
	u16 towerMaxCost [[comment("get_tower_weapon_max_cost (melee +0x2C)")]];
	u32 ammoMask [[comment("gunner_usable_ammo_and_coating_mask: usable ammo bits (bowguns) / coating bits (bows)")]];
	u16 Tower_G50_Param_ID [[name("Tower/G50 Param ID"), comment("get_gcls_param_id: index of the Tower / G50 level stat list")]];
	u8 arcShotType [[comment("bow_arc_type_get (bows, 0-3)")]];
	u8 unk2F [[comment("No reader, always 0")]];
	u8 G_rank [[name("G Rank"), color("FF0000"), comment("Read as a u16 with the next byte (get_ex_g_weapon_rank)")]];
	u8 unk31 [[comment("High byte of the G rank u16, always 0")]];
	u8 decoSpecialSlot [[comment("Deco_item_check: special decorations need 1 here, the others 0 (melee +0x2A)")]];
	u8 modelVariant [[comment("pl_weapon_model_init model variant (melee +0x2B), always 0x0F")]];
	u8 ailmentId [[format("ailmentName"), comment("get_weapon_ail_damage_if_ailment, weapon_element_status_affinity_value")]];
	u8 ailDamage [[format("timesten")]];
	u16 zenithSkill [[name("Zenith Skills"), format("zenithSkill")]];
	u32 unk38 [[hidden, comment("No reader, always 0")]];
};

struct WeaponName {
	s32p name;
};

struct WeaponDescription {
	s32p description_1;
	s32p description_2;
	s32p description_3;
	s32p mhfy;
};

struct TableWeapons {
	MeleeItem  meleeEntries  [ while (std::mem::read_signed($, 2) != -1) ] @ header.ptrs.meleeWeapons [[name("Melee")]];
	RangedItem rangedEntries [ while (std::mem::read_signed($, 2) != -1) ] @ header.ptrs.rangedWeapons [[name("Ranged")]];
};

TableWeapons tableWeapons;

u32 MeleeLength    = sizeof(MeleeItem);
u32 RangedLength   = sizeof(RangedItem);
u32 MeleeQuantity  = (sizeof(tableWeapons.meleeEntries)/MeleeLength);
u32 RangedQuantity = (sizeof(tableWeapons.rangedEntries)/RangedLength);

struct WeaponMelee {
	MeleeItem         data         [MeleeQuantity] @ header.ptrs.meleeWeapons       [[name("Data")]];
  WeaponName        names        [MeleeQuantity] @ header.ptrs.meleeWeaponNames   [[name("Names")]];
  WeaponDescription descriptions [MeleeQuantity] @ header.ptrs.meleeWeaponDesc    [[name("Descriptions")]];
};

struct WeaponRanged {
	RangedItem        data         [RangedQuantity] @ header.ptrs.rangedWeapons     [[name("Data")]];
  WeaponName        names        [RangedQuantity] @ header.ptrs.rangedWeaponNames [[name("Names")]];
  WeaponDescription descriptions [RangedQuantity] @ header.ptrs.rangedWeaponDesc  [[name("Descriptions")]];
};

struct Weapons {
  WeaponMelee  melee  @ header.ptrs.meleeWeapons  [[name("Melee")]];
  WeaponRanged ranged @ header.ptrs.rangedWeapons [[name("Ranged")]];
};

Weapons weapons @ header.ptrs.meleeWeapons [[name("Weapons")]];

// =======================
// Compound elements (header 0x6A8): element types 6-18 (elementName), one
// row each, row = type - 6. Each row is up to 5 {base element 1-5, percent}
// pairs, element 0 ends it. element_compound_split (FUN_1081F980) and
// element_compound_part_value (value x percent / 100) read them;
// transcend_add_attack_exp_by_weapon picks the matching Veins.
// =======================

struct CompoundElementPart {
    u8 element [[format("elementName")]];
    u8 percent;
};

struct CompoundElement {
    CompoundElementPart parts[5];
} [[name(elementName(std::core::array_index() + 6))]];

CompoundElement compoundElements[13] @ header.ptrs.compoundElements [[name("Compound Elements")]];
