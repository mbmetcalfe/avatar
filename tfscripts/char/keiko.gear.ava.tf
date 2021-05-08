;; keiko.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"
/load -q char/lord.ac1.ava.tf

;/def -wkeiko hit_post_on = \
;	wield %{hit_wield}%;wear %{hit_offhand}%; \
;	/set unbrandish=%{hit_held}%; \
;    /def -wkeiko sle = /hit2mana%%;/send sleep%;\
;	/def -wkeiko keikounlvl = /send remove all.levelgear=put all.levelgear %lootContainer=wear %{hit_neck1}%; \
;	/def -wkeiko keikolvl = /send remove %{hit_neck1}=get all.levelgear %lootContainer=wear all.levelgear

/def -wkeiko ac_post_on =  \
;    remove all.shield%;wear glove%;remove all.rune%;\wear all.scorpion%;\
	/set unbrandish=%{ac_held}
