;;; read in Kaboo's gear file
/load -q char/kaboo.gear.ava.tf

/set my_spell=Barkskin

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie
;/def _varietyCommand = fletch arrow explosive

/def -wkaboo ls = \
    /send get poison quiver=wear poison=longshot %1 %2=rem poison=wear ice=put poison quiver
/def -wkaboo -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s frenzy spell\!" kaboo_tranquil_frenzy = /send emote is filled with rage!
;gtell |bb|My innate mental strength seems to be too much for you |bw|%P1|bb|.  Better luck next time.

/def -wkaboo b = /send rem bow=wear shield=bash %*=rem shield=wield bow=stand
/def kaboomidround = /send -wkaboo held


;; Load in the variables saved from previous state.
/loadCharacterState kaboo
