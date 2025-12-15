#pragma once

#include <std/io.pat>
#include <std/string.pat>

enum autoSkillList : u16 {
	No_Skill = 0,

	Para_Halved = 1,
	Para_Negate = 2,
	Para_Doubled = 3,

	Sleep_Halved = 4,
	Sleep_Negate = 5,
	Sleep_Doubled = 6,

	Stun_Halved = 7,
	Stun_Negate = 8,
	Stun_Doubled = 9,

	Poison_Halved = 10,
	Poison_Negate = 11,
	Poison_Doubled = 12,

	Deodorant = 13,
	Deodorant_Alt = 14,

	Unknown_015 = 15,

	Snowball_Resist = 16,
	Snowball_Resist_Alt = 17,

	Unknown_018 = 18,

	Sneak = 19,
	Taunt = 20,

	Health_Plus10 = 21,
	Health_Plus20 = 22,
	Health_Plus30 = 23,
	Health_Minus10 = 24,
	Health_Minus20 = 25,
	Health_Minus30 = 26,

	Recovery_Speed_Plus1 = 27,
	Recovery_Speed_Plus2 = 28,
	Recovery_Speed_Minus1 = 29,
	Recovery_Speed_Minus2 = 30,

	Razor_Sharp_Plus1 = 31,
	Blunt_Edge = 32,
	Sharpness_Plus1 = 33,

	Unknown_034 = 34,

	Critical_Eye_Plus1 = 35,
	Critical_Eye_Plus2 = 36,
	Critical_Eye_Plus3 = 37,

	Speed_Sharpening = 38,
	Slothful_Sharpening = 39,

	Guard_Plus1 = 40,
	Guard_Plus2 = 41,
	Guard_Minus1 = 42,
	Guard_Minus2 = 43,

	Auto_Guard = 44,
	Throwing_Distance_Up = 45,

	Reload_Speed_Plus1 = 46,
	Reload_Speed_Plus2 = 47,
	Reload_Speed_Plus3 = 48,
	Reload_Speed_Minus1 = 49,

	Unknown_050 = 50,

	Auto_Reload = 51,

	Recoil_Reduction_Plus1 = 52,
	Recoil_Reduction_Plus2 = 53,

	Normal_Shot_Up = 54,
	Pierce_Shot_Up = 55,
	Pellet_Shot_Up = 56,

	Normal_Shot_Add = 57,
	Normal_Shot_All = 58,

	Pierce_Shot_Plus_Lv1 = 59,
	Pierce_Shot_Plus_Lv1_Lv2 = 60,
	Pierce_Shot_Plus_All = 61,

	Pellet_Shot_Plus_Lv1 = 62,
	Pellet_Shot_Plus_Lv1_Lv2 = 63,
	Pellet_Shot_Plus_All = 64,

	Crag_Shot_Lv1 = 65,
	Crag_Shot_Lv1_Lv2 = 66,
	Crag_Shot_All = 67,

	Cluster_Shot_Plus_Lv1 = 68,
	Cluster_Shot_Plus_Lv1_Lv2 = 69,
	Cluster_Shot_Plus_All = 70,

	Status_Attack_Up = 71,
	Bomber = 72,

	Hunger_Halved = 73,
	Hunger_Negated = 74,
	Hunger_Up_Small = 75,
	Hunger_Up_Large = 76,

	Gourmand = 77,
	Scavenger = 78,

	Attack_Up_Small = 79,
	Attack_Up_Medium = 80,
	Attack_Up_Large = 81,

	Defense_Plus20 = 82,
	Defense_Plus30 = 83,
	Defense_Plus60 = 84,
	Defense_Minus20 = 85,
	Defense_Minus30 = 86,
	Defense_Minus40 = 87,

	Divine_Protection = 88,
	Goddess_Embrace = 89,
	Demonic_Protection = 90,
	Death_Gods_Embrace = 91,

	Earplugs = 92,
	High_Grade_Earplugs = 93,

	Anti_Theft = 94,

	Wide_Area_Plus1 = 95,
	Wide_Area_Plus2 = 96,

	Pro_Transporter = 97,

	All_Res_Plus5 = 98,
	All_Res_Plus10 = 99,
	All_Res_Plus20 = 100,
	All_Res_Minus5 = 101,
	All_Res_Minus10 = 102,
	All_Res_Minus20 = 103,

