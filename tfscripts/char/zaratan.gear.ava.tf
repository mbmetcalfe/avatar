;; zaratan.gear.ava.tf
/cleangear

/set main_bag="drake scale skin smoldering rucksack loot"

;/load -q char/hero.lightmana.ava.tf
/load -q char/hero.mana2.ava.tf
/load -q char/hero.ac3.ava.tf

/def -wzaratan ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get all.fingerbone %{main_bag}=wear all.fingerbone%;\
    /send get "Girth quest" %{main_bag}=wear "Girth quest"%;\
    /def -wzaratan sle = /ac2mana%%;/send sleep%;\
    /send smooth self
/def -wzaratan mana_post_on = \
    /send get "Girth quest" %{main_bag}=wear "Girth quest"%;\
    /send relax

/def -wzaratan ac_pre_off = \
    /send remove all.fingerbone=put all.fingerbone %{main_bag}%;\
    /send remove "Girth quest"=put "Girth quest" %{main_bag}
/def -wzaratan mana_pre_off = /send remove "Girth quest"=put "Girth quest" %{main_bag}
