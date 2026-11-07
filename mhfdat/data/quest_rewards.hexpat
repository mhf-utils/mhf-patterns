#pragma once

/**
	Quest reward tables, read by quest_generate_reward_item_list (0x10AB79E0),
	quest_reward_tables_init_with_luck (0x10ABCF90) and
	quest_reward_roll_map_bonus_pools (0x10ABC460) in
	mhfo-hd.dll. Every field is named after the code that reads it; bytes
	with no reader stay as gapXX. Proofs:
	tools/mhfdat_re/data/rewards_notes.md.
*/

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/MonsterIDs.hexpat>
#include <misc/types.pat>

// =======================
// Reward slot counts. s8 chances out of 32 for slot 1, 2, 3...: the roll goes
// on while (random & 0x1F) < chance (+ the luck bonus) and stops on a miss or
// a 0. One row per luck: none, Great Luck (skill 0x9F, course right 8, lucky
// charms), Good Luck (0x9E), Bad Luck (0xA0), Horrible Luck (0xA1).
// =======================

struct LuckSlotChances9 {
    s8 noLuck[9];
    s8 greatLuck[9];
    s8 goodLuck[9];
    s8 badLuck[9];
    s8 horribleLuck[9];
};

struct LuckSlotChances6 {
    s8 noLuck[6];
    s8 greatLuck[6];
    s8 goodLuck[6];
    s8 badLuck[6];
    s8 horribleLuck[6];
};

struct LuckSlotChances16 {
    s8 noLuck[16];
    s8 greatLuck[16];
    s8 goodLuck[16];
    s8 badLuck[16];
    s8 horribleLuck[16];
};

struct SlotChances4 {
    s8 chance[4];
};

