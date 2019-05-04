;;; Triggers to count damage and echo it in a nice format.
;;; This is an adaptation of the code originally written by Jekyll.
;;;
;;; Damage is written to a text file, and then parsed/compiled on
;;; demand. This is to reduce the lag from looking up values and
;;; doing any calculations during lord runs (like gear rooms) where
;;; lots of damage is happening at the same time.
;;; Data is written as a comma separated file, loaded into a PostgreSQL DB
;;; and then parsed using Python scripts based on the damage report
;;; requested.
;;;
;;; Usage:
;;;
;;; /zdamreset	- resets the damage counter
;;; /zdamcomp	- compiles the damage
;;; damrep %1	- reports damage done by a groupmember
;;; /gdamrep %1	- reports damage done by group to %1 channel (e.g., gt, b)
;;; topdam	- reports the top damage dealers for the group in order
;;;		  this is the total damage dealt, and is not broken up in
;;;		  any meaningful way.
;;; topavgdam [%1] - this reports the average damage for each type of damage
;;;		  by default. The optional argument will restrict it to a
;;;		  specific damage type. 1 - melee, 2 - rogue, 3 - spell
;;;
;;;
;;; 
;; A macro to swap game color codes |xx| to tf color codes.
;; Use it as follows:
;; /set mymsg=$(/chgcolor %{mymsg})
/def chgcolor = \
    /let inmsg=%{*}%; \
    /let outmsg=$[replace("|k|", "@{xCblack}", {inmsg})] %; \
    /let outmsg=$[replace("|b|", "@{xCblue}", {outmsg})] %; \
    /let outmsg=$[replace("|c|", "@{xCcyan}", {outmsg})] %; \
    /let outmsg=$[replace("|g|", "@{xCgreen}", {outmsg})] %; \
    /let outmsg=$[replace("|r|", "@{xCred}", {outmsg})] %; \
    /let outmsg=$[replace("|y|", "@{xCyellow}", {outmsg})] %; \
    /let outmsg=$[replace("|w|", "@{xCwhite}", {outmsg})] %; \
    /let outmsg=$[replace("|p|", "@{xCmagenta}", {outmsg})] %; \
    /let outmsg=$[replace("|bk|", "@{hCblack}", {outmsg})] %; \
    /let outmsg=$[replace("|bb|", "@{hCblue}", {outmsg})] %; \
    /let outmsg=$[replace("|bc|", "@{hCcyan}", {outmsg})] %; \
    /let outmsg=$[replace("|bg|", "@{hCgreen}", {outmsg})] %; \
    /let outmsg=$[replace("|br|", "@{hCred}", {outmsg})] %; \
    /let outmsg=$[replace("|by|", "@{hCyellow}", {outmsg})] %; \
    /let outmsg=$[replace("|bw|", "@{hCwhite}", {outmsg})] %; \
    /let outmsg=$[replace("|bp|", "@{hCmagenta}", {outmsg})] %; \
    /echo -pw %outmsg

/def acast = /toggle autocast%;/echoflag %autocast Auto-Cast

/def -mregexp -ag -F -t"^You fire at (.*) and miss!" arrownilcount = \
        /sys echo "$[tolower(%{charname})]","nil","1" >> /home/chris/tf/damage.txt %;\
        /echo -pw @{Cyellow}You missed. You suck!@{n}

/def -mregexp -ag -F -t"([A-Za-z]*) fires at (.*) and misses!" groupiearrownil = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P2 %; \
	/if (regmatch(tolower({P1}),{grouplist}) ) \
		/sys echo "%{t1}","nil","1" >> /home/chris/tf/damage.txt %; \
	/endif %; \
	/echodam @{Cyellow}%{t2} fires at %{t3} and misses!

/def -mregexp -ag -F -t"^(.*)'s attacks haven't hurt (.*)!" nilcounting = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P2 %; \
	/let tAttacked=%P2 %; \
	/if ({P2} =~ "you") \
		/echo -pw @{Cred}%{t2} attacks haven't hurt %{t3}! %; \
    	/elseif ( regmatch(tolower({P1}),{grouplist}) ) \
		/sys echo "%{t1}","nil","1" >> /home/chris/tf/damage.txt %; \
		/echodam @{Cyellow}%{t2} attacks haven't hurt %{t3}! %; \
    	/else \
		/echo -pw @{Cyellow}%{t2} attacks haven't hurt @{hCblue}%{t3}!@{n} %; \
	/endif %; \

/def -mregexp -F -t"^Your attacks haven't hurt" selfnilcount = \
	/sys echo "$[tolower(%{charname})]","nil","1" >> /home/chris/tf/damage.txt