	Fire_Res_Plus10 = 104,
	Fire_Res_Plus20 = 105,
	Fire_Res_Plus30 = 106,
	Fire_Res_Minus10 = 107,
	Fire_Res_Minus20 = 108,
	Fire_Res_Minus30 = 109,

	Water_Res_Plus10 = 110,
	Water_Res_Plus20 = 111,
	Water_Res_Plus30 = 112,
	Water_Res_Minus10 = 113,
	Water_Res_Minus20 = 114,
	Water_Res_Minus30 = 115,

	Ice_Res_Plus10 = 116,
	Ice_Res_Plus20 = 117,
	Ice_Res_Plus30 = 118,
	Ice_Res_Minus10 = 119,
	Ice_Res_Minus20 = 120,
	Ice_Res_Minus30 = 121,

	Thunder_Res_Plus10 = 122,
	Thunder_Res_Plus20 = 123,
	Thunder_Res_Plus30 = 124,
	Thunder_Res_Minus10 = 125,
	Thunder_Res_Minus20 = 126,
	Thunder_Res_Minus30 = 127,

	Dragon_Res_Plus10 = 128,
	Dragon_Res_Plus20 = 129,
	Dragon_Res_Plus30 = 130,
	Dragon_Res_Minus10 = 131,
	Dragon_Res_Minus20 = 132,
	Dragon_Res_Minus30 = 133,

	Heat_Halved = 134,
	Heat_Negate = 135,
	Heat_Negate_Alt = 136,
	Heat_Surge_Small = 137,
	Heat_Surge_Large = 138,

	Cold_Halved = 139,
	Cold_Negate = 140,
	Cold_Negate_Alt = 141,
	Cold_Surge_Small = 142,
	Cold_Surge_Large = 143,

	Wind_Res_Small = 144,
	Wind_Res_Large = 145,
	Dragon_Wind_Breaker = 146,

	Map = 147,

	Unknown_148 = 148,

	Gathering_Plus1 = 149,
	Gathering_Plus2 = 150,
	Gathering_Minus1 = 151,
	Gathering_Minus2 = 152,

	Hi_Speed_Gathering = 153,

	Spirits_Whim = 154,
	Divine_Whim = 155,
	Spectres_Whim = 156,
	Devils_Whim = 157,

	Good_Luck = 158,
	Great_Luck = 159,
	Bad_Luck = 160,
	Horrible_Luck = 161,

	Fishing_Expert = 162,
	Detect = 163,
	Autotracker = 164,

	Recovery_Items_Up = 165,
	Recovery_Items_Down = 166,

	Combination_Plus10 = 167,
	Combination_Plus15 = 168,
	Combination_Plus30 = 169,
	Combination_Minus5 = 170,
	Combination_Minus15 = 171,

	Maximum_Bullets = 172,
	Alchemy = 173,

	Unknown_174 = 174,
	Unknown_175 = 175,
	Unknown_176 = 176,

	Evasion_Plus1 = 177,
	Evasion_Plus2 = 178,

	Adrenaline_Plus1 = 179,
	Adrenaline_Plus2 = 180,

	Worry = 181,

	Item_Duration_Up = 182,
	Item_Duration_Down = 183,

	Marathon_Runner = 184,
	Short_Sprinter = 185,

	Load_Up = 186,
	Deviation_Down = 187,
	Deviation_Up = 188,

	Come_On_Big_Guy = 189,

	Speed_Eating = 190,
	Slow_Eating = 191,

	Carving_Expert = 192,

	Hazard_Res_Small = 193,
	Hazard_Res_Large = 194,
	Hazard_Prone_Small = 195,
	Hazard_Prone_Large = 196,

	Quake_Res_Plus1 = 197,

	Vocal_Chord_Halved = 198,
	Vocal_Chord_Immunity = 199,

	BBQ_Expert = 200,
	BBQ_Master = 201,
	False_BBQ_Expert = 202,

	Gunnery = 203,

	Unknown_204 = 204,
	Unknown_205 = 205,
	Unknown_206 = 206,
	Unknown_207 = 207,
	Unknown_208 = 208,
	Unknown_209 = 209,
	Unknown_210 = 210,
	Unknown_211 = 211,

	Flute_Expert = 212,

	Unknown_213 = 213,
	Unknown_214 = 214,
	Unknown_215 = 215,
	Unknown_216 = 216,
	Unknown_217 = 217,

