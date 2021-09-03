;;; falrym.ava.tf
;;; Specific variables/macroes for falrym

;;; read in falrym's gear file
/load -q char/falrym.gear.ava.tf
/require healer.tf

/def -wfalrym wa = /send wake%;/mana2hit

;;; ----------------------------------------------------------------------------
;;; Autohealing setup
;;; ----------------------------------------------------------------------------
/set comfGain=955
/set divGain=262
/set healGain=131
/set cureCriticalGain=67
/set cureSeriousGain=45
/set cureLightGain=26

;/def -wfalrym falrymsleep = /sle
;/def -wfalrym falrymwake = /wa

/def -mglob -p1 -ag -wfalrym -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
;;; ----------------------------------------------------------------------------
/def -wfalrym -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_falrym = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'cure light'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState falrym
