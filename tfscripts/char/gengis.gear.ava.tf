;; gengis.gear.ava.tf
/cleangear
/set main_bag "floating icesphere loot"
/set lootContainer=loot


/set mana_bag="urn black managearz"
;/load -q char/lord.ac2.ava.tf
/load -q char/lord.ac4.ava.tf

/set ac_wield "scepter silver githyanki"
/set wield "scepter silver githyanki"

/def -wgengis -mglob -p9 -t"You wield A Divine Sceptre." gengis_change_wield_sceptre = \
    /set ac_wield "scepter silver githyanki"%;\
    /set wield "scepter silver githyanki"

/def -wgengis -mglob -p9 -t"You wield an icy gray staff." gengis_change_wield_graystaff = \
    /set ac_wield "gray staff"%;\
    /set wield "gray staff"

