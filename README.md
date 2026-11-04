# Monster Hunter Frontier – ImHex Patterns
ImHex patterns documenting the binary data structures used by **Monster Hunter Frontier (MHF)**.
This repository aims to provide accurate, readable, and extensible patterns for exploring and reverse-engineering Frontier’s game files using **[ImHex](https://imhex.werwolv.net/)**.

## 📦 Supported Formats
The patterns primarily target Frontier binary files such as:

* `mhfdat.bin`
* `mhfemd.bin`
* `mhfgao.bin`
* `mhfinf.bin`
* `mhfjmp.bin`
* `mhfnav.bin`
* `mhfpac.bin`
* `mhfrcc.bin`
* `mhfsdt.bin`
* `mhfsqd.bin`
* quest-related binaries
* character saves: `savedata`, `platebox`, `platemyset`, `partner` (decompressed)

Each file may be documented either:

* **directly** by a top-level pattern, or
* **modularly**, via sectioned sub-patterns imported by a main file pattern.

## 🧩 Pattern Organization
Patterns are organized by **file** and **responsibility**:

```
mhfdat/
├── index.hexpat          # Main entry point for mhfdat.bin
├── header.hexpat         # File header & pointers
├── utils/index.pat       # Helpers shared by the sections (names, next table...)
└── data/
    ├── monsters.hexpat   # Monster crowns and descriptions
    ├── items.hexpat
    ├── equipments.hexpat
    ├── part_breaks.hexpat # Part break and carve drops, Macha Pot rewards
    ├── sigils.hexpat     # Random sigils
    ├── skills.hexpat     # Skill tree, skill effects, Vampirism, Crit Conversion, Rush, Obscurity, Furious, zenith Up skill values, Soul values, Thunder Clad, Status Pursuit, Drawing Arts, Magnet Spike tunables (0xB90)
    ├── caravan.hexpat    # Voyage and ranking routes, levels, gem skills and tiers, CP rates, part break CP, ranking CP rolls
    ├── road.hexpat       # Hunting Road monster points, skills and floor milestones
    ├── tower.hexpat      # Tower jewel recipes and upgrade costs, tower skills and support bonuses
    ├── shop_guild.hexpat # Shop catalogs and the Guild Shop
    ├── weapon_params.hexpat # Per-class weapon parameters, bullet sets, horn melodies, rapid fire, motion values, random weapon sharpness, reach bodies, gunner shot power, HC Kai bonuses, armor piece element / status rates, Dual Blades blade effects, bow model materials, just reload / shot, gunlance shells, weapon constants by weapon (0x660), Switch Axe F tunables (0xA88), Lance combo rules (0x654), weapon skill modifiers (0xA8C), evade actions (0x8C0), bowgun shot tables (0xA70)
    ├── sharpness.hexpat  # Sharpness tables by weapon class (where each color ends)
    ├── treasure_corp.hexpat # Treasure Corp areas, result chances and draw count rules (the items are in mhfgao)
    ├── guild_weekly_bonus.hexpat # Guild weekly bonus values by level (attack, defense, Partnyaa stats, Treasure Corp)
    ├── npc_sounds.hexpat # Town NPC motion sounds (sound events by NPC id and motion)
    ├── recruit_filters.hexpat # Party recruit filters: rank conditions, goals, quest types
    ├── evolution.hexpat  # Evolution weapons: weapon series lists, the 16 series level tables (Flash, Shine, Glory, Clear)
    ├── quests.hexpat     # HR, G-rank, Conquest and beginner quest lists, Guild Priority Requests, interception monster G stars
    ├── quest_rewards.hexpat # Quest reward slot chances, capture / break, Secret Book, Shiten and map bonus rewards
    ├── clan.hexpat       # Clan mission targets and roll weights
    ├── cooking.hexpat    # Kitchen meal ingredients, stat tiers, special dishes
    ├── guild_cooking.hexpat # Guild cooking recipes, ingredients, skill pools
    ├── goocoo.hexpat     # Goocoo food, house-sitting, remodelling, exchange, pot
    ├── halk.hexpat       # Halk food
    ├── meowka_pot.hexpat # Garden Meowka Pot recipes
    ├── legend_rasta.hexpat # Legend Rasta loadouts and groups, Rasta item sets
    ├── partner.hexpat    # Partner creation, faces, skills and extra skills
    ├── secret_book.hexpat # Secret Book effects and SR levels
    ├── transcend.hexpat  # Transcend depths and quest clear gains
    ├── combine.hexpat    # Item combining: pair and triple recipes
    ├── monster_sounds.hexpat # Monster motion sound tables (HD reads them here, not in mhfemd)
    ├── weapon_actions.hexpat # Weapon action scripts: steps, cancels, events
    ├── equipment_effects.hexpat # Weapon and armor visual effects (sets and rows)
    ├── mytra.hexpat      # Mytra Adventure Dispatch, shop stock and cat mixes
    ├── player_sounds.hexpat # Player motion sound banks, sound distance types and curves (0x540-0x548)
    ├── item_lists.hexpat # Protected items and box search filters
    ├── player_unique_params.hexpat # Player unique parameters (pl_get_unq_prm): tuning rows by mechanic (Vigorous, evade frames, Bomber...)
    ├── rasta_guild.hexpat # Rasta hunt orders, Loyalty and Cred costs and level tables
    └── ...
quest/
├── block.hexpat          # A quest's main block, shared by quest files and mhfinf
└── objective.hexpat
save/
├── equip.hexpat          # Equipment slots and classes shared by the saves
└── plate.hexpat          # Sigil skills and slots shared by platebox and platemyset
savedata.bin.hexpat       # Decompressed character save (0x24D24 bytes)
platebox.bin.hexpat       # Decompressed sigil box, up to 300 slots
platemyset.bin.hexpat     # Sigil sets, 40 x 3 slots
partner.bin.hexpat        # Partner blob and its equipment box
```

### 🔹 Modular loading
Section patterns are **not meant to be loaded directly**.

They are imported by a main pattern (e.g. `mhfdat/index.hexpat`) and conditionally enabled using compile-time flags:

```c
#define __DATA_MONSTERS 1
#define __DATA_ITEMS 1
```

Every `__DATA_*` flag of `mhfdat.bin.hexpat` can be enabled alone or all at once; `__DECOMPILE` adds the raw tables as the client reads them.

This allows:

* selective parsing
* faster evaluation
* easier debugging

## 🚀 Using These Patterns
### Option 1 – ImHex global patterns folder (recommended)
Copy or symlink this repository into one of ImHex’s pattern directories
(see **Help → About** in ImHex to locate them).

Example (Windows, admin shell):

```cmd
mklink /D "C:\Program Files\ImHex\patterns\mhf-pattern" "G:\path\to\mhf-pattern"
```

### Option 2 – ImHex Project (best for development)
Create an ImHex project and place this repository in a sibling `patterns/` folder:

```
MyProject/
├── project.imhex
├── patterns/
│   └── mhf-pattern/
└── binaries/
    └── mhfdat.bin
```

ImHex will automatically resolve imports from `patterns/`.

### Option 3 – Command line
ImHex (1.38 tested) runs a pattern without its window, from this folder. It needs a terminal (under a script, wrap it in `script -q -c "…" /dev/null`):

```sh
# run it: errors, and std::print output with -v
imhex --pl run -v -i mhfdat.bin -p mhfdat.bin.hexpat -I . -D __DATA_ITEMS
# export what it parsed (slow on large tables: every format function runs)
imhex --pl format -i mhfdat.bin -p mhfdat.bin.hexpat -I . -D __DATA_SIGILS -f json -o sigils.json
```

## 🧠 What These Patterns Provide
* 🧾 Struct-accurate parsing of Frontier binary formats
* 🐲 Fully named monster tables (ID → hex → decimal → name)
* 🎯 Drop tables, part breaks, carve data
* 🧩 Pointer-based table resolution (`ptVar<>`)
* 🔍 Safe parsing with bounds checking
* 🧱 Modular, extensible design for future work

Patterns favor **correctness and readability** over assumptions.

## 📐 Conventions checked on the ZZ files
* A table is sized by the counts the file gives (header, important numbers, equipment counts) rather than by scanning for a marker: the leg armors don't end at a `-1`.
* A table with no end marker ends at the next table the header points to (`nextTable`), and some markers lie past it (the JP combine shop runs into the tables after it).
* Tables are reached through their header pointer only: the EN client relocated most of them compared to the JP one (G-rank quest lists, for instance).
* Some tables have no count in the file (14 weapon classes, 44 bullet sets, 15 Caravan levels, 16 ranking groups, the 68/17/23 arena lists): each fixed length was checked to end at zero padding or at the table's own data on the ZZ JP and EN files. Two are still unknown and only partly shown: the weapon upgrade bonus slots (header 0xA8) and the coating modifiers (header 0xB0).
* Monster description i (header 0x134) belongs to the monster of crown row i (header 0x130): the descriptions have no monster id of their own.
* G-50 weapon upgrades: header 0x5F8 holds the melee ones and 0x5FC the ranged ones, counted at important numbers + 0x22A and + 0x22C. On the JP file the ranged table runs into the melee one with no end marker.

## 🙏 Credits
* This repository started as a fork of [var-username/Monster-Hunter-Frontier-Patterns](https://github.com/var-username/Monster-Hunter-Frontier-Patterns) by **var-username**, with contributions from **ezemania2** and **Relial**. The random sigils (`mhfdat/data/sigils.hexpat`), the save sigils (`save/sigil.hexpat`) and the Hunter Navi tab fields come from it.
* Its own credits carry over: [@Malckyor](https://github.com/Malckyor) and [@Chakratos](https://github.com/Chakratos) for prior work, [@DorielRivalet](https://github.com/DorielRivalet) for 010 templates, [@sekaiwish](https://github.com/sekaiwish) for server emulation and client 010 templates.
* The quest block fields follow [Paxlord/PaxMHFZQuestEditor](https://github.com/Paxlord/PaxMHFZQuestEditor) where noted.
* The layouts of the skill, Caravan, Hunting Road skill, crown, weapon parameter, Guild Shop and Tower tables come from [ezemania2/mhf-file-editor](https://github.com/ezemania2/mhf-file-editor), re-checked on the ZZ files; the Hunting Road monster points from [BlazeMH/Blaze-Hunting-Road-Editor](https://github.com/BlazeMH/Blaze-Hunting-Road-Editor), as that editor credits.
* The clan mission, cooking, guild cooking, Goocoo, Halk, Meowka Pot, Legend Rasta, Partner, Secret Book, Transcend, Conquest quest, rapid fire, Furious, combine, Guild Priority Request, monster sound, weapon action, motion value, random sharpness, equipment effect, Mytra, player sound and monster start action tables, and the Hunter Jewel fields of the gem skills, come from ezemania2's reverse engineering of the mhfo-hd.dll code that reads them, checked on the ZZ files.
* The save patterns (`savedata`, `platebox`, `platemyset`, `partner`) come from ezemania2's reverse engineering of mhfo-hd.dll and Otya063/mhf-client's `UserSaveData`, checked on ZZ saves; the sigil skill ids follow [Relial/mhfz_sigil_editor](https://github.com/Relial/mhfz_sigil_editor). A compressed save (`cmp 20110113` header) must be expanded first.

## 📜 License
[LGPL-3.0](LICENSE.md), as the original repository.