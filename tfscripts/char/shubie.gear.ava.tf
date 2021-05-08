;; shubie.gear.ava.tf
/cleangear

/set main_bag="bodybag body bag loot"

/load -q char/hero.mana5.ava.tf
/load -q char/hero.ac3.ava.tf
/load -q char/hero.hit4.ava.tf

/def -wshubie ac_pre_on = /send altof helfyre
;/def -wshubie ac_pre_on = /send altof zaratan

/def -wshubie ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /send get "talisman gauntlets magence"=wear "talisman gauntlets magence"%;\
    /def -wshubie sle = /ac2mana%%;/send sleep%;\
    /send smooth self
/def -wshubie mana_post_on = /send relax
/def -wshubie hit_pre_on = /send altof falrim
/def -wshubie hit_post_on = \
    /set unbrandish=%{hit_held}%;\
    /set offhand=%{hit_offhand}%;\
    /set wield=%{hit_wield}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /send get "talisman gauntlets magence"=wear "talisman gauntlets magence"%;\
    /send wield %{wield}=wear %{offhand}%;\
    /def -wshubie sle = /hit2mana%%;sleep

/def -wshubie ac_pre_off = \
    /send remove all.fingerbone=put all.fingerbone %{main_bag}%;\
    /send remove "talisman gauntlets magence"=put "talisman gauntlets magence" %{main_bag}
/def -wshubie hit_pre_off = /ac_pre_off
