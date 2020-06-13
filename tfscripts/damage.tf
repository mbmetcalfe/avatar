;;; ----------------------------------------------------------------------------
;;; damage.tf
;;; Triggers to count damage and echo it in a nice format.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; Variables used to hold class-types for making some triggers/macroes simpler
;;; ----------------------------------------------------------------------------
/set arcType=arc asn dru fus sld
/set cleType=cle dru pal prs viz
/set magType=mag stm sor wzd
/set monType=mon shf
/set psiType=mnd psi
/set rogType=asn bld bci rog shf bld

/def qdmg = \
    /if ({#} > 2) /let qdmgchan=%-2%;/else /let qdmgchan=/echo%;/endif%;\
    /if ({#} = 0) \
        /echo -pw @{Cred}Syntax: @{Cwhite}/qdmg # verb [channel] @{n}%;\
    /else \
        /sys php qdmg.php %{1} %{2}%;\
        /repeat -0:0:01 1 /quote %{qdmgchan} '"qdmg.dat"%;\
    /endif

/def acast = \
    /toggle autocast%;\
    /echoflag %autocast Auto-Cast%;\
    /statusflag %autocast aCast
/alias acast \
    /if ({#} == 1) /send surge %{1}%;/aq surge off%;/endif%;\
    /set autocast=0%;\
    /acast%;\
    /aq /acast

/def amid = \
    /toggle automidround%;\
    /if ({automidround} == 1) \
        /if ({#} == 1) /send surge %{1}%;/endif%;\
        /eval /set _myname=${world_name}%;\
        /if /ismacro %{_myname}midround%; /then \
            /echo -pw %%% @{Cgreen}/%{_myname}midround is defined@{n}%;\
         /else \
            /echo -pw %%% @{Cred}/%{_myname}midround macro is not defined.@{n}%;\
            /set automidround=0%;\
        /endif%;\
    /else /send surge off%;\
    /endif%;\
    /echoflag %automidround Midround-Action%;\
    /statusflag %automidround aMid%;\

/alias amid \
    /set automidround=0%;\
    /amid %{*}%;\
    /aq /amid
/def -i performmidround = \
    /eval /set _myname=${world_name}%;\
    /if ({automidround} == 1) \
        /if /ismacro %{_myname}midround%; /then \
            /%{_myname}midround%;\
         /else \
            /echo -pw %%% @{Cred}No midround macro defined.@{n}%;\
        /endif%;\
    /endif%;\
    /unset _myname

;;; ----------------------------------------------------------------------------
;;; Yet another mid-round/autocast implementation.
;;; This version is more multiplay-friendly.
;;; Based on Meep/Ebin's design.
;;; /auto and /autoall are generic macros
;;;     so I can do /def cast =/auto cast %1
;;;     /cast just calls /auto to set a variable based on /auto's positional params
;;;     /auto looks at world, %1 (char), and %2 (the %1 passed to /cast)
;;;     tried to get rid of a bunch of duplication
;;; ----------------------------------------------------------------------------
/def auto = \
    /let tr %{1}%;\
    /let this=$[world_info()]%;\
    /let auto_tr_v %{this}_auto_%{tr}%;\
    /let auto_tr $[expr({auto_tr_v})]%;\
    /if ({2} =~ "") /let auto_tr $[!auto_tr] %;\
    /elseif ({2} =~ "on") /let auto_tr 1 %;\
    /elseif ({2} =~ "off")  /let auto_tr 0%;\
    /else /echo -p @{hcRed}Valid arguments are: on, off and <none>@{n}%;\
    /endif%;\
    /set %{this}_auto_%{tr} %{auto_tr}%;\
    /if (auto_tr) /echo -p @{Cred}[CHAR INFO]:@{hCred} Auto-@{Cmagenta}%{tr}@{hCred} (%{this}) is @{Cgreen}ENABLED@{n}.%;\
    /else /echo -p @{Cred}[CHAR INFO]:@{hCred} Auto-@{Cmagenta}%{tr}@{hCred} (%{this}) is @{Cred}DISABLED@{n}.%;\
    /endif

/def autoall = \
    /let tr %{1}%;\
    /let auto_tr_v auto_%{tr}%;\
    /let auto_tr $[expr({auto_tr_v})]%;\
    /if ({2} =~ "") /let auto_tr $[!auto_tr] %;\
    /elseif ({2} =~ "on") /let auto_tr 1 %;\
    /elseif ({2} =~ "off")  /let auto_tr 0%;\
    /else /echo -p @{hcRed}Valid arguments are: on, off and <none>@{n}%;\
    /endif%;\
    /set auto_%{tr} %{auto_tr}%;\
    /if (auto_tr) /echo -p %%% Auto-%{tr} is @{Cgreen}enabled@{n}.%;\
    /else /echo -p %%% Auto-%{tr} is @{Cred}disabled@{n}.%;\
    /endif
    
;;; do stuff like this (/castdmg is ref'd in the prompt stuff):
;;; On a per alt, /cast and /stab to turn autocast/autostab on and off. 
;;; Also control /aoe across all alts to turn it on/off depending if I'm in a gear room or not.
/def cast=/auto cast %1
/def aoe=/autoall aoe %1

/def setCastTarget = \
    /set castTargetMob=%{*}%;\
    /echo -pw @{Cwhite}Cast target set to: @{hCred}%{castTargetMob}@{n}%;\
    /aq /unset castTargetMob

/def castdmg = \
    /let this $[world_info()]%;\
    /if /test auto_aoe == 1%;/then /send -w%{this} 2 %{castTargetMob}%;/else /send -w%{this} 1 %{castTargetMob}%;/endif
/def target = \
    /set castTargetMob=%1%;/echo -p @{Cred}[TARGET INFO]: Target is now: @{Cwhite}%{castTargetMob}@{n}%;\
    /def -n1 -mregexp -t"\w+ is not here\!" target_mob_not_here = /set castTargetMob

;;; ----------------------------------------------------------------------------

;/def aoe = \
;    /let _surge=0%;\
;    /if ({#} == 1 & {1} > 1) /let _surge=%{1}%;/endif%;\
;    /eval /set _myname=${world_name}%;\
;    /if /ismacro %{_myname}aoespell%; /then \
;        /if ({_surge} > 0) /send surge %{_surge}%;/endif%;\
;        /%{_myname}aoespell%;\
;        /if ({_surge} > 0) /send surge off%;/endif%;\
;    /else \
;        /echo -pw %%% @{Cred}No AoE macro (%{_myname}aoespell) defined.@{n}%;\
;    /endif%;\
;    /unset _myname

/def -mregexp -ag -F -p99 -t"Your attacks haven't hurt (.*)." nilcount = \
    /set nil=$[++nil]%;\
    /set hits=$[++hits]%;\
    /echodam @{Cyellow}Your attacks haven't hurt %{P1}.@{n}%;\
    /if ({autovs}=1 & regmatch({myclass},{rogType})) \
        /if ({mytier} =~ "lord") vital %avs_spot%;\
        /else vital%;\
        /endif%;\
    /endif%;\
    /if ({autohold}=1 & regmatch({myclass},{arcType})) held%; /endif%;\
    /if ({autoaim}=1 & {myclass} =~ "asn") aim %avs_spot%;/endif%;\
    /performmidround

;; Melee damage
/def -mregexp -ag -F -t"^You fire at (.*) and miss!" arrownilcount = \
    /set hits=$[hits+1]%;\
    /set adodged=$[adodged+1]%;\
    /echodam @{Cred}You fire at %P1 and miss!@{n}

/def -mglob -ag -F -t"You fumble as you fire!" arrowfumblecount = \
    /set fumbles=$[fumbles+1]%;\
    /echodam @{Cred}You fumble as you fire!@{n}

/def -mregexp -ag -p5 -t"^Your (attack|attacks) (strikes|strike) (.*) ([0-9]+) (time|times), with (.+) ([a-zA-Z]+)([\!\.]+)" dmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P6" %; \
    /if ({P6} =~ "terminal") \
        /set dval=blank%;\
        /set hits=$[hits+1]%;\
        /set totdmg=$[totdmg + trunc(totdmg/hits)]%;\
    /else \
        /quote -S /set dval=!php readfile.php "%P6" %; \
    /endif%;\
    /if ({dval} !~ 'blank') \
        /set hits=$[hits+1]%;\
        /set totdmg=$[totdmg + {dval}] %;  \
    /endif%; \
    /echodam @{Cyellow}Your %P1 %P2 %P3 %P4 %P5, with @{hCcyan}%{P6}@{nCyellow} %{P7}%{P8}@{n}

/def -mregexp -ag -F -p6 -t"^Your (attack|attacks) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)[\!\.]+" dmg_auto_midround = \
    /if ({autovs}=1 & regmatch({myclass},{rogType})) \
        /if ({mytier} =~ "lord") vital %avs_spot%;\
        /else vital%;\
        /endif%;\
    /endif%;\
    /if ({autohold}=1 & regmatch({myclass},{arcType})) held%; /endif%;\
    /if ({autoaim}=1 & {myclass} =~ "asn") aim %avs_spot%;/endif%;\
    /performmidround

/def -mregexp -ag -p7 -t"^Your (attack|attacks) (strikes|strike) (.*) 9 (time|times), with (.*) ([a-zA-Z]*)([\!\.]+)" dmg_auto_fandango = \
    /if ({P5} =~ "terminal") \
        /set dval=blank%;\
        /set hits=$[hits+1]%;\
        /set totdmg=$[totdmg + trunc(totdmg/hits)]%;\
    /else \
        /quote -S /set dval=!php readfile.php "%P5" %; \
    /endif%;\
    /if ({dval} !~ 'blank') \
        /set hits=$[hits+1]%;\
        /set totdmg=$[totdmg + {dval}] %;  \
    /endif%; \
    /echodam @{Cyellow}Your %P1 %P2 %P3 9 %P4, with @{hCcyan}%{P5}@{nCyellow} %{P6}%{P7}@{n}

;;; ----------------------------------------------------------------------------
;;; Melee-type trigger.  Picks up kicks, counters, bashes, etc.
;;; It has a lower priority than the spell damage trigger so that the spells
;;; will be processed over this trigger.  The pattern is similar.
;;; ----------------------------------------------------------------------------
/def -p0 -ag -mregexp -t'You (.*) with (.*) ([a-zA-Z]+)(\.|\!)' otherdmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P2" %; \
    /if ({P2} =~ "terminal") \
        /set dval=blank%;\
        /set hits=$[hits+1]%;\
        /set totdmg=$[totdmg + trunc(totdmg/hits)]%;\
    /else \
        /quote -S /set dval=!php readfile.php "%P2" %; \
    /endif%;\
    /if ({dval} !~ 'blank') \
        /set totdmg=$[totdmg + {dval}] %;  \
       /set hits=$[hits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You %P1 with @{hCcyan}%P2 @{nCyellow}%{P3}%{P4}@{n}

;;; ----------------------------------------------------------------------------
;;; Spell damage
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -p6 -t"You (fireball|psionic blast|ultrablast|maelstrom|cataclysm|disintegrate|ice lance|sandstorm|mindwipe|torment|brimstone|vampire touch|leech|fracture|rupture|white fire|white light) (.*) with (.*) ([a-zA-Z]*)" spelldmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P3" %; \
    /if ({P3} =~ "terminal") \
        /set dval=blank%;\
        /set chits=$[chits+1]%;\
        /set cdmg=$[cdmg + trunc(cdmg/chits)]%;\
    /else \
        /quote -S /set dval=!php readfile.php "%P3" %; \
    /endif%;\
    /if ({dval} !~ 'blank') \
        /set cdmg=$[cdmg + {dval}] %;\
        /set chits=$[chits+1]%;\
    /endif%; \
    /if ({autocast} = 1) \
        c "%{P1}"%; \
    /endif%; \
    /echodam @{Cyellow}You %{P1}@{Cyellow} %{P2} with @{hCcyan}%{P3} @{nCyellow}%{P4}!@{n}

;;; ----------------------------------------------------------------------------
;;; Stormlord auto-cast triggers
;;; ----------------------------------------------------------------------------
;;; Hero spells
/def -mglob -p7 -t"The clouds calm, and the lightning subsides." autocastsustain_cloudburst = \
    /if ({autocast} = 1) c cloudburst%;/endif

/def -mglob -p7 -t"The hail stops, and all is eerily silent." autocastsustain_hail_storm = \
    /if ({autocast} = 1) c 'hail storm'%;/endif

/def -mglob -p7 -F -t"The spring shower begins to break." autocastsustain_spring_rain = \
    /if ({autocast} = 1) c 'spring rain'%;/endif

;;; Lord spells
/def -mglob -p7 -t"The rumbling stops, and the thunder clouds depart." autocastsustain_thunderhead = \
    /if ({autocast} = 1) c thunderhead%;/endif

/def -mglob -p7 -t"Your blizzard dwindles to a flurry, then stops." autocastsustain_blizzard = \
    /if ({autocast} = 1) c blizzard%;/endif

;;; ----------------------------------------------------------------------------
;;; Sustained/DoT spell damage
;;; pillar of flame -> burn
;;; cloudburst -> lightning
;;; hail storm -> hail
;;; thunderhead -> shock
;;; freeze -> blizzard
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -p6 -t"You (lightning|hail|burn|shock|freeze) (.*) with (.*) ([a-zA-Z]*)" susspelldmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P3" %; \
    /if ({P3} =~ "terminal") \
        /set dval=blank%;\
        /set chits=$[csushits+1]%;\
        /set csusdmg=$[csusdmg + trunc(csusdmg/csushits)]%;\
    /else \
        /quote -S /set dval=!php readfile.php "%P3" %; \
    /endif%;\
    /if ({dval} !~ 'blank') \
       /set csusdmg=$[csusdmg + {dval}] %;\
       /set csushits=$[csushits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You %P1 %P2 with @{hCcyan}%{P3} @{nCyellow}%{P4}!@{n}

;;; ----------------------------------------------------------------------------
;;; Psi-fandango damage
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -t"You slice (.*) with (.*) ([a-zA-Z]*)" psidmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P2" %; \
    /quote -S /set dval=!php readfile.php "%P2" %; \
    /if ({dval} !~ 'blank') \
        /set fanddmg=$[fanddmg + {dval}] %;\
        /set fandhits=$[fandhits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You slice %P1 with @{hCcyan}%P2 @{nCyellow}%P3@{n}

;;; ----------------------------------------------------------------------------
;;; Rog-stab damage
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -t"You pierce (.*) with (.*) ([a-zA-Z]*)" rogdmgcnt = \
;    /quote -S /set dval=!php readfile-mysql.php "%P2" %;\
    /quote -S /set dval=!php readfile.php "%P2" %;\
    /if ({dval} !~ 'blank') \
        /set rdmg=$[rdmg + {val}] %;\
        /set rhits=$[rhits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You pierce %P1 with @{hCcyan}%P2 @{nCyellow}%P3@{n}

;; TO ADD
/def psidmg = \
    /let damchan=/echo%; \
    /if ({#} > 0) /let damchan=%*%; /endif %; \
    /let avgdmg=$[trunc(fanddmg/fandhits)]%; \
    /let avfand=$[avgdmg*9]%;\
    /quote -S /set avfandvar=!php getdmg.php %{avfand}%;\
    /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
    /let rfanddmg=$[trunc(fanddmg/1000)]%;\
    /let fandammsg=Fandango Dam: |g|%{rfanddmg}k |w|damage in |g|%{fandhits} |w|hits. Avg |g|%{avgdmg}|w|/hit which is |c|%{avgdmgvar}|w| and ~ |c|%{avfandvar}|w|/cast|w|%;\
    /if ({damchan} =~ "/echo") \
        /let fandammsg=$(/chgcolor %fandammsg)%; \
        /echo -pw %%% %fandammsg %; \
    /else \
        /eval %damchan %fandammsg %; \
    /endif

/def rogdmg = \
    /let avgdmg=$[rdmg/rhits]%;\
    /quote -S /let avgdmgvar=!php getdmg.php %{avgdmg} %;\
    gt my assassinate did |r|%{rdmg} |w|damage in |c|%{rhits} |w|hits...and averaged |r|%{avgdmg}|w| per stab which is |c|%{avgdmgvar}|w|

/def -mregexp -ag -t"You attempt a critical golden strike!" hitgolden = \
    /set golden=$[++golden]%;\
    /echodam @{Cyellow}You attempt golden strike @{hCyellow}#%{golden}@{nCyellow}!@{n}
/def -mregexp -p0 -t"^Turning aside (.*)'s attack, you counter\!" ctr_counter = \
    /set ctrs=$[++ctrs]%;\
    /echodam @{Cwhite}Turning aside %{P1}'s attack, you counter!@{n}
/def -mregexp -ag -t'^Critical hit!' hitcritical = \
    /set critical=$[++critical] %; \
    /echodam @{Cwhite}Critical hit @{hCwhite}(#%{critical})@{nCwhite}!@{n}
/def -mglob -p9 -F -t"*You creep up behind *" sneak_attack = /set sneakattack=$[++sneakattack]
/def -Fp9 -mglob -t'...but it turns to face you just as you attack!' sneak_attack_fail = /set sneakattackfail=$[++sneakattackfail]
/def -Fp9 -mglob -t'...but it sees you coming a mile away!' sneak_attack_fail = /set sneakattackfail=$[++sneakattackfail]

/def -mregexp -ag -t"You aim for a (VERY )?weak spot\!" vital_shot = \
    /set vital=$[++vital]%;\
    /echodam @{Cred}You aim for a weak spot! (#@{hCred}%{vital}@{nCred})

;;; ----------------------------------------------------------------------------
;;; macro to echo the damage from triggers above.  Toggle the battle spam
;;; with /bspam (self) /obspam (others)
;;; ----------------------------------------------------------------------------
/set bspam=1
/def bspam = /toggle bspam%;/echoflag %bspam @{Cyellow}Battle Spam@{n}
/def -i echodam = \
    /if ({bspam} = 1) /echo -pw %{*}@{n}%; /endif

/set obspam=1
/def obspam = /toggle obspam%;/echoflag %obspam @{Cyellow}Others Battle Spam@{n}
/def -i echootherdam = \
    /if ({obspam} = 1) /echo -pw %{*}@{n}%; /endif

;;; ----------------------------------------------------------------------------
;;; Report damage done.
;;;     /damrep [channel]
;;; give an optional channel to display it there, otherwise, it displays in an
;;; /echo.
;;; e.g. /damrep     - echoes damage
;;;     /damrep gt     - will echo damage in a gtell
;;;     /damrep tell joe - will give joe a tell with damage stats
;;; ----------------------------------------------------------------------------
/def damrep = \
    /let damchan=/echo%; \
    /if ({#} > 0) /let damchan=%*%; /endif %; \
    /let avgdmg=$[trunc(totdmg/hits)]%;\
    /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
    /let rtotdmg=$[trunc({totdmg}/1000)]%;\
    /let dammsg=Melee Dam: |g|%{rtotdmg}k |w|damage in |g|%{hits} |w|rounds. Avg |g|%{avgdmg}|w|/round which is |c|%{avgdmgvar}|w|.%; \
    /if ({chits} > 0) \
        /let avgdmg=$[trunc(cdmg/chits)]%;\
        /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
        /let rcdmg=$[trunc({cdmg}/1000)]%;\
        /let cdammsg=Spell Dam: |g|%{rcdmg}k |w|damage in |g|%{chits} |w|hits. Avg |g|%{avgdmg}|w|/cast which is |c|%{avgdmgvar}|w|.%; \
    /endif%; \
    /if ({csushits} > 0) \
        /let avgsusdmg=$[trunc(csusdmg/csushits)]%;\
        /quote -S /set avgdmgvar=!php getdmg.php %{avgsusdmg} %;\
        /let rcsusdmg=$[trunc({csusdmg}/1000)]%;\
        /let csusdammsg=Sustained Spell Dam: |g|%{rcsusdmg}k |w|damage in |g|%{csushits} |w|hits. Avg |g|%{avgsusdmg}|w|/hit which is |c|%{avgdmgvar}|w|.%; \
    /endif%; \
    /if (regmatch({myclass},{arcType})) \
        /let extradammsg=%{critical} |bw|critical hits|w|. |w|%{fumbles} |r|fumbles|w|.%; \
    /endif %; \
    /if (regmatch({myclass},{monType})) \
        /let extradammsg=|w|%{ctrs} |bg|counters|w|. %{golden} |by|golden strikes|w|. %{sucresc}|c|:|w|%{resc} |c|rescues|w|. %; \
    /endif %; \
    /if (regmatch({myclass},{rogType})) \
        /let extradammsg=%{extradammsg} |w|%{vital} |r|vital shots|w|. %{sneakattack}:%{sneakattackfail} |b|sneak attacks|w|.%; \
        /let extradammsg=%{extradammsg} |w|%{adodged} |r|misses|w|.%;\
    /endif %; \
    /if ({damchan} =~ "/echo") \
        /let dammsg=$(/chgcolor %dammsg)%; \
        /echo -pw %%% %dammsg %; \
        /if ({chits} > 0) \
            /let cdammsg=$(/chgcolor %cdammsg) %; \
            /echo -pw %%% %cdammsg %; \
        /endif%; \
        /if ({csushits} > 0) \
            /let csusdammsg=$(/chgcolor %csusdammsg) %; \
            /echo -pw %%% %csusdammsg %; \
        /endif%; \
		/if (regmatch({myclass},{arcType}) | \
             regmatch({myclass},{rogType}) | \
             regmatch({myclass},{monType})) \
            /let extradammsg=$(/chgcolor %extradammsg) %; \
            /echo -pw %%% %extradammsg %; \
        /endif %; \
    /else \
        /eval %damchan %dammsg %; \
        /if ({chits} > 0) \
            /eval %damchan %cdammsg%; \
        /endif%; \
        /if ({csushits} > 0) \
            /eval %damchan %csusdammsg%; \
        /endif%; \
		/if (regmatch({myclass},{arcType}) | \
		     regmatch({myclass},{rogType}) | \
			 regmatch({myclass},{monType})) \
            /eval %damchan %extradammsg %; \
        /endif %; \
    /endif

/def damreset = \
    /set nil=0 %;/set ctrs=0%;/set terminal=0 %; /set critical=0%; \
    /set vital=0%;/set sneakattack=0%;/set sneakattackfail=0%;/set adodged=0%;/set fumbles=0%;\
    /unset avgdmg%;/unset avgdmgvar%;/unset totdmg%;/unset hits%;/unset chits%; \
    /unset cdmg%;/unset fanddmg%;/unset fandhits%;/unset csusdmg%;/unset csushits%;\
    /echo -p % @{hCred}Damage stats reset.@{n}

;;; ----------------------------------------------------------------------------
;;; gag's for running
;;; ----------------------------------------------------------------------------
/def -mglob -ag -p0 -F -t"* returns to *'s hand\." gag_weaponreturn
/def -mglob -ag -p0 -F -t"*'s weapons dance through the air\!" gag_psifandango
/def -mglob -ag -p0 -F -t"* wields *\." gag_otherwield
/def -mglob -ag -p0 -F -t"* puts * in their offhand\." gag_otheroffhand

;;; ----------------------------------------------------------------------------
;;; gag's for casting
;;; ----------------------------------------------------------------------------
/def -mregexp -ag -t'([a-zA-Z]+) concentrates deeply\.\.\.' battle_gag_psi_cast = \
    /echootherdam @{Cwhite}%{P1} concentrates deeply...@{n}
/def -mregexp -ag -t'([a-zA-Z]+) utters the words, \'(.*)\'\.' battle_gag_cast = \
    /echootherdam @{Cwhite}%{P1} utters the words, '@{Ccyan}%{P2}@{Cwhite}'@{n}
/def -mregexp -ag -t'([a-zA-Z]+) preaches the Holy Word, \'(.*)\!\'' battle_gag_preach = \
    /echootherdam @{Cwhite}%{P1} preaches the Holy Word, '@{Ccyan}%{P2}@{Cwhite}'@{n}

;;; ----------------------------------------------------------------------------
;;; gag's for counters/vitals
;;; ----------------------------------------------------------------------------
/def -ag -p5 -mregexp -t"^Turning aside (.*)'s attack, ([a-zA-Z]+) counters!" obspam_counter = \
    /let ctrtemp=<%P2< %; \
    /let t1=%P1%;/let t2=%P2%;\
    /if ( regmatch(tolower({ctrtemp}),{groupies}) ) \
        /echootherdam @{Cwhite}Turning aside %t1's attack, %t2 counters!%;\
    /endif
/def -ag -p5 -mregexp -t"([a-zA-Z]+) aims for (.*)!" obspam_vital = \
    /let vitaltemp=<%P1< %; \
    /let t1=%P1%;/let t2=%P2%;\
    /if ( regmatch(tolower({vitaltemp}),{groupies}) ) \
        /echootherdam @{Cred}%t1 aims for %t2!%;\
    /endif

;;; ----------------------------------------------------------------------------
;;; Damage triggers for others 
;;; If attacker is in group it is filtered (attacks are highlighted)
;;; If attacked is in group it is filtered (shows up blue)
;;; ----------------------------------------------------------------------------
;;/def -mregexp -ag -p6 -t"([a-zA-Z]+)'s attacks haven't hurt (.*)\." groupie_dmgnil = \
/def -mregexp -ag -p7 -t"([a-zA-Z0-9,\.\-\ \']+)'s attacks haven't hurt (.*)(\.|\!)" groupie_dmgnil = \
    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
    /let tAttacker=<%t1<%;\
    /let tAttacked=<%t2<%;\
    /if ({t2} =~ "you") \
        /echo -pw @{Cred}%{t1}'s @{nCyellow}attacks haven't hurt %{t2}%{t3}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
        /echo -pw @{Cyellow}%{t1}'s @{nCyellow}attacks haven't hurt @{hCblue}%{t2}@{nCyellow}%{t3}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
        /let stabber_list=$[tolower($(/listvar -vmglob charlst_assassin))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_black_circle_initiate))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_rogue))]%;\
        /let stabber_list=$[replace(",", "", {stabber_list})]%;\
        /if ($(/findmatch $[tolower({t1})] %{stabber_list}) = 1) \
            /echo -pw @{Cyellow}%t1's haven't hurt %{t2}%{t3}@{n}%;\
        /else \
            /echootherdam @{Cyellow}%t1's haven't hurt %{t2}%{t3}@{n}%;\
        /endif%;\
    /else \
        /echo -pw @{Cyellow}%{t1}'s attacks haven't hurt %{t2}%{P3}@{n}%;\
    /endif

/def -mregexp -ag -p7 -t"^The lightning stuns ([\d]+)!" groupie_stunend = \
    /let t1=$[strip_attr({P1})]%;\
    /let _Attacked=<%{t1}<%;\
    /if ( regmatch(tolower({tAttacked}),{groupies}) ) \
        /echootherdam @{Cyellow}The lightning stuns @{hCblue}%{t1}@{nCyellow}@{n}%;\
    /else \
        /echo -pw The lightning stuns %{t1}!%;\
    /endif
    
;;/def -mregexp -ag -p6 -t"([a-zA-Z]+)'s (.*) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt = \
;/def -mregexp -ag -p6 -t"([a-zA-Z0-9,\.\-\ \']+)'s (.*) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt = \
;    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
;    /let t4=%P4%;/let t5=%P5%;/let t6=%P6%;\
;    /let t7=%P7%;/let t8=%P8%;/let t9=%P9%;\
;    /let tAttacker=<%t1<%;\
;    /let tAttacked=<%t4<%;\
;    /echo DEBUG 1: p4: %P4%;\
;    /if ({P4} =~ "you") \
;        /echo -pw 1 @{Cred}%t1's %t2 %t3 %t4 %t5 %t6, with @{Cyellow}%{t7}@{nCred} %{t8}%{t9}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
;        /echo -pw 1 @{Cyellow}%t1's %t2 %t3 @{hCblue}%t4 @{nCyellow}%t5 %t6, with @{Cmagenta}%{t7}@{Cyellow} %{t8}%{t9}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
;        /echootherdam 1 @{Cyellow}%t1's %t2 %t3 %t4 %t5 %t6, with @{Cmagenta}%{t7}@{Cyellow} %{t8}%{t9}@{n}%;\
;    /else \
;        /echo -pw 1 @{Cyellow}%t1's %t2 %t3 %t4 %t5 %t6, with @{Cmagenta}%{t7}@{Cyellow} %{t8}%{t9}@{n}%;\
;    /endif

;;/def -mregexp -ag -p6 -t"([a-zA-Z]+)'s (.*) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt2 = \
;/def -mregexp -p6 -t"([a-zA-Z0-9,\.\-\ \']+)'s (.*) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt2 = \
;    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
;    /let t4=%P4%;/let t5=%P5%;/let t6=%P6%;\
;    /let tAttacker=<%t1<%;\
;    /let tAttacked=<%t3<%;\
;    /echo DEBUG 2: p1: %P1, p2: %P2, p3: %P3%;\
;    /if ({P3} =~ "you") \
;        /echo -pw 2.1 @{Cred}%t1's %t2 strikes %t3 with @{Cyellow}%{t4}@{Cred} %{t5}%{t6}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
;        /echo -pw 2.2 @{Cyellow}%t1's %t2 strikes @{hCblue}%t3@{nCyellow} with @{Cmagenta}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
;        /echootherdam 2 @{Cyellow}%t1's %t2 strikes %t3 with @{Cmagenta}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
;    /else \
;        /echo -pw 2.3 @{Cyellow}%t1's %t2 strikes %t3 with @{Cmagenta}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
;    /endif

;;/def -mregexp -ag -p6 -t"([a-zA-Z]+) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt3 = \
;/def -mregexp -p6 -t"([a-zA-Z0-9,\.\-\ \']+) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" groupie_dmgcnt3 = \
;    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
;    /let t4=%P4%;/let t5=%P5%;\
;    /let tAttacker=<%t1<%;\
;    /let tAttacked=<%t2<%;\
;    /echo DEBUG 3: p1: %P1, p2: %P2%;\
;    /if ({P2} =~ "you") \
;        /echo -pw 3.1 @{Cred}%t1's strikes %t2 with @{Cyellow}%{t3}@{Cred} %{t4}%{t5}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
;        /echo -pw 3.2 @{Cyellow}%t1's strikes @{hCblue}%t2 @{nCyellow}with @{Cmagenta}%{t3}@{Cyellow} %{t4}%{t5}@{n}%;\
;    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
;        /echootherdam 3 @{Cyellow}%t1's strikes %t2 with @{Cmagenta}%{t3}@{Cyellow} %{t4}%{t5}@{n}%;\
;    /else \
;        /echo -pw 3.3 @{Cyellow}%t1's strikes %t2 with @{Cmagenta}%{t3}@{Cyellow} %{t4}%{t5}@{n}%;\
;    /endif
;;;--------------------------------
;;The Giants' Nightmare's attack strikes you 1 time, with **DEVASTATING** intensity!
;;The Giants' Nightmare's attacks strike you 2 times, with MAIMING intensity!
/def -mregexp -ag -p7 -t"([a-zA-Z0-9,\.\-\ \']*)'s (pierce strikes|attack strikes|attacks strike) (.*) ([0-9]+) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" other_damage = \
    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
    /let t4=%P4%;/let t5=%P5%;/let t6=%P6%;\
    /let t7=%P7%;/let t8=%P8%;\
    /let tAttacker=<%t1<%;\
    /let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's %t2 %t3 %t4 %t5, with @{Cyellow}%{t6}@{Cred} %{t7}%{t8}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
        /echo -pw @{Cyellow}%t1's %t2 @{hCblue}%t3 @{nCyellow}%t4 %t5, with @{Cgreen}%{t6}@{Cyellow} %{t7}%{t8}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
        /let stabber_list=$[tolower($(/listvar -vmglob charlst_assassin))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_black_circle_initiate))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_rogue))]%;\
        /let stabber_list=$[replace(",", "", {stabber_list})]%;\
        /if ($(/findmatch $[tolower({t1})] %{stabber_list}) = 1) \
            /echo -pw @{Cyellow}%t1's %t2 %t3 %t4 %t5, with @{Cgreen}%{t6}@{Cyellow} %{t7}%{t8}@{n}%;\
        /else \
            /echootherdam @{Cyellow}%t1's %t2 %t3 %t4 %t5, with @{Cgreen}%{t6}@{Cyellow} %{t7}%{t8}@{n}%;\
        /endif%;\
    /else \
        /echo -pw @{Cyellow}%t1's %t2 %t3 %t4 %t5, with @{Cgreen}%{t6}@{Cyellow} %{t7}%{t8}@{n}%;\
    /endif

/def -mregexp -ag -p6 -t"([a-zA-Z0-9,\.\-\ \']*)'s ([a-zA-Z\ ]+) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" other_spell_damage = \
    /let t1=%P1%;/let t2=%P2%;/let t3=%P3%;\
    /let t4=%P4%;/let t5=%P5%;/let t6=%P6%;\
    /let tAttacker=<%t1<%;/let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's @{Cwhite}%t2 @{Cred}strikes %t3 with @{Cyellow}%{t4}@{Cred} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{groupies}) ) \
        /echo -pw @{Cyellow}%t1's %t2 strikes @{Cblue}%t3 @{Cyellow}with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{groupies}) ) \
        /let stabber_list=$[tolower($(/listvar -vmglob charlst_assassin))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_black_circle_initiate))]%;\
        /let stabber_list=%{stabber_list} $[tolower($(/listvar -vmglob charlst_rogue))]%;\
        /let stabber_list=$[replace(",", "", {stabber_list})]%;\
        /if ($(/findmatch $[tolower({t1})] %{stabber_list}) = 1) \
            /echo -pw @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
        /else \
            /echootherdam @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
        /endif%;\
    /else \
        /echo -pw @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /endif
