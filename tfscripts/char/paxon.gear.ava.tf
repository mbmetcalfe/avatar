;; paxon.gear.ava.tf
/cleangear

/set main_bag "floating icesphere loot"

/def -wpaxon mana_post_on = \
    /set unbrandish=%{mana_held}%; \
    /set wield=%{mana_wield}%;\
    /set offhand=%{mana_offhand}%;\
    /def -wpaxon paxonlvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%; \
    /def -wpaxon paxonunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}
;/def -wpaxon man = /send rem girth=put girth %{main_bag}

/def -wpaxon ac_post_on =  \
    /set unbrandish=%{ac_held}%; \
    /set wield=%{ac_wield}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /def -wpaxon sle = /ac2mana%%;/send sleep%;\
    /def -wpaxon paxonunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear all.bone%; \
    /def -wpaxon paxonlvl = /send get all.levelgear %{main_bag}=rem bone=wear all.levelgear
