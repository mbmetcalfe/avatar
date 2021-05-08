;;; ganik.ava.tf
;;; Specific variables/macroes for Ganik

;;; read in Ganik's gear file
/load -q char/ganik.gear.ava.tf

;;; set up other variables
/def -wganik -p0 -mregexp -t"^\*?(BrOOd|Hierlo|Shaykh|Khyfa|Zaffer|Lokken)\*? tells the group 'get me'" group_leader_resc = /send rescue %p1

/def -wganik -p1 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" ganik_poke_resc = /if ({ganik_auto_rescue} == 1) /send rescue %{P1}%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState ganik
