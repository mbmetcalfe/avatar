;; keiko.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/hero.mana2.ava.tf
;/load -q char/hero.ac2.ava.tf
/load -q char/hero.ac1.ava.tf

;/def -wkeiko hit_post_on = \
;	wield %{hit_wield}%;wear %{hit_offhand}%; \
;	/set unbrandish=%{hit_held}%; \
;    /def -wkeiko sle = /hit2mana%%;/send sleep%;\
;	/def -wkeiko keikounlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}%; \
;	/def -wkeiko keikolvl = /send remove %{hit_neck1}=get all.levelgear %lootContainer=wear all.levelgear

/def -wkeiko mana_post_on = \
    /set unbrandish=%{mana_held}%; \
	/def -wkeiko keikolvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%; \
	/def -wkeiko keikounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}
;/def -wkeiko mana_pre_off = /send rem girth=put girth %{main_bag}

/def -wkeiko ac_post_on =  \
    remove all.shield%;wear glove%;remove all.rune%;\wear all.scorpion%;\
	/set unbrandish=%{ac_held}%; \
    /def -wkeiko sle = /ac2mana%%;/send sleep%;\
	/def -wkeiko keikolvl = /send get all.levelgear %lootContainer=rem all.necklace=rem %{ac_head}=wear all.levelgear%;\
	/def -wkeiko keikounlvl = /send rem all.levelgear=put all.levelgear %lootContainer=wear %{ac_head}=wear all.necklace
