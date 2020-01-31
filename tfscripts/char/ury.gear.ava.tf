;; ury.gear.ava.tf
/cleangear
/set main_bag "bodybag loot"
/set quiver_bag "encrusted layer shells quiver"

/load -q char/hero.arc.ava.tf

/set arc_held "brace piercing arrows"

/def -wury arc_pre_on = /send get %{quiver_bag} %{main_bag}
/def -wury arc_post_on = \
        /def -wury urylvl = /send get all.levelgear floating=rem %{arc_about}=rem %{arc_head}=wear all.levelgear%; \
        /def -wury uryunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{arc_about}=wear %{arc_head}%; \
	/set unbrandish=%{arc_held}
/def -wury arc_pre_off = /send put %{quiver_bag} %{main_bag}

/def -wury mana_pre_on = /send get %{quiver_bag} %{main_bag}
/def -wury mana_post_on = \
        /def -wury urylvl = /send get all.levelgear %{main_bag}=rem %{mana_neck1}=rem %{mana_head}=wear all.levelgear%; \
        /def -wury uryunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}=wear %{mana_head}%; \
	/set unbrandish=%{mana_held}
/def -wury mana_pre_off = /send put %{quiver_bag} %{main_bag}

;; Temp trigger until he gets more mvs
/def -wury -mregexp -p1 -au -t"^You feel less durable\.$" ury_endurance_fall = \
    /send wear seven%;\
    /set enduranceleft=-1
/def -wury -mregexp -p1 -au -t"^You feel energized\.$" ury_endurance_up = \
    /send wear %{arc_feet}%;\
    /set enduranceleft=999
