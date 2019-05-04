;;; Triggers to count damage and echo it in a nice format.
/def acast = /toggle autocast%;/echoflag %autocast Auto-Cast

/def -mregexp -ag -t"Your attacks haven't hurt (.*)." nilcount = \
    /set nil=$[++nil]%;\
    /echodam @{Cyellow}Your attacks haven't hurt %{P1}.@{n}

;; Melee damage
/def -mregexp -ag -t"Your (attack|attacks) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)!" dmgcnt = \
    /quote -S /set dval=!php readfile-mysql.php "%P6" %; \
    /if ({dval} !~ 'blank') \
        /set totdmg=$[totdmg + {dval}] %;  \
        /set hits=$[hits+1]%;\
    /endif%; \
    /if ({autohold}=1 & ({myclass} =~ "arc" | {myclass} =~ "asn" | {myclass} =~ "fus")) held%; /endif%; \
    /if ({autovs}=1 & ({myclass} =~ "asn" | {myclass} =~ "bci" | {myclass} =~ "rog" | {myclass} =~ "shf"))\
        /if ({mytier} =~ "lord") vital %avs_spot%;\
        /else vital%;\
        /endif%;\
    /endif%; \
    /echodam @{Cyellow}Your %P1 %P2 %P3 %P4 %P5, with @{hCcyan}%{P6}@{nCyellow} %{P7}!@{n}

