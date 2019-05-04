;;; medhya.ava.tf
;;; Specific variables/macroes for Medhya

/require psionic.tf

/load -q char/medhya.gear.ava.tf

/def medhyamidround = /send -wmedhya c ultrablast

/alias ps quicken 9%;c psyphon %1%;quicken off

/def -wmedhya -p6 -mregexp -ah -t"You psyphon (.*) with (.*) intensity." medhya_psyphon_mob = \
    /set ticktoggle=1%;\
    /repeat -00:00:03 1 /sregen

;; Load in the variables saved from previous state.
/loadCharacterState medhya

