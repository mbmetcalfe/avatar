;; falrim.gear.ava.tf
;;
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.hit1.ava.tf
/load -q char/hero.ac3.ava.tf
/set ac_bag="bodybag body bag tankgear!"
/set ac_wield="crimson spellshard shard spell"
/load -q char/hero.mana4.ava.tf

;/def -wfalrim mana_post_on = \
;    /def -wfalrim falrimlvl = /send get all.levelgear %{main_bag}=rem all.talisman=rem %{mana_head}=wear all.levelgear%; \
;    /def -wfalrim falrimunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear all.talisman

/def -wfalrim hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
	/set unbrandish=%{hit_held}%; \
    /def -wfalrim sle = /hit2mana%%;/send sleep%;\
    /def -wfalrim wa = stand%%;/mana2hit%;\
	/def -wfalrim falrimunlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}%; \
	/def -wfalrim falrimlvl = /send remove %{hit_neck1}=get all.levelgear %lootContainer=wear all.levelgear

/def -wfalrim mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /def -wfalrim falrimlvl = /send get all.levelgear %{main_bag}=wear levelgear%; \
    /def -wfalrim falrimunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}

;/def -wfalrim man = /send rem girth=put girth %{main_bag}

/def -wfalrim ac_post_on =  \
	/set unbrandish=%{ac_held}%; \
    /def -wfalrim sle = /ac2mana%%;/send sleep%;\
    /def -wfalrim wa = stand%%;/mana2ac%;\
	/def -wfalrim falrimunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.bone%; \
	/def -wfalrim falrimlvl = /send get all.levelgear %{main_bag}=rem bone=wear all.levelgear
