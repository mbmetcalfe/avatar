;;; ---------------------------------------------------------------------------
;;; asha.ava.tf
;;; ---------------------------------------------------------------------------
;;; March 16, 2004:	Failed morph @ level 657, lost 111
;;; March 29, 2004:	Morphed @ level 756: 9166 hp   11677 mana   6916 mv
;;;			Gen #2: 10294 hp 15818 mana  7988 mv
;;; May 19, 2004:	Remorted to Tuatar @ level 25 lord
;;; May 20, 2004:	Heroed: 647 hp 540 ma 491 mv
;;; June 3, 2004:	101 hero:1068 hp 782 m 650 mv
;;; June 15, 2004: 	Failed morph @ level 681, lost 162
;;; July 28, 2004:	Failed morph @ level 718, lost 48 levels.
;;; Aug 3, 2004:	Morphed @ level 760.
;;; Aug 4, 2004:	Keeper gen: 10254 hp 17560 mana

; read in Asha's gear file
/load -q char/asha.gear.ava.tf
/require psionic.tf

;;; ---------------------------------------------------------------------------
;;; Misc other triggers/aliases
;;; ---------------------------------------------------------------------------
;/send gtell #tr {^ Pain clatters to the ground!} {get all.pain;give pain asha;give pain asha} {psi}
;/send gtell #tr {^ Pain clatters to the ground!} {get |by|pain|n|;get |bg|boss2|n|;give |by|pain|n| asha;give |bg|boss2|n| asha} {psi}

/alias danc c 'dancing weapon'
/alias bio /send look %1 description

/test ashaMidSpell := (ashaMidSpell | "fandango")
/def ashamidround = c %{ashaMidSpell}%;/fixweaps

/alias fan c fandango
/def -washa tfan = \
    /if ({autocast}=1) \
        c fandango%;inv%;\
        /repeat -0:00:35 1 /tfan%; \
    /endif
/def -i fixweaps = /send rem %{hit_wield}=wield %{hit_wield}=wear %{hit_offhand}
/alias fix /fixweaps

/def -mglob -p0 -washa -t"You feel weaker." giantstr_fade = /if ({running} == 1) /send str%; /endif

/def -mregexp -p0 -washa -t"^([a-zA-Z]+) cries on your shoulder\." emotivedrain_other = c 'emotive drain' %{P1}

/def -mregexp -auCwhite -p9 -t'Your illusory shield dissipates.' asha_illusoryshielddrop = \
    /set illusoryshieldleft=-1%;\
    /if ({refreshmisc} == 1) /q 5 c 'illusory shield'%;/endif    

;/def -mregexp -ag -F -p6 -t"^Your (attack|attacks) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)[\!\.]+" dmg_auto_midround
/def -mregexp -p7 -t"^Your (attack|attacks) (strikes|strike) (.*) 9 (time|times), with (.*) ([a-zA-Z]*)[\!\.]+" asha_dmg_auto_midround

;;; ---------------------------------------------------------------------------
;;; Weapon fiddling
;;; ---------------------------------------------------------------------------
/def -i fixweaps = /send wield %{hit_wield}=wear %{hit_offhand}
/def -mglob -p0 -washa -t"You feel weaker." giantstr_fade = \
    /if ({running} == 1) /send str%; /endif

/def -mglob -p0 -washa -t"You must be wielding two weapons to use this spell!" weaponmissing = \
    /send wield %{hit_wield}=wear %{hit_offhand}%;\
    /set ashaMidSpell=mindwipe

/def -mglob -p1 -washa -t"You wield  Pain." asha_fixed_wield = /set ashaMidSpell=fandango
/def -mglob -p1 -washa -t"You put  Fear in your offhand." asha_fixed_offhand = /set ashaMidSpell=fandango
/def -mglob -p1 -washa -t"You put a bladed disc emitting a haze in your offhand." = /set ashaMidSpell=fandango

/def -mglob -washa -ar -t' Pain falls to the ground, lifeless\.' dwweaponfall = /send get %{hit_wield}=wield %{hit_wield}

/def -mglob -washa -ar -t' Pain clatters to the ground\!' weaponfall = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps
;/def -mglob -washa -t' Pain returns to your hand\.' weaponcatch = /if ({autocast} == 1) c fandango%; /endif

/def -ar -mglob -washa -t' Pain floats into the room and into your hands\!' wieldfetch = wield %{hit_wield}
/def -ar -mglob -washa -t' Fear floats into the room and into your hands\!' offhand2fetch = wear %{hit_offhand}

;/def -ar -mglob -washa -t'You tire as your chain prevents  Pain from falling to the ground.' wieldkineticchain = /if ({autocast} == 1) c fandango%; /endif

/def -mglob -washa -t'* gives you  Pain.' wieldgiven = /send save=wield %{hit_wield}
/def -ah -mglob -washa -t'You get  Pain.' wieldgotten = /send save

/def -mglob -washa -t'* gives you  Fear.' offhand2given = /send save=wear %{hit_offhand}
/def -ah -mglob -washa -t'You get  Fear.' offhand2gotten = /send save

/def -ah -mglob -washa -t"*A silver sword hums at a low pitch on the floor*" weapons_onground = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps
/def -ah -mglob -washa -t"*A crystal clear blade of pure energy hovers here*" weapons_onground2 = /send get %{hit_wield}=get %{hit_offhand}%;/fixweaps

/def getweapons = /addq get %{hit_wield} corpse#get %{hit_offhand} corpse
/def -mglob -washa -t" Fear is captured! It floats into * hands!" weapons_caught2 = \
    /getweapons%;\
    /set ashaMidSpell=mindwipe

;;; ---------------------------------------------------------------------------
/def -washa ashalvl = /send get orb %{main_bag}=wear orb
/def -washa ashaunlvl = /send wear %{hit_held}=put orb %{main_bag}

/def -washa detects = c infravision%;c 'detect hidden'

/def -mglob -ahCwhite -t"Your weapons dance through the air!" highlight_fandango

/def fandcost = \
    /mcost Fandango 114%;\
    /mcost Fandango-q@{hCmagenta}1 228%;\
    /mcost Fandango-q@{hCmagenta}2 342%;\
    /mcost Fandango-q@{hCmagenta}3 456%;\
    /mcost Fandango-q@{hCmagenta}4 570%;\
    /mcost Fandango-q@{hCmagenta}5 684%;\
    /mcost Fandango-q@{hCmagenta}6 798%;\
    /mcost Fandango-q@{hCmagenta}7 912%;\
    /mcost Fandango-q@{hCmagenta}8 1026

;; Cast minds eye before wearing all
/def -washa -p0 -mglob -ag -h'SEND wear all' hook_asha_wear_all = /send quicken 5=c 'minds eye'=quicken off=wear all

;;; scripts to bipass migraine effects if stuff is stacked
/def -washa -p1900 -mregexp -ahCwhite -t"^You feel a slight headache growing stronger\.\.\." migraine_disconnect_asha = \
    /if ({running}=1) /rc%;quicken off%;surge off%;c 'psychic drain'%;/endif

;; Load in the variables saved from previous state.
/loadCharacterState asha
