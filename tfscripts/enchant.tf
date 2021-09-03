;; enchant.tf
;; Simple enchant bot.
;; To use, first set these two variables
;;   max_enchant_level  - The max level to enchant to.
;;   min_enchant_damage - The min damage for weapons you wish to enchant.
;;   min_enchant_base   - The min base for armor you wish to enchant.
;; 
;; Once those are set, turn bot on with "/enchant" and identify the item you want to enchant. 
;;  * If an enchant is successful it will be placed in %{fodder_bag}.
;;  * If the item fades, it is identified to ensure it is still within level range.
;;  * If nothing happens, another enchant is issued.
;;  * If item explodes, the next one is identified.
;;  * If no more items found, character sleeps and enchant-bot is turned off.
;;  * If item is above level-range or below acceptable max damage/base ac it is dropped.

/def fodderbag = /setvar fodder_bag %{*}
/def -i fodderlevel = /setvar max_enchant_level %{*}
/def -i fodderdamage = /setvar min_enchant_damage %{*}
/def -i fodderbase = /setvar min_enchant_base %{*}

;; Toggle auto-enchanting.
;; If the default thresholds not set for alt, set them now.
/def enchant = \
  /auto enchant %1%;\
  /let mel=$(/getvar max_enchant_level)%;\
  /if /test $(/getvar max_enchant_level) == 0%;/then \
    /setvar max_enchant_level 54%;\
    /setvar min_enchant_damage 46%;\
    /setvar min_enchant_base 11%;\
  /endif%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /set enchant_nothing=0%;/set enchant_brill=0%;/set enchant_shimmer=0%;/set enchant_vape=0%;/set enchant_fade=0%;\
    /echo -pw @{hCmagenta}Enchant-bot settings:@{n}%;\
    /echo -pw @{Cgreen}  Max Enchant Level: @{Cwhite}$(/getvar max_enchant_level)@{n}%;\
    /echo -pw @{Cgreen}  Min Weapon Damage: @{Cwhite}$(/getvar min_enchant_damage)@{n}%;\
    /echo -pw @{Cgreen}  Min Armor Base:    @{Cwhite}$(/getvar min_enchant_base)@{n}%;\
    /echo -pw @{Cgreen}  Fodder Bag:        @{Cwhite}$(/getvar fodder_bag)@{Cgreen}.@{n}%;\
  /else /enchantstat%;\
  /endif

/def enchantstat = \
  /echo -pw @{Cred}[ENCHANT INFO:] Nothing: @{Cwhite}%{enchant_nothing}@{Cred}, Brill: @{Cwhite}%{enchant_brill}@{Cred}, Shimmer: @{Cwhite}%{enchant_shimmer}@{Cred}, Vape: @{Cwhite}%{enchant_vape}@{Cred}, Fade: @{Cwhite}%{enchant_fade}
 
; Trigs to capture data and start enchanting
/def -F -mregexp -t"^Object '(.*)' type (weapon|armor|bow).*\." auto_enchant1=\
  /set ae_keywords=%{P1}%;\
  /set ae_type=%{P2}
/def -F -mregexp -t"^Weight [0-9]+, value [0-9]+, level ([0-9]+)\.$" auto_enchant2=\
  /set ae_level=%{P1}
/def -F -mregexp -t"^Damage is [0-9]+ to ([0-9]+) \(average [0-9]+\)\.$" auto_enchant3=\
  /let ae_max=%{P1}%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /if ({ae_level}<$(/getvar max_enchant_level) & {ae_max} >= $(/getvar min_enchant_damage)) c 'enchant %{ae_type}' "%{ae_keywords}"%;\
    /else drop "%{ae_keywords}"=c id "%{ae_keywords}"%;\
    /endif%;\
  /endif