	Breakout = 218,
	Taijutsu = 219,

	Strong_Arm_Plus1 = 220,

	Unknown_221 = 221,

	Inspiration = 222,
	Passive = 223,

	Unknown_224 = 224,
	Unknown_225 = 225,
	Unknown_226 = 226,
	Unknown_227 = 227,

	Bond = 228,

	Unknown_229 = 229,

	Guts = 230,
	Great_Guts = 231,
	True_Guts = 232,

	Unknown_233 = 233,

	Pressure_Small = 234,
	Capture_Proficiency = 235,

	Unknown_236 = 236,
	Unknown_237 = 237,

	Poison_Coatings_Add = 238,
	Poison_Coating_Add = 239,
	Sleep_Coatings_Add = 240,

	Fire_Attack_Small = 241,
	Fire_Attack_Large = 242,
	Water_Attack_Small = 243,
	Water_Attack_Large = 244,
	Thunder_Attack_Small = 245,
	Thunder_Attack_Large = 246,
	Ice_Attack_Small = 247,
	Ice_Attack_Large = 248,
	Dragon_Attack_Small = 249,
	Dragon_Attack_Large = 250,

	Starving_Wolf_Plus1 = 251,
	Starving_Wolf_Plus2 = 252,

	Unknown_253 = 253,

	Bomb_Sword_Plus1 = 254,
	Bomb_Sword_Plus2 = 255,
	Bomb_Sword_Plus3 = 256,

	Power_Sword_Plus1 = 257,
	Power_Sword_Plus2 = 258,
	Power_Sword_Plus3 = 259,

	Poison_Sword_Plus1 = 260,
	Poison_Sword_Plus2 = 261,
	Poison_Sword_Plus3 = 262,

	Para_Sword_Plus1 = 263,
	Para_Sword_Plus2 = 264,
	Para_Sword_Plus3 = 265,

	Sleep_Sword_Plus1 = 266,
	Sleep_Sword_Plus2 = 267,
	Sleep_Sword_Plus3 = 268,

	Fire_Sword_Plus1 = 269,
	Fire_Sword_Plus2 = 270,
	Fire_Sword_Plus3 = 271,

	Water_Sword_Plus1 = 272,
	Water_Sword_Plus2 = 273,
	Water_Sword_Plus3 = 274,

	Ice_Sword_Plus1 = 275,
	Ice_Sword_Plus2 = 276,
	Ice_Sword_Plus3 = 277,

	Thunder_Sword_Plus1 = 278,
	Thunder_Sword_Plus2 = 279,
	Thunder_Sword_Plus3 = 280,

	Dragon_Sword_Plus1 = 281,
	Dragon_Sword_Plus2 = 282,
	Dragon_Sword_Plus3 = 283,

	Critical_Eye_Plus4 = 284,
	Critical_Eye_Plus5 = 285,

	Attack_Up_Very_Large = 286,
	Attack_Up_Absolute = 287,

	Super_Earplugs = 288,
	Peerless = 289,

	Precision_Plus2 = 290,

	Health_Plus40 = 291,
	Health_Plus50 = 292,

	Razor_Sharp_Plus2 = 293,

	Defense_Plus90 = 294,
	Defense_Plus120 = 295,

	Summer_Person = 296,
	Winter_General = 297,

	Artillery_Expert = 298,
	Artillery_God = 299,

	Pressure_Large = 300,
	Capture_Guru = 301,

	Focus_Plus2 = 302,
	Focus_Plus1 = 303,

	Distraction = 304,

	SnS_Tech_Sword_Saint = 305,
	SnS_Tech_Kaiden = 306,
	SnS_Tech_Expert = 307,
	SnS_Tech_Novice = 308,

	DS_Tech_Dual_Dragon = 309,
	DS_Tech_Kaiden = 310,
	DS_Tech_Expert = 311,
	DS_Tech_Novice = 312,

	GS_Tech_Sword_King = 313,
	GS_Tech_Kaiden = 314,
	GS_Tech_Expert = 315,
	GS_Tech_Novice = 316,

	LS_Tech_Katana_God = 317,
	LS_Tech_Kaiden = 318,
	LS_Tech_Expert = 319,
	LS_Tech_Novice = 320,

