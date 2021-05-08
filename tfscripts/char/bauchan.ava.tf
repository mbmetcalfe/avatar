;;; April 20, 2010 - Morphed at level 678: 28542 hp 550 ma 20060 mv
;;; June 3, 2010 - Remorted sprite.
;;; June 7, 2010 - Heroed: 436 hp 122 ma 483 mv

;;; read in Bauchan's gear file
/load -q char/bauchan.gear.ava.tf


/set main_bag "jumpsuit white loot"
;/eval /set quiver_bag=%{main_bag}
/set quiver_bag="bodybag body bag quiver"

;;; Throw weapons: 
;;;    airblade (veil);
;;;    shuriken (shogun);
;;;    charkam (Dream Steppes);
;;;    short spear (Isle of NaamBres'Shho)
;;;    ax called tornado - hits multiple mobs (Divide)
;;;    spear called rip (Apocalypse)

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie

/def bauchanfren = /q 5 c frenzy

;/set lsarrow=poison
/set lsarrow=piercing
/alias ls =\
    get "%lsarrow arrow" %{quiver_bag}%;\
    wield "bow aranor"%;wear "%lsarrow arrow"%;\
    /send longshot %1 %2%;\
    wield %{wield}%;wear "%{unbrandish}"%;put "%lsarrow arrow" %{quiver_bag}

/alias ahold /autohold%;/addq /autohold
/alias thr \
    /set thrownWeapon=%1%;\
    throw %1

;;; ac-hit and hit-ac gear swap aliases
/def -wbauchan toac = \
    get %{hit_bag} %{main_bag}%;\
    get all %{hit_bag}%;put willow %{hit_bag}%;\
    rem all.tooth%;put all.tooth %{hit_bag}%;wear all.bone%;\
    wear teardrop%;put headdress %{hit_bag}%;\
    wear "stone flame"%;put torch %{hit_bag}%;\
    put scabbard %{hit_bag}%;\
    wear carb%;put crecy %{hit_bag}%;\
    wear shroud%;put tiger %{hit_bag}%;\
    wear templar%;put drow %{hit_bag}%;\
    put %{hit_bag} %{main_bag}
/def -wbauchan tohit = \
    get %{hit_bag} %{main_bag}%;\
    get all %{hit_bag}%;put willow %{hit_bag}%;\
    rem all.bone%;put all.bone %{hit_bag}%;wear all.tooth%;\
    wear headdress%;put teardrop %{hit_bag}%;\
    wear torch%;put "stone flame" %{hit_bag}%;\
    put collar %{hit_bag}%;\
    put scabbard %{hit_bag}%;\
    wear crecy%;put carb %{hit_bag}%;\
    wear tiger%;put shroud %{hit_bag}%;\
    wear drow%;put templar %{hit_bag}%;\
    put %{hit_bag} %{main_bag}

/def -wbauchan b = /send rem %{hit_wield}=wield dagger=wear shield=bash %*=rem shield=wield %{hit_wield}=stand

/def bauchanmidround = scatter 7

/set thrownWeapon=short
/def -p1 -ah -wbauchan -mglob -t"* falls to the ground!" throw_fall = /send get %thrownWeapon
/def -p1 -ah -wbauchan -mglob -t"You throw a short spear at * and miss\!" throw_miss = /send get %thrownWeapon
/def -p1 -ah -wbauchan -mglob -t"* catches it\!" throw_mob_catch = /addq get %thrownWeapon corpse
/alias thr \
    /set thrownWeapon=%1%;\
    throw %1

/def -wbauchan -mglob -p2 -t"You get a pair of spiked elbow braces from corpse of *." bauchan_drop_elbow_braces = /send drop elbow

/def -mglob -au -p1 -wbauchan -t"The Office of the High Clerist" autols_crullius = \
    /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -au -p1 -wbauchan -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
    /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -au -p1 -wbauchan -t"The family graveyard" autols_eater = \
    /if ({leader} !~ "Self") ls north eater%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState bauchan
