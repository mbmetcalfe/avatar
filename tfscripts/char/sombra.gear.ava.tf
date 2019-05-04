;; sombra.gear.ava.tf
/cleangear

;/set main_bag "encrusted layer shells loot"
/set main_bag="jumpsuit white loot"

/load -q char/hero.roghit2.ava.tf
/load -q char/hero.mana1.ava.tf
/load -q char/hero.ac1.ava.tf

/set hit_wield="dagger flame shaped unodagger"
/set hit_offhand="dagger flame shaped dosdagger"
/set hit_held="necrostaff necro staff health"


;/load -q char/lord.hit2.ava.tf
;/load -q char/lord.ac2.ava.tf
;/set hit_wield="claw dragon simple"
;/set hit_offhand="pointy stick crom lordgear"
;/set ac_wield="stiletto poignant memories unostiletto"
;/set ac_offhand="stiletto poignant memories dosstiletto"

/def -wsombra hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%; \
    /def -wsombra sombraunlvl = /send remove all.levelgear=put all.levelgear %{main_bag}=wear %{hit_head}=wear %{hit_neck1}%;\
    /def -wsombra sombralvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear
;    /send wear %{ac_body}
;/def -wsombra hit_pre_off = /send rem %{ac_body}=get %{ac_bag} %{main_bag}=put %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -wsombra hit_pre_on = /send get %{ac_bag} %{main_bag}=get %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}


/def -wsombra ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /def -wsombra sombraunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}%; \
    /def -wsombra sombralvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear

;/def -wsombra ac_pre_on = \
;    /send get %{hit_bag} %{main_bag}=get %{hit_wield} %{hit_bag}=get %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

;/def -wsombra ac_pre_off = \
;    /send remove %{hit_wield}=remove %{hit_offhand}=get %{hit_bag} %{main_bag}=put %{hit_wield} %{hit_bag}=put %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

