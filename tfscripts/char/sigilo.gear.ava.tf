;; sigilo.gear.ava.tf
/cleangear

/set main_bag="bodybag body bag loot"

/load -q char/hero.roghit2.ava.tf
/load -q char/hero.ac1.ava.tf

/set hit_wield="dagger flame shaped unodagger"
/set hit_offhand="dagger flame shaped dosdagger"
;/set hit_held="necrostaff necro staff health"



/def -wsigilo hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%; \
    /def -wsigilo sigilounlvl = /send remove all.levelgear=put all.levelgear %{main_bag}=wear %{hit_head}=wear %{hit_neck1}%;\
    /def -wsigilo sigilolvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear
;    /send wear %{ac_body}
;/def -wsigilo hit_pre_off = /send rem %{ac_body}=get %{ac_bag} %{main_bag}=put %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -wsigilo hit_pre_on = /send get %{ac_bag} %{main_bag}=get %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}


/def -wsigilo ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /def -wsigilo sigilounlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{ac_neck1}=wear %{ac_head}%; \
    /def -wsigilo sigilolvl = /send get all.levelgear %{main_bag}=wear levelgear=wear levelgear

;/def -wsigilo ac_pre_on = \
;    /send get %{hit_bag} %{main_bag}=get %{hit_wield} %{hit_bag}=get %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

;/def -wsigilo ac_pre_off = \
;    /send remove %{hit_wield}=remove %{hit_offhand}=get %{hit_bag} %{main_bag}=put %{hit_wield} %{hit_bag}=put %{hit_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

