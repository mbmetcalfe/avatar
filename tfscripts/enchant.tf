;; enchant.tf
;; Simple enchant bot.
;; To use, first set these two variables
;;   max_enchant_level - The max level to enchant to.
;;   min_enchant_damage - The min damage for weapons you wish to enchant.
;; 
;; Once those are set, turn bot on with "/enchant" and identify the item you want to enchant. 
;;  * If an enchant is successful it will be placed in %{fodder_bag}.
;;  * If the item fades, it is identified to ensure it is still within level range.
;;  * If nothing happens, another enchant is issued.
;;  * If item explodes, the next one is identified.
;;  * If no more items found, character sleeps and enchant-bot is turned off.
;;  * If item is above level-range or below acceptable max damage/base ac it is dropped.
/def enchant = \
  /auto enchant %1%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /echo -pw @{hCmagenta}Enchant-bot settings:@{n}%;\
    /echo -pw @{Cgreen}  Max Enchant Level: @{Cwhite}%{max_enchant_level}@{n}%;\
    /echo -pw @{Cgreen}  Min Weapon Damage: @{Cwhite}%{min_enchant_damage}@{n}%;\
    /echo -pw @{Cgreen}  Min Armor Base:    @{Cwhite}%{min_enchant_base}@{n}%;\
    /echo -pw @{Cgreen}  Fodder Bag:        @{Cwhite}%{fodder_bag}@{Cgreen}.@{n}%;\
  /endif
/set max_enchant_level=56
/set min_enchant_damage=46
/set min_enchant_base=11
/def -F -mregexp -t"^Object '(.*)' type (weapon|armor).*\." auto_enchant1=\
  /set ae_keywords=%{P1}%;\
  /set ae_type=%{P2}
/def -F -mregexp -t"^Weight [0-9]+, value [0-9]+, level ([0-9]+)\.$" auto_enchant2=\
  /set ae_level=%{P1}
/def -F -mregexp -t"^Damage is [0-9]+ to ([0-9]+) \(average [0-9]+\)\.$" auto_enchant3=\
  /let ae_max=%{P1}%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /echo Level: %{ae_level}, Max Level: %{max_enchant_level}, Weapon Max: %{ae_max}, Min weapon max: %{min_enchant_damage}%;\
    /if ({ae_level}<{max_enchant_level} & {ae_max} >= {min_enchant_damage}) c 'enchant %{ae_type}' "%{ae_keywords}"%;\
    /else drop "%{ae_keywords}"=c id "%{ae_keywords}"%;\
    /endif%;\
  /endif
/def -F -mregexp -t"^Armor class is ([0-9]+).$" auto_enchant_armor1=\
  /let ae_base=%{P1}%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /echo Level: %{ae_level}, Max Level: %{max_enchant_level}, Armor Base: %{ae_base}, Min Armor Base: %{min_enchant_base}%;\
    /if ({ae_level}<{max_enchant_level} & {ae_base} >= {min_enchant_base}) c 'enchant %{ae_type}' "%{ae_keywords}"%;\
    /else drop "%{ae_keywords}"=c id "%{ae_keywords}"%;\
    /endif%;\
  /endif
;; If fade, re-ident and be sure < max level
/def -F -mregexp -t"^(.*) glows brightly\, then fades\.\.\.oops\." auto_enchant4=/if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif
;; if nothing, enchant again
/def -F -mregexp -t"^Nothing seemed to happen\.$" auto_enchant5=/if /test $(/getvar auto_enchant) == 1%;/then c 'enchant %{ae_type}' "%{ae_keywords}"%;/endif
;; if brill, stash it
/def -F -mregexp -t"^(.*) glows a brilliant (blue|yellow|gold)\!" auto_enchant6=/if /test $(/getvar auto_enchant) == 1%;/then /send put "%{ae_keywords}" %{fodder_bag}=c id "%{ae_keywords}"%;/endif
;; if explode, identify next one
/def -F -mregexp -t"^.* shivers violently and explodes\!" auto_enchant7=/if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif
/def -F -mregexp -t"^.* flares blindingly\.\.\. and evaporates\!" auto_enchant_armor2=/if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif
;; if no more items, sleep and turn off bot.
/def -F -mregexp -t"^You are not carrying .*\!$" auto_enchant8=/if /test $(/getvar auto_enchant) == 1%;/then /enchant off%;sleep%;/endif
/def -F -mregexp -t"^You do not have enough mana to cast enchant (bow|armor|weapon).$" auto_enchant9=\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
      sleep%;\
      /def full_mana_action = stand%%;c 'enchant %{ae_type}' "%{ae_keywords}"%;\
  /endif
