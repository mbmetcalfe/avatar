;; granuja.gear.ava.tf
/cleangear

/set main_bag="floating icesphere loot"


/load -q char/lord.hit2.ava.tf
/load -q char/lord.ac2.ava.tf
/set ac_wield="sword ascension unoac"
/set ac_offhand="sword ascension dosac"
/set hit_wield="sword ascension unohit"
/set hit_offhand="sword ascension doshit"

/def -wgranuja hit_post_on = \
    wield %{hit_wield}%;wear %{hit_offhand}%; \
    /set unbrandish=%{hit_held}%; \
    /def -wgranuja granujaunlvl = /send remove orb=put orb %{main_bag}=wear %{hit_held}%;\
    /def -wgranuja granujalvl = /send get orb %{main_bag}=wear orb

;/def -wgranuja hit_pre_off = /send rem %{ac_body}=get %{ac_bag} %{main_bag}=put %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -wgranuja hit_pre_on = /send get %{ac_bag} %{main_bag}=get %{ac_body} %{ac_bag}=put %{ac_bag} %{main_bag}
;/def -wgranuja hit_post_on = /send get %{ac_bag} %{main_bag}=get %ac_wield %ac_bag%;get %ac_offhand %ac_bag%;wield %{hit_wield}=wear %{hit_offhand}%;put %ac_bag %main_bag


/def -wgranuja ac_post_on =  \
    wield %{ac_wield}%;wear %{ac_offhand}%;\
    /set unbrandish=%{ac_held}%; \
    /def -wgranuja granujaunlvl = /send rem orb=put orb %{main_bag}=wear %{ac_held}%; \
    /def -wgranuja granujalvl = /send get orb %{main_bag}=wear orb

;/def -wgranuja ac_pre_on = \
;    /send get %{hit_bag} %{main_bag}=get %{ac_wield} %{hit_bag}=get %{ac_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

;/def -wgranuja ac_pre_off = \
;    /send remove %{ac_wield}=remove %{ac_offhand}=get %{hit_bag} %{main_bag}=put %{ac_wield} %{hit_bag}=put %{ac_offhand} %{hit_bag}=put %{hit_bag} %{main_bag}

