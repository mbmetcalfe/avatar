;;;-----------------------------------------------------------------------------
;;; granuja.ava.tf
;; good poison combo: venom wield/ virus offhand
;;; Hero 897 Killed UD:
;;;     Full hit with carb, shroud, smoldering crown
;;;     bladedance trance, bladetrance level 3
;;;     quaffed 26 nectars
;;;     Ended with You report: 733/8025 hp 12/3514 mana
;;;-----------------------------------------------------------------------------
/load -q char/granuja.gear.ava.tf

/require rogue.tf

/def -ag -mregexp -wgranuja -t"^\*([a-zA-Z]*)\* tell[s]* the group 'pick ([a-zA-Z]+)'" gtell_autopick = pick %P2

/def granujamidround = \
    /if ({mudLag} <3) \
        /send vital %avs_spot%;\
    /endif 

;; Load in the variables saved from previous state.
/loadCharacterState granuja
