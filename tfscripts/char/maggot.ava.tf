;;; read in Maggot's gear file
/load -q char/maggot.gear.ava.tf

/set main_bag "bodybag bod bag loot"

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie
/set boltType=ice

/alias aoe \
  /aoe %{1}%;\
  /set maggot_auto_cast 1%;\
  /if ({auto_aoe} == 1) \
    /send get "%{boltType} bolt" %{quiver_bag}=wield "silver  crossbow"=wear "%{boltType} bolt"%;\
    /set xbowon=1%;\
  /else bow%;\
  /endif

;/alias xbow get "%{boltType} bolt" %{quiver_bag}%;wield %{arc_xbow}%;wear "%{boltType} bolt"%;/set xbowon=1

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

;; bow/xbow swapping when aggied
;/def -wmaggot -p9 -ag -mregexp -F -t"\'s attac.* strikes? you [0-9]* (time|times), with .* [a-zA-Z]*(\.|\!)$" maggot_aggie_swap_bow = \
;    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
;/def -wmaggot -p9 -ag -mregexp -F -t"\'s attacks haven\'t hurt you\!$" maggot_nil_aggie_swap_bow = \
;    /if ({xbowon}=0 & {leader} !~ "Self" & {running}=1) xbow%;/aq bow%;/endif
;/def -wmaggot -p9 -ag -mregexp -F -t"([a-zA-Z]+) successfully rescues you from the .*\!" maggot_rescued_swap_bow = \
;    /if ({xbowon}=1 & {leader} !~ "Self" & {running}=1) bow%;/clrq%;/endif
;/def -p10 -mglob -au -t"You have the wrong kind of ammo!" maggot_wrong_ammo = /swap %{boltType}

;; Stance triggers
/set maggot_off_stance=square
/def -mglob -au -p1 -wmaggot -t"One of your Exhaust timers has elapsed. (echelon)" maggot_echelon_exhaust_up = \
    /if ({refreshmisc} == 1) /send stance echelon%;/endif
/def -mglob -au -p1 -wmaggot -t"You drop out of echelon formation." maggot_echelon_down = \
    /if ({refreshmisc} == 1) /send stance %{maggot_off_stance}%;/endif

;; Toggle focus fire on certain mobs
;/def -mregexp -p5 -t"^You start fighting (Groundskeeper Skaggs)\." maggot_auto_focus_mobs = /cast on%;/aq /cast off

/def maggot_char_status = /stance_char_status
;/def maggot_char_status = \
;  /set status_misc=$[getStanceStatus()]%;\
;  /let curStanceLen=$[strlen({status_misc})]%;\
;  /status_edit_misc %{curStanceLen}

;; Trigger ice blooms
/def bloom = /auto bloom %1
/def -mregexp -p20 -t"icy patch blooms into a jagged, crystalline growth\!" maggot_explode_bloom = \
  /echo -pw BLOOMING!%;\
  /if ({maggot_auto_bloom}==1) \
    /if ({maggot_auto_cast} == 1) /cast off%;/endif%;\
    /send get "brace lordly explosive bolts" %{quiver_bag}=wear "brace lordly explosive bolts"=focus%;\
    /aq wear %{unbrandish}%;put "brace lordly explosive bolts" %{quiver_bag}%;/cast on%;\
  /endif
/def -mregexp -p20 -t"The icy buildup protruding from (.*)'s wound explodes in a jagged shower of slivers\!" maggot_exploded_bloom = \
  /echo -pw BLOOMED!%;\
  /if ({maggot_auto_bloom}==1) \
    /cast on%;\
    wear %{unbrandish}%;put "brace lordly explosive bolts" %{quiver_bag}%;\
  /endif

;; Load in the variables saved from previous state.
/loadCharacterState maggot
