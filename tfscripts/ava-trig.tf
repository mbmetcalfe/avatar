;;; ---------------------------------------------------------------------------
;;; ava-trig.tf
;;; Random triggers that don't fit into their own module/file
;;; ---------------------------------------------------------------------------
/def -mregexp -t'^You disappear into the void.' voidtrig = /send snore=inventory
/def -mregexp -t'You attempt to bash into' failbash = wake
/def -mregexp -t"^[-',A-Za-z ]+ bashed into you and you go down\!" bashed_down = /send stand

/def -mregexp -ag -t'^You failed your ([a-zA-Z ]*) due to lack of concentration!' failspell = \
	/echo -p @{hCgreen}You failed your @{nCwhite}%P1 @{hCgreen}due to lack of concentration!@{n}

/set atitle=1
/def atitle = \
    /if ({atitle} = 1) \
        /xtitle ${world_character} %{*}%;\
    /endif
/def title = \
	/let mytitle=%{2}%;\
    /if (({1} =~ "on") | ({1} =~ "ON") | ({1} =~ "On")) \
        /edit -c100 x_fg_hook%;\
        /edit -c100 reloghook2%;\
        /set atitle=1%;\
        /atitle (%mytier %mylevel)%;\
	/else \
        /edit -c0 x_fg_hook%;\
        /edit -c0 reloghook2%;\
        /set atitle=0%;\
	/endif%;\
	/xtitle %{mytitle}

/def -mregexp -t"^Exp/TNL:[ ]+[0-9]+/[0-9]+[ ]+Level ([0-9\(\)]+) (.+) ([A-Za-z]+)\.$" = \
	/let tmylevel=$[strchr({P1},"(")>-1?(substr({P1},0,strchr({P1},"("))):{P1}] %; \
	/let classinfo=$[tolower({P3})] %; \
	/let tmyclass=$[substr({classinfo},0,3)] %; \
	/echo -p %%% @{Ccyan}Level @{hCcyan}%tmylevel %classinfo @{hCwhite}(@{nCcyan}%tmyclass@{hCwhite})@{n}
/def -ag -mregexp -t"^You must go beyond sublevel ([0-9]+) to get level gains\." get_gains = \
	/let leveltoget=%P1%;/let levelstogain=$[leveltoget-mylevel]%;\
	/echo -p @{Ccyan}You must reach sublevel @{hCwhite}%P1 @{nCCyan}to get level gains.  @{hCwhite}%{levelstogain} @{nCCyan}more levels.@{n}

/def -mregexp -ag -t'^You feel more confidence in your ability with ([a-zA-Z ]*)' moreconfidence = \
	/echo -p @{Cwhite}You feel more confidence in your ability with @{Cyellow}%P1@{Cwhite}.@{n}

; Group triggers/aliases
/def -mregexp -t'^You join ([a-zA-Z]+)\'s group.' monlead = \
    /setlead $[strip_attr({P1})]%;\
    monitor %{leader}%;\
    /repeat -00:00:01 1 /logCharStat

/def -mregexp -t'^[a-zA-Z]+ removes you from [a-zA-Z]+ group.' rmgroup1 = /setlead Self
/def -mregexp -t'^You stop following [a-zA-Z]+.' rmgroup2 = \
    /if ({running} = 0) /setlead Self%;/send group%; /endif
/def -mregexp -t'^[\w]+ disbands the group.' rmgroup3 = \
    /if ({running} = 0) /setlead Self%;/send group%;/endif

/def -p0 -mregexp -t"([A-Za-z]+) now follows you." groupfollower = \
    /let _name=%P1 %; \
    /if ({leader} !~ "Self") \
        /if ({running} = 0) /setlead Self%; /endif%; \
    /endif%; \
    /if ( regmatch(tolower({_name}),"me") ) \
        /echo -aB -p % Good job! You avoided a group me trigger. %; \
    /else \
        /if ({autogroup}=1) group %_name %; \ /endif %; \
    /endif