/def -F -mregexp -t"^Armor class is ([0-9]+).$" auto_enchant_armor1=\
  /let ae_base=%{P1}%;\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
    /if ({ae_level}<$(/getvar max_enchant_level) & {ae_base} >= $(/getvar min_enchant_base)) c 'enchant %{ae_type}' "%{ae_keywords}"%;\
    /else drop "%{ae_keywords}"=c id "%{ae_keywords}"%;\
    /endif%;\
  /endif

; Trigs to keep enchanting.
;; If fade, re-ident and be sure < max level
/def -F -mregexp -t"^(.*) glows brightly\, then fades\.\.\.oops\." auto_enchant4=\
  /if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_fade]

;; if nothing, enchant again
/def -F -mregexp -t"^Nothing seemed to happen\.$" auto_enchant5=\
  /if /test $(/getvar auto_enchant) == 1%;/then c 'enchant %{ae_type}' "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_nothing]

;; if brill, stash it
/def -F -mregexp -t"^(.*) glows a brilliant (blue|yellow|gold)\!" auto_enchant6=\
  /if /test $(/getvar auto_enchant) == 1%;/then /send put "%{ae_keywords}" $(/getvar fodder_bag)=c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_brill]

;; if non-brill, stash it
/def -F -mregexp -t"^(.*) shimmers with a gold aura\.$" auto_enchant_armor2=\
  /if /test $(/getvar auto_enchant) == 1%;/then /send put "%{ae_keywords}" $(/getvar fodder_bag)=c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_shimmer]
/def -F -mregexp -t"^(.*) glows blue\.$" auto_enchant_weapon=\
  /if /test $(/getvar auto_enchant) == 1%;/then /send put "%{ae_keywords}" $(/getvar fodder_bag)=c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_shimmer]

;; if explode, identify next one
/def -F -mregexp -t"^.* shivers violently and explodes\!" auto_enchant7=\
  /if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_vape]
/def -F -mregexp -t"^.* flares blindingly\.\.\. and evaporates\!" auto_enchant_armor3=\
  /if /test $(/getvar auto_enchant) == 1%;/then c id "%{ae_keywords}"%;/endif%;\
  /test $[++enchant_vape]

;; if no more items, sleep and turn off bot.
/def -F -mregexp -t"^You are not carrying .*\!$" auto_enchant8=\
  /if /test $(/getvar auto_enchant) == 1%;/then /enchant off%;sleep%;/endif

/def -F -mregexp -t"^You do not have enough mana to cast enchant (bow|armor|weapon).$" auto_enchant9=\
  /if /test $(/getvar auto_enchant) == 1%;/then%;\
      sleep%;\
      /def full_mana_action = stand%%;c 'enchant %{ae_type}' "%{ae_keywords}"%;\
  /endif
/def -F -mregexp -t"^You do not have enough mana to cast identify." auto_enchant10=\
    /if /test $(/getvar auto_enchant) == 1%;/then%;\
      sleep%;\
      /def full_mana_action = stand%%;c id "%{ae_keywords}"%;\
    /endif

;; if item can't fit in fodder bag, turn off bot.
/def -F -mglob -t"It won't fit." auto_enchant11=\
    /if /test $(/getvar auto_enchant) == 1%;/then%;\
      sleep%;/beep%;\
      /enchant off%;\
    /endif

;; Manifest helpers
/def -F -mregexp -t"^Object '(.*)' type (weapon|armor|bow).*\." manifest_object_name=\
  /set manifest_keywords=%{P1}%;\
  /set manifest_type=%{P2}
  
