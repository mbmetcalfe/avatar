;; maxine.gear.ava.tf
;;
/cleangear

/set main_bag "jumpsuit white loot"

/load -q char/lord.arc.ava.tf
/load -q char/lord.mana1.ava.tf
/set mana_bag="jumpsuit white managear!"
/set arc_held "brace thundercrack arrows"
;/set quiver_bag "floating icesphere quiver"
/eval /set quiver_bag=%{main_bag}
/set mana_wield="black bow scorn"
/set mana_offhand=""

/def -wmaxine arc_post_on = \
    wield %{hit_wield}%; \
    /set unbrandish=%{hit_held}%; \
    /def -wmaxine sle = /arc2mana%%;/send sleep%;\
    /def -wmaxine maxineunlvl = /send remove all.levelgear=put all.levelgear %main_bag=wear all.talisman%; \
    /def -wmaxine maxinelvl = /send remove all.talisman=get all.levelgear %main_bag=wear all.levelgear

/def -wmaxine mana_post_on = \
    /def -wmaxine maxinelvl = /send get all.levelgear %{main_bag}=rem all.talisman=rem %{mana_head}=wear all.levelgear%; \
    /def -wmaxine maxineunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear all.talisman

;/def -wmaxine mana_pre_off = /send rem girth=put girth %{main_bag}
/def -wmaxine hit_pre_on = /send get quiver %{main_bag}
/def -wmaxine hit_pre_off = /send remove quiver=put quiver %{main_bag}
/def -wmaxine mana_pre_on = /send get quiver %{main_bag}
/def -wmaxine mana_post_on = /send wear %{mana_wield}
/def -wmaxine mana_pre_off = /send remove quiver=put quiver %{main_bag}

