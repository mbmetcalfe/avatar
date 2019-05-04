;;; verlegenheit.ava.tf
;;; May 22, 2004:	Failed UD at level 555: 5674 hp 246 ma 2867 mv
;;; June 14, 2004:  Killed UD at level 708 (295 hps left).
;;; June 14, 2004:  Morphed at level 708: 32235 hp 1815 ma 12565 mv
;;; June 14, 2004:  Gen #1: 39670 hp 1772 ma  13964 mv
;;; December 11, 2006: Remorted to Dwarf Paladin
;;; December 12, 2006: Reheroed
;;; December 20, 2006: Updated to version 23 @ Hero 115
;;;                    before: 1543 hp 386 mana
;;;                    after:  1548 hp 416 mana

/require healer.tf

;;; read in Verlegenheit's gear file
/load -q char/verlegenheit.gear.ava.tf

/alias sb c 'shoulder burden'

;;; scripts to bipass migraine effects if stuff is stacked
/def -wverlegenheit -p900 -mregexp -ar -t"^You feel a slight headache growing stronger\.\.\." migraine_disconnect_verlegenheit = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'cure light'%;/endif

;; drone/autoheal thing
/def -mglob -p1 -ag -wphenyx -t"Punch whom?" autoheal_toggle = \
    /if ({autoheal}=1) /set healToggle=1%;\
    /else /echo -pw @{Cgreen}Punch whom?@{n}%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState verlegenheit