;; Melee damage
/def -F -mregexp -ag -t"^Your (attack|attacks) (strikes|strike) (.*) ([0-9]*) (time|times), with (.*) ([a-zA-Z]*)(!|\.)" dmgcnt = \
	/if ({P6} !~ "terminal") \
	/sys echo "$[tolower(%{charname})]","%{P6}","1" >> /home/chris/tf/damage.txt %; \
	/endif %; \
    /echo -pw @{Cyellow}Your %P1 %P2 %P3 %P4 %P5, with @{h}%{P6}@{n} %{P7}%{P8}@{n}

/def -F -mregexp -ag -t"^Your shot hits (.*) with (.*) ([a-zA-Z]*)!$" fus_dmgcnt = \
	/if ({P2} !~ "terminal") \
		/sys echo "$[tolower(%{charname})]","%{P2}","1" >> /home/chris/tf/damage.txt %; \
	/endif %; \
	/echo -pw @{Cyellow}Your shot hits %P1 with @{h}%{P2}@{n} %{P3}!

/def -F -mregexp -ag -t"^One shot finds no target!$" fus_scat_nil = \
	/sys echo "$[tolower(%{charname})]","nil","1" >> /home/chris/tf/damage.txt %; \
	/echo -pw @{Cred}One shot finds no target!

;; Melee-type trigger.  Picks up kicks, counters, bashes, etc.
;; It has a lower priority than the spell damage trigger so that the spells
;; will be processed over this trigger.  The pattern is similar.
;;/def -p0 -ag -mregexp -t'You (.*) with (.*) ([a-zA-Z]+)(\.|\!)' otherdmgcnt = \
;;    
;;	/echodam @{Cyellow}You %P1 with @{hCcyan}%P2 @{xCyellow}%{P3}%{P4}@{n}

/def -mregexp -ag -p6 -t"^(You) (shatterspell|hail|lightning|shock|freeze|psionic blast|ultrablast|maelstrom|cataclysm|disintegrate|ice lance|sandstorm|mindwipe|torment|vampire touch|leech|fracture|rupture|Meteor Swarm|brimstone|field of death|acid rain|blast|white light|white fire|desiccate|breath|holy ground|burn) (.*) with (.*) ([a-zA-Z]*)" spelldmgcnt = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P2 %; \
	/let t4=%P4 %; \
	/let t5=%P3 %; \
	/let t6=%P5 %; \
		/sys echo "$[tolower(%{charname})]","%{t4}","3" >> /home/chris/tf/damage.txt %; \
    /echo -pw @{Cyellow}%{t2} %{t3} strikes %{t5} with @{Ccyan}%{t4} @{Cyellow}%{t6}!@{n}

;; Spell damage
/def -mregexp -ag -p6 -t"^([a-zA-Z]*)\'s (shatterspell|wrath|hail|lightning|shock|freeze|psionic blast|ultrablast|maelstrom|cataclysm|disintegrate|ice lance|sandstorm|mindwipe|torment|vampire touch|leech|fracture|rupture|Meteor Swarm|brimstone|field of death|acid rain|blast|white light|white fire|breath|desiccate|holy ground|burn) strikes (.*) with (.*) ([a-zA-Z]*)" spelldmgcntother = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P2 %; \
	/let t4=%P4 %; \
	/let t5=%P3 %; \
	/let t6=%P5 %; \
    /if ( regmatch(tolower({P1}),{grouplist}) ) \
		/sys echo "%{t1}","%{t4}","3" >> /home/chris/tf/damage.txt %; \
        /endif %; \
    /echodam @{Cyellow}%{t2}'s %{t3} strikes %{t5} with @{Cgreen}%{t4} @{Cyellow}%{t6}!@{n}

;; Rog-stab damage

/def -mregexp -ag -t"^You (backstab|pierce) (.*) with (.*) ([a-zA-Z]*)(\.|\!)" rogdmgcnt = \
        /if ({P6} !~ "terminal") \
        /sys echo "$[tolower(%{charname})]","%{P3}","2" >> /home/chris/tf/damage.txt %; \
        /endif %; \
   /echo -pw @{Cyellow}You %P1 %P2 with @{hCcyan}%P3 @{xCyellow}%P4!@{n}

;; Count the stabs done by groupmembers.
;; Fierlo's pierce strikes A hungry darkenbeast with =>>>>***DESTRUCTIVE***<<<<= force!

