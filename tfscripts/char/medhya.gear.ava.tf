;; medhya.gear.ava.tf
;;
/cleangear

/set main_bag "drake scale skin smoldering rucksack loot"

/load -q char/hero.ac3.ava.tf
/set ac_bag="bodybag body bag tankgear!"
/set ac_wield="crimson spellshard shard spell"
/load -q char/hero.mana4.ava.tf
/load -q char/hero.hit1.ava.tf
/set hit_wield="huge justice sword ornate"
/set hit_offhand="sword baron"

/def -wmedhya hit_post_on = \
	wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set wield=%{hit_wield}%;/set offhand=%{hit_offhand}%;\
	/set unbrandish=%{hit_held}%; \
    /def -wmedhya sle = /hit2mana%%;/send sleep%;\
    /def -wmedhya wa = stand%%;/mana2hit%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone

/def -wmedhya mana_post_on = /set unbrandish=%{mana_held}

/def -wmedhya ac_pre_off = /send remove all.fingerbone=put all.fingerbone %{main_bag}
/def -wmedhya hit_pre_off = /ac_pre_off

/def -wmedhya ac_post_on =  \
	/set unbrandish=%{ac_held}%;\
    /set wield=%{ac_wield}%;\
    /def -wmedhya sle = /ac2mana%%;/send sleep%;\
    /def -wmedhya wa = stand%%;/mana2ac%;\
    /send get fingerbone %{main_bag}=wear fingerbone
