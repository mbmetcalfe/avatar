;;; read in Mahal's gear file
;; gear for UD: orb, templar rings, bone necks, carb, teardrop, crimson skirt, 
;; fates, killing gloves, alienskin, shroud, collar, ice bracers, and hand crossbow
;; no frenzy for UD
;; June 9, 2007 - Killed UD, full hit, no frenzy, level 620: 3217/6260 left over.
;; August 9, 2007 - Morphed from level Hero 772, had 777 mana, seemed like a sign.

/load -q char/hero.arc.ava.tf
/set ac_wrist1="nagaskin"
/set ac_wrist2="nagaskin"
/set ac_arms="golden bolts"
;/load -q char/lord.mana1.ava.tf
;/set arc_wield "troublemaker sling"
;/set arc_held "brace ice sling stones"
;/set quiver_bag "floating icesphere quiver"
/set quiver_bag="bodybag body bag quiver"

/set main_bag "jumpsuit white loot"

/def toac = \
    get all.nagaskin %{main_bag}%;get %{ac_arms} %{main_bag}%;\
    rem all.power%;wear all.nagaskin%;wear %{ac_arms}%;put all.power %{main_bag}%;put %{arc_arms} %{main_bag}
/def tohit = \
    get all.power %{main_bag}%;get %{arc_arms} %{main_bag}%;\
    rem all.nagaskin%;wear all.power%;wear %{arc_arms}%;put all.nagaskin %{main_bag}%;put %{ac_arms} %{main_bag}

/set lsarrow=piercing

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie

;/def -wmahal mahalfren = /send get crab %{main_bag}=eat crab

/set thrownWeapon=short
/def -p1 -ah -wmahal -mglob -t"* falls to the ground!" throw_fall = \
    get %thrownWeapon
/def -p1 -ah -wmahal -mglob -t"You throw * at * and miss\!" throw_miss = \
    get %thrownWeapon
/def -p1 -ah -wmahal -mglob -t"* catches it\!" throw_mob_catch = \
    /addq get %thrownWeapon corpse
/alias thr \
    /set thrownWeapon=%1%;\
    throw %1

/alias ls =\
    get "%lsarrow arrow" quiver%;\
    get aranor %lootContainer%;\
    wield aranor%;wear "%lsarrow arrow"%;\
    /send longshot %1 %2%;\
    wield %{wield}%;wear "%{unbrandish}"%;put "%lsarrow arrow" quiver%;\
    put aranor %lootContainer

/def -wmahal -mglob -p2 -t"You get a pair of spiked elbow braces from corpse of *." mahal_drop_elbow_braces = /send drop elbow

/def -mglob -au -p1 -wmahal -t"The Office of the High Clerist" autols_crullius = \
  /if ({leader} !~ "Self") ls west crullius%;/endif
/def -mglob -au -p1 -wmahal -t"The Temple's Second Floor" autols_arcanthrus_grantus = \
  /if ({leader} !~ "Self") ls south arc%;ls south grant%;/endif
/def -mglob -au -p1 -wmahal -t"The family graveyard" autols_eater = \
  /if ({leader} !~ "Self") ls north eater%;/endif

;; Racial refresh stuff

/def -mglob -au -p1 -wmahal -t"You feel drained as your heat fades." mahal_innervate_ready = /send racial innervate
/def fireaura = /auto fireaura %1
/def -mglob -au -p1 -wmahal -t"You feel less fatigued. (fireaura)" mahal_fireaura_refresh = /if /test $(/getvar auto_fireaura) == 1%;/then /send racial fireaura%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState mahal
