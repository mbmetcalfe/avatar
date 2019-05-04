;; medhya.gear.ava.tf
;;
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.ac2.ava.tf
/load -q char/hero.mana3.ava.tf
/load -q char/hero.hit1.ava.tf

;/def -wmedhya mana_post_on = \
;    /def -wmedhya medhyalvl = /send get all.levelgear %{main_bag}=rem all.talisman=rem %{mana_head}=wear all.levelgear%; \
;    /def -wmedhya medhyaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear all.talisman

/def -wmedhya hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
	/set unbrandish=%{hit_held}%; \
    /def -wmedhya sle = /hit2mana%%;/send sleep%;\
    /def -wmedhya wa = stand%%;/mana2hit%;\
	/def -wmedhya medhyaunlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}%; \
	/def -wmedhya medhyalvl = /send remove %{hit_neck1}=get all.levelgear %lootContainer=wear all.levelgear

/def -wmedhya mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /def -wmedhya medhyalvl = /send get all.levelgear %{main_bag}=wear levelgear%; \
    /def -wmedhya medhyaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}

;/def -wmedhya man = /send rem girth=put girth %{main_bag}

/def -wmedhya ac_post_on =  \
	/set unbrandish=%{ac_held}%; \
    /def -wmedhya sle = /ac2mana%%;/send sleep%;\
    /def -wmedhya wa = stand%%;/mana2ac%;\
	/def -wmedhya medhyaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.bone%; \
	/def -wmedhya medhyalvl = /send get all.levelgear %{main_bag}=rem bone=wear all.levelgear
