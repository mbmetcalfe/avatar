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

;; bow/xbow swapping when aggied
/def -wury -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" ury_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wury -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" ury_nil_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wury -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" ury_rescued_swap_bow = \
    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif


;; Load in the variables saved from previous state.
/loadCharacterState ury
