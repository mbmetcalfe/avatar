;;; read in Thrug's gear file
;/load -q char/thrug.gear.ava.tf

/require rogue.tf

/def -mglob -wthrug -p0 -t"You feel less fatigued\." racial_frenzy_fatigue = \
	/if ({refren} = 1) /send racial frenzy %; /endif

;; Load in the variables saved from previous state.
/loadCharacterState thrug