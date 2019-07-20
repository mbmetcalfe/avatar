;;; vulko.ava.tf
;;; Specific variables/macroes for vulko

;;; read in vulko's gear file
/load -q char/vulko.gear.ava.tf
/require healer.tf

/def -wvulko wa = /send wake%;/mana2ac

;;; ----------------------------------------------------------------------------
;;; Autohealing setup
;;; ----------------------------------------------------------------------------
/set comfGain=955
/set divGain=262
/set healGain=131
/set cureCriticalGain=67
/set cureSeriousGain=45
/set cureLightGain=26

/def -wvulko falrimsleep = /sle
/def -wvulko falrimwake = /wa

/def -mregexp -p5 -wvulko -F -t'^You failed your (phlebotomize|flamestrike) due to lack of concentration!' vulk_failspell = \
    /if ({automidround} == 1) /send cast '%{P1}'%;/endif

/test vulkoMidSpell := (vulkoMidSpell | 'phlebotomize')
/test vulkoAOESpell := (vulkoAOESpell | 'pillar of flame')
/def vulkomidround = /send -wvulko c %{vulkoMidSpell}
/def vulkoaoespell = /send -wvulko c %{vulkoAOESpell}

/alias fin c 'final rites' %1
/alias sang c 'sanguen pax' pool
/alias nova c 'blood nova' pool

;A ulexite-shelled turtle has been marked with final rites.
/def -wvulko -mglob -p9 -ah -t" has been marked with final rites." vulko_final_rites

/def -mglob -p1 -ag -wvulko -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

; Temp trigger to swap to ac when Nit does
/def -wvulko -mglob -t"Nit smoothes out its clothes." vulko_smooth_to_ac = /mana2ac

;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
;;; ----------------------------------------------------------------------------
/def -wvulko -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_vulko = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'cure light'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState vulko