/def -mregexp -ag -t"^([a-zA-Z]*)\'s (pierce|backstab) strikes (.*) with (.*) ([a-zA-Z]*)(\.|\!)" rogdmgcnt2 = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P3 %; \
	/let t4=%P4 %; \
	/let t5=%P5 %; \
	/let t6=%P6 %; \
    /if ( regmatch(tolower({P1}),{grouplist}) ) \
		/sys echo "%{t1}","%{t4}","2" >> /home/chris/tf/damage.txt %; \
        /endif %; \
   /echo -pw @{Cyellow}%{t2}'s pierce strikes %{t3} with @{hCcyan}%{t4} @{xCyellow}%{t5}@{n}



/def -mregexp -ag -t"^([a-zA-Z]*) fired a volley which hit with a combined damage of (.*)" volley_other = \
	/let t1=$[tolower({P1})] %; \
	/let t2=%P1 %; \
	/let t3=%P2 %; \
    /if ( regmatch(tolower({P1}),{grouplist}) ) \
		/sys echo "%{t1}","%{t3}","1" >> /home/chris/tf/damage.txt %; \
        /endif %; \
   /echo -pw @{Cyellow}%{t2} fired a volley which hit with a combined damage of %{t3} @{xCyellow}@{n}



/def -mglob -t"*You creep up behind *" sneak_attack = /set sneakattack=$[++sneakattack]
/def -mglob -t"*You aim for a weak spot\!" vital_shot = /set vital=$[++vital]

;;; macro to echo the damage from triggers above.  Toggle the battle spam
;;; with /bspam
/set bspam=1
/def bspam = /toggle bspam%;/echoflag %bspam @{Cyellow}Battle Spam@{n}
/def -i echodam = \
    /if ({bspam} = 1) /echo -pw %{*}@{n}%; /endif


/def zdamreset = \
    /set nil=0 %;/set ctrs=0%;/set terminal=0 %; /set critical=0%; \
    /set vital=0%;/set sneakattack=0%;/set adodged=0%;\
    /unset avgdmg%;/unset avgdmgvar%;/unset totdmg%;/unset hits%;/unset chits%; \
    /unset cdmg%;/unset fanddmg%;/unset fandhits%;/unset csusdmg%;/unset csushits%;\
	/quote -S /echo !psql avatar -q -c "delete from damage_others" %; \
	/sys rm /home/chris/tf/damage.txt %; /sys rm /home/chris/tf/damage.temp %; \
    /echo -p % @{hCred}Damage stats reset.@{n}

/def zdaminit = \
	/sys rm /home/chris/tf/damage.txt %; \
	/sys touch /home/chris/tf/damage.txt


/def zdamoff = \
	/edit -c0 other_damage

/def zdamcomp = \
	/sys mv /home/chris/tf/damage.txt /home/chris/tf/damage.temp %; \
	/quote -S /echo !psql avatar -q -c "\\copy damage_others from '/home/chris/tf/damage.temp' using delimiters ','"

;;;" (to fix syntax highlighting in vim)


