;;; maggot.gear.ava.tf
/cleangear

/load -q char/hero.arc.ava.tf
/set arc_wield "crossbow recurve"
/set arc_held "brace piercing bolts"
;/load -q char/lord.arc.ava.tf
;/set arc_wield "lightning crossbow"
;/set arc_held "brace mithril bolts"
;/set arc_wield="long bow deep shadow"
;/set arc_held "brace lightning arrows"

/def -wmaggot arc_pre_on = /send get quiver %{main_bag}
/def -wmaggot arc_post_on = /set unbrandish=%{arc_held}
/def -wmaggot arc_pre_off = /send put quiver %{main_bag}
/def -wmaggot mana_pre_on = /send get quiver %{main_bag}
/def -wmaggot mana_post_on = /set unbrandish=%{mana_held}
/def -wmaggot mana_pre_off = /send put quiver %{main_bag}

;;; ac-hit and hit-ac gear swap aliases
/def -wmaggot toac = \
    get %{arc_bag} %{main_bag}%;\
    get all %{arc_bag}%;put willow %{arc_bag}%;\
    rem all.tooth%;put all.tooth %{arc_bag}%;wear all.bone%;\
    wear teardrop%;put %{arc_head} %{arc_bag}%;\
    wear "stone flame"%;put %{arc_light} %{arc_bag}%;\
    put %{arc_waist} %{arc_bag}%;\
    wear carb%;put %{arc_body} %{arc_bag}%;\
    wear shroud%;put tiger %{arc_bag}%;\
    wear templar%;put drow %{arc_bag}%;\
    put %{arc_bag} %{main_bag}
/def -wmaggot tohit = \
    get %{arc_bag} %{main_bag}%;\
    get all %{arc_bag}%;put willow %{arc_bag}%;\
    rem all.bone%;put all.bone %{arc_bag}%;wear all.tooth%;\
    wear headdress%;put teardrop %{arc_bag}%;\
    wear torch%;put "stone flame" %{arc_bag}%;\
    put collar %{arc_bag}%;\
    put scabbard %{arc_bag}%;\
    wear crecy%;put carb %{arc_bag}%;\
    wear tiger%;put shroud %{arc_bag}%;\
    wear drow%;put templar %{arc_bag}%;\
    put %{arc_bag} %{main_bag}

