;; kaboo.gear.ava.tf
/cleangear
/set main_bag "floating watersphere"
/load -q char/lord.arc.ava.tf
/load -q char/lord.mana1.ava.tf

/set arc_held "brace ice arrows"

/def -wkaboo arc_pre_on = /send get quiver %{main_bag}
/def -wkaboo arc_post_on = \
        /def -wkaboo kaboolvl = /send get all.levelgear floating=rem %{arc_about}=rem %{arc_head}=wear all.levelgear%; \
        /def -wkaboo kaboounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{arc_about}=wear %{arc_head}%; \
	/set unbrandish=%{arc_held}
/def -wkaboo arc_pre_off = /send put quiver %{main_bag}

/def -wkaboo mana_pre_on = /send get quiver %{main_bag}
/def -wkaboo mana_post_on = \
        /def -wkaboo kaboolvl = /send get all.levelgear %{main_bag}=rem %{mana_neck1}=rem %{mana_head}=wear all.levelgear%; \
        /def -wkaboo kaboounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}=wear %{mana_head}%; \
	/set unbrandish=%{mana_held}
/def -wkaboo mana_pre_off = /send put quiver %{main_bag}
