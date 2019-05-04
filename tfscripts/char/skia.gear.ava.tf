;; skia.gear.ava.tf
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/lord.hit2.ava.tf
;/load -q char/hero.mana3.ava.tf
/load -q char/lord.ac2.ava.tf

/set hit_wield="claw dragon simple"
/set hit_offhand="sword githyanki gith silver lordgear suffering"

/def -wskia hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%; \
    /def -wskia sle = /hit2mana%%;/send sleep%;\
    /def -wskia skiaunlvl = /send remove all.levelgear=put all.levelgear %{main_bag}=wear %{hit_head}=wear %{hit_neck1}%;\
    /def -wskia skialvl = /send remove %{hit_head}=remove %{hit_neck1}=get all.levelgear %{main_bag}=wear all.levelgear
;    /send wear %{ac_body}
;/def -wskia hit_pre_off = /send rem %{ac_body}=get %{ac_bag} %{main_bag}=put %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -wskia hit_pre_on = /send get %{ac_bag} %{main_bag}=get %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}


/def -wskia mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /def -wskia skialvl = /send get all.levelgear %{main_bag}=remove %{mana_neck1}=remove %{mana_head}=wear all.levelgear%; \
    /def -wskia skiaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}

/def -wskia ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /def -wskia sle = /ac2mana%%;/send sleep%;\
    /def -wskia skiaunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}%; \
    /def -wskia skialvl = /send get all.levelgear %{main_bag}=rem %{ac_neck1}=rem %{ac_head}=wear all.levelgear

/def -wskia ac_pre_on = /send get %{hit_bag} %{main_bag}=get %{hit_wield} %{hit_bag}=put %{hit_bag} %{main_bag}

/def -wskia ac_pre_off = \
    /send remove %{hit_wield}=get %{hit_bag} %{main_bag}=put %{hit_wield} %{hit_bag}=put %{hit_bag} %{main_bag}
