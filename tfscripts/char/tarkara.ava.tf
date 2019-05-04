;;; tarkara.ava.tf
;;; Specific variables/macroes for tarkara
;;; Oct 9, 2014 - Died to Bask - No Silver Iguana for me!
;;; read in Tarkara's gear file
;/load -q char/tarkara.gear.ava.tf
/set hit_bag="urn black hitgear"
/set main_bag=loot

; MnI@Lev.25; DtI@Hero(1); WvI@Hero(250); VpI@Hero(500); PyI@Hero(750)
; LsE@Lord(1); PaE@Lord(300)
;DtI@Hero 250: 2022 hp    187 ma  1778 mv   3333 tnl
;WvI@Hero 250: 2132 hp    308 ma  1914 mv   2857 tnl
;WvI@Hero 500: 3721 hp    497 ma  3165 mv   2857 tnl
;VpI@Hero 500: 3181 hp    605 ma  3363 mv   2857 tnl
;VpI@Hero 750: 4552 hp    858 ma  4778 mv   2857 tnl
;PyI@Hero 750: 7417 hp    402 ma  5639 mv   2500 tnl
;Killed UD at level 779 in solo gear, and used 22 milks
; left with 1181/  7633 hp
; 
;pl + 20150706 - Lord 309: Evolved to PaE (Thanks Meep, Amagadon, Melody)
;pl + |bk|    |n|Before 32884 hps, 3641 ma, 31218 mvs
;pl + |bk|    |n|After  35582 hps, 3503 ma, 33734 mvs
/set poisonkit=box
/require rogue.tf

/def -mglob -wtarkara -t'You land and rest your wings.' tarkara_racial_fly_drop = \
    /if ({running}=1) \
        get "boots flight feathered" %{main_bag}%;\
        wear "boots flight feathered"%;\
    /endif

/def tarkaramidround = \
    /if ({mudLag} <3) \
        /send vital %avs_spot%;\
    /endif

/set grouped_fusilier=bauchan
/def -p2 -ah -wtarkara -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get short corpse#give short %{grouped_fusilier}

;; Load in the variables saved from previous state.
/loadCharacterState tarkara
