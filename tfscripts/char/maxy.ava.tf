;;; maxy.ava.tf
;;; Specific variables/macroes for Maxy

;;; read in Maxy's gear file
/load -q char/maxy.gear.ava.tf

;;; set up other variables
/def -wmaxy -p0 -mregexp -t"^\*?(BrOOd|Hierlo|Shaykh|Khyfa|Zaffer|Lokken)\*? tells the group 'get me'" group_leader_resc = /send rescue %p1

/def maxymidround = /send -wganik smash
/def gan = /send -wmaxy %{*}

;; Load in the variables saved from previous state.
/loadCharacterState maxy
