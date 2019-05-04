;;; phenyx.ava.tf
;;; Specific variables/macroes for phenyx

;;; read in phenyx's gear file
/load -q char/phenyx.gear.ava.tf

/def -wphenyx -p0 -mregexp -t"^\*?(Shaykh|Khyfa|Zaffer|Lokken)\*? tells the group 'get me'" zaffer_resc = /send rescue %{P1}

/set grouped_fusilier=recurve
/def -p2 -ah -wphenyx -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get spear corpse#give spear %{grouped_fusilier}

/def -wphenyx wa = /send wake%;/mana2hit
/def -wphenyx sle = /hit2mana%;/send sleep

;; Load in the variables saved from previous state.
/loadCharacterState phenyx
