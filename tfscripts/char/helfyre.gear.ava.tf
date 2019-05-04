;; helfyre.gear.ava.tf
/cleangear

/set main_bag="girdle pouches many loot"

/load -q char/hero.roghit.ava.tf
/load -q char/hero.lightmana.ava.tf
/load -q char/hero.ac3.ava.tf

/def -whelfyre hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%;\
    /set offhand=%{hit_offhand}%;\
    /send wield %{hit_wield}=wear %{hit_offhand}%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -whelfyre sle = /hit2mana%%;/send sleep%;\
    /def -whelfyre helfyreunlvl = /send remove all.levelgear=put all.levelgear %{main_bag}=wear %{hit_head}=wear %{hit_neck1}%;\
    /def -whelfyre helfyrelvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear
;    /send wear %{ac_body}
;/def -whelfyre hit_pre_off = /send rem %{ac_body}=get %{ac_bag} %{main_bag}=put %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -whelfyre hit_pre_on = /send get %{ac_bag} %{main_bag}=get %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}

/def -whelfyre hit_pre_off = \
    /send remove fingerbone=put fingerbone %{main_bag}

/def -whelfyre ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wield %{hit_wield}=wear %{ac_offhand}%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -whelfyre sle = /ac2mana%%;/send sleep%;\
    /def -whelfyre helfyreunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}%; \
    /def -whelfyre helfyrelvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear

/def -whelfyre ac_pre_on = \
    /send get %{hit_bag} %{main_bag}=get %{hit_wield} %{hit_bag}=get %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

/def -whelfyre ac_pre_off = \
    /send remove %{hit_wield}=remove %{hit_offhand}=get %{hit_bag} %{main_bag}=put %{hit_wield} %{hit_bag}=put %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}%;\
    /send remove fingerbone=put fingerbone %{main_bag}