	Hammer_Tech_Beast = 321,
	Hammer_Tech_Kaiden = 322,
	Hammer_Tech_Expert = 323,
	Hammer_Tech_Novice = 324,

	HH_Tech_Emperor = 325,
	HH_Tech_Kaiden = 326,
	HH_Tech_Expert = 327,
	HH_Tech_Novice = 328,

	Lance_Tech_Holy_Spear = 329,
	Lance_Tech_Kaiden = 330,
	Lance_Tech_Expert = 331,
	Lance_Tech_Novice = 332,

	GL_Tech_Cannon_Ruler = 333,
	GL_Tech_Kaiden = 334,
	GL_Tech_Expert = 335,
	GL_Tech_Novice = 336,

	HBG_Tech_Gun_Sage = 337,
	HBG_Tech_Kaiden = 338,
	HBG_Tech_Expert = 339,
	HBG_Tech_Novice = 340,

	LBG_Tech_Gun_Prodigy = 341,
	LBG_Tech_Kaiden = 342,
	LBG_Tech_Expert = 343,
	LBG_Tech_Novice = 344,

	Bow_Tech_Bow_Demon = 345,
	Bow_Tech_Kaiden = 346,
	Bow_Tech_Expert = 347,
	Bow_Tech_Novice = 348,

	Violent_Wind_Breaker = 349,
	Quake_Res_Plus2 = 350,

	Trap_Expert = 351,
	Trap_Master = 352,

	Weapon_Handling = 353,

	Elemental_Attack_Up = 354,
	Elemental_Attack_Down = 355,

	Stamina_Recovery_Large = 356,
	Stamina_Recovery_Small = 357,
	Stamina_Recovery_Down = 358,

	Kickboxing_King = 359,

	Strong_Arm_Plus2 = 360,

	Throwing_Knives_Plus1 = 361,
	Throwing_Knives_Plus2 = 362,

	Caring_Plus1 = 363,
	Caring_Plus2 = 364,
	Caring_Plus3 = 365,

	Defense_Lock = 366,

	Fencing_Plus1 = 367,
	Fencing_Plus2 = 368,

	Status_Halved = 369,
	Status_Immunity = 370,
	Status_Doubled = 371,

	SnS_Tech_Dupe = 372,
	DB_Tech_Dupe = 373,
	GS_Tech_Dupe = 374,
	LS_Tech_Dupe = 375,
	Hammer_Tech_Dupe = 376,
	Horn_Tech_Dupe = 377,
	Lance_Tech_Dupe = 378,
	Gunlance_Tech_Dupe = 379,
	HBG_Tech_Dupe = 380,
	LBG_Tech_Dupe = 381,
	Bow_Tech_Dupe = 382,
	Passive_Dupe = 383,

	Wide_Area_Plus3 = 384,
	Wide_Area_Minus1 = 385,

	Heavy_Drinker = 386,
	Drunkard = 387,

	Crystal_Resistance = 388,
	Crystal_Vulnerability = 389,

	Magnetic_Resistance = 390,
	Magnetic_Vulnerability = 391,

	Light_Tread = 392,
	Relief = 393,
	Shiriagari = 394,
	Lone_Wolf = 395,
	Compensation = 396,

	Rapid_Fire = 397,
	Sharpening_Artisan = 398,

	Unaffected_Plus1 = 399,
	Unaffected_Plus2 = 400,
	Unaffected_Plus3 = 401,

	Reflect_Plus1 = 402,
	Reflect_Plus2 = 403,
	Reflect_Plus3 = 404,

	Honed_Blade_Plus1 = 405,
	Honed_Blade_Plus2 = 406,
	Honed_Blade_Plus3 = 407,

	Strong_Attack_Plus1 = 408,
	Strong_Attack_Plus2 = 409,
	Strong_Attack_Plus3 = 410,
	Strong_Attack_Plus4 = 411,
	Strong_Attack_Plus5 = 412,

	Encourage_Plus1 = 413,
	Encourage_Plus2 = 414,

	Grace_Plus1 = 415,
	Grace_Plus2 = 416,
	Grace_Plus3 = 417,

	Vitality_Plus1 = 418,
	Vitality_Plus2 = 419,
	Vitality_Plus3 = 420,
	Vitality_Minus1 = 421,

	Wrath_Awoken = 422,
	Buchigire = 423,

	Iron_Arm_Plus1 = 424,
	Iron_Arm_Plus2 = 425,

