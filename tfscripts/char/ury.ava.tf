;;; read in Ury's gear file
/load -q char/ury.gear.ava.tf

/set my_spell=Barkskin

/require archer.tf
/alias bowie get bowie %{main_bag}%;wield bowie
/alias unbowie wield %{wield}%;put bowie %{main_bag}
/alias skco bowie%;skin corpse%;unbowie
;/def _varietyCommand = fletch arrow explosive

/def -wury ls = \
    /send get poison quiver=wear poison=longshot %1 %2=rem poison=wear ice=put poison quiver

/def -wury b = /send rem bow=wear shield=bash %*=rem shield=wield bow=stand
/def urymidround = /send -wury held


;; Load in the variables saved from previous state.
/loadCharacterState ury
