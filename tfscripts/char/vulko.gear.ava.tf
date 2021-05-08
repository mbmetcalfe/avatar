;; vulko.gear.ava.tf
;;
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/lord.mana2.ava.tf
/set mana_body="empty adamantine shell"
/set mana_bag="urn black managearz"
/load -q char/lord.ac4.ava.tf
/set ac_body=%{mana_body}
/set ac_held="conjunctiongift jewel acilese"

/def -wvulko mana_pre_off = /send remove %{mana_body}=put %{mana_body} %{main_bag}
/def -wvulko mana_on_cleanup = \
    get %{mana_bag} %{main_bag}%;\
    put %{mana_wield} %{mana_bag}%;put %{mana_offhand} %{mana_bag}%;put %{mana_wield} %{mana_bag}%;\
    put %{mana_bag} %{main_bag}
/def -wvulko mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /send get %{mana_body} %{main_bag}=wear %{mana_body}%;\
    /mana_on_cleanup
;    /def -wvulko vulkolvl = /send get all.levelgear %{main_bag}=wear levelgear%; \
;    /def -wvulko vulkounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_neck1}

/def -wvulko ac_pre_off = /send remove %{mana_body}=put %{mana_body} %{main_bag}
/def -wvulko ac_on_cleanup = /send get %{ac_bag} %{main_bag}=put %{ac_neck1} %{ac_bag}=put all.hero %{ac_bag}=put %{ac_wield} %{ac_bag}=put %{ac_bag} %{main_bag}
/def -wvulko ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /send get %{mana_body} %{main_bag}=wear %{mana_body}%;\
    /ac_on_cleanup
;    /def -wvulko vulkounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.bone%; \
;    /def -wvulko vulkolvl = /send get all.levelgear %{main_bag}=rem bone=wear all.levelgear