	Breeder = 426,

	Unknown_427 = 427,
	Unknown_428 = 428,

	Issen_Plus1 = 429,
	Issen_Plus2 = 430,
	Issen_Plus3 = 431,

	Fortify = 432,
	Tenacity = 433,

	Steady_Hand_Plus1 = 434,

	Mounting_Plus1 = 435,
	Mounting_Plus2 = 436,
	Mounting_Plus3 = 437,

	Tenderizer = 438,
	Weakness_Exploit = 439,
	Reduce_Weakness = 440,

	Combo_Expert_Plus1 = 441,
	Combo_Expert_Plus2 = 442,
	Combo_Expert_Plus3 = 443,
	Combo_Expert_Minus1 = 444,

	Hunter_Life = 445,
	Hunter_Valhalla = 446,

	Critical_Shot_Plus1 = 447,
	Critical_Shot_Plus2 = 448,
	Critical_Shot_Plus3 = 449,

	Evasion_Plus3 = 450,

	Movement_Speed_Up_Plus1 = 451,
	Movement_Speed_Up_Plus2 = 452,

	Saving_Master = 453,
	Saving_Expert = 454,

	Charge_Attack_Up_Plus1 = 455,
	Charge_Attack_Up_Plus2 = 456,

	Evade_Distance_Up = 457,

	Red_Soul = 458,
	Blue_Soul = 459,

	Vampirism_Plus1 = 460,
	Vampirism_Plus2 = 461,

	Adaptation_Plus1 = 462,
	Adaptation_Plus2 = 463,

	Dark_Finale = 464,
	Medical_Sage = 465,

	Tonfa_Tech_Phoenix = 466,
	Tonfa_Tech_Kaiden = 467,
	Tonfa_Tech_Expert = 468,
	Tonfa_Tech_Novice = 469,

	Unknown_470 = 470,

	Incitement = 471,

	Blazing_Majesty_Plus1 = 472,
	Blazing_Majesty_Plus2 = 473,

	Drug_Knowledge = 474,

	Absolute_Defense = 475,
	Imperturbable = 476,
	Fully_Prepared = 477,
	Negligence = 478,

	Unknown_479 = 479,

	Stylish = 480,
	Assistance = 481,

	Recoil_Reduction_Plus3 = 482,

	Gentle_Shot_Plus1 = 483,
	Gentle_Shot_Plus2 = 484,
	Gentle_Shot_Plus3 = 485,

	Elemental_Exploit = 486,
	Elemental_Diffusion = 487,

	Combat_Supremacy = 488,

	Vigorous = 489,
	Vigorous_Alt = 490,

	Status_Immunity_Myriad = 491,

	Sword_God_Plus1 = 492,
	Sword_God_Plus2 = 493,

	Thunder_Clad = 494,

	Status_Pursuit = 495,

	Drawing_Arts_Plus1 = 496,
	Drawing_Arts_Plus2 = 497,

	Blast_Resistance = 498,

	Crit_Conversion = 499,
	Crit_Conversion_Alt = 500,

	Solid_Determination = 501,
	Stylish_Assault = 502,

	Freeze_Resistance = 503,
	Ice_Age = 504,

	Consumption_Slayer = 505,

	SAF_Tech_Marshal = 506,
	SAF_Tech_Kaiden = 507,
	SAF_Tech_Expert = 508,
	SAF_Tech_Novice = 509,
	SAF_Tech_Dupe = 510,

	Fortification_Plus1 = 511,
	Fortification_Plus2 = 512,

	Sniper = 513,
	Obscurity = 514,

	Evasion_Boost = 515,
	Rush = 516,

	Encourage_Plus2_Alt = 517,

	Reflect_Plus3_Alt = 518,

	Skilled = 519,
	Ceaseless = 520,

	Point_Breakthrough = 521,
	Abnormality = 522,
	Spacing = 523,

	Strong_Attack_Plus6 = 524,

	Sword_God_Plus3 = 525,

	Steady_Hand_Plus2 = 526,

	Trained_Plus1 = 527,
	Trained_Plus2 = 528,

	Furious = 529,

	Magspike_Tech_Star = 530,
	Magspike_Tech_Kaiden = 531,
	Magspike_Tech_Expert = 532,
	Magspike_Tech_Novice = 533,

	Unknown_534 = 534
};
