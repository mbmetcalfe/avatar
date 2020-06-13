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

/test vulkoMidSpell := (vulkoMidSpell | 'phlebotomize')
/test vulkoAOESpell := (vulkoAOESpell | 'pillar of flame')
/def vulkomidround = /send -wvulko c %{vulkoMidSpell}
/def vulkoaoespell = /send -wvulko c %{vulkoAOESpell}

/alias fin c 'final rites' %1
; Heroic aliases
/alias sang \
    /if ({#} = 1) augment %1%;/endif%;\
    c 'sanguen pax' pool%;\
    /if ({#} = 1) augment off%;/endif
/alias nova \
    /if ({#} = 1) surge %1%;/endif%;\
    c 'blood nova' pool%;\
    /if ({#} = 1) surge off%;/endif

/alias fins \
    c 'final rite' %1%;\
    /aq sang %2

; Lordly aliases
/alias vit \
    /if ({#} = 1) augment %1%;/endif%;\
    c 'vitae flux' pool%;\
    /if ({#} = 1) augment off%;/endif
/alias fine \
    c 'final rite' %1%;\
    /aq vit %2
/alias fines \
    /send stance soul=c 'soul shackle' %1%;\
    fine %1 %2
/alias shack /send stance soul=c 'soul shackle' %1
/alias vgo /cast on%;/aq /cast off%;/send =

/alias mm /if ({#} > 1 | {1} > 0) surge %1%;/endif%;c 'memento mori' pool%;/if ({#} > 1 | {1} > 0) surge off%;/endif

/def -wvulko -mglob -p9 -ah -t" has been marked with final rites." vulko_final_rites

/def aphleb = /auto phleb %1
/def ashack = /auto shackle %1
/def -wvulko -F -mregexp -p999 -aCmagenta -t"has some big nasty wounds and scratches" vulko_shackle_start = \
    /if ({vulko_auto_shackle} == 1) shack%;/endif
/def -wvulko -F -mregexp -p999 -aCred -t"(looks pretty hurt|in awful condition)" vulko_auto_phleb = \
    /if ({running} == 1 & {vulko_auto_cast} == 0 & {vulko_auto_phleb} == 1)\
        /cast on%;/aq /cast off%;/send =%;\
    /endif

/def -mglob -p1 -ag -wvulko -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif


;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
;;; ----------------------------------------------------------------------------
/def -wvulko -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_vulko = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'cure light'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState vulko