/alias damrep /while ({#}) /quote -S /set damage_report=!/home/chris/tf/damage.py gt %1 %; \
	%{damage_report} %; \
	/shift %; /done

/alias dam_report /unset players %; \
	/while ({#}) /set players=%{players} %2 %; \
	/shift %; \
	/done %; \
	/quote -S /set damage_report=!/home/chris/tf/damage.py %{dam_channel} %{players} %; \
	/send %{damage_report}

/def gdamrep = /set dam_channel=%1 %; \
	dam_report %{dam_channel} %{grouplist}

/alias topdam /quote -S /set damage_report=!/home/chris/tf/damage.py 0 %; \
	gt %{damage_report}

/alias topavgdam /if (%1=~"") \
		/quote -S /set damage_report=!/home/chris/tf/damage.py 1 %; \
		gt %{damage_report} %; \
		/quote -S /set damage_report=!/home/chris/tf/damage.py 3 %; \
		gt %{damage_report} %; \
		/quote -S /set damage_report=!/home/chris/tf/damage.py 2 %; \
		gt %{damage_report} %; \
	/else /quote -S /set damage_report=!/home/chris/tf/damage.py %1 %; \
		gt %{damage_report} %; \
	/endif
		


/def -mregexp -ag -p0 -F -t"([a-zA-Z0-9,\.\-\ \']*)'s (attack strikes|attacks strike) (.*) ([0-9]+) (time|times), with (.*) ([a-zA-Z]*)(\.|\!)" other_damage = \
    /let t1=%P1 %;/let t2=%P2 %;/let t3=%P3 %;\
    /let t4=%P4 %;/let t5=%P5 %;/let t6=%P6 %;\
    /let t7=%P7 %;/let t8=%P8 %;\
    /let tAttacker=$[tolower({t1})] %;\
    /let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's %t2 %t3 %t4 %t5, with @{Cyellow}%{t6}@{Cred} %{t7}%{t8}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{grouplist}) ) \
        /echo -pw @{Cyellow}%t1's %t2 @{hCblue}%t3 @{xCyellow}%t4 %t5, with @{hCcyan}%{t6}@{xCyellow} %{t7}%{t8}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{grouplist}) ) \
	/if ({t6} !~ 'terminal') \
	/sys echo "%{tAttacker}","%{t6}","1" >> /home/chris/tf/damage.txt %; \
	/echodam @{Cyellow}%t1's %t2 %t3 %t4 %t5, with @{Cgreen}%{t6}@{Cyellow} %{t7}%{t8}@{n} %; \
	/endif %; \
    /else \
        /echo -pw @{Cyellow}%t1's %t2 @{hCblue}%t3@{nCyellow} %t4 %t5, with %{t6} %{t7}%{t8}@{n}%;\
    /endif


/def -mregexp -ag -p0 -F -t"([a-zA-Z0-9,\.\-\ \']*)'s (slice|stab) strikes (.*) with ([A-Za-z\*]*) ([a-zA-Z]*)(\.|\!)" psi_damage = \
    /let t1=%P1 %;/let t2=%P2 %;/let t3=%P3 %;\
    /let t4=%P4 %;/let t5=%P5 %;/let t6=%P6 %;\
    /let tAttacker=$[tolower({t1})] %;\
    /let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's %t2 strikes %t3 with @{Cyellow}%{t4}@{Cred} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{grouplist}) ) \
        /echo -pw @{Cyellow}%t1's %t2 strikes @{hCblue}%t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{grouplist}) ) \
	/if ({t6} !~ 'terminal') \
	/sys echo "%{tAttacker}","%{t4}","4" >> /home/chris/tf/damage.txt %; \
	/echo -pw @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
	/endif %; \
    /else \
        /echo -pw @{Cyellow}%t1's %t2 strikes %t3 with %{t4} %{t5}%{t6}@{n}%;\
    /endif


/def -mregexp -ag -p0 -F -t"([a-zA-Z0-9,\.\-\ \']*|^You)'s (hit|kick|scorpion kick|whirlwind kick|crushing punch|spirit blast|unicorn thrust) strikes (.*) with ([A-Za-z\*]*) ([a-zA-Z]*)(\.|\!)" ctr_damage = \
    /let t1=%P1 %;/let t2=%P2 %;/let t3=%P3 %;\
    /let t4=%P4 %;/let t5=%P5 %;/let t6=%P6 %;\
    /let tAttacker=$[tolower({t1})] %;\
    /let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's %t2 strikes %t3 with @{Cyellow}%{t4}@{Cred} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{grouplist}) ) \
        /echo -pw @{Cyellow}%t1's %t2 strikes @{hCblue}%t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacker}),{grouplist}) ) \
	/if ({t6} !~ 'terminal') \
	/sys echo "%{tAttacker}","%{t4}","5" >> /home/chris/tf/damage.txt %; \
	/echodam @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
	/endif %; \
    /else \
        /echo -pw @{Cyellow}%t1's %t2 strikes %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /endif


/def -mregexp -ag -p0 -F -t"^(You) (hit|kick|scorpion kick|whirlwind kick|crushing punch|spirit blast|unicorn thrust) (.*) with ([A-Za-z\*]*) ([a-zA-Z]*)(\.|\!)" ctr_damage_self = \
    /let t1=%P1 %;/let t2=%P2 %;/let t3=%P3 %;\
    /let t4=%P4 %;/let t5=%P5 %;/let t6=%P6 %;\
    /let tAttacker=$[tolower({t1})] %;\
    /let tAttacked=<%t3<%;\
    /if ({P3} =~ "you") \
        /echo -pw @{Cred}%t1's %t2 strikes %t3 with @{Cyellow}%{t4}@{Cred} %{t5}%{t6}@{n}%;\
    /elseif ( regmatch(tolower({tAttacked}),{grouplist}) ) \
        /echo -pw @{Cyellow}%t1's %t2 strikes @{hCblue}%t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
    /else \
	/if ({t6} !~ 'terminal') \
	/sys echo "$[tolower(%{charname})]","%{t4}","5" >> /home/chris/tf/damage.txt %; \
	/echo -pw @{Cyellow}%t1 %t2 %t3 with @{Cgreen}%{t4}@{Cyellow} %{t5}%{t6}@{n}%;\
	/endif %; \
    /endif
