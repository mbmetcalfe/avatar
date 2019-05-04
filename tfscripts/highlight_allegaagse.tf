;;; ---------------------------------------------------------------------------
;;; highlight_allegaagse.tf
;;; Highlight when alleg gear is mentioned/listed
;;; ---------------------------------------------------------------------------
/loaded __TFSCRIPTS__/highlight_allegaagse.tf

/def searchalleg = /recall -l -mregexp 0- (alleg)

/def -ag -Ph -F -t'havynne\'s lantern(.*)' highlight_allegaagse_001 = /test $[echoGearItem({PL}, "havynne's lantern",  "alleg", {P1})]
/def -ag -Ph -F -t'a golden bow(.*)' highlight_allegaagse_002 = /test $[echoGearItem({PL}, "a golden bow",  "alleg", {P1})]
/def -ag -Ph -F -t'a bloodletter flail(.*)' highlight_allegaagse_003 = /test $[echoGearItem({PL}, "a bloodletter flail",  "alleg", {P1})]
/def -ag -Ph -F -t'a sacrificial knife(.*)' highlight_allegaagse_004 = /test $[echoGearItem({PL}, "a sacrificial knife",  "alleg", {P1})]
/def -ag -Ph -F -t'a diamond dagger(.*)' highlight_allegaagse_005 = /test $[echoGearItem({PL}, "a diamond dagger",  "alleg", {P1})]
/def -ag -Ph -F -t'ring of the white flame(.*)' highlight_allegaagse_006 = /test $[echoGearItem({PL}, "Ring of the white flame",  "alleg", {P1})]
/def -ag -Ph -F -t'signet of the Pure Flame(.*)' highlight_allegaagse_007 = /test $[echoGearItem({PL}, "signet of the Pure Flame",  "alleg", {P1})]
/def -ag -Ph -F -t'a ram\'s head staff(.*)' highlight_allegaagse_008 = /test $[echoGearItem({PL}, "a ram's head staff",  "alleg", {P1})]
/def -ag -Ph -F -t'a shard-embedded whip(.*)' highlight_allegaagse_009 = /test $[echoGearItem({PL}, "a shard-embedded whip",  "alleg", {P1})]
/def -ag -Ph -F -t'a heavy shroud(.*)' highlight_allegaagse_010 = /test $[echoGearItem({PL}, "a heavy shroud",  "alleg", {P1})]
/def -ag -Ph -F -t'sultan\'s Turban(.*)' highlight_allegaagse_011 = /test $[echoGearItem({PL}, "sultan's Turban",  "alleg", {P1})]
/def -ag -Ph -F -t'the sceptre of creation(.*)' highlight_allegaagse_012 = /test $[echoGearItem({PL}, "the sceptre of creation",  "alleg", {P1})]
/def -ag -Ph -F -t'exotic robes(.*)' highlight_allegaagse_013 = /test $[echoGearItem({PL}, "exotic robes",  "alleg", {P1})]
/def -ag -Ph -F -t'the broken blade of Karnath(.*)' highlight_allegaagse_014 = /test $[echoGearItem({PL}, "the broken blade of Karnath",  "alleg", {P1})]
/def -ag -Ph -F -t'an ice collar(.*)' highlight_allegaagse_015 = /test $[echoGearItem({PL}, "an ice collar",  "alleg", {P1})]
/def -ag -Ph -F -t'the Netherworld Dagger(.*)' highlight_allegaagse_016 = /test $[echoGearItem({PL}, "the Netherworld Dagger",  "alleg", {P1})]
/def -ag -Ph -F -t'the black sword of the keep(.*)' highlight_allegaagse_017 = /test $[echoGearItem({PL}, "the black sword of the keep",  "alleg", {P1})]
/def -ag -Ph -F -t'golden sleeves(.*)' highlight_allegaagse_018 =/test $[echoGearItem({PL}, "golden sleeves",  "alleg", {P1})]
/def -ag -Ph -F -t'a sun staff(.*)' highlight_allegaagse_019 =/test $[echoGearItem({PL}, "a sun staff",  "alleg", {P1})]
/def -ag -Ph -F -t'an ice hound\'s tooth(.*)' highlight_allegaagse_020 =/test $[echoGearItem({PL}, "an ice hound's tooth",  "alleg", {P1})]
/def -ag -Ph -F -t'an ice bow(.*)' highlight_allegaagse_021 =/test $[echoGearItem({PL}, "an ice bow",  "alleg", {P1})]
/def -ag -Ph -F -t'vial of unfinished portal serum(.*)' highlight_allegaagse_022 =/test $[echoGearItem({PL}, "vial of unfinished portal serum",  "alleg", {P1})]
/def -ag -Ph -F -t'a seething ball of blue flame(.*)' highlight_allegaagse_023 =/test $[echoGearItem({PL}, "a seething ball of blue flame",  "alleg", {P1})]
/def -ag -Ph -F -t'stone platemail(.*)' highlight_allegaagse_024 =/test $[echoGearItem({PL}, "stone platemail",  "alleg", {P1})]
/def -ag -Ph -F -t'dark purple robe(.*)' highlight_allegaagse_025 =/test $[echoGearItem({PL}, "dark purple robe",  "alleg", {P1})]
/def -ag -Ph -F -t'a lavabomb(.*)' highlight_allegaagse_026 =/test $[echoGearItem({PL}, "a lavabomb",  "alleg", {P1})]
/def -ag -Ph -F -t'a dancing katana(.*)' highlight_allegaagse_027 =/test $[echoGearItem({PL}, "a dancing katana",  "alleg", {P1})]
/def -ag -Ph -F -t'a viper fang(.*)' highlight_allegaagse_028 =/test $[echoGearItem({PL}, "a viper fang",  "alleg", {P1})]
/def -ag -Ph -F -t'a buckler bracelet(.*)' highlight_allegaagse_029 =/test $[echoGearItem({PL}, "a buckler bracelet",  "alleg", {P1})]
/def -ag -Ph -F -t'a small steam gun(.*)' highlight_allegaagse_030 =/test $[echoGearItem({PL}, "a small steam gun",  "alleg", {P1})]
/def -ag -Ph -F -t'a pair of wind-ravaged boots(.*)' highlight_allegaagse_031 =/test $[echoGearItem({PL}, "a pair of wind-ravaged boots",  "alleg", {P1})]
/def -ag -Ph -F -t'a incantation note(.*)' highlight_allegaagse_032 =/test $[echoGearItem({PL}, "a incantation note",  "alleg", {P1})]
/def -ag -Ph -F -t'an aurora bow(.*)' highlight_allegaagse_033 =/test $[echoGearItem({PL}, "an aurora bow",  "alleg", {P1})]
/def -ag -Ph -F -t'the earthen mace of might(.*)' highlight_allegaagse_034 =/test $[echoGearItem({PL}, "the earthen mace of might",  "alleg", {P1})]
/def -ag -Ph -F -t'a cape of angel feathers(.*)' highlight_allegaagse_035 =/test $[echoGearItem({PL}, "a cape of angel feathers",  "alleg", {P1})]
/def -ag -Ph -F -t'a grim bone shield(.*)' highlight_allegaagse_036 =/test $[echoGearItem({PL}, "a grim bone shield",  "alleg", {P1})]
/def -ag -Ph -F -t'ritual purification wand(.*)' highlight_allegaagse_037 =/test $[echoGearItem({PL}, "ritual purification wand",  "alleg", {P1})]
/def -ag -Ph -F -t'the staff of the lower planes(.*)' highlight_allegaagse_038 =/test $[echoGearItem({PL}, "the staff of the lower planes",  "alleg", {P1})]
/def -ag -Ph -F -t'a decaying vest made from cracked leather(.*)' highlight_allegaagse_039 =/test $[echoGearItem({PL}, "a decaying vest made from cracked leather",  "alleg", {P1})]
/def -ag -Ph -F -t'a massive slate-grey sledgehammer(.*)' highlight_allegaagse_040 =/test $[echoGearItem({PL}, "a massive slate-grey sledgehammer",  "alleg", {P1})]
/def -ag -Ph -F -t'a black whip(.*)' highlight_allegaagse_041 = /test $[echoGearItem({PL}, "a black whip",  "alleg", {P1})]
/def -ag -Ph -F -t'a green web veil(.*)' highlight_allegaagse_042 =/test $[echoGearItem({PL}, "a green web veil",  "alleg", {P1})]
/def -ag -Ph -F -t'a bloodstained blindfold(.*)' highlight_allegaagse_043 =/test $[echoGearItem({PL}, "a bloodstained blindfold",  "alleg", {P1})]
/def -ag -Ph -F -t'an obsidian sledgehammer(.*)' highlight_allegaagse_044 =/test $[echoGearItem({PL}, "an obsidian sledgehammer",  "alleg", {P1})]
/def -ag -Ph -F -t'a crumpled note(.*)' highlight_allegaagse_045 = /test $[echoGearItem({PL}, "a crumpled note",  "alleg", {P1})]
/def -ag -Ph -F -t'crystal ball(.*)' highlight_allegaagse_046 = /test $[echoGearItem({PL}, "crystal ball",  "alleg", {P1})]
/def -ag -Ph -F -t'a storm-skin cloak(.*)' highlight_allegaagse_047 = /test $[echoGearItem({PL}, "a storm-skin cloak",  "alleg", {P1})]
/def -ag -Ph -F -t'black wand with a grinning skull(.*)' highlight_allegaagse_048 = /test $[echoGearItem({PL}, "black wand with a grinning skull",  "alleg", {P1})]
/def -ag -Ph -F -t'an ethereal blade(.*)' highlight_allegaagse_049 =/test $[echoGearItem({PL}, "an ethereal blade",  "alleg", {P1})]
/def -ag -Ph -F -t'a dancing rapier(.*)' highlight_allegaagse_050 =/test $[echoGearItem({PL}, "a dancing rapier",  "alleg", {P1})]
/def -ag -Ph -F -t'omayra\'s kit(.*)' highlight_allegaagse_051 =/test $[echoGearItem({PL}, "omayra's kit",  "alleg", {P1})]
/def -ag -Ph -F -t'the Blade of Discord(.*)' highlight_allegaagse_052 =/test $[echoGearItem({PL}, "the Blade of Discord",  "alleg", {P1})]
/def -ag -Ph -F -t'a radiance of wickedness(.*)' highlight_allegaagse_053 =/test $[echoGearItem({PL}, "a radiance of wickedness",  "alleg", {P1})]
/def -ag -Ph -F -t'a suit of dress plate(.*)' highlight_allegaagse_054 =/test $[echoGearItem({PL}, "a suit of dress plate",  "alleg", {P1})]
/def -ag -Ph -F -t'black master\'s hood(.*)' highlight_allegaagse_055 =/test $[echoGearItem({PL}, "black master's hood",  "alleg", {P1})]
/def -ag -Ph -F -t'clear psi-blade(.*)' highlight_allegaagse_056 =/test $[echoGearItem({PL}, "clear psi-blade",  "alleg", {P1})]
/def -ag -Ph -F -t'blue psi-blade(.*)' highlight_allegaagse_057 =/test $[echoGearItem({PL}, "blue psi-blade",  "alleg", {P1})]
/def -ag -Ph -F -t'a ring of minor imagery(.*)' highlight_allegaagse_058 =/test $[echoGearItem({PL}, "a ring of minor imagery",  "alleg", {P1})]
/def -ag -Ph -F -t'a pair of kzinti slaughter gloves(.*)' highlight_allegaagse_059 =/test $[echoGearItem({PL}, "a pair of kzinti slaughter gloves",  "alleg", {P1})]
/def -ag -Ph -F -t'the whip, \"Death-Tamer\"(.*)' highlight_allegaagse_060 =/test $[echoGearItem({PL}, "the whip, \"Death-Tamer\"",  "alleg", {P1})]
/def -ag -Ph -F -t'silver dagger with a golden handle(.*)' highlight_allegaagse_061 =/test $[echoGearItem({PL}, "silver dagger with a golden handle",  "alleg", {P1})]
/def -ag -Ph -F -t'a blueish-white stone(.*)' highlight_allegaagse_062 =/test $[echoGearItem({PL}, "a blueish-white stone",  "alleg", {P1})]
/def -ag -Ph -F -t'aura of domination(.*)' highlight_allegaagse_063 =/test $[echoGearItem({PL}, "aura of domination",  "alleg", {P1})]
/def -ag -Ph -F -t'the mark of madness(.*)' highlight_allegaagse_064 =/test $[echoGearItem({PL}, "the mark of madness",  "alleg", {P1})]
/def -ag -Ph -F -t'amulet with a small silver sword inscribed on it(.*)' highlight_allegaagse_065 =/test $[echoGearItem({PL}, " amulet with a small silver sword inscribed on it",  "alleg", {P1})]
/def -ag -Ph -F -t'panthrodrine-skin leggings(.*)' highlight_allegaagse_066 =/test $[echoGearItem({PL}, "panthrodrine-skin leggings",  "alleg", {P1})]
/def -ag -Ph -F -t'a flaming phoenix feather(.*)' highlight_allegaagse_067 =/test $[echoGearItem({PL}, "a flaming phoenix feather",  "alleg", {P1})]
/def -ag -Ph -F -t'devilish lance(.*)' highlight_allegaagse_068 =/test $[echoGearItem({PL}, "devilish lance",  "alleg", {P1})]
/def -ag -Ph -F -t'a show of loyalty(.*)' highlight_allegaagse_069 =/test $[echoGearItem({PL}, "a show of loyalty",  "alleg", {P1})]
/def -ag -Ph -F -t'a dress of silk and velvet rags(.*)' highlight_allegaagse_070 =/test $[echoGearItem({PL}, "a dress of silk and velvet rags",  "alleg", {P1})]
/def -ag -Ph -F -t'a glowing iron skewer(.*)' highlight_allegaagse_071 =/test $[echoGearItem({PL}, "a glowing iron skewer",  "alleg", {P1})]
/def -ag -Ph -F -t'a shaleskin arm guard(.*)' highlight_allegaagse_072 =/test $[echoGearItem({PL}, "a shaleskin arm guard",  "alleg", {P1})]
/def -ag -Ph -F -t'baleflame(.*)' highlight_allegaagse_073 =/test $[echoGearItem({PL}, "baleflame",  "alleg", {P1})]
/def -ag -Ph -F -t'steel broadsword(.*)' highlight_allegaagse_074 =/test $[echoGearItem({PL}, "steel broadsword",  "alleg", {P1})]
/def -ag -Ph -F -t'a stone disc(.*)' highlight_allegaagse_075 =/test $[echoGearItem({PL}, "a stone disc",  "alleg", {P1})]
/def -ag -Ph -F -t'Red Bracer(.*)' highlight_allegaagse_076 =/test $[echoGearItem({PL}, "Red Bracer",  "alleg", {P1})]
/def -ag -Ph -F -t'a crude spear(.*)' highlight_allegaagse_077 =/test $[echoGearItem({PL}, "a crude spear",  "alleg", {P1})]
/def -ag -Ph -F -t'a whirl of elusive feathers(.*)' highlight_allegaagse_078 =/test $[echoGearItem({PL}, "a whirl of elusive feathers",  "alleg", {P1})]
/def -ag -Ph -F -t'clasp of eternal anguish(.*)' highlight_allegaagse_079 =/test $[echoGearItem({PL}, "clasp of eternal anguish",  "alleg", {P1})]
/def -ag -Ph -F -t'axe of the third plane(.*)' highlight_allegaagse_080 =/test $[echoGearItem({PL}, "axe of the third plane",  "alleg", {P1})]
/def -ag -Ph -F -t'an iron dha(.*)' highlight_allegaagse_081 =/test $[echoGearItem({PL}, "an iron dha",  "alleg", {P1})]
/def -ag -Ph -F -t'green psi-blade(.*)' highlight_allegaagse_082 =/test $[echoGearItem({PL}, "green psi-blade",  "alleg", {P1})]
/def -ag -Ph -F -t'a stone hammer(.*)' highlight_allegaagse_083 =/test $[echoGearItem({PL}, "a stone hammer",  "alleg", {P1})]
/def -ag -Ph -F -t'a rock hammer(.*)' highlight_allegaagse_084 =/test $[echoGearItem({PL}, "a rock hammer",  "alleg", {P1})]
/def -ag -Ph -F -t'a unicorn horn(.*)' highlight_allegaagse_085 =/test $[echoGearItem({PL}, "a unicorn horn",  "alleg", {P1})]
/def -ag -Ph -F -t'a flametongue called \'Firebrand\'(.*)' highlight_allegaagse_086 =/test $[echoGearItem({PL}, "a flametongue called 'Firebrand'",  "alleg", {P1})]
/def -ag -Ph -F -t'a dancing dagger(.*)' highlight_allegaagse_087 =/test $[echoGearItem({PL}, "a dancing dagger",  "alleg", {P1})]
/def -ag -Ph -F -t'a side of venison(.*)' highlight_allegaagse_088 =/test $[echoGearItem({PL}, "a side of venison",  "alleg", {P1})]
/def -ag -Ph -F -t'an air gun(.*)' highlight_allegaagse_089 =/test $[echoGearItem({PL}, "an air gun",  "alleg", {P1})]
/def -ag -Ph -F -t'yellow psi-blade(.*)' highlight_allegaagse_090 =/test $[echoGearItem({PL}, "yellow psi-blade",  "alleg", {P1})]
/def -ag -Ph -F -t'a devilish talisman(.*)' highlight_allegaagse_091 =/test $[echoGearItem({PL}, "a devilish talisman",  "alleg", {P1})]
/def -ag -Ph -F -t'a dagger of dark rites(.*)' highlight_allegaagse_092 =/test $[echoGearItem({PL}, "a dagger of dark rites",  "alleg", {P1})]
/def -ag -Ph -F -t'assassin\'s armband(.*)' highlight_allegaagse_093 =/test $[echoGearItem({PL}, "assassin's armband",  "alleg", {P1})]
/def -ag -Ph -F -t'blood red robe(.*)' highlight_allegaagse_094 =/test $[echoGearItem({PL}, "blood red robe",  "alleg", {P1})]
/def -ag -Ph -F -t'a Faerie script(.*)' highlight_allegaagse_095 =/test $[echoGearItem({PL}, "a Faerie script",  "alleg", {P1})]
/def -ag -Ph -F -t'coarse leather boots(.*)' highlight_allegaagse_096 =/test $[echoGearItem({PL}, "coarse leather boots",  "alleg", {P1})]
/def -ag -Ph -F -t'the staff of prophecy(.*)' highlight_allegaagse_097 =/test $[echoGearItem({PL}, "the staff of prophecy",  "alleg", {P1})]
/def -ag -Ph -F -t'black etched tablet(.*)' highlight_allegaagse_098 =/test $[echoGearItem({PL}, "black etched tablet", "alleg", strcat(" Trade for: Faerie Script", {P1}))]
/def -ag -Ph -F -t'a red bracer(.*)' highlight_allegaagse_099 = /test $[echoGearItem({PL}, "a red bracer",  "alleg", {P1})]
/def -ag -Ph -F -t'an iron web shield(.*)' highlight_allegaagse_100 =/test $[echoGearItem({PL}, "an iron web shield", "alleg", strcat(" Trade for: Coarse Leather Boots", {P1}))]

;/def -mregexp -F -t"the staff of prophecy" alleg_test = /substitute the staff of prophecy (alleg)
;/def -mregexp -F -t"coarse leather boots" alleg_test2 = /test substitute(replace("coarse leather boots", "coarse leather boots(alleg)", {P0}))
;/def -mregexp -F -t"a Faerie script" alleg_test3 = /test substitute(replace("a Faerie script", "a Faerie script (alleg)", {P0}))
;/def -mregexp -F -t"blood red robe" alleg_test4 = /test substitute(replace("blood red robe", "blood red robe (alleg)", {P0}))
