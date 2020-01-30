;;; medhya.ava.tf
;;; Specific variables/macroes for Medhya

/require psionic.tf

/load -q char/medhya.gear.ava.tf

/def medhyamidround = /send -wmedhya c ultrablast

/alias ps quicken 9%;c psyphon %1%;quicken off

/def -wmedhya -p6 -mregexp -ah -t"You psyphon (.*) with (.*) intensity." medhya_psyphon_mob = \
    /set ticktoggle=1%;\
    /repeat -00:00:03 1 /sregen

;; Turn Medhya's drone on with /auto drone on

/def medhyadrone = \
  /if ({medhya_auto_drone}=1) \
      /send config +noautomove=title |n|: BUZZ FOR STEEL%;\
  /else \
      /send title reset=config -noautomove%;\
  /endif%;\
  /send tag remove bot%;\
  /if ({medhya_auto_drone} == 1) \
      /send tag set bot |c|Currently botting. Buzz for steel.|n|%;\
  /endif

/def -wmedhya -mregexp -t"You swat at your ear, a buzzing noise is coming from ([a-zA-Z]+)." medhyasteel =\
    /if ({medhya_auto_drone} = 1) stand%;c 'steel skeleton' %P1%;sleep%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState medhya