/def -F -mregexp -t"^Diamonds: ([0-9]+), Rub[iesy]+: ([0-9]+), Emeralds?: ([0-9]+), Sapphires?: ([0-9]+), Amethysts?: ([0-9]+)" manifest_embedded_gems=\
  /let manifest_diamonds=%{P1}%;\
  /let manifest_rubies=%{P2}%;\
  /let manifest_emeralds=%{P3}%;\
  /let manifest_sapphires=%{P4}%;\
  /let manifest_amethysts=%{P5}%;\
  /echo %{P5}%;\
  /let gem_msg=%;\
  /let manifest_item=NA%;\
  /if ({manifest_diamonds} > 0) /let gem_msg=%{gem_msg} |r|%{manifest_diamonds}|n| Diamonds%;/endif%;\
  /if ({manifest_rubies} > 0) /let gem_msg=%{gem_msg} |r|%{manifest_rubies}|n| Rubies%;/endif%;\
  /if ({manifest_emeralds} > 0) /let gem_msg=%{gem_msg} |r|%{manifest_emeralds}|n| Emeralds%;/endif%;\
  /if ({manifest_sapphires} > 0) /let gem_msg=%{gem_msg} |r|%{manifest_sapphires}|n| Sapphires%;/endif%;\
  /if ({manifest_amethysts} > 0) /let gem_msg=%{gem_msg} |r|%{manifest_amethysts}|n| Amethysts%;/endif%;\
; Lord Manifest items
  /if ({manifest_keywords} =~ "claw dragon") \
    /if ({manifest_diamonds}==0 & {manifest_rubies}==1 & {manifest_emeralds}==1 & {manifest_sapphires}==3 & {manifest_amethysts}==0)\
        /let manifest_item=Lonewolf's Claw%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "ring earth elemental lordgear") \
    /if ({manifest_diamonds}==0 & {manifest_rubies}==3 & {manifest_emeralds}==0 & {manifest_sapphires}==2 & {manifest_amethysts}==1)\
      /let manifest_item=Jean's Ruby Ring%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "broken shackles tyranny") \
    /if ({manifest_diamonds}==7 & {manifest_rubies}==0 & {manifest_emeralds}==0 & {manifest_sapphires}==0 & {manifest_amethysts}==0)\
      /let manifest_item=runic First Cycle Bracelet%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "watermark tattoo wave") \
    /if ({manifest_diamonds}==1 & {manifest_rubies}==1 & {manifest_emeralds}==1 & {manifest_sapphires}==2 & {manifest_amethysts}==1)\
      /let manifest_item=szi's armband of wickedness%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "armor ornate silver githyanki gith chestplate lordgear") \
    /if ({manifest_diamonds}==4 & {manifest_rubies}==0 & {manifest_emeralds}==1 & {manifest_sapphires}==0 & {manifest_amethysts}==1)\
      /let manifest_item=ironhand's Emblazoned Armor%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "stone flame inferno") \
    /if ({manifest_diamonds}==2 & {manifest_rubies}==1 & {manifest_emeralds}==1 & {manifest_sapphires}==1 & {manifest_amethysts}==1)\
      /let manifest_item=guiding light of ronan%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "jeweled crown aziz-ra") \
    /if ({manifest_diamonds}==2 & {manifest_rubies}==1 & {manifest_emeralds}==1 & {manifest_sapphires}==0 & {manifest_amethysts}==2)\
      /let manifest_item=Ferret's Hood%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "lodestone chunk! rock!") \
    /if ({manifest_diamonds}==1 & {manifest_rubies}==1 & {manifest_emeralds}==3 & {manifest_sapphires}==0 & {manifest_amethysts}==2)\
      /let manifest_item=dawiz's sceptre of might%;\
    /endif%;\
  /elseif ({manifest_keywords} =~ "head stick") \
    /if ({manifest_diamonds}==1 & {manifest_rubies}==1 & {manifest_emeralds}==1 & {manifest_sapphires}==1 & {manifest_amethysts}==4)\
      /let manifest_item=crom's pointy stick%;\
    /endif%;\
  /endif%;\
  /send say The |r|%{manifest_keywords}|n| has: %{gem_msg}.%;\
  /if ({manifest_item} !~ "NA") /send say This can manifest to |r|%{manifest_item}|n|. (|w|cast manifest "%{manifest_keywords}" "%{manifest_item}"|n|)%;\
  /else /send say I can't match that with a manifest%;\
  /endif
