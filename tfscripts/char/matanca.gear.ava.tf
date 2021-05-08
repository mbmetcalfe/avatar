;; matanca.gear.ava.tf
/cleangear

/set main_bag="bodybag body bag loot"

/load -q char/hero.mana5.ava.tf
/load -q char/hero.ac3.ava.tf
/load -q char/hero.hit4.ava.tf

/def -wmatanca ac_pre_on = /send altof helfyre
;/def -wmatanca ac_pre_on = /send altof zaratan

/def -wmatanca ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /send get "talisman gauntlets magence"=wear "talisman gauntlets magence"%;\
    /def -wmatanca sle = /ac2mana%%;/send sleep%;\
    /send smooth self
/def -wmatanca mana_post_on = /send relax
/def -wmatanca hit_pre_on = /send altof falrim
/def -wmatanca hit_post_on = \
    /set unbrandish=%{hit_held}%;\
    /set offhand=%{hit_offhand}%;\
    /set wield=%{hit_wield}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /send get "talisman gauntlets magence"=wear "talisman gauntlets magence"%;\
    /send wield %{wield}=wear %{offhand}%;\
    /def -wmatanca sle = /hit2mana%%;sleep

/def -wmatanca ac_pre_off = \
    /send remove all.fingerbone=put all.fingerbone %{main_bag}%;\
    /send remove "talisman gauntlets magence"=put "talisman gauntlets magence" %{main_bag}
/def -wmatanca hit_pre_off = /ac_pre_off
