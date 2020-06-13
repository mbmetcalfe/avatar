;; waldorf.gear.ava.tf
/cleangear

/set main_bag "bodybag body bag loot"
;/set hit_bag "bullet skin bag"

/set hit_light "sceptre blazing fury"
/set hit_finger1 "bands diamond obsidian once-sundered ring"
/set hit_finger2 "ring higher power"
/set hit_neck1 "necklace severed fae ears"
/set hit_neck2 "necklace severed fae ears"
/set hit_body "blue-green demonscale wrap"
/set hit_head "crown pain wire shards glass"
/set hit_legs "living dark mystical daemonstone"
/set hit_feet "boots planewalking mithril"
/set hit_hands "gauntlet clenched fist"
/set hit_arms "wings superior elegance"
;/set hit_offhand="psi-blade energy pure pain"
;/set hit_offhand="ant wing chakram boss2"
;/set hit_offhand="sword githyanki gith silver lordgear normal"
/set hit_offhand="ant wing chakram normal"
;/set hit_offhand="ant wing chakram calpchak2b"
/set hit_about "robe magnificence"
/set hit_waist "belt souls strap"
/set hit_wrist1 "broken shackles tyranny"
/set hit_wrist2 "broken shackles tyranny"
/set hit_wield "sword githyanki gith silver lordgear normal"
;/set hit_wield "ant wing chakram calpchak32b"
/set hit_held="hand severed githyanki"

;;; ---------------------------------------------------------------------------
;;; Weapon fiddling
;;; ---------------------------------------------------------------------------
/def -i fixweaps = /send wield %{hit_wield}=wear %{hit_offhand}
/def -mglob -p0 -wwaldorf -t"You feel weaker." waldorf_giantstr_fade = \
    /if ({running} == 1) /send str%; /endif

/def -mregexp -au -p1 -wwaldorf -t"You send A SWORD to attack .*" waldorf_dancing_claws_out = /set weapon_inhand=0
/def -mglob -p0 -wwaldorf -t"A SWORD returns to your hand." waldorf_dancing_claws_back = \
    /set weapon_inhand=1%;\
    /setMySpell dancing weapon

/def -mglob -p0 -wwaldorf -t"You must be wielding two weapons to use this spell!" waldorf_weaponmissing = \
    /set weapon_inhand=0%;\
    /send wield %{hit_wield}=wear %{hit_offhand}%;\
    /setMySpell mindwipe

/def -mglob -p1 -wwaldorf -t"You wield A SWORD." waldorf_fixed_wield = \
    /set weapon_inhand=1%;\
    /setMySpell fandango
/def -mglob -p1 -wwaldorf -t"You put ANOTHER SWORD in your offhand." waldorf_fixed_offhand = \
    /set weapon_inhand=0%;\
    /send remove %{hit_wield}%;\
    /fixweaps%;\
    /setMySpell mindwipe

/def -mregexp -wwaldorf -ar -t"^A SWORD falls to the ground, lifeless." waldorf_dwweaponfall = \
    /send get %{hit_wield}=wield %{hit_wield}%;\
    /set weapon_inhand=0

/def -mregexp -wwaldorf -ar -t'^A SWORD clatters to the ground\!$' waldorf_fandango_wieldfall = \
    /send get %{hit_wield}=get %{hit_offhand}%;\
    /set weapon_inhand=0%;\
    /fixweaps

/def -ar -mregexp -wwaldorf -t"^A SWORD floats into the room and into your hands\!$" waldorf_wieldfetch = wield %{hit_wield}
/def -ar -mregexp -wwaldorf -t"^ANOTHER SWORD floats into the room and into your hands\!$" waldorf_offhandfetch = offhand %{hit_offhand}

/def -mglob -wwaldorf -t"* gives you A SWORD." waldorf_wieldgiven = /send wield %{hit_wield}
;/def -ah -mglob -wwaldorf -t"You get A SWORD." waldorf_wieldgotten = /send save
/def -ah -mglob -wwaldorf -t"You get A SWORD from corpse of *." waldorf_wieldfrom_cor = /send wield %{hit_wield}

/def -ah -mglob -wwaldorf -t"*A silver sword hums at a low pitch on the floor*" waldorf_weapons_onground = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps
;/def -ah -mglob -wwaldorf -t"*A crystal clear blade of pure energy hovers here*" waldorf_weapons_onground2 = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps

/def getweapons = /addq get %{hit_wield} corpse#get %{hit_offhand} corpse
/def -mglob -wwaldorf -t"A SWORD is captured! It floats into * hands!" waldorf_weapons_caught2 = \
    /getweapons%;\
    /setMySpell mindwipe
