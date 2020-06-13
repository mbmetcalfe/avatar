;;; read in Maggot's gear file
/load -q char/maggot.gear.ava.tf

/set main_bag "bodybag bod bag loot"
/set quiver_bag "encrusted layer shells quiver"
;/set quiver_bag "collosus skin bag quiver"

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie

;/set lsarrow=poison
/set lsarrow=mithril
/alias ls \
    /if ({xbowon} == 1) \
        bow%;\
	/send longshot %1 %2%;\
	xbow%;\
    /else /send longshot %1 %2%;\
    /endif%;
/alias ls /send longshot %1 %2

;; Temp triggers until he gets more mvs
/def -wmaggot -mregexp -p1 -au -t"^You feel less durable\.$" maggot_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wmaggot -mregexp -p1 -au -t"^You feel energized\.$" maggot_endurance_up = \
    /send wear %{arc_feet}=config +savespell%;\
    /set enduranceleft=999

/def -wmaggot -mglob -p2 -t"You get a pair of spiked elbow braces from corpse of *." maggot_drop_elbow_braces = /send drop elbow

;; bow/xbow swapping when aggied
/def -wmaggot -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" maggot_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wmaggot -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" maggot_nil_aggie_swap_bow = \
    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
/def -wmaggot -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" maggot_rescued_swap_bow = \
    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif

;; Stance triggers
/set maggot_off_stance=column
/def -mglob -au -p1 -wmaggot -t"One of your Exhaust timers has elapsed. (echelon)" maggot_echelon_exhaust_up = \
    /if ({refreshmisc} == 1) /send stance echelon%;/endif
/def -mglob -au -p1 -wmaggot -t"You drop out of echelon formation." maggot_echelon_down = \
    /if ({refreshmisc} == 1) /send stance %{maggot_off_stance}%;/endif

/def -mglob -au -p1 -wmaggot -t"The Office of the High Clerist" autols_crullius = \
    /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -au -p1 -wmaggot -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
    /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -au -p1 -wmaggot -t"The family graveyard" autols_eater = \
    /if ({leader} !~ "Self") ls north eater%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState maggot
