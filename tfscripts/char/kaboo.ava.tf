;;; read in Kaboo's gear file
/load -q char/kaboo.gear.ava.tf

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie
/def _varietyCommand = fletch bolt 'lordly explosive'

/def -wkaboo ls = /send get poison quiver=wear poison=longshot %1 %2=rem poison=wear ice=put poison quiver
/def -wkaboo -mregexp -t"^Your innate mental strength defeats ([a-zA-Z]+)'s frenzy spell\!" kaboo_tranquil_frenzy = /send emote is filled with rage!

;; afk-loop to create special arrows
/def fletch = /auto fletch %1
/def kaboofletch = \
    /send get "all.fletching kit tools materials" %{main_bag}%;\
    /undef archer_autofletch_nothing archer_autofletch archer_nofletchkit%;\
    /kaboo_fletch_loop
/def kaboo_fletch_loop = \
    /if /test $(/getvar auto_fletch) == 1%;/then%;\
        /send -wkaboo stand=heighten=heighten=heighten=tell kaboo |bw|Making some arrows.|n|%;\
        /repeat -0:00 6 /send -wkaboo wear "fletching kit tools materials"=fletch arrow ebony%;\
        /repeat -0:00 5 /send -wkaboo wear "fletching kit tools materials"=fletch arrow sableroix%;\
;        /repeat -0:00 5 /send -wkaboo wear "fletching kit tools materials"=fletch bolt explosive%;\
        /repeat -00:20:00 1 /send sleep=inv%;\
        /repeat -00:50:00 1 /kaboo_fletch_loop%;\
    /else \
        /echo -pw %%% Done Making arrows.%;\
        /send -wkaboo rem "fletching kit tools materials"=put "all.fletching kit tools materials" %{main_bag}=wear "%{unbrandish}"%;\
    /endif
/def -wkaboo -mglob -au -t"Your senses return to normal." kaboo_refresh_heighten = \
    /if /test $(/getvar auto_fletch) == 1%;/then /send heighten=heighten=heighten%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState kaboo
