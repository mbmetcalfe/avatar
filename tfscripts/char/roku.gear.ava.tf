;; roku.gear.ava.tf
/cleangear

/set main_bag="bodybag body bag loot"

/load -q char/hero.mana2.ava.tf
/set mana_bag="otyugh carcass covering beast mana"
/set mana_wield="kzinti holy scythe"
/load -q char/hero.ac3.ava.tf
/set ac_bag="bodybag body bag tankgear!"

/def -wroku ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /def -wroku sle = /ac2mana%%;/send sleep

/def -wroku ac_pre_off = /send remove all.fingerbone=put all.fingerbone %{main_bag}

/def -wroku mana_post_on = /send wield %{mana_wield}=wear %{mana_offhand}
