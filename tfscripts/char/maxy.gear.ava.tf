;; maxy.gear.ava.tf
/cleangear

/set main_bag "otyugh carcass covering beast loot"

/load -q char/lord.hit1.ava.tf
;/load -q char/hero.mana1.ava.tf
/load -q char/lord.ac1.ava.tf

/def -wmaxy hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
	/set unbrandish=%{hit_held}%; \
	/def -wmaxy maxyunlvl = /send remove all.levelgear=put all.levelgear %{main_bag}=wear %{hit_neck1}=wear %{hit_head}%; \
	/def -wmaxy maxylvl = /send remove %{hit_neck1}=remo %{hit_head}=get all.levelgear %{main_bag}=wear all.levelgear

/def -wmaxy mana_post_on = \
    /def -wmaxy maxylvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%; \
    /def -wmaxy maxyunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}
;/def -wmaxy mana_pre_off = /send rem girth=put girth %{main_bag}

/def -wmaxy ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /def -wmaxy maxyunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}=wear %{ac_held}%; \
    /def -wmaxy maxylvl = /send get all.levelgear %{main_bag}=rem %{ac_neck1}=rem %{ac_head}=rem %{ac_held}=wear all.levelgear
