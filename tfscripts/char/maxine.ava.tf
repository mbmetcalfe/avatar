;;; maxine.ava.tf
;;; Specific variables/macroes for Maxine
;;; August 17, 2005 - 'Vag' deemed offensive, name changed to 'Maxine'
;;; October 7, 2014 - Morphed on 2nd attempt @ Hero 454:
;;;      16412 hp  12831 ma  18168 mv

;;; read in Maxine's gear file
/load -q char/maxine.gear.ava.tf
/require healer.tf
/require archer.tf

;; used for auto-fletch to keep variety of commands
;; server-side alias to recall and get a new fletch kit
/def _varietyCommand = forage

/def wall /send c 'wall of thorns' %{1}

/def -mglob -wmaxine -p0 -t"You feel less fatigued\." racial_frenzy_fatigue = \
    /if ({refren} = 1) /send racial frenzy %; /endif

/def -wmaxine -mglob -p9 -F -t"* is surrounded by a pink outline." maxine_swap_faerie = \
    /if ({running} = 1) \
        wear %{unbrandish}%;\
        /aq wear faerie%;\
    /endif

;/def -wmaxine -mregexp -p9 -F -t"^The eyes of (.+) dim and turn milky white\." maxine_swap_autumn = \
;    /if ({running} = 1) \
;        wear %{unbrandish}%;\
;        /aq wear autumn%;\
;    /endif

/def -wmaxine wa = /send wake%;/mana2arc

/def -wmaxine -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" archer_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wmaxine -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" archer_nil_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wmaxine -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" archer_rescued_swap_bow = \
    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif

;;; ----------------------------------------------------------------------------
;;; Autohealing setup
;;; ----------------------------------------------------------------------------
/set comfGain=955
/set divGain=262
/set healGain=131
/set cureCriticalGain=78
/set cureSeriousGain=42
/set cureLightGain=26

;/def -mglob -p1 -ag -wmaxine -t"Wow, that takes talent." autoheal_toggle = \
;    /if ({autoheal}=1) /set healToggle=1%;/endif
/def -mglob -p1 -ag -wmaxine -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
;;; ----------------------------------------------------------------------------
/def -wmaxine -p900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger..." migraine_disconnect_maxine = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'cure light'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState maxine