/def -mregexp -p5 -F -t"^([a-zA-Z]+) enters [a|an|the]+ ([a-z]+)." leader_ported = \
    /let _porter=$[tolower(strip_attr({P1}))]%;\
    /if ({_porter} =~ {leader}) \
        /echo -pw %%% @{hCgreen}%{leader}, your group leader just entered a %{P2}.@{n}%;\
        /beep%;\
    /endif

;/def -mregexp -t'^You lose ([0-9]*) hero levels\!' fail_morph = \
;    /eval /sys echo $[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: You lose %P1 hero levels! >> char/%{myname}.%{gains_suffix}.dat%;\
;    /atitle - Lost %P1 levels.
;[HERO INFO]: Vulko failed morph at level 478.
/def -mregexp -t'^\[HERO INFO\]\: ([a-zA-Z]+) failed morph at level ([0-9]+)\.$' fail_morph = \
    /let _lc_name=$[tolower({P1})]%;\
    /if ({_lc_name} =~ {myname}) \
        /eval /sys echo $[ftime("%m%d", time())] - %{mylevel} %{mytier}: Failed morph. >> char/%{myname}.%{gains_suffix}.dat%;\
    /endif

/def -mglob -t"With confidence you meld with the continuum briefly and become a new Lord!" success_morph = \
    /eval /sys echo $[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: Morphed. >> char/%{myname}.%{gains_suffix}.dat%;\
    /atitle (Lord 1)

; Gain/lose stats
;;; Aug 29, 2005 - Changed gains triggers to calculate the gain b/c of the bug.
;;;                 Just uncomment/remove the relevant lines when it's fixed.
/def -mregexp -ah -t'^Your gain is: ([0-9]+)/([0-9]+) hp, ([0-9]+)/([0-9]+) m, ([0-9]+)/([0-9]+) mv ([0-9]+)/([0-9]+) prac.' tellgaintrig = \
    /set max_prac=%P8%;\
    /let hpgain=%P1%;/let managain=%P3%;/let mvgain=%P5%;/let pracgain=%P7%; \
    /set levels=$[++levels]%;/set mylevel=$[++mylevel]%; \
    /atitle (%mytier %mylevel)%;\
    /set hpgains=$[hpgains+hpgain]%;/set managains=$[managains+managain]%; \
    /set mvgains=$[mvgains+mvgain]%;/set pracgains=$[pracgains+pracgain]%; \
    /let bhp=%P2%;/let bmana=%P4%;/let bmv=%P6%;/let bprac=%P8%; \
;;;        /if ({hpgain}!=0 & {managain}!=0 & {mvgain}!=0 & {pracgain}!=0) \
;;; should always have at least 1 prac?  So if none, likely no gains...
    /if ({pracgain}!=0) \
        /echo -p @{Cmagenta}Your gain is: @{hCcyan}%{hpgain}@{nCcyan}hp @{hCyellow}%{managain}@{nCyellow}m @{hCgreen}%{mvgain}@{nCgreen}mv @{hCwhite}%{pracgain}@{nCwhite}prac@{nCmagenta}. %; \
        /set lvlmsg=$[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}:%{hpgain}/%{bhp} hp, %{managain}/%{bmana} m, %{mvgain}/%{bmv} mv %{pracgain}/%{bprac} prac. %; \
        /eval /sys echo %lvlmsg >> char/%{myname}.%{gains_suffix}.dat%; \
;;;            /eval /send gt |c|%{hpgain} |y|hp, |c|%{managain} |y|m, |c|%{mvgain} |y|mv |c|%{pracgain} |y|prac.|w|%;\
    /endif

/def -mregexp -ag -t'^You raise a level!!  Your gain is: ([0-9]+)/([0-9]+) hp, ([0-9]+)/([0-9]+) m, ([0-9]+)/([0-9]+) mv ([0-9]+)/([0-9]+) prac.' telllowmortgaintrig = \
    /set max_prac=%P8%;\
    /let hpgain=%P1%;/let managain=%P3%;/let mvgain=%P5%;/let pracgain=%P7%; \
    /set levels=$[++levels]%;/set mylevel=$[++mylevel]%; \
    /atitle (%mytier %mylevel)%;\
    /set hpgains=$[hpgains+hpgain]%;/set managains=$[managains+managain]%; \
    /set mvgains=$[mvgains+mvgain]%;/set pracgains=$[pracgains+pracgain]%; \
    /let bhp=%P2%;/let bmana=%P4%;/let bmv=%P6%;/let bprac=%P8%; \
    /echo -p @{Cmagenta}Your gain is: @{hCcyan}%{hpgain}@{nCcyan}hp @{hCyellow}%{managain}@{nCyellow}m @{hCgreen}%{mvgain}@{nCgreen}mv @{hCwhite}%{pracgain}@{nCwhite}prac@{nCmagenta}. %; \
    /set lvlmsg=$[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}:%{hpgain}/%{bhp} hp, %{managain}/%{bmana} m, %{mvgain}/%{bmv} mv %{pracgain}/%{bprac} prac. %; \
    /eval /sys echo %lvlmsg >> char/%{myname}.%{gains_suffix}.dat%;\
    /eval /send gt |c|%{hpgain} |y|hp, |c|%{managain} |y|m, |c|%{mvgain} |y|mv |c|%{pracgain} |y|prac.|w|
    
/def -mregexp -p1 -t"You need [0-9]+ experience to level and have ([0-9]+) practices\." char_worth_pracs = /set max_prac=%P1
/def -mregexp -p1 -t"Wimpy  :    [0-9]+ hits     Practices   :        ([0-9]+)     Incarnation :          [0-9]+" char_score_pracs = /set max_prac=%P1

/def -mglob -ahCmagenta -t"You gain 1 hit point!!! Don't spend it all in one place." kills_rollover = \
     /eval /sys echo $[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: You gain 1 hit point! 10k kills rollover >> char/%{myname}.%{gains_suffix}.dat

/def -mregexp -ag -t"^You gain ([0-9]+) practice point for guiding ([a-zA-Z]+) to a new level of power\!" leading_prac = \
	/set pracgains=$[pracgains+{P1}]%; \
	/echo -p @{hCcyan}%P1 @{nCwhite}practice for @{hCcyan}%{P2}'s @{nCwhite}level.@{n}%; \
	/eval /sys echo $[ftime("%Y%m%d", time())] - %mylevel %mytier: %{P1} pracs for leveling %{P2}. >> char/%{myname}.%{gains_suffix}.dat

; Brandishable triggers
/def -mregexp -aCwhite -t'^Has ([0-9]+)\(([0-9]+)\) charges at level ([0-9]+) \'([a-zA-Z ]+)\'.' brandishlefttrig = /setBranLeft %{P2}

/def -mregexp -p2 -t"You gain 1 leadership point for guiding ([a-zA-Z]+) to a new level of power!" leadership_point = \
    /eval /sys echo $[ftime("%Y%m%d", time())] -  %{mylevel} %{mytier}: Leadership point for leveling %P1.>> char/%{myname}.%{gains_suffix}.dat

/def -mregexp -t'^You have been rebuilt into (.*)\.' char_rebuild = \
	/let rebuildmsg=$[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: You have been rebuilt into %P1.%; \
	/eval /sys echo %rebuildmsg >> char/%{myname}.%{gains_suffix}.dat

/def -mregexp -t'^You used ([0-9]+) practices and raised your ([a-zA-Z]+) ([0-9]+) times\.' train_stat = \
	/let trainmsg=%{mylevel} %{mytier}: Trained %P3 %P2 using %P1 practices.

/def -mregexp -t'^You feel weaker. You have lost ([a-zA-Z]*).$' lost_stat = \
	/let loststat=%P1%; \
	/let statlossmsg=$[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: Lost stat %{loststat}%; \
	/eval /sys echo %statlossmsg >> char/%{myname}.%{gains_suffix}.dat%; \
	/echo -p @{Ccyan}You have lost @{hCred}%{loststat}@{nCcyan}.@{n}

/def -mregexp -ag -t'^Your ([a-zA-Z]) increases through your experiences!' statgain = \
	/let statgained=%P1%; \
	/echo -p @{Cwhite}Just gained @{hCmagenta}%statgained@{nCwhite}.@{n}%; \
	/eval /sys echo $[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: Your %statgained increases through your experiences!>> char/%{myname}.%{gains_suffix}.dat

/def -mregexp -t'^Your speed increases from your many narrow escapes\!$' gained_stat_dex = \
	/let statgainmsg=$[ftime("%Y%m%d", time())] - %{mylevel} %{mytier}: Gained stat DEX%; \
	/eval /sys echo %statgainmsg >> char/%{myname}.%{gains_suffix}.dat%; \
	/echo -p @{Ccyan}You have gained @{hCred}DEX@{nCcyan}.@{n}

/def -p98 -F -mregexp -t"You have ([0-9]+) gold coins in hand and ([0-9]+) gold coins in the bank\." set_gold = /set myGold=$[{P1}+{P2}]

/def -mregexp -p1 -t"You have ([0-9]+) gold coins in hand and ([0-9]+) gold coins in the bank\." worth_gemstone_count = /showgemcount %P2

/def showgemcount = \
    /let totalCoins=%{1}%;\
    /let gemstoneMessage=%{totalCoins} coins: %;\
    /if ({totalCoins} >= 50000000) \
        /let numGems=$[{totalCoins} / 50000000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Eyes of Snikt.%;\
        /let totalCoins=$[mod({totalCoins}, 50000000)]%;\
    /endif%;\
    /if ({totalCoins} >= 10000000) \
        /let numGems=$[{totalCoins} / 10000000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Seraphim Pearls.%;\
        /let totalCoins=$[mod({totalCoins}, 10000000)]%;\
    /endif%;\
    /if ({totalCoins} >= 5000000) \
        /let numGems=$[{totalCoins} / 5000000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Sunstones.%;\
        /let totalCoins=$[mod({totalCoins}, 5000000)]%;\
    /endif%;\
    /if ({totalCoins} >= 1000000) \
        /let numGems=$[{totalCoins} / 1000000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Widow Tears.%;\
        /let totalCoins=$[mod({totalCoins}, 1000000)]%;\
    /endif%;\
    /if ({totalCoins} >= 500000) \
        /let numGems=$[{totalCoins} / 500000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Firehearts.%;\
        /let totalCoins=$[mod({totalCoins}, 500000)]%;\
    /endif%;\
    /if ({totalCoins} >= 100000) \
        /let numGems=$[{totalCoins} / 100000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Fizoras.%;\
        /let totalCoins=$[mod({totalCoins}, 100000)]%;\
    /endif%;\
    /if ({totalCoins} >= 50000) \
        /let numGems=$[{totalCoins} / 50000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Diamonds.%;\
        /let totalCoins=$[mod({totalCoins}, 50000)]%;\
    /endif%;\
    /if ({totalCoins} >= 25000) \
        /let numGems=$[{totalCoins} / 25000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Catseyes.%;\
        /let totalCoins=$[mod({totalCoins}, 25000)]%;\
    /endif%;\
    /if ({totalCoins} >= 15000) \
        /let numGems=$[{totalCoins} / 15000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Emeralds.%;\
        /let totalCoins=$[mod({totalCoins}, 15000)]%;\
    /endif%;\
    /if ({totalCoins} >= 15000) \
        /let numGems=$[{totalCoins} / 15000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Emeralds.%;\
        /let totalCoins=$[mod({totalCoins}, 15000)]%;\
    /endif%;\
    /if ({totalCoins} >= 12000) \
        /let numGems=$[{totalCoins} / 12000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Sapphires.%;\
        /let totalCoins=$[mod({totalCoins}, 12000)]%;\
    /endif%;\
    /if ({totalCoins} >= 10000) \
        /let numGems=$[{totalCoins} / 10000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Aquamarines.%;\
        /let totalCoins=$[mod({totalCoins}, 10000)]%;\
    /endif%;\
    /if ({totalCoins} >= 8000) \
        /let numGems=$[{totalCoins} / 8000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Citrines.%;\
        /let totalCoins=$[mod({totalCoins}, 8000)]%;\
    /endif%;\
    /if ({totalCoins} >= 6000) \
        /let numGems=$[{totalCoins} / 6000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Moonstones.%;\
        /let totalCoins=$[mod({totalCoins}, 6000)]%;\
    /endif%;\
    /if ({totalCoins} >= 4000) \
        /let numGems=$[{totalCoins} / 4000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Topaz.%;\
        /let totalCoins=$[mod({totalCoins}, 4000)]%;\
    /endif%;\
    /if ({totalCoins} >= 2000) \
        /let numGems=$[{totalCoins} / 2000]%;\
        /let gemstoneMessage=%{gemstoneMessage} %{numGems} Amethyst.%;\
        /let totalCoins=$[mod({totalCoins}, 2000)]%;\
    /endif%;\
    /let gemstoneMessage=%{gemstoneMessage} %{totalCoins} coins.%;\
    /echo -pw @{nCgreen}%{gemstoneMessage}@{n}


;;; ----------------------------------------------------------------------------
;;; Boons.
;;; ----------------------------------------------------------------------------
;; Send a General note with the boon.  This macro assumes there are two boons.
;/def -i sendBoonNote = \
;    /if ({drone} == 1) \
;        /if /!ismacro boon_note_line_added%; /then \
;            /def -mglob -n1 -t"Line Added." boon_note_line_added = /def -mglob -n1 -t"Line Added." boon_note_line_added = /send note post=board 7%;\
;        /endif%;\
;        /send board 1=note to all=note subject Boons%;\
;        /send note + %{*}%;\
;    /endif
/def -i sendBoonNoteToSlack = /sendSlackNotificationMsg :gift: %{*} :gift: 
/def -i sendBoonNote = /sendDiscordNotifyMsg :gift: %{*} :gift:

/def -mglob -ah -p1 -t"Tul-Sith smiles, and amplifies your healing prowess!" misc_avatar_boon_healing = \
    /sendBoonNote Tul-Sith is amplifying healing prowess.
/def -mglob -ah -p1 -t"A spring flows over and brings new healing warmth to the realm!" misc_avatar_boon_healing2 = \
    /sendBoonNote A HP regeneration boon is in effect.
/def -mglob -ah -p1 -t"Your melee brute strength increases!" misc_avatar_boon_melee_brute = \
    /sendBoonNote A melee brute strength boon is in effect.
/def -mglob -ah -p1 -t"Bhyss flexes his muscle and magic becomes instantly more powerful!" misc_avatar_boon_magic_power = \
    /sendBoonNote Bhyss is making magic more powerful.
/def -mglob -ah -p1 -t"Experience is suddenly easier to come by!" misc_avatar_boon_experience = \
    /sendBoonNote An experience boon is in effect.
/def -mglob -ah -p1 -t"Your spells now last longer in this world!" misc_avatar_boon_spell_duration = \
    /sendBoonNote Spell duration has been moderately increased!
/def -mglob -ah -p1 -t"The gods smile, and bestow the realm with increased mana!" misc_avatar_boon_mana_regen = \
    /sendBoonNote A Mana regeneration boon is in effect.

;;; ----------------------------------------------------------------------------
;;; Exit handling
;;; ----------------------------------------------------------------------------
/def -mregexp -p9 -t"^\[Exits\:(( north(->closed)*| east(->closed)*| south(->closed)*| west(->closed)*| up(->closed)*| down(->closed)*)+)\]$" current_exists = \
    /set exits=%;\
    /let _exits=$[strip_attr({P1})]%;\
    /mapcar /setExits %{_exits}%;\
    /set exits=[%{exits}]
/def -mregexp -p9 -t"^\[Exits: No Obvious Exits\]$" current_exits_none = /set exits=[None]

/def -i setExits = \
    /let _currDir=%{1}%;\
    /if ({_currDir} =/ "*closed") /let _currDir=$[toupper({_currDir})]%;/endif%;\
    /set exits=%{exits}$[substr({_currDir}, 0, 1)]