;; Melee-type trigger.  Picks up kicks, counters, bashes, etc.
;; It has a lower priority than the spell damage trigger so that the spells
;; will be processed over this trigger.  The pattern is similar.
/def -p0 -ag -mregexp -t'You (.*) with (.*) ([a-zA-Z]+)(\.|\!)' otherdmgcnt = \
    /quote -S /set dval=!php readfile-mysql.php "%P2" %; \
    /if ({dval} !~ 'blank') \
        /set totdmg=$[totdmg + {dval}] %;  \
        /set hits=$[hits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You %P1 with @{hCcyan}%P2 @{nCyellow}%{P3}%{P4}@{n}

;; Spell damage
/def -mregexp -ag -p6 -t"You (psionic blast|ultrablast|maelstrom|cataclysm|disintegrate|ice lance|sandstorm|mindwipe|fracture) (.*) with (.*) ([a-zA-Z]*)" spelldmgcnt = \
    /quote -S /set dval=!php readfile-mysql.php "%P3" %; \
    /if ({dval} !~ 'blank') \
        /set cdmg=$[cdmg + {dval}] %;\
        /set chits=$[chits+1]%;\
    /endif%; \
    /if ({autocast} = 1) \
            c %P1%; \
;        /if ($(/findmatch maelstrom %P1) = 1) \
;            c maelstrom%; \
;        /endif%; \
;        /if ($(/findmatch mindwipe %P1) = 1) \
;            c mindwipe%; \
;        /endif%; \
    /endif%; \
    /echodam @{Cyellow}You %P1 %P2 with @{hCcyan}%{P3} @{nCyellow}%{P4}!@{n}

;; Psi-fandango damage
/def -mregexp -ag -t"You slice (.*) with (.*) ([a-zA-Z]*)" psidmgcnt = \
    /quote -S /set dval=!php readfile-mysql.php "%P2" %; \
    /if ({dval} !~ 'blank') \
        /set fanddmg=$[fanddmg + {dval}] %;\
        /set fandhits=$[fandhits+1]%;\
    /endif%; \
    /echodam @{Cyellow}You slice %P1 with @{hCcyan}%P2 @{nCyellow}%P3@{n}

;; Rog-stab damage
/def -mregexp -t"You pierce (.*) with (.*) ([a-zA-Z]*)" rogdmgcnt = \
    /quote -S /set dval=!php readfile-mysql.php "%P2" %;\
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
    /set golden=$[++golden]%; \
    /echodam @{Cyellow}You attempt golden strike @{hCyellow}#%{golden}@{nCyellow}!@{n}

/def -mregexp -ag -t'^Critical hit!' hitcritical = \
    /set critical=$[++critical]%;\
    /echodam @{Cwhite}Critical hit @{hCwhite}(#%{critical})@{nCwhite}!@{n}

/def -mregexp -ag -p0 -t"^Turning aside (.*)'s attack, you counter\!" ctr_counter = \
    /set ctrs=$[++ctrs]%;\
    /echodam @{Cwhite}Turning aside %{P1}'s attack, you counter!@{n}

/def -mglob -t"*You creep up behind *" sneak_attack = /set sneakattack=$[++sneakattack]
/def -mglob -t"*You aim for a weak spot\!" vital_shot = /set vital=$[++vital]

;;; macro to echo the damage from triggers above.  Toggle the battle spam
;;; with /bspam
/set bspam=1
/def bspam = /toggle bspam%;/echoflag %bspam @{Cyellow}Battle Spam@{n}
/def -i echodam = \
    /if ({bspam} = 1) /echo -pw %{*}@{n}%; /endif
;;; macro to echo the damage from triggers below.  Toggle the battle spam
;;; with /obspam
/set obspam=1
/def obspam = /toggle obspam%;/echoflag %obspam @{Cyellow}Others Battle Spam@{n}
/def -i echootherdam = \
    /if ({obspam} = 1) /echo -pw %{*}@{n}%; /endif

;;; Report damage done.
;;;     /damrep [channel]
;;; give an optional channel to display it there, otherwise, it displays in an
;;; /echo.
;;; e.g. /damrep     - echoes damage
;;;     /damrep gt     - will echo damage in a gtell
;;;     /damrep tell joe - will give joe a tell with damage stats
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
    /if ({myclass} =~ "arc" | {myclass} =~ "fus" | {myclass} =~ "asn" | {myclass} =~ "dru") \
        /let extradammsg=%{critical} |bw|critical hits|w|.%; \
    /endif %; \
    /if ({myclass} =~ "mon" | {myclass} =~ "shf") \
        /let extradammsg=|w|%{ctrs} |bg|counters|w|. %{golden} |by|golden strikes|w|. %{sucresc}|c|:|w|%{resc} |c|rescues|w|. %; \
    /endif %; \
    /if ({myclass} =~ "rog" | {myclass} =~ "asn" | {myclass} =~ "shf" | {myclass} =~ "bci") \
        /let extradammsg=%{extradammsg} |w|%{vital} |r|vital shots|w|. %{sneakattack} |b|sneak attacks|w|.%; \
        /let extradammsg=%{extradammsg} |w|%{adodged} |r|misses|w|.%;\
    /endif %; \
    /if ({damchan} =~ "/echo") \
        /let dammsg=$(/chgcolor %dammsg)%; \
        /echo -pw %%% %dammsg %; \
        /if ({chits} > 0) \
            /let cdammsg=$(/chgcolor %cdammsg) %; \
            /echo -pw %%% %cdammsg %; \
        /endif%; \
        /if ({myclass} =~ "arc" | {myclass} =~ "bci" | {myclass} =~ "mon" | {myclass} =~ "asn" | {myclass} =~ "shf" | {myclass} =~ "fus" | {myclass} =~ "dru") \
            /let extradammsg=$(/chgcolor %extradammsg) %; \
            /echo -pw %%% %extradammsg %; \
        /endif %; \
    /else \
        /eval %damchan %dammsg %; \
        /if ({chits} > 0) \
            /eval %damchan %cdammsg%; \
        /endif%; \
        /if ({myclass} =~ "arc" | {myclass} =~ "bci" | {myclass} =~ "mon" | {myclass} =~ "asn" | {myclass} =~ "shf" | {myclass} =~ "fus" | {myclass} =~ "dru") \
            /eval %damchan %extradammsg %; \
        /endif %; \
    /endif

/def damreset = \
    /set nil=0 %;/set ctrs=0%;/set terminal=0 %; /set critical=0%; \
    /set vital=0%;/set sneakattack=0%;/set adodged=0%;\
    /unset avgdmg%;/unset avgdmgvar%;/unset totdmg%;/unset hits%;/unset chits%; \
    /unset cdmg%;/unset fanddmg%;/unset fandhits%;\
    /echo -p % @{hCred}Damage stats reset.@{n}%;\
    /clrgdmg

;;; gag's for running
/def -mglob -ag -p0 -F -t"* returns to *'s hand\." gag_weaponreturn
/def -mglob -ag -p0 -F -t"*'s weapons dance through the air\!" gag_psifandango
/def -mglob -ag -p0 -F -t"* wields *\." gag_otherwield
/def -mglob -ag -p0 -F -t"* puts * in their offhand\." gag_otheroffhand

;;; gag's for casting
/def -mregexp -ag -t'([a-zA-Z]+) concentrates deeply\.\.\.' battle_gag_psi_cast = \
    /echootherdam @{Cwhite}%{P1} concentrates deeply...@{n}
/def -mregexp -ag -t'([a-zA-Z]+) utters the words, \'(.*)\'\.' battle_gag_cast = \
    /echootherdam @{Cwhite}%{P1} utters the words, '@{Ccyan}%{P2}@{Cwhite}'@{n}
;;; gag's for counters/vitals
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

;;; ------------- Testing damage counter for others -------------
;;;
;;; TODO:  Create these macroes:
;;;             - macro to create triggers for those to track
;;;             - macro to remove triggers for those to track
;;;             - macro to output damage for single player
;;;         Also consider tallying damage for all trackies and rank them
;;;         Future?? Save high scores/player or overall top 10.
;;;         Cyril tells you 'Total Damage/Average:597974 (12.5%)/489
;; /odmg name [channel] - echoes damage dealt by 'name' to given channel.  If no
;;                        channel given, default is /echo
;; /gdmg - echoes all groupies damage to grouptells.
;; /tdmg GroupieName - Add triggers to track groupie damage.
;;                   - Case of name is significant or damage won't be tracked.
;;                   - /addotherdmg and/addotherdmg2 are used to add up total
;;                     damage
;; /rdmg Groupiename - Remove triggers.
;; /clrodmg name1 name2 ... nameN - Clear damage variables
;; /clrgdmg - Clears damage variables for grouplist.

/def odmg = \
    /let damchan=/echo%; \
    /if ({#} > 1) /let damchan=%-1%; /endif %; \
    /if ($(/listvar -vmglob totdmg_%1*) > 0) \
        /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
        /let gtotdmg=$[$(/listvar -vmglob totdmg_%1*) + $(/listvar -vmglob totodmg_%1*)]%; \
        /let ghits=$[$(/listvar -vmglob hits_%1*) + $(/listvar -vmglob ohits_%1*)] %; \
        /let avgdmg=$[trunc(gtotdmg/ghits)]%;\
        /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
        /let rtotdmg=$[trunc({gtotdmg}/1000)]%;\
        /let dammsg=%{grpdmgname}'s Dam: |g|%{rtotdmg}k |w|dmg. Avg |g|%{avgdmg}|w| which is |c|%{avgdmgvar}|w|.%; \
        /if ({damchan} =~ "/echo") \
            /let dammsg=$(/chgcolor %dammsg)%; \
            /echo -pw %%% %dammsg %; \
        /else \
            /eval %damchan %dammsg %; \
        /endif%; \
    /endif

/def psiodmg = \
    /let damchan=/echo%; \
    /if ({#} > 0) /let damchan=%*%; /endif %; \
    /if ($(/listvar -vmglob totodmg_%1*) > 0) \
        /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
        /let gtotodmg=$(/listvar -vmglob totodmg_%1*)%; \
        /let gohits=$(/listvar -vmglob ohits_%1*) %; \
        /let avgdmg=$[trunc(gtotodmg/gohits)]%; \
        /let avdw=$[avgdmg*3]%;\
        /quote -S /set avovar=!php getdmg.php %{avdw}%;\
        /quote -S /set avgdmgvar=!php getdmg.php %{avgdmg} %;\
        /let rodmg=$[trunc(gtotodmg/1000)]%;\
        /let odammsg= %{grpdmgname}'s Dam: |g|%{rodmg}k |w|damage in |g|%{gohits} |w|hits. Avg |g|%{avgdmg}|w|/hit which is |c|%{avgdmgvar}|w| and ~ |c|%{avovar}|w|/cast|w|%;\
        /if ({damchan} =~ "/echo") \
            /let odammsg=$(/chgcolor %odammsg)%; \
            /echo -pw %%% %odammsg %; \
        /else \
            /eval %damchan %odammsg %; \
        /endif%; \
    /endif

/def -i gtgdmg = /odmg %1 gtell
/def gdmg = /mapcar /gtgdmg %grouplist%;/damrep gtell%;/if ({myclass} =~ "psi") /psidmg gtell%;/endif

;; /addotherdmg and /addotherdmg2 are used in the tracking triggers.
/def -i addotherdmg = \
    /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
    /eval /set totdmg_%grpdmgname=$[$(/listvar -vmglob totdmg_%grpdmgname) + %2]%; \
    /eval /set hits_%grpdmgname=$[$(/listvar -vmglob hits_%grpdmgname) + 1]
/def -i addotherdmg2 = \
    /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
    /eval /set totodmg_%grpdmgname=$[$(/listvar -vmglob totodmg_%grpdmgname) + %2]%; \
    /eval /set ohits_%grpdmgname=$[$(/listvar -vmglob ohits_%grpdmgname) + 1]

/def tdmg = \
    /eval /set totdmg_%1 0%;/eval /set hits_%1 0%;\
    /eval /set totodmg_%1 0%;/eval /set ohits_%1 0%; \
    /def -mregexp -ag -p6 -t"%1's attacks haven't hurt (.*)\." othernildmg_%1=/echootherdam @{Cyellow}%1's attacks haven't hurt %%{P1}.%;\
    /def -mregexp -ag -p6 -t"%1's (.*) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" otherdmgcnt_%1 = \
        /quote -S /set dval=!php readfile-mysql.php "%%P6" %%; \
        /if ({dval} !~ 'blank') /addotherdmg %1 %%dval%%; /endif%%; \
        /echootherdam @{Cyellow}%1's %%P1 %%P2 %%P3 %%P4 %%P5, with @{Cgreen}%%{P6}@{Cyellow} %%{P7}%%{P8}@{n}%; \
    /def -mregexp -ag -p6 -t"%1's (.*) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" otherdmgcnt2_%1 = \
        /quote -S /set dval=!php readfile-mysql.php "%%P3" %%; \
        /if ({dval} !~ 'blank') /addotherdmg2 %1 %%dval%%; /endif%%; \
        /echootherdam @{Cyellow}%1's %%P1 strikes %%P2 with @{Cmagenta}%%{P3}@{Cyellow} %%{P4}%%{P5}@{n}%; \
    /def -mregexp -ag -p6 -t"%1 strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" otherdmgcnt3_%1 = \
        /quote -S /set dval=!php readfile-mysql.php "%%P2" %%; \
        /if ({dval} !~ 'blank') /addotherdmg2 %1 %%dval%%; /endif%%; \
        /echootherdam @{Cyellow}%1's strikes %%P1 with @{Cmagenta}%%{P2}@{Cyellow} %%{P3}%%{P4}@{n}%; \
    /echo -pw @{Ccyan}Tracking damage for: @{Cyellow}%1@{Ccyan}.@{n}

;; Following 2 triggers should pick damage dealt by others, but not tracked.
;; Lower priority than triggers that are tracking so these should not get fired
;; for tracked damage.  To confirm, damverb is in white for non-tracked.
;; Main purpose is to allow /echootherdam to have battlespam on and gag
;; non-tracked damage.  (This may gag hits to others by mobs.)
;; NOTE: Might be covered in rescue.tf
;/def -mregexp -ag -p5 -t"([a-zA-Z]+)'s (.*) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" otherdmgcnt_default = \
;    /echootherdam @{Cyellow}%P1's %P2 %P3 %P4 %P5 %P6, with @{Cwhite}%{P7}@{Cyellow} %{P8}%{P9}@{n}%; \
;/def -mregexp -ag -p5 -t"([a-zA-Z]+)'s (.*) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" otherdmgcnt2_default = \
;    /echootherdam @{Cyellow}%P1's %P2 strikes %P3 with @{Cmagenta}%{P4}@{Cyellow} %{P5}%{P6}@{n}

/def rdmg = \
    /while ({#}) \
        /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
        /if ($(/listvar -vmglob totdmg_%grpdmgname) !~ "") \
            /unset totdmg_%grpdmgname %; \
            /unset hits_%grpdmgname%; \
            /unset totodmg_%grpdmgname %; \
            /unset ohits_%grpdmgname%; \
            /undef othernildmg_%grpdmgname%; \
            /undef otherdmgcnt_%grpdmgname%; \
            /undef otherdmgcnt2_%grpdmgname%; \
            /undef otherdmgcnt3_%grpdmgname%; \
            /echo -pw @{Ccyan}No longer tracking damage for: @{Cyellow}%grpdmgname@{Ccyan}.@{n}%; \
        /else \
            /if /ismacro otherdmgcnt_%1%; /then /undef otherdmgcnt_%1%; /endif%; \
            /if /ismacro otherdmgcnt2_%1%; /then /undef otherdmgcnt2_%1%; /endif%; \
            /if /ismacro otherdmgcnt3_%1%; /then /undef otherdmgcnt3_%1%; /endif%; \
            /echo -pw @{Ccyan}No longer tracking damage for: @{Cyellow}%1@{Ccyan}.@{n}%; \
        /endif%; \
        /shift%; \
    /done

/def clrdmg = \
    /while ({#}) \
        /let grpdmgname=$[substr($(/listvar -smglob totdmg_%1*),7)] %; \
        /set totdmg_%grpdmgname=0 %; \
        /set hits_%grpdmgname=0%; \
        /set totodmg_%grpdmgname=0 %; \
        /set ohits_%grpdmgname=0%; \
        /shift %; \
    /done

/def clrgdmg = \
    /clrdmg %grouplist%;\
    /echo -p % @{hCcyan}Damage stats reset for @{nCyellow}%{grouplist}@{hCcyan}.@{n}
