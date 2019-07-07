;;; keiko.ava.tf
;;; Specific variables/macroes for Keiko
;;; Oct 21, 2007: Hero 500 - 5009 hp  565 ma   2582 mv
;;; Jan 19, 2010: Hero 791 - Killed UD.
;;;  Full AC + scorpion tattooes and crimsonscale skirt
;;;  q9 fear, ctr push then ctr kick +emu stance, then ctr hit and vampire
;;;  over quaffed using ~20 quaffs, ended up with 2.3k hps left.
;;; Jan 19, 2010: Hero 791 - Morphed -  32515 / 32515 hp, 1956 / 1956 m, 20208 / 20208 mv
;;; Feb 12, 2010: Remorted to Troll.
;;; Aug 31, 2016: Automorphed (5 extra levels): 38360 hp 2042 ma  14360 mv

;;; read in Keiko's gear file
/load -q char/keiko.gear.ava.tf
/load -q char/lord.ac1.ava.tf

/require rogue.tf
/require monk.tf

/def -wkeiko keikolvl = wear levelgearac
/def -wkeiko keikounlvl = wear lodestone

/def keikomidround = \
    /if ({mudLag} <3) \
        /send vital %avs_spot%;\
    /endif


/set grouped_fusilier=Chandalen
/def -p2 -ah -wkeiko -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get spear corpse#give spear %{grouped_fusilier}

;; Load in the variables saved from previous state.
/loadCharacterState keiko
