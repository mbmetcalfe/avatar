;;; odium.ava.tf
;You have learned the following Rites:
;    might
;    * resist pain
;    ignore pain
;    * deathblow
;    wail
;    prime strike
;    mutilation
;    armor training
;    * warcry
;    final fury
;    * bloodlust

;;; read in Odium's gear file
;/load -q char/odirum.gear.ava.tf

;;; set up other variables
/set main_bag=loot

/def -wodium -p0 -mregexp -t"^\*?(Shaykh|Khyfa|Zaffer|Lokken|Xharnah)\*? tells the group 'get me'" zaffer_resc = \
    /send rescue %{P1}

/def -wodium rally = \
    /if ({#} = 1) \
        /send follow %{1}=rally=follow %{leader}%;\
    /else \
        /send rally%;\
        /if ({leader} !~ "Self") /send appoint %{leader}%;/endif%;\
    /endif

;; poke for rescue
/def -wodium -p1 -au -mregexp -t"^([a-zA-Z]+) pokes you in the ribs\.$" odium_poke_resc = /if ({odium_auto_rescue} == 1) /send rescue %{P1}%;/endif

;/def -wodium odiumfren = /send gtell frenzy pls
/def -wodium odiumfren = /send get crab %{main_bag}=eat crab
;/def -wodium odiumsanc = /send get wafer loot=eat wafer
/def -wodium odiumsanc = /send gtell sanc pls

/def -p50 -au -wodium -mregexp -t"A female lizardman thief hunts for treasure\." odium_atarg_female_lizardman = b2 female!%;/aq /find female

;You've gone COMPLETELY BERSERK!!
;Your rage dissipates.
/def scar = /auto scar
/def -F -mregexp -t"^You start fighting " autoscar=/if /test $(/getvar auto_scar) == 1%;/then scar%;/endif
/def -mglob -au -t"You've gone COMPLETELY BERSERK!!" odium_autoscar_off = /if /test $(/getvar auto_scar) == 1%;/then /scar off%;/endif
;/def -mglob -au -t"Your rage dissipates." odium_auto_scar_on = /if /test $(/getvar auto_scar) == 0%;/then /scar on%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState odium
