// Diva Story and Legend Rasta story scenario files (decompressed; a JKR file
// is only shown packed). The pattern picks the layout from the first bytes:
// - dat/load/um00.bin: story menu (second byte 0)
// - dat/load/us00_NNN.bin: episode list of one menu entry
// - dat/load/uc00_CCC_EE.bin and dat/load/NNN_EE_NNN.bin (Legend Rasta
//   stories): episode script (starts with FFFF)
// - server scenario files ({category}_0_0_0_S{mainId}_T{flags}_C{chapterId}.bin,
//   side stories): container of a list, a script and a menu chunk (first byte 0)

#pragma endian little
#pragma pattern_limit 1000000
#pragma array_limit 100000

#include <std/mem.pat>

fn rd8(u32 p) { return std::mem::read_unsigned(p, 1); };
fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32be(u32 p) { return std::mem::read_unsigned(p, 4, std::mem::Endian::Big); };
fn isJkr(u32 p) { return std::mem::read_unsigned(p, 4) == 0x1A524B4A; };

struct CStr {
    char s[while(std::mem::read_unsigned($, 1) != 0)];
    padding[1];
} [[sealed, format("fmt_cstr")]];

fn fmt_cstr(ref CStr c) { return c.s; };

enum NodeType : u8 {
    Start = 0x00,
    End = 0x01,
    EpisodeClear = 0x02,
    ChapterClear = 0x03,
    Objective = 0x04,
    Reward = 0x05,
    FirstClearReward = 0x06,
    ChoiceStart = 0x07,
    ChoiceMark8 = 0x08,
    ChoiceMark9 = 0x09,
    ChoiceMarkA = 0x0A,
    ChoiceA = 0x0B,
    ChoiceB = 0x0C,
    Alternate = 0x0D,
    Checkpoint = 0x0E,
    FlipBranch = 0x0F,
    Scene = 0x10,
    Dialogue = 0x11,
    Dialogue12 = 0x12,
    Join = 0x13,
    Unk14 = 0x14
};

enum ObjectiveType : u8 {
    QuestTallyBoth = 0x00,
    QuestTallyA = 0x01,
    QuestTallyB = 0x02,
    Unk03 = 0x03,
    ClearQuest = 0x04,
    TalkToNpc = 0x07,
    SoloTallyBoth = 0x08,
    SoloTallyA = 0x09,
    SoloTallyB = 0x0A,
    RankTallyBoth = 0x0B,
    RankTallyA = 0x0C,
    RankTallyB = 0x0D,
    Unk0E = 0x0E
};

enum RewardType : u8 {
    Liking = 0x00,
    Zenny = 0x01,
    GZenny = 0x02,
    Item = 0x03
};

struct ActorEntry {
    u8 tag;
    if (tag != 0) {
        u16 values[3];
    }
};

struct Actor<auto V> {
    if (V < 8) {
        u8 a;
    } else {
        u8 a[3];
    }
    u16 motion;
    if (V >= 3) {
        u8 b;
    }
    u8 c;
    ActorEntry e0;
    if (e0.tag != 0) {
        ActorEntry e1;
        if (e1.tag != 0) {
            ActorEntry e2;
            if (e2.tag != 0) {
                ActorEntry e3;
            }
        }
    }
};

struct Node<auto V> {
    u8 t = rd8($);
    NodeType type;
    match (t) {
        (0x00 | 0x01 | 0x02 | 0x03 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0D | 0x0E | 0x0F | 0x12 | 0x13 | 0x14): {}
        (0x04): {
            ObjectiveType sub;
            u32 target;
            u16 targetId;
            if (V >= 7) {
                u16 v170;
            }
            if (V >= 9) {
                u16 v172;
            }
        }
        (0x05 | 0x06): {
            RewardType sub;
            u32 amount;
            u16 item;
        }
        (0x0B | 0x0C): {
            CStr text;
        }
        (0x10): {
            if (V >= 2) {
                u8 sub;
            }
            Actor<V> actor;
            u16 v30;
            if (V >= 4) {
                u8 v32;
            }
        }
        (_): {
            if (V >= 2) {
                u8 sub;
            }
            u16 speaker;
            Actor<V> actor0;
            Actor<V> actor1;
            CStr text;
        }
    }
};

struct HeaderEntry {
    u16 v0;
    u8 v1;
    u8 v2;
};

struct Script<auto End> {
    u16 magic;
    u16 version;
    HeaderEntry head[9];
    Node<version> nodes[while($ < End)];
};

struct Episode {
    u8 number;
    CStr name;
};

struct MenuEntry {
    u8 number;
    u8 chapters[16];
    CStr title;
    CStr text;
};

struct Scenario {
    be u32 size0;
    be u32 size1;
    u32 start0 = $;
    if (size0 > 0) {
        if (isJkr($)) {
            u8 chunk0Jkr[size0];
        } else {
            Episode episodes[while($ < start0 + size0 && rd8($) != 0)];
            if ($ < start0 + size0) {
                u8 chunk0Tail[start0 + size0 - $];
            }
        }
    }
    u32 start1 = $;
    if (size1 > 0) {
        if (isJkr($)) {
            u8 chunk1Jkr[size1];
        } else {
            Script<start1 + size1> script;
        }
    }
    be u32 size2;
    u32 start2 = $;
    if (size2 > 0) {
        if (isJkr($)) {
            u8 chunk2Jkr[size2];
        } else {
            MenuEntry menu[while($ < start2 + size2 && rd8($) != 0)];
            if ($ < start2 + size2) {
                u8 chunk2Tail[start2 + size2 - $];
            }
        }
    }
};

struct ScenarioFile {
    if (isJkr(0)) {
        u8 jkrPacked[std::mem::size()];
    } else if (rd16(0) == 0xFFFF) {
        Script<std::mem::size()> script;
    } else if (rd8(0) == 0) {
        Scenario scenario;
    } else if (rd8(1) == 0) {
        MenuEntry menu[while($ < std::mem::size() && rd8($) != 0)];
    } else {
        Episode episodes[while($ < std::mem::size() && rd8($) != 0)];
    }
};

ScenarioFile file @ 0x00;
