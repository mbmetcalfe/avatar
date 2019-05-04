;; ganik.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.hit1.ava.tf
/load -q char/hero.mana1.ava.tf
/load -q char/hero.ac1.ava.tf

/def -wganik hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
	/set unbrandish=%{hit_held}%; \
	/def -wganik ganikunlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}=wear %{hit_head}%; \
	/def -wphenyx ganiklvl = /send remove %{hit_neck1}=remo %{hit_head}=get all.levelgear %lootContainer=wear all.levelgear

/def -wganik mana_post_on = \
	/def -wganik ganiklvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%; \
	/def -wganik ganikunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}
;/def -wganik mana_pre_off = /send rem girth=put girth %{main_bag}

/def -wganik ac_post_on =  \
	/set unbrandish=%{ac_held}%; \
	/def -wganik ganikunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}=wear %{ac_held}%; \
	/def -wganik ganiklvl = /send get all.levelgear %{main_bag}=rem %{ac_neck1}=rem %{ac_head}=rem %{ac_held}=wear all.levelgear
