;;; read in Kaboo's gear file
/load -q char/kaboo.gear.ava.tf

/set my_spell=Barkskin

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie
/def _varietyCommand = fletch bolt 'lordly explosive'

/def -wkaboo ls = \
    /send get poison quiver=wear poison=longshot %1 %2=rem poison=wear ice=put poison quiver
/def -wkaboo -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s frenzy spell\!" kaboo_tranquil_frenzy = /send emote is filled with rage!
;gtell |bb|My innate mental strength seems to be too much for you |bw|%P1|bb|.  Better luck next time.

/def -wkaboo b = /send rem bow=wear shield=bash %*=rem shield=wield bow=stand
/def kaboomidround = /send -wkaboo held


;; afk-loop to create special arrows
/def fletch = /auto fletch %1
/def kaboofletch = \
    /send get "all.fletching kit tools materials" %{main_bag}%;\
    /undef archer_autofletch_nothing archer_autofletch archer_nofletchkit%;\
    /kaboo_fletch_loop
/def kaboo_fletch_loop = \
    /if /test $(/getvar auto_fletch) == 1%;/then%;\
        /echo -pw %%% Making some arrows.%;\
        /send -wkaboo tell kaboo |bw|Making some arrows.|n|%;\
        /repeat -0:00 5 /send -wkaboo wear "fletching kit tools materials"=fletch arrow sableroix%;\
        /repeat -0:00 5 /send -wkaboo wear "fletching kit tools materials"=fletch bolt explosive%;\
        /repeat -01:04:00 1 /kaboo_fletch_loop%;\
    /else \
        /echo -pw %%% Done Making arrows.%;\
        /send -wkaboo rem "fletching kit tools materials"=put "all.fletching kit tools materials" %{main_bag}=wear "%{unbrandish}"%;\
    /endif

;; Load in the variables saved from previous state.
/loadCharacterState kaboo
