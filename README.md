# Monster Hunter Frontier – ImHex Patterns
ImHex patterns documenting the binary data structures used by **Monster Hunter Frontier (MHF)**.
This repository aims to provide accurate, readable, and extensible patterns for exploring and reverse-engineering Frontier’s game files using **[ImHex](https://imhex.werwolv.net/)**.

## 📦 Supported Formats
The patterns primarily target Frontier binary files such as:

* `mhfdat.bin`
* `mhfinf.bin`
* `mhfpac.bin`
* `mhfemd.bin`
* quest-related binaries

Each file may be documented either:

* **directly** by a top-level pattern, or
* **modularly**, via sectioned sub-patterns imported by a main file pattern.

## 🧩 Pattern Organization
Patterns are organized by **file** and **responsibility**:

```
mhfdat/
├── index.hexpat          # Main entry point for mhfdat.bin
├── header.hexpat         # File header & pointers
└── data/
    ├── monsters.hexpat
    ├── items.hexpat
    ├── equipments.hexpat
    ├── partbreaks.hexpat
    └── ...
```

### 🔹 Modular loading
Section patterns are **not meant to be loaded directly**.

They are imported by a main pattern (e.g. `mhfdat/index.hexpat`) and conditionally enabled using compile-time flags:

```c
#define __DATA_MONSTERS 1
#define __DATA_ITEMS 1
```

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

## 🧠 What These Patterns Provide
* 🧾 Struct-accurate parsing of Frontier binary formats
* 🐲 Fully named monster tables (ID → hex → decimal → name)
* 🎯 Drop tables, part breaks, carve data
* 🧩 Pointer-based table resolution (`ptVar<>`)
* 🔍 Safe parsing with bounds checking
* 🧱 Modular, extensible design for future work

Patterns favor **correctness and readability** over assumptions.