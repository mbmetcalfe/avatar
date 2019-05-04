;;; read in Mahal's gear file
;; gear for UD: orb, templar rings, bone necks, carb, teardrop, crimson skirt, 
;; fates, killing gloves, alienskin, shroud, collar, ice bracers, and hand crossbow
;; no frenzy for UD
;; June 9, 2007 - Killed UD, full hit, no frenzy, level 620: 3217/6260 left over.
;; August 9, 2007 - Morphed from level Hero 772, had 777 mana, seemed like a sign.

/load -q char/lord.arc.ava.tf
/load -q char/lord.mana1.ava.tf
/set arc_wield "troublemaker sling"
/set arc_held "brace ice sling stones"
/set quiver_bag "floating icesphere quiver"

/set main_bag "jumpsuit white loot"

/set lsarrow=poison
/set my_spell=Barkskin

/require archer.tf
/alias bowie get bowie %lootContainer%;wield bowie
/alias unbowie wield %{wield}%;put bowie %lootContainer
/alias skco bowie%;skin corpse%;unbowie

/def mahalmidround = scatter 7

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
    get deep %lootContainer%;\
    wield deep%;wear "%lsarrow arrow"%;\
    /send longshot %1 %2%;\
    wield %{wield}%;wear "%{unbrandish}"%;put "%lsarrow arrow" quiver%;\
    put deep %lootContainer

;; Load in the variables saved from previous state.
/loadCharacterState mahal
