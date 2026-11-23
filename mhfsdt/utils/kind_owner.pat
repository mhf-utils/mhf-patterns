#pragma once

/// Owner of a shell kind (descriptor id). Monster names are the Monster enum of mhfo-hd.dll
/// (/MHF/mhf-client/Monster), weapon classes the WeaponType names.
fn kind_owner(s16 k) {
    match (k) {
        (0): return "Player melee hits, every blade class (rows split by class; 4 / 5 / 0x60 / 0x61 = kicks)";
        (6): return "Player Heavy Bowgun (sub_id 1) / Light Bowgun (sub_id 5) ammo; only kind looked up by sub_id (offset_get)";
        (24): return "Player Bow arrows (row = arrow / shot type)";
        (85): return "Player Long Sword: Spirit Release / sword crystal blast";
        (99): return "Rukodiora (em99)";
        (100): return "Player Tonfa";
        (106): return "Player Switch Axe F: attack shells";
        (107): return "Player Switch Axe F: secondary shells";
        (108): return "Player shared effect shells (Bow Rising Dragon, wide-area items, Long Sword / Great Sword extra shells)";
        (110): return "Hyujikiki (em110)";
        (111): return "Midogaron (em111), KamuOrugaron (em91)";
        (112): return "Giaorugu (em112), Abiorugu (em104)";
        (113): return "MiRu (em113)";
        (120): return "Player Magnet Spike: attack shells";
        (121): return "Player Magnet Spike: magnet shells (also ended / reacted on the magnetized monster)";
        (125): return "Forokururu (em125)";
        (127): return "Diorex (em127)";
        (128): return "GarubaDaora (em128)";
        (130): return "Varusaburosu (em130)";
        (139): return "Gureadomosu (em139)";
        (140): return "Harudomerugu (em140); its Table D also holds the global monster rows (hit frame windows, stagger, part break, transcend...)";
        (141): return "Toridcless (em141)";
        (142): return "Gasurabazura (em142)";
        (145): return "ThirdPhaseDuremudira (em145)";
        (146): return "Zinogre (em146), StygianZinogre (em153)";
        (147): return "Deviljho (em147), StarvingDeviljho (em155)";
        (148): return "Brachydios (em148)";
        (150): return "ToaTesukatora (em150)";
        (151): return "Barioth (em151)";
        (152): return "Uragaan (em152)";
        (154): return "Shared monster shell: mostly Guanzorumu (em154); also WhiteFatalis, Inagami, Egyurasu...";
        (158): return "Voljang (em158)";
        (159): return "Nargacuga (em159), BlinkingNargacuga (em163)";
        (160): return "Keoaruboru (em160)";
        (161): return "Zenaserisu (em161)";
        (162): return "GoreMagala (em162)";
        (164): return "ShagaruMagala (em164)";
        (165): return "Amatsu (em165)";
        (166): return "Elzelion (em166)";
        (167): return "ArrogantDuremudira (em167)";
        (169): return "Seregios (em169)";
        (170): return "Bogabadorumu (em170), BombardierBogabadorumu (em172)";
        (171): return "UnknownBlueBarrel (em171; action set shared with Egyurasu em157)";
        (172): return "BombardierBogabadorumu (em172)";
        (174): return "SparklingZerureusu (em174)";
        (175): return "PSO2Rappy (em175; get_hzv_info only)";
        (300): return "Shared monster shell: DaimyoHermitaur, Rukodiora, Pariapuria, Lavasioth...";
        (302): return "Kirin (em33)";
        (303): return "Shared monster shell: Rathian / Rathalos family, Odibatorasu, Gypceros, Chameleos...";
        (304): return "Hypnocatrice (em74)";
        (305): return "Shared monster shell: Espinas, Blangonga...";
        (306): return "AkuraVashimu (em83)";
        (307): return "Tigrex (em76)";
        (315): return "Khezu (em15)";
        (317): return "Gravios (em17)";
        (321): return "Plesioth (em21)";
        (371): return "WhiteFatalis (em71)";
        (395): return "Doragyurosu (em95)";
        (403): return "TaikunZamuza (em103)";
        (409): return "Anorupatisu (em109)";
        (421): return "Baruragaru (em121)";
        (429): return "Inagami (em129)";
        (440): return "Harudomerugu (em140)";
        (441): return "Toridcless (em141), Zenith";
        (442): return "Gasurabazura (em142), Zenith";
        (500 | 502 | 503 | 504 | 505 | 506 | 507 | 508 | 509 | 510 | 511 | 512 | 513 | 514 | 515 | 516 | 518 | 519 | 520 | 522 | 524 | 528 | 529 | 531 | 532 | 533 | 534 | 535 | 536 | 537 | 539 | 541 | 542 | 546 | 547 | 549 | 553): return std::format("Object entity: objEmSubType {} of the Unk133 (em133) object slot, spawned from code 0x111A-0x111D", k - 500);
        (999): return "Player status rows in Table D (blights, frenzy, seals, sharpness drain...) and shells attached to the player (blind fog...)";
        (_): return "owner not traced";
    }
};

fn kind_fmt(s16 k) { return std::format("kind {}: {}", k, kind_owner(k)); };
