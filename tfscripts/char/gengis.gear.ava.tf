;; gengis.gear.ava.tf
/cleangear
/set main_bag "floating icesphere loot"
/set lootContainer=loot


/set mana_bag="urn black managearz"
;/load -q char/lord.ac2.ava.tf
/load -q char/lord.ac4.ava.tf

/set ac_wield "scepter silver githyanki"
/set wield "scepter silver githyanki"

/def -wgengis mana_post_on = \
    /set unbrandish=%{mana_held}%; \
        /def -wgengis gengislvl = /send get all.levelgear %{main_bag}=wear hat=wear crucifix%;\
        /def -wpaxon gengisunlvl = /send rem all.levelgear=put all.levelgear %{main_bag}=wear %{mana_head}=wear %{mana_neck1}

/def -wgengis ac_post_on = \
    /set unbrandish=%{ac_held}%;\
    /def -wgengis sle = /ac2mana%%;/send sleep%;\
    /def -wgengis gengisunlvl = /send wear %{ac_about}=put levelgear %{main_bag}%;\
    /def -wgengis gengislvl = /send get all.levelgear %{main_bag}=wear levelgear

;/def -wgengis ac_pre_off = /send rem cloak=put cloak %{main_bag}

;/def -wgengis mana_pre_off = /send rem cloak=put cloak %{main_bag}

/def -wgengis -mglob -p9 -t"You wield A Divine Sceptre." gengis_change_wield_sceptre = \
    /set ac_wield "scepter silver githyanki"%;\
    /set wield "scepter silver githyanki"

/def -wgengis -mglob -p9 -t"You wield an icy gray staff." gengis_change_wield_graystaff = \
    /set ac_wield "gray staff"%;\
    /set wield "gray staff"

