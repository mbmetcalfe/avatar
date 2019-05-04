;;; ganik.ava.tf
;;; Specific variables/macroes for Ganik

;;; read in Ganik's gear file
/load -q char/ganik.gear.ava.tf

;;; set up other variables
/def -wganik -p0 -mregexp -t"^\*?(BrOOd|Hierlo|Shaykh|Khyfa|Zaffer|Lokken)\*? tells the group 'get me'" group_leader_resc = /send rescue %p1

/set grouped_fusilier=gmork
/def -p2 -ah -wganik -mglob -t"* catches it\!" fusilier_mob_catch = \
    /addq get short corpse#give short %{grouped_fusilier}

/def ganikmidround = /send -wganik smash
/def gan = /send -wganik %{*}

;; Load in the variables saved from previous state.
/loadCharacterState ganik