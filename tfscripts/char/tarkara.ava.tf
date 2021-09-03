;;; tarkara.ava.tf
;;; Oct 9, 2014 - Died to Bask - No Silver Iguana for me!
;/load -q char/tarkara.gear.ava.tf
/load -q char/lord.roghit1.ava.tf
/set hit_bag="urn black hitgear"
/set hit_held="shard black doom marble"
/set hit_wield="pointy stick croms lordgear elemdagger"
/set hit_offhand="pointy stick crom lordgear plain"
/set main_bag="jumpsuit white loot"

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
/set poisonkit=black box kit
/require rogue.tf

/def -mglob -wtarkara -t'You land and rest your wings.' tarkara_racial_fly_drop = \
    /if ({running}=1) \
        get "boots flight feathered" %{main_bag}%;\
        wear "boots flight feathered"%;\
    /endif

/def tarkarafren = /q 5 c frenzy %1

;; Load in the variables saved from previous state.
/loadCharacterState tarkara
