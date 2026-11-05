#pragma once

/**
	Quest reward tables, read by quest_generate_reward_item_list (0x10AB79E0),
	quest_reward_tables_init_with_luck (0x10ABCF90) and FUN_10ABC460 in
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

ptVar<LuckSlotChances9> rewardSlotChancesBasicB[10] @ header.ptrs.rewardSlotChancesBasicB [[name("Reward Slot Chances: Basic B"), comment("reward lines of kind 0x8001: index = quest star - DAT_1E774CAF in a G rank field when above it, else 0; index 0 is replaced by the code table 0x11A41F40-0x11A41F60 (no reader for [0]); with an index above 0 the luck row is 1 with course right 8, else 0")]];
ptVar<LuckSlotChances6> rewardSlotChancesSub[10] @ header.ptrs.rewardSlotChancesSub [[name("Reward Slot Chances: Sub Targets"), comment("reward lines of kind 0x8002 / 0x8003, same index as Basic B")]];
ptVar<SlotChances4> rewardSlotChancesCapture[10] @ header.ptrs.rewardSlotChancesCapture [[name("Reward Slot Chances: Capture"), comment("reward lines of kind 0x2F and capture rewards (part 0x80), same index as Basic B, no luck row")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBStOther[10] @ header.ptrs.rewardSlotChancesBasicBStOther [[name("Reward Slot Chances: Basic B, S/T Other"), comment("replaces Basic B when GameWork +0x2B0E is set, +0x2B0F is 'S' or 'T' and +0x2B17 is not 5, 6 or 7")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt5[10] @ header.ptrs.rewardSlotChancesBasicBSt5 [[name("Reward Slot Chances: Basic B, S/T 5"), comment("same, GameWork +0x2B17 == 5")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt6[10] @ header.ptrs.rewardSlotChancesBasicBSt6 [[name("Reward Slot Chances: Basic B, S/T 6"), comment("same, GameWork +0x2B17 == 6")]];
ptVar<LuckSlotChances9> rewardSlotChancesBasicBSt7[10] @ header.ptrs.rewardSlotChancesBasicBSt7 [[name("Reward Slot Chances: Basic B, S/T 7"), comment("same, GameWork +0x2B17 == 7")]];

ptVar<LuckSlotChances9> serverBoxSlotChances[40] @ header.ptrs.serverBoxSlotChances [[name("Server Reward Box Slot Chances"), comment("quest_reward_tables_init_with_luck: [mode * 10 + tier]; mode = its argument 0-3, tier from quest_reward_tables_prepare_context (special quest 0, contexts 1 / 2 -> 1, context 0 -> 2, 3 or 4 by DAT_1E80DB34 +0x9B); items come from the server reward boxes")]];
ptVar<LuckSlotChances9> serverBoxSlotChancesByMode[4] @ header.ptrs.serverBoxSlotChancesByMode [[name("Server Reward Box Slot Chances by Mode"), comment("quest_reward_tables_init_with_luck: [mode]; rewards written from slot 0x18")]];

ptVar<LuckSlotChances16> specialSlotChancesBasicHR[4] @ header.ptrs.specialSlotChancesBasicHR [[name("Special Reward Slot Chances: Basic, HR"), comment("kinds 0x8000 / 0x8001 when quest variant3 & 2 and (restriction 0xBB or GameWork +0x3323 & 2), HR quest; only [0] is read")]];
ptVar<LuckSlotChances6> specialSlotChancesSubHR[4] @ header.ptrs.specialSlotChancesSubHR [[name("Special Reward Slot Chances: Sub Targets, HR"), comment("same for kinds 0x8002 / 0x8003; only [0] is read")]];
ptVar<SlotChances4> specialSlotChancesCaptureHR[4] @ header.ptrs.specialSlotChancesCaptureHR [[name("Special Reward Slot Chances: Capture, HR"), comment("same for captures; only [0] is read")]];
ptVar<LuckSlotChances16> specialSlotChancesBasicG[4] @ header.ptrs.specialSlotChancesBasicG [[name("Special Reward Slot Chances: Basic, G"), comment("as the HR table, G rank quest (variant1 & 8 or HagiLv); only [0] is read")]];
ptVar<LuckSlotChances6> specialSlotChancesSubG[4] @ header.ptrs.specialSlotChancesSubG [[name("Special Reward Slot Chances: Sub Targets, G"), comment("only [0] is read")]];
ptVar<SlotChances4> specialSlotChancesCaptureG[4] @ header.ptrs.specialSlotChancesCaptureG [[name("Special Reward Slot Chances: Capture, G"), comment("only [0] is read")]];

// =======================
// Capture and part break rewards (header 0x128, and 0xACC when HagiLv is 9 or
// the quest id is in the 0x4E8 ranges): rows end at monster 0xFF. Each item
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
// Secret Book rewards for a large target: [(hidenBookNo - 1) * 4 + tier],
// 14 books x 4 tiers, -1 ends.
// =======================

ItemId secretBookRewardsHR[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsHR [[name("Secret Book Rewards: HR"), comment("tier by HagiLv: 0 -> 0 (1 for targets 0x4C, 0x4E, 0x4F), 1 -> 1, 3 -> 2, 3 with GameWork +0x2E77 or DAT_1E76BADA -> 3")]];
ItemId secretBookRewardsG[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsG [[name("Secret Book Rewards: G"), comment("quest_is_g_rank_in_field; tier by G star: 3-4 -> 1, 5-6 -> 2, 7-10 -> 3")]];
ItemId secretBookRewardsGR500[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookRewardsGR500 [[name("Secret Book Rewards: GR 500"), comment("G rank field, get_g_class_rank() >= 500, not HC; tier by monster rank (FUN_10AC34F0 or the monster status): 3-4 -> 1, 5-6 -> 2, 7-10 -> 3")]];

struct WeightedReward {
    s16 chance [[comment("percent, cumulative (random % 100)")]];
    ItemId item;
    u16 count [[comment("+ the course right 10 bonus for items in code table 0x1187C01A")]];
};

WeightedReward secretBookGBonusItems[while (std::mem::read_signed($, 2) != -1)] @ header.ptrs.secretBookGBonusItems [[name("Secret Book G Bonus Items"), comment("G rank field with the book's G save bit (save +0x23B58 + 100 + (hidenBookNo - 1) * 4, bit 31), not HC: one roll")]];

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
    u16 questId;
    u8 gap02;
    u8 rookieProof [[comment("non-zero: Rookie Proof (0xA62) when the player has no Secret Book")]];
    u8 redClothChance [[comment("percent: Unapell Red Cloth (0x69E) x10 (a Rookie Proof with quest variant4 & 0x20)")]];
    u8 ashClothChance [[comment("percent: Unapell Ash Cloth (0x69F) x10 (same)")]];
    u8 ticketChance [[comment("percent: Unapell Ticket (0x661) x10")]];
    u8 gap07;
};

RookieQuestReward rookieQuestRewards[while (std::mem::read_unsigned($, 2) != 0xFFFF)] @ header.ptrs.rookieQuestRewards [[name("Rookie Quest Rewards")]];

s8 chequeGateByPlayers[5] @ header.ptrs.chequeGateByPlayers [[name("Cheque Gate by Players"), comment("by the number of non-mercenary players; only tested != 0, then FUN_10ABE0B0 gates a 30k Cheque (0x5C0) x get_tune_rate(0x18)")]];
s8 chequeGateByPlayersRasta[5] @ header.ptrs.chequeGateByPlayersRasta [[name("Cheque Gate by Players: Rasta"), comment("added to it with save +0xA0 & 0x200 and the Rasta notice globals DAT_1E62F204 / 208 / 2B8 / 2BC set")]];

// 30k Cheque HR chances (header 0x390, quest_reward_cheque_roll, called once from
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
    s16 count;
    u32 gap04;
};

struct PouchItemReward {
    ItemId pouchItem [[comment("player_inventory_item_lookup; consumed after the rolls (item_recycling_skill_consume_roll)")]];
    s16 minCount;
    u32 gap04;
    PouchItemRewardItem items[8];
    u8 chance[8] [[comment("percent, cumulative (random % 100); 3 rolls")]];
};

PouchItemReward pouchItemRewards[while (std::mem::read_signed($, 2) != 0)] @ header.ptrs.pouchItemRewards [[name("Pouch Item Rewards"), comment("large target hunted, not in a quest series")]];

struct ShitenReward {
    s16 monster;
    s8 upper [[comment("1 when the quest id is at an odd index of shitenQuests")]];
    u8 gap03;
    ItemId noFaintItem [[comment("given when pl_seriesFaintCount == 0")]];
    s16 noFaintCount;
    ItemId timeItem [[comment("given when QuestWork +0x914 <= timeLimitMinutes x 1800")]];
    s16 timeCount;
    s32 timeLimitMinutes;
};

ShitenReward shitenRewards[importantNums.numShitenRewards] @ header.ptrs.shitenRewards [[name("Shiten Rewards")]];
u16 shitenQuests[importantNums.numShitenQuests] @ header.ptrs.shitenQuests [[name("Shiten Quests"), comment("pairs {normal, upper}; the generator and hunterNavi_ck_07_14 / 07_15 read the odd ones, FUN_10AFF270 all")]];

s16 zenithSigilStampChance[5] @ header.ptrs.zenithSigilStampChance [[name("Zenith Sigil Stamp Chances"), comment("HagiLv 9: [0]-[3] percent by monster status (0x40 / 0x4F-0x52 -> 0, 0x41 -> 1, 0x42 -> 2, 0x43 -> 3) for a Zenith Sigil Stamp (0x3BB8), then [4] a second roll for another one")]];

ItemId rewardRateExemptItems[importantNums.numRewardRateExemptItems] @ header.ptrs.rewardRateExemptItems [[name("Reward Rate Exempt Items"), comment("FUN_10ABE070 / caravan_route_apply_completion_rewards: counts of these items are not scaled by the reward rate (FUN_10AC35E0)")]];

// =======================
// Map bonus pools (FUN_10ABC460, header 0xA80 by map id, 0xA84 chances).
// Eight rolls, each on its own: roll i passes with (random & 0x1F) < its
// chance, then picks an item from pool (selector - 1) + group * 10, group =
// code table 0x1187F4E8 {0, 1, 2, 3, 4, 4, 4, 4}. Count 1, 2 with HC.
// =======================

struct MapBonusItem {
    ItemId item [[comment("0 = skipped")]];
    u8 chance [[comment("percent, cumulative (random % 100)")]];
    u8 gap03;
};

struct MapBonusPool {
    MapBonusItem items[16];
};

struct MapBonusEntry {
    u8 poolSelector[10] [[comment("index 0 quest 0xCFD8 or HR without FUN_1087B570, 2 HagiLv < 3 with it, 4 HagiLv >= 3, 6 Gousyu / FUN_10AC3EB0 / DAT_1E76BADA, 8 G rank field; +1 when g_envSeasonTime & 0x18 == 0x10; 0 = no bonus")]];
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

// Quest rare rewards (headers 0x7B4 / 0x7B8, quest_rare_reward_roll from
// quest_generate_reward_item_list): for each finished large-monster target of
// the quest (not in special, arcade, Road ... quests), a roll % 10000 below
// the chance of 0x7B4 picks the rows of 0x7B8 for that monster whose rankBand
// matches the quest (quest_rare_reward_rank_band_ok: 1-9 by G rank, HC and
// HagiLv) and whose resultKind matches the target's result flags
// (quest_rare_reward_result_ok: 1 flag 0x1, 2 0x201, 3 0x101, 4 0x8004; 0 never),
// then gives one of the 3 items by weight.
u16 questRareRewardChance @ header.ptrs.questRareRewardChance [[name("Quest Rare Reward Chance"), comment("Per 10000; the other 30 bytes of the slot are not read")]];

struct QuestRareRewardItem {
    u16 item [[format("getItemName")]];
    u16 count;
    u32 unk04;
};

struct QuestRareReward {
    MonsterID monster;
    padding[1];
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
    u32 weight;
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
fn exoticBonusMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct ExoticBonusMaterial {
    u16 monster [[format("exoticBonusMonster")]];
    ItemId item;
};

ExoticBonusMaterial exoticBonusMaterials[importantNums.numExoticBonusMaterials] @ header.ptrs.exoticBonusMaterials [[name("GR800 Exotic Bonus Materials")]];
