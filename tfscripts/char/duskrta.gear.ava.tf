;; duskrta.gear.ava.tf
/cleangear

/load -q char/lord.ac5.ava.tf
/set main_bag "floating icesphere loot"

;/set ac_waist="girth quest"
;/set mana_waist="girth quest"

/def -wduskrta -mglob -p9 -t"You wield the Eye of the Oni." duskrta_change_wield_oni = \
    /set ac_wield "huge red eye oni bloodshot"%;\
    /set wield "huge red eye oni bloodshot"

/def -wduskrta -mglob -p9 -t"You wield an icy gray staff." duskrta_change_wield_graystaff = \
    /set ac_wield "gray staff"%;\
    /set wield "gray staff"
