;;; ----------------------------------------------------------------------------
;;; File: psionic.tf
;;; This script contains macroes/triggers of use to psionic-type characters.
;;; ----------------------------------------------------------------------------
/set my_spell='steel skeleton'

/alias cell \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c 'cell adjustment' %1%;\
    /if ({_quicken} = 1) quicken off%;/endif
/alias dread \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c dread %1%;\
    /if ({_quicken} = 1) quicken off%;/endif
/alias scram \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c scramble %1%;\
    /if ({_quicken} = 1) quicken off%;/endif
/alias dec \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c deception %1%;\
    /if ({_quicken} = 1) quicken off%;/endif
/alias ov \
    /if ({#} > 1 | {1} > 0) \
        /let _quicken=1%;\
        quicken %1%;\
        /shift%;\
    /endif%;\
    c overconfidence %1%;\
    /if ({_quicken} = 1) quicken off%;/endif
/alias pb \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c 'psionic blast' %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias rup \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c rupture %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias ult \
    /if ({#} > 1 | {1} > 0) surge %1%;/endif%;\
    c ultrablast %2%;\
    /if ({#} > 1 | {1} > 0) surge off%;/endif
/alias am \
    /if ({#} = 0) c 'anger management' %targetMob%; \
    /else c 'anger management' %*%; \
    /endif
/alias df \
    /if ({#} = 1) surge %1%; /endif %;\
    c 'death field'%;\
    /if ({#} = 1) surge off%; /endif

/def grsteel = /mapcar /steel %grouplist

;;; ----------------------------------------------------------------------------
;;; scripts to bipass migraine effects if stuff is stacked
;/def -p900 -mregexp -ag -t"^You feel a slight headache growing stronger..." migraine_disconnect = \
;    /echo -p @{hCwhite}You feel a slight headache growing stronger...@{n}%;\
;    /if ({running}=1) /rc%;quicken off%;surge off%;c 'psychic drain'%;/endif

;;; hack attempt to highlight caster mobs
/def -ah -mregexp -t", (a sorceror|a kinetic caster|a psion|a mage|a very learned caster|a cleric|a lich|will make an omelette of your brain|a great healer)," caster_mobs
;;; hack attempt to highligh stompers
/def -ahCmagenta -mregexp -t", heavy-footed, " stomper_mob

;;; ----------------------------------------------------------------------------
;;; Kinetic Enhancers
;;  intelligent weapon, conscious weapon and felling weapon up
;; Can have one of fell/stun/disabling
;;; ----------------------------------------------------------------------------
;You imbue your weapons with the ability to distract.
/def -mregexp -aCyellow -t"^You imbue your weapons with the ability to (stun|disable|distract)\." kinetic_enhancement_up = \
    /if ({P1} =~ "stun") /set stunningweaponleft=999%;\
    /elseif ({P1} =~ "disable") /set disablingweaponleft=999%;\
    /elseif ({P1} =~ "distract") /set distractingweaponleft=999%;\
    /endif

/def -mregexp -aCyellow -t"^Your weapons lose their consciousness\.$" conscious_enhancement_down =\
    /if ({refreshmisc} == 1) /aq c 'conscious weapon'%;/endif

/def -mregexp -aCyellow -t"^Your weapons will no longer intelligently attack your opponents\." intelligent_weap_down = \
    /refreshSpell 'intelligent weapon'

/def -mregexp -aCyellow -t"^Your weapons lose the ability to (fell|stun|disable)\." kinetic_enhancement_down = \
    /if ({P1} =~ "stun") \
        /set stunningweaponleft=-1%;\
        /if ({refreshmisc} == 1) \
            /aq c 'stunning weapon'%;\
        /endif%;\
    /elseif ({P1} =~ "disable") \
        /set disablingweaponleft=-1%;\
        /if ({refreshmisc} == 1) \
            /aq c 'disabling weapon'%;\
        /endif%;\
    /elseif ({P1} =~ "distract") \
        /set distractingweaponleft=-1%;\
        /if ({refreshmisc} == 1) \
            /aq c 'distracting weapon'%;\
        /endif%;\
    /elseif ({P1} =~ "fell")\
        /if ({refreshmisc} == 1) \
            /aq c 'felling weapon'%;\
        /endif%;\
    /endif
/def -mregexp -aCyellow -t"^Your weapons already possess the ability to (stun|disable)\." kinetic_enhancement_up2 = \
    /if ({P1} =~ "stun") /set stunningweaponleft=999%;\
    /elseif ({P1} =~ "disable") /set disablingweaponleft=999%;\
    /elseif ({P1} =~ "distract") /set distractingweaponleft=999%;\
    /endif

/def -mregexp -aCyellow -t"^You can no longer support your kinetic chain and it snaps." kinetic_chain_down = /set kineticchainleft=-1
/def -mregexp -t"^One of your Exhaust timers has elapsed\. \(kinetic chain\)" kinetic_chain_exhaust_down = \
    /if ({refreshmisc} == 1) \
        /aq c 'kinetic chain'%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Attempt to bi-pass gravitas weapon catching
;;; Good idea to magic light a few times before run starts.
;;; ----------------------------------------------------------------------------
/set psi_dart_item=mindtrick
/def -p1 -F -au -mregexp -t'surrounds (him|her|it)self with a telekinetic sink\.' gravitas_trap = \
    /if ({myclass} =~ "psi") /send get all.%{psi_dart_item} %{main_bag}=cast dart=put all.%{psi_dart_item} %{main_bag}%;/endif

/def overconf = /auto overconf %1
/def -mregexp -au -p20 -F -t"^You start fighting (a Black Circle assassin|a High Drow child|Veyah's most trusted guard)\." psi_auto_overconf = /if /test $(/getvar auto_overconf) == 1%;/then c overconf%;/endif

/def psyphon = /auto psyphon %1
/def -mregexp -au -p21 -F -t"^You start fighting (Veyah's sorcerer)\." psi_auto_psyphon = /if /test $(/getvar auto_psyphon) == 1%;/then c psyphon%;/endif

;;; ----------------------------------------------------------------------------
;;; Attempt to cast shatterspell on mobs
;;; ----------------------------------------------------------------------------
/def shatter = /auto shatter %1
/def -au -mregexp -t"^Torrents of jagged ice cascade down upon .* enemies\!$" auto_shatterspell = /if /test $(/getvar auto_bash) == 1%;/then c shatterspell%;/endif

