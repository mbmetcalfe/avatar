;; nit.gear.ava.tf
/cleangear

/set main_bag "white jumpsuit loot"
/load -q char/hero.hit1.ava.tf
/load -q char/hero.ac1.ava.tf
/load -q char/hero.mana2.ava.tf

/def -wnit ac_pre_off = /send remove all.fingerbone=put all.fingerbone %{main_bag}
/def -wnit mana_pre_off = /ac_pre_off
/def -wnit hit_pre_off = /ac_pre_off

/def -wnit ac_post_on =  \
    /set unbrandish=%{ac_held}%;\
    /set offhand=%{ac_offhand}%;\
    /send wear %{ac_offhand}%;\
    /send get fingerbone %{main_bag}=wear fingerbone%;\
    /def -wnit sle = /ac2mana%%;/send sleep%;\
    /def -wnit wa = /send wake%%;/mana2ac

/def -weti hit_post_on = \
    /set unbrandish=%{hit_held}%;\
    /set offhand=%{hit_offhand}%;\
    /send wield %{hit_wield}=wear %{hit_offhand}%;\
    /def -wnit sle = /mana2hit%%;/send sleep%;\
    /def -wnit wa = /send stand%%;/mana2hit%;\
    /send get fingerbone %{main_bag}=wear fingerbone

;;; ---------------------------------------------------------------------------
;;; Weapon fiddling
;;; ---------------------------------------------------------------------------
/def -i fixweaps = /send wield %{hit_wield}=wear %{hit_offhand}
/def -mglob -p0 -wnit -t"You feel weaker." nit_giantstr_fade = \
    /if ({running} == 1) /send str%; /endif

/def -mregexp -au -p1 -wnit -t"You send A narrow blade .*" nit_dancing_narrow_out = /set weapon_inhand=0
/def -mglob -p0 -wnit -t"A narrow blade returns to your hand." nit_dancing_narrow_back = \
    /set weapon_in_hand=1%;\
    /setMySpell dancing weapon

/def -mregexp -au -p1 -wnit -t"You send A SWORD to attack .*" nit_dancing_claws_out = /set weapon_inhand=0
/def -mglob -p0 -wnit -t"A SWORD returns to your hand." nit_dancing_claws_back = \
    /set weapon_inhand=1%;\
    /setMySpell dancing weapon

/def -mglob -p0 -wnit -t"You must be wielding two weapons to use this spell!" nit_weaponmissing = \
    /set weapon_inhand=0%;\
    /send wield %{hit_wield}=wear %{hit_offhand}%;\
    /setMySpell mindwipe

/def -mglob -p1 -wnit -t"You wield A SWORD." nit_fixed_wield = \
    /set weapon_inhand=1%;\
    /setMySpell fandango
/def -mglob -p1 -wnit -t"You put ANOTHER SWORD in your offhand." nit_fixed_offhand = \
    /set weapon_inhand=0%;\
    /send remove %{hit_wield}%;\
    /fixweaps%;\
    /setMySpell mindwipe

/def -mregexp -wnit -ar -t"A narrow blade falls to the ground, lifeless." nit_dwweapon2fall = \
    /send get blade=wield blade%;\
    /set weapon_inhand=0

/def -mregexp -wnit -ar -t"^A SWORD falls to the ground, lifeless." nit_dwweaponfall = \
    /send get %{hit_wield}=wield %{hit_wield}%;\
    /set weapon_inhand=0

/def -mregexp -wnit -ar -t'^A SWORD clatters to the ground\!$' nit_fandango_wieldfall = \
    /send get %{hit_wield}=get %{hit_offhand}%;\
    /set weapon_inhand=0%;\
    /fixweaps

/def -ar -mregexp -wnit -t"^A SWORD floats into the room and into your hands\!$" nit_wieldfetch = wield %{hit_wield}
/def -ar -mregexp -wnit -t"^ANOTHER SWORD floats into the room and into your hands\!$" nit_offhandfetch = offhand %{hit_offhand}

/def -mglob -wnit -t"* gives you A SWORD." nit_wieldgiven = /send wield %{hit_wield}
;/def -ah -mglob -wnit -t"You get A SWORD." nit_wieldgotten = /send save
/def -ah -mglob -wnit -t"You get A SWORD from corpse of *." nit_wieldfrom_cor = /send wield %{hit_wield}

/def -ah -mglob -wnit -t"*A silver sword hums at a low pitch on the floor*" nit_weapons_onground = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps
;/def -ah -mglob -wnit -t"*A crystal clear blade of pure energy hovers here*" nit_weapons_onground2 = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps

/def getweapons = /addq get %{hit_wield} corpse#get %{hit_offhand} corpse
/def -mglob -wnit -t"A SWORD is captured! It floats into * hands!" nit_weapons_caught2 = \
    /getweapons%;\
    /setMySpell mindwipe
