;;; ----------------------------------------------------------------------------
;;; resistance.tf
;;; Script to handle racial resistances.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Resistance & Susceptibility Descriptors:
;;; insignificantly     partially       quite               outstandingly
;;; faintly             kind of         substantially       extraordinarily
;;; hardly              somewhat        very                completely
;;; barely              moderately      exceedingly
;;; scarcely            reasonably      exceptionally
;;; slightly            rather          extremely
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The following damage types are relatively common in our realm:
;;; air             chopping        fire            pure divine
;;; biological      cold            mental          slicing
;;; blasting        cursed          piercing        water
;;; blunt           earth           poison          whipping
;;; caustic         electric        pure arcane
;;; These damage types may occasionally be encountered, but they are more rare:
;;; leeching        pressure        stasis
;;; mind control    sonic

;;; These types are hardly (if ever) used.  At some point in the future some
;;; of them may be repurposed for some new type of damage.
;;; antimagic       natural         portal
;;; falling         polymorph       radiant
;;; ----------------------------------------------------------------------------

/def -p5 -ah -mregexp -t"^([a-zA-Z \-]+) are ([a-z]+) (resistant|susceptible) to ([a-z ]+)\." race_show_resistance
/def -p5 -ah -mregexp -t"^([a-zA-Z \-]+) have no resistances or susceptibilities\." race_show_no_resistance

;+--------------------------------+
;| Spell           | Damage Type  |
;+--------------------------------+
;| disintegrate    | pure arcane  |
;| fireball        | fire         |
;| maelstrom       | pressure     |
;| meteor swarm    | earth & fire |
;| acid rain       | caustic      |
;| firestorm       | fire         |
;| icestrike       | cold         |
;| magma blast     | fire & earth |
;| lightning bolt  | electric     |
;| chain lightning | electric     |
;| acid blast      | caustic      |
;+--------------------------------+
;| mindwipe        | mind control |
;| fracture        | mental       |
;;+-------------------------------+
/def setMySpell = \
    /set %{myname}MidSpell='%{*}'%;\
    /if /ismacro %{myname}SetMySpell%; /then \
        /def -n1 -mglob -ag -t"Alias removed." _alias_removed%;\
        /def -n1 -mglob -ag -t"Alias 1 created." _alias_1_created%;\
        /%{myname}SetMySpell %{*}%;\
    /endif
/def setMyAOESpell = \
    /set %{myname}AOESpell='%{*}'%;\
    /if /ismacro %{myname}SetMyAOESpell%; /then \
        /def -n1 -mglob -ag -t"Alias removed." _alias_removed%;\
        /def -n1 -mglob -ag -t"Alias 2 created." _alias_2_created%;\
        /%{myname}SetMyAOESpell %{*}%;/endif
/def setSpellResistance = \
    /if ({#} == 0) \
        /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
            /if ({mytier} =~ "lord") \
                /setMySpell maelstrom%;\
                /setMyAOESpell meteor swarm%;\
            /elseif ({mytier} =~ "hero") \
                /setMySpell disintegrate%;\
                /setMyAOESpell acid rain%;\
            /endif%;\
        /endif%;\
;    /elseif
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Animal|Elf|Mobile|Insectoid|Griffon|Harpy|Human|Giant|Centaur|True Fae|Minotaur|Troglodyte)\.' resistance_set_base = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /if ({mytier} =~ "lord") \
            /setMySpell maelstrom%;\
            /setMyAOESpell meteor swarm%;\
        /elseif ({mytier} =~ "hero") \
            /setMySpell disintegrate%;\
            /setMyAOESpell acid rain%;\
        /endif%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Demonseed)\.' resistance_set_caustic = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell acid blast%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Gargoyle|Troll)\.' resistance_set_radiant = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /if ({mytier} =~ "lord") /setMySpell maelstrom%;\
        /elseif ({mytier} =~ "hero") /setMySpell disintegrate%;\
        /endif%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Golem|Sprite|Elemental)\.' resistance_set_arcane = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell disintegrate%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Lizard Man|Pyro Imp|Dragon)\.' resistance_set_cold = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell icestrike%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Gith|High Elf)\.' resistance_set_mental = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell maelstrom%;\
    /elseif ({myclass} =~ "mnd") \
        /setMySpell fracture%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Placeholder)\.' resistance_set_mind_control = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell maelstrom%;\
    /elseif ({myclass} =~ "mnd") \
        /setMySpell mindwipe%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Ghost|Devil|Demon)\.' resistance_set_divine = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /if ({mytier} =~ "lord") /setMySpell maelstrom%;\
        /elseif ({mytier} =~ "hero") /setMySpell disintegrate%;\
        /endif%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Ent|Cloud Giant|Air Elemental|Blue Dragon)\.' resistance_set_fire = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell fireball%;\
        /setMyAOESpell meteor swarm%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Fire giant)\.' resistance_set_earth = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell magma blast%;\
        /setMyAOESpell meteor swarm%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Fire Elemental|Water Elemental|Merman)\.' resistance_set_electric = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell lightning bolt%;\
        /setMyAOESpell chain lightning%;\
    /endif

/def -mregexp -ah -Ph -F -t'is an? (Earth Elemental)\.' resistance_set_air = \
    /if ({myclass} =~ "mag" | {myclass} =~ "wzd") \
        /setMySpell acid blast%;\
        /setMyAOESpell acid rain%;\
    /endif
