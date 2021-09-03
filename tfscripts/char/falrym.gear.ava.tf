;; falrym.gear.ava.tf
;;
/cleangear

/set main_bag "bodybag body bag loot"

/load -q char/hero.hit1.ava.tf
/load -q char/hero.ac3.ava.tf
/set ac_bag="bodybag body bag tankgear!"
/set ac_wield="crimson spellshard shard spell"
/load -q char/hero.lightmana.ava.tf

/def -wfalrym hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
	/set unbrandish=%{hit_held}%; \
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -wfalrym sle = /hit2mana%%;/send sleep%;\
    /def -wfalrym wa = stand%%;/mana2hit

/def -wfalrym mana_post_on = \
    /set unbrandish=%{mana_held}

;/def -wfalrym man = /send rem girth=put girth %{main_bag}

/def -wfalrym ac_post_on =  \
	/set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;/set wield=%{ac_wield}%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -wfalrym sle = /ac2mana%%;/send sleep%;\
    /def -wfalrym wa = stand%%;/mana2ac

/def -wfalrym ac_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}
/def -wfalrym hit_pre_off = /ac_pre_off