ptVar<LuckSlotChances9> rewardSlotChancesBasicB[10] @ header.ptrs.rewardSlotChancesBasicB [[name("Reward Slot Chances: Basic B"), comment("reward lines of kind 0x8001: index = quest star - DAT_1E774CAF in a G rank field when above it, else 0; index 0 is replaced by the code table 0x11A41F40-0x11A41F60 (no reader for [0]); with an index above 0 the luck row is 1 with course right 8, else 0 (luck skills and lucky charms ignored; GameWork +0x3323 & 4, or online with QuestWork +0x2C & 0x400000, still force 1)")]];
ptVar<LuckSlotChances6> rewardSlotChancesSub[10] @ header.ptrs.rewardSlotChancesSub [[name("Reward Slot Chances: Sub Targets"), comment("reward lines of kind 0x8002 / 0x8003, same index as Basic B")]];
ptVar<SlotChances4> rewardSlotChancesCapture[10] @ header.ptrs.rewardSlotChancesCapture [[name("Reward Slot Chances: Capture"), comment("reward lines of kind 0x2F and capture rewards (part 0x80), same index as Basic B, no luck row")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBStOther[10] @ header.ptrs.rewardSlotChancesBasicBStOther [[name("Reward Slot Chances: Basic B, S/T Other"), comment("replaces Basic B when GameWork +0x2B0E is set, +0x2B0F is 'S' or 'T' and +0x2B17 is not 5, 6 or 7")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt5[10] @ header.ptrs.rewardSlotChancesBasicBSt5 [[name("Reward Slot Chances: Basic B, S/T 5"), comment("same, GameWork +0x2B17 == 5")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt6[10] @ header.ptrs.rewardSlotChancesBasicBSt6 [[name("Reward Slot Chances: Basic B, S/T 6"), comment("same, GameWork +0x2B17 == 6")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt7[10] @ header.ptrs.rewardSlotChancesBasicBSt7 [[name("Reward Slot Chances: Basic B, S/T 7"), comment("same, GameWork +0x2B17 == 7")]];

ptVar<LuckSlotChances9> serverBoxSlotChances[40] @ header.ptrs.serverBoxSlotChances [[name("Server Reward Box Slot Chances"), comment("quest_reward_tables_init_with_luck: [mode * 10 + tier]; mode = its argument (quest_complete_idle_update passes 0, 3 and 1, never 2: [20]-[29] have no reader; mode 3 skips the roll: the chances of [30]-[39] have no reader), tier from quest_reward_tables_prepare_context (special quest 0, contexts 1 / 2 -> 1, context 0 -> 2, 3 or 4 by DAT_1E80DB34 +0x9B); items come from the server reward boxes")]];
ptVar<LuckSlotChances9> serverBoxSlotChancesByMode[4] @ header.ptrs.serverBoxSlotChancesByMode [[name("Server Reward Box Slot Chances by Mode"), comment("quest_reward_tables_init_with_luck: [mode], only modes 0 (reward records 0xFA7) and 1 (records 0x106A) when quest_reward_tables_prepare_context returns 1-3; [2] and [3] have no reader; rewards written to slots 0x18-0x1F")]];

ptVar<LuckSlotChances16> specialSlotChancesBasicHR[4] @ header.ptrs.specialSlotChancesBasicHR [[name("Special Reward Slot Chances: Basic, HR"), comment("kinds 0x8000 / 0x8001 when quest variant3 & 2 and (restriction 0xBB or GameWork +0x3323 & 2), HR quest; only [0] is read")]];
ptVar<LuckSlotChances6> specialSlotChancesSubHR[4] @ header.ptrs.specialSlotChancesSubHR [[name("Special Reward Slot Chances: Sub Targets, HR"), comment("same for kinds 0x8002 / 0x8003; only [0] is read")]];
ptVar<SlotChances4> specialSlotChancesCaptureHR[4] @ header.ptrs.specialSlotChancesCaptureHR [[name("Special Reward Slot Chances: Capture, HR"), comment("capture lines (kind 0x2F): same test as the Basic table; capture rewards of the capture / break table (part 0x80, monster 0x7B parts 4 / 8) use it on quest variant3 & 2 in an HR quest alone (no restriction 0xBB / GameWork +0x3323 test); only [0] is read")]];
ptVar<LuckSlotChances16> specialSlotChancesBasicG[4] @ header.ptrs.specialSlotChancesBasicG [[name("Special Reward Slot Chances: Basic, G"), comment("as the HR table, G rank quest (variant1 & 8 or HagiLv); only [0] is read")]];
ptVar<LuckSlotChances6> specialSlotChancesSubG[4] @ header.ptrs.specialSlotChancesSubG [[name("Special Reward Slot Chances: Sub Targets, G"), comment("kinds 0x8002 / 0x8003 under the Basic G test; only [0] is read; its 4 pointers are those of 0x9E0 (same tables on the 3 files)")]];
ptVar<SlotChances4> specialSlotChancesCaptureG[4] @ header.ptrs.specialSlotChancesCaptureG [[name("Special Reward Slot Chances: Capture, G"), comment("only [0] is read")]];

// =======================
// Capture and part break rewards (header 0x128; 0xACC when HagiLv is 9 or the
// quest is a Berserk Extreme Great Slaying quest of 0x4E8: berserkExtreme
// firstQuest .. + 5 except + 4, lastQuest, supportFirstQuest .. + 4; same test
// in RemItemSetEX_tblget, quest_generate_reward_item_list and
// quest_reward_tables_init_with_luck): rows end at monster 0xFF. Each item
// list is a partBreakItemDrops row (0xFFFF = none), picked by gGetHagiLv()
// (quest_get_zenith_star_tier() on HagiLv 9).
// =======================

struct CaptureBreakReward {
    MonsterID monster [[comment("QuestWork +0x38A[monster] (captured) or +0x7B0[monster] (parts broken)")]];
    u8 part [[comment("0x80 = capture (also 0x04 / 0x08 for monster 0x7B), else the bit tested in QuestWork +0x7B0[monster]")]];
    u16 dropTableByHagiLv[12] [[comment("partBreakItemDrops row by HagiLv, 0xFFFF = none")]];
};

CaptureBreakReward captureBreakRewards[while (std::mem::read_unsigned($, 1) != 0xFF)] @ header.ptrs.captureBreakRewards [[name("Capture and Break Rewards")]];
CaptureBreakReward captureBreakRewardsZenith[while (std::mem::read_unsigned($, 1) != 0xFF)] @ header.ptrs.captureBreakRewardsZenith [[name("Capture and Break Rewards: Zenith")]];

// =======================
// Secret Book rewards: [(hidenBookNo - 1) * 4 + tier], 14 books x 4 tiers,
// -1 ends. 0x328 / 0x734 only in HC quests (quest_hc_is_active), with no
// large-target test; 0x874 for a large target.
// =======================

ItemId secretBookRewardsHR[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsHR [[name("Secret Book Rewards: HR"), comment("tier: IsQuestGousyu (HagiLv 3 with GameWork +0x2E77) or DAT_1E76BADA -> 3, else by HagiLv: 0 -> 0 (1 for targets 0x4C, 0x4E, 0x4F), 1 -> 1, 3 -> 2, any other -> 3")]];
ItemId secretBookRewardsG[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsG [[name("Secret Book Rewards: G"), comment("HC quest and quest_is_g_rank_in_field; tier by quest star (quest flag +0x98 & 0x2000: each target's star from the 0xB18 lookup): 1-2 -> 0, 3-4 -> 1, 5-6 -> 2, 7-10 -> 3. Also read in UL mode by secret_book_reward_item_get (tier by star 1-2 -> 0, 3-4 -> 1, 5+ -> 2) and, with course right 10, by BillingSecretBookCourseRemunerationAdd (BillingSecretBookCourseRemunerationAdd), which adds a second stack of a reward item found in this list")]];
ItemId secretBookRewardsGR500[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsGR500 [[name("Secret Book Rewards: GR 500"), comment("G rank field, get_g_class_rank() >= 500, not HC, large target; tier by star 1-2 -> 0, 3-4 -> 1, 5-6 -> 2, 7-10 -> 3; star = quest_star_level_get, or with quest flag +0x98 & 0x1000 the monster status (0x41 / 0x42 -> 4, 0x43 -> 8, other 1); with quest flag +0x98 & 0x2000 one item per target (star from the 0xB18 lookup), up to 4 different items, stacks 0x50-0x5F. Also read in UL mode by secret_book_reward_item_get and, with course right 10, by billing_secret_book_course_remuneration_add_gr500 / _num_gr500 (0x10AB70F0 / 0x10AB7200), which add a second stack of an item found in this list")]];

struct WeightedReward {
    u16 chance [[comment("percent, cumulative (random % 100)")]];
    ItemId item;
    u16 count [[comment("0x73C only: with course right 10, + the s8 bonus of code table 0x1187C018 ({u16 item, s8 bonus, u8}, ends at item 0; ZZ: only 0xAA7 +2; Wii U GetPresentItemOfBillingSecretBookCourse)")]];
};

WeightedReward secretBookGBonusItems[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookGBonusItems [[name("Secret Book G Bonus Items"), comment("not HC: first target (QuestWork +0x16C) done and large, G rank field and the book's G save bit (save +0x23B58 + 100 + (hidenBookNo - 1) * 4, bit 31): one roll, else no item")]];

// =======================
// HC Secret Book bonus by species class (header 0x55C HagiLv >= 2 or Gousyu,
// 0x560 HagiLv 1, 0x564 HagiLv 0; 0x560 also for HagiLv 0 targets 0x4C,
// 0x4E, 0x4F): Secret Book holder, HC on, large target hunted with QuestWork
// +0x7B0[target] set. Rows end at species class 0; on ZZ that last row still
// holds items and chances, never read.
// =======================

struct SpeciesBonusItem {
    ItemId item [[comment("0 = nothing")]];
    u8 count;
    u8 chance [[comment("percent, cumulative (random % 100)")]];
};

struct SpeciesBonusRow {
    u8 speciesClass [[comment("mhfemd pSpecies[target].speciesClass")]];
    u8 gap01;
    SpeciesBonusItem items[5];
};

SpeciesBonusRow hcSecretBookBonusHagi2Plus[while (std::mem::read_unsigned($, 1) != 0)] @ header.ptrs.hcSecretBookBonusHagi2Plus [[name("HC Secret Book Bonus: HagiLv 2+")]];
SpeciesBonusRow hcSecretBookBonusHagi1[while (std::mem::read_unsigned($, 1) != 0)] @ header.ptrs.hcSecretBookBonusHagi1 [[name("HC Secret Book Bonus: HagiLv 1")]];
SpeciesBonusRow hcSecretBookBonusHagi0[while (std::mem::read_unsigned($, 1) != 0)] @ header.ptrs.hcSecretBookBonusHagi0 [[name("HC Secret Book Bonus: HagiLv 0")]];

// =======================
// Other quest clear rewards
// =======================

struct RookieQuestReward {
    u16 questId [[comment("QuestWork +0x8")]];
    u8 gap02 [[comment("no HD reader: Wii U rolls it as a percent for an HC Ticket (0xAA7) x1; HD only advances the RNG")]];
    u8 rookieProof [[comment("non-zero: Rookie Proof (0xA62) when the player has no Secret Book")]];
    u8 redClothChance [[comment("percent, no Secret Book either: Unapell Red Cloth (0x69E) x10 (a Rookie Proof with quest variant4 & 0x20)")]];
    u8 ashClothChance [[comment("percent: Unapell Ash Cloth (0x69F) x10 (same)")]];
    u8 ticketChance [[comment("percent: Unapell Ticket (0x661) x10")]];
    u8 gap07;
};

RookieQuestReward rookieQuestRewards[while (std::mem::read_unsigned($, 2) != 0xFFFF)] @ header.ptrs.rookieQuestRewards [[name("Rookie Quest Rewards")]];

s8 chequeGateByPlayers[5] @ header.ptrs.chequeGateByPlayers [[name("Cheque Gate by Players"), comment("by the number of non-mercenary players; only tested != 0, then getCheckDifficultBookPremium gates a 30k Cheque (0x5C0) x get_tune_rate(0x18)")]];
s8 chequeGateByPlayersRasta[5] @ header.ptrs.chequeGateByPlayersRasta [[name("Cheque Gate by Players: Rasta"), comment("added to it with save +0xA0 & 0x200 and the Rasta notice globals DAT_1E62F204 / 208 / 2B8 / 2BC set")]];

// 30k Cheque HR chances (header 0x390, getCheckDifficultBookPremium, called once from
// quest_generate_reward_item_list): quests of the mhfinf premium quest lists
// always get the cheque; else it needs the Premium course right (CHECK_RIGHT_6)
// and quest flags (+0x16C & 0x30, not 0x40 without 0x400). The last row with
// minHrUd <= gGetHunterRankUd() (binary search) gives the chance; on
// random % 100 < chance the caller adds item 0x5C0 (30k Cheque) x get_tune_rate.
// The caller also needs HR > 30, the cheque gates above and a target monster
// whose crown row (header 0x130) byte +0xC is not 7-9.
struct ChequeHrChance {
    u16 minHrUd [[comment("Rows sorted ascending")]];
    s16 chance [[comment("Percent")]];
};

ChequeHrChance chequeHrChances[importantNums.numChequeHrChances] @ header.ptrs.chequeHrChances [[name("30k Cheque HR Chances")]];

// N course bonus items (header 0x394 / 0x398, getNBonusItem, called once from
// quest_generate_reward_item_list in stages 0xC8, 0xCA-0xCC, 0xCE, 0xD2, 0x11A,
// 0x11E, 0x1BD): with course right 9 (N) or 30, objective slot 0 cleared and a
// target monster whose crown row (header 0x130) byte +0xC is 1-6 or 10-12, the
// last row with minPostRank <= the quest's postRankMin (mhfinf +0x4E, binary
// search) gives the chance; on rand % 100 < chance one item picked at
// rand % count is added x1 to the reward list.
struct NBonusItemChance {
    u16 minPostRank [[comment("Rows sorted ascending")]];
    s16 chance [[comment("Percent")]];
};

NBonusItemChance nBonusItemChances[importantNums.numNBonusItemChances] @ header.ptrs.nBonusItemChances [[name("N Bonus Item Chances")]];
ItemId nBonusItems[importantNums.numNBonusItems] @ header.ptrs.nBonusItems [[name("N Bonus Items"), comment("One picked at random, x1")]];

struct PouchItemRewardItem {
    ItemId item;
    u16 count;
    u32 gap04;
};

struct PouchItemReward {
    ItemId pouchItem [[comment("Pl_item_num_ck; 0 ends the list, every row is checked")]];
    s16 minCount [[comment("needed in the pouch (signed compare); that many are taken out after the 3 rolls (item_recycling_skill_consume_roll, consume_item_handler)")]];
    u32 gap04;
    PouchItemRewardItem items[8];
    u8 chance[8] [[comment("percent, cumulative (random % 100); 3 rolls")]];
};

PouchItemReward pouchItemRewards[while (std::mem::read_signed($, 2) != 0)] @ header.ptrs.pouchItemRewards [[name("Pouch Item Rewards"), comment("large target hunted, not in a quest series")]];

struct ShitenReward {
    u16 monster [[comment("word compare with QuestWork +0x170 (first target)")]];
    s8 upper [[comment("1 when the quest id is at an odd index of shitenQuests")]];
    u8 gap03;
    ItemId noFaintItem [[comment("given when pl_seriesFaintCount == 0")]];
    u16 noFaintCount;
    ItemId timeItem [[comment("given when QuestWork +0x914 <= timeLimitMinutes x 1800")]];
    u16 timeCount;
    s32 timeLimitMinutes;
};

ShitenReward shitenRewards[importantNums.numShitenRewards] @ header.ptrs.shitenRewards [[name("Shiten Rewards")]];
u16 shitenQuests[importantNums.numShitenQuests] @ header.ptrs.shitenQuests [[name("Shiten Quests"), comment("pairs {normal, upper}, word compares; quest_generate_reward_item_list reads the odd ones (shitenRewards upper flag), hunterNavi_ck_07_14 only [1], hunterNavi_ck_07_15 only [3], quest_menu_dispatcher cases 0x6D / 0x6E copy the even / odd ones, quest_is_conquest_or_shiten tests all")]];

s16 zenithSigilStampChance[5] @ header.ptrs.zenithSigilStampChance [[name("Zenith Sigil Stamp Chances"), comment("HagiLv 9 and QuestWork +0x16C & 0x30 (not 0x40 without 0x400): [0]-[3] percent by monster status (0x40 / 0x4F-0x52 -> 0, 0x41 -> 1, 0x42 -> 2, 0x43 -> 3, other: no roll) for a Zenith Sigil Stamp (0x3BB8) x1 in reward stacks 0x20-0x2F; only when that roll hits, [4] a second roll for another one (signed compare with random % 100)")]];

ItemId rewardRateExemptItems[importantNums.numRewardRateExemptItems] @ header.ptrs.rewardRateExemptItems [[name("Reward Rate Exempt Items"), comment("reward_item_is_rate_exempt (0x10ABE070): counts of these items are not scaled by the reward rate (FUN_10AC35E0); caravan_route_apply_completion_rewards also leaves them out of the lucky charm (GameWork +0x2F79) stack doubling")]];

// =======================
// Map bonus pools (quest_reward_roll_map_bonus_pools, called at the end of
// quest_generate_reward_item_list with the luck row; header 0xA80 by map id,
// 0xA84 chances), skipped in a quest series. Eight rolls, each on its own:
// roll i passes with (random & 0x1F) < its chance (signed), then picks an item
// from pool (selector - 1) + group * 10, group = code table 0x1187F4E8
// {0, 1, 2, 3, 4, 4, 4, 4}. Count 1, 2 with HC; reward stacks 0x70-0x77
// (0x98-0x9F with quest flag +0x98 & 0x2000).
// =======================

struct MapBonusItem {
    ItemId item [[comment("0 = skipped; its chance still adds up, so a roll that lands on it goes to the next row with a chance")]];
    u8 chance [[comment("percent, cumulative (random % 100)")]];
    u8 gap03;
};

struct MapBonusPool {
    MapBonusItem items[16];
};

struct MapBonusEntry {
    u8 poolSelector[10] [[comment("index 8 G rank in field, else 0 quest 0xCFD8, else 6 IsQuestGousyu / quest flag +0x98 & 0x200 (quest_flag200_is_set) / DAT_1E76BADA, else 4 HagiLv >= 3, 2 HagiLv 1 (hagi_lv_is_1_or_3: HagiLv 1 or 3), 0 other; +1 when g_envSeasonTime & 0x18 == 0x10; 0 = no bonus")]];
    MapBonusPool pools[50];
};

ptVar<MapBonusEntry> mapBonusPools[104] @ header.ptrs.mapBonusPools [[name("Map Bonus Pools"), comment("by GameWork->mapId (no bound check in the code); 104 entries on ZZ, the array ends where the first entry starts")]];

struct LuckRollChances8 {
    s8 noLuck[8];
    s8 greatLuck[8];
    s8 goodLuck[8];
    s8 badLuck[8];
    s8 horribleLuck[8];
};

struct MapBonusChances {
    LuckRollChances8 *chances : ptr;
    u32 gap04[4];
};

MapBonusChances mapBonusChances @ header.ptrs.mapBonusChances [[name("Map Bonus Chances")]];

// Quest rare rewards (headers 0x7B4 / 0x7B8, chkQuestRareRemItem from
// quest_generate_reward_item_list): for each finished large-monster target of
// the quest (not in special, arcade, Road ... quests), a roll % 10000 below
// the chance of 0x7B4 picks the rows of 0x7B8 for that monster whose rankBand
// matches the quest (chkQuestRemRareItemRank: 1-9 by G rank, HC and
// HagiLv) and whose resultKind matches the target's result flags
// (chkQuestRemRareItemClrType: 1 flag 0x1, 2 0x201 (or DAT_1E76BADA with GameWork
// +0x32FC & 0x10), 3 0x101, 4 0x8004; 0 never),
// then gives one of the 3 items by weight.
u16 questRareRewardChance @ header.ptrs.questRareRewardChance [[name("Quest Rare Reward Chance"), comment("Per 10000; the other 30 bytes of the slot are not read")]];

fn exoticBonusMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct QuestRareRewardItem {
    u16 item [[format("getItemName")]];
    u16 count;
    u32 gap04;
};

struct QuestRareReward {
    u16 monster [[format("exoticBonusMonster"), comment("u16, compared with the target's u16 monster id")]];
    u8 rankBand;
    u8 resultKind;
    QuestRareRewardItem items[3];
    u8 weights[3];
    padding[1];
};

QuestRareReward questRareRewards[importantNums.numQuestRareRewards] @ header.ptrs.questRareRewards [[name("Quest Rare Rewards")]];

// Conquest Crystal rewards (header 0x9A4): rows ended by a weight of 0.
// quest_reward_conquest_crystal_roll (from quest_generate_reward_item_list, on
// the quests its two gates allow) needs item 0x2C01 (Conquest Crystal) in the
// pouch, draws one row by weight (gRandomSeed1 % total), adds it to the first
// free reward stack among slots 0-23 and then consumes the crystal.
struct ConquestCrystalReward {
    s32 weight [[comment("signed: total <= 0 draws nothing (JLE), IDIV, cumulative JG")]];
    u16 item [[format("getItemName")]];
    u16 count;
};

ConquestCrystalReward conquestCrystalRewards[while(std::mem::read_unsigned($, 4) != 0)] @ header.ptrs.conquestCrystalRewards [[name("Conquest Crystal Rewards")]];
ConquestCrystalReward conquestCrystalRewardsEnd @ addressof(conquestCrystalRewards) + sizeof(conquestCrystalRewards) [[name("Conquest Crystal Rewards End")]];

// GR800 Exotic bonus materials (header 0x9F8, important numbers + 0x3BE rows).
// quest_gr800_exotic_bonus_material_get: on a G rank quest with quest flag
// +0x98 & 0x200 (quest_flag200_rank_tier_get = 2) and a GR of 800 or more, the
// first row whose monster is the slain monster (EnemyWork +3) gives its item.
// Each kill adds 1 of that item to GameWork +0x3E0C / +0x3E16 (5 entries);
// quest_generate_reward_item_list then adds them to the rewards
// (quest_reward_add_exotic_bonus_item): all 5 with their count when quest flag
// +0x98 & 0x2000 is set (stacks 0x50-0x5F), else the first 2, one each (stacks
// 0x20-0x2F). The last row is 0.

struct ExoticBonusMaterial {
    u16 monster [[format("exoticBonusMonster")]];
    ItemId item;
};

ExoticBonusMaterial exoticBonusMaterials[importantNums.numExoticBonusMaterials] @ header.ptrs.exoticBonusMaterials [[name("GR800 Exotic Bonus Materials")]];

// Course bonus item (headers 0x8B4 / 0x8B8, quest_reward_course_bonus_item_roll,
// from quest_reward_course_bonus_add / quest_reward_course_bonus_rebuild called by
// quest_complete_idle_update when course right 8 is set or a party gate passes):
// on a G rank field quest (GR != 0) whose first target (QuestWork +0x16C) is
// cleared and a large monster, one roll random % 100 against the cumulative
// chances adds the item to the first free reward stack from 0x80 (0xA8 with quest
// flag +0x98 & 0x2000) to 0xDF, and the result screen prints "Rewards added due
// to active course!" (mhfpac +0x6F0 [237]). 0x8B8 replaces 0x8B4 when course
// rights 8 (0x100) and 10 (0x400) are both set.
WeightedReward courseBonusItems[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.courseBonusItems [[name("Course Bonus Items")]];
s16 courseBonusItemsEnd @ addressof(courseBonusItems) + sizeof(courseBonusItems) [[name("Course Bonus Items End")]];
WeightedReward courseBonusItemsRight10[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.courseBonusItemsRight10 [[name("Course Bonus Items (Rights 8 + 10)")]];
s16 courseBonusItemsRight10End @ addressof(courseBonusItemsRight10) + sizeof(courseBonusItemsRight10) [[name("Course Bonus Items (Rights 8 + 10) End")]];
