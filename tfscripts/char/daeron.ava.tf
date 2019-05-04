;; daeron.ava.tf
;; 2004/04/26: Created + promoted to Design Trackie by Crom.
;; 2005/08/20: Promoted to Acolyte by Cerdwyn.
;; 2005/09/09: Promoted to Demigod by Cerdywn.
;; 2005/10/29: Promoted to Immortal by Cerdwyn/Kariya.
;; 2006/04/24: Promoted to Deity by Cerdwyn.
;; 2007/06/01: Promoted to Host Senior.
/load -q ../settings.tf

/set daeron_quest_dir=../Design/quest
/set daeron_restore_dir=../Design/restore
/set mytier=imm
/set mylevel=Host

/if ({autoloot}=1) /autoloot%;/endif
;; track all chan
/alias tc _ %*

;; dch design track chan
/alias dch /send \\\d %*
/alias wch /send \\\w %*
/alias qch /send \\\q %*
/alias tc /send \\\ %*

/alias grin \
    /if ({myname} =~ "daeron" & {#} = 0) /send emote |by| grins|base|.%; \
    /else /send grin %*%; \
    /endif

/alias smile \
    /if ({myname} =~ "daeron" & {#} = 0) /send emote |bc| smiles|base|.%; \
    /else /send grin %*%; \
    /endif

/alias corpsenote \
    /if ({#} = 1) \
        board 2%;\
        note clear%;\
        note to %1 Immortal%;\
        note subject Your rotting corpse%;\
        note + Your corpse is in cold storage, see an Imm to retrieve it.%;\
        note show%;\
    /else /echo -pw %%% @{Cred}Must specify recipient.@{n}%;\
    /endif

/def mkcoffee = \
    /for i 1 %{1} \
        oload 17527 52%%;\
        ioset cup name large cup hot coffee%%;\
        ioset hot extra 32768%%;\
        ioset hot short |w|a large cup of hot coffee|n|%%;\
        ioset hot long |y|A steaming hot cup of coffee sits here, waiting for you to drink it.|n|%%;\
        ioset hot adesc |y|You take a swig of Daeron's specially brewed java.  |by|aaAAaaAAaahhh!

/def coffee = \
    config -prompt%;\
    /while ({#}) \
        /mkcoffee 1%;\
        at %1 give hot %1%;\
        at %1 coffee %1%;\
        /shift%;\
    /done%;\
    config -prompt

/def -mregexp -wdaeron -t"([a-zA-Z]+) hands you a cup of a strong black liquid. You sniff it cautiously.  Coffee\!\!" coffee_handout = \
    /mkcoffee 1%;give "large cup hot coffee" %{p1}

;;; Force linkdead to quit if non-afk
/def -mregexp -wdaeron -p2 -t"Alts are:\(LD\)([a-zA-Z]+)" ld_force_quit = \
    /send -wdaeron force %p1 quit

;;;
/def mstat = \
    /def -mregexp -wdaeron -ah -n1 -t"^Short description: (.*)" mobstat_short_desc = \
        /send gt %%P1: |r|%%{mobstathp}|w|/|br|%%{mobstathpmax} %%{mobstathpperc} |w|hp |y|%%{mobstatmana}|w|/|by|%%{mobstatmanamax} |w|mana%%;\
        /unset mobstathp%%;/unset mobstathpmax%%;/unset mobstatmana%%;/unset mobstatmanamax%;\
    /def -mregexp -wdaeron -ah -n1 -t"^Hp:      ([0-9]+) / ([0-9]+)   Mana:   ([0-9]+) / ([0-9]+)   Mv:  ([0-9]+) / ([0-9]+)" mobstat_stats = \
        /set mobstathp=%%P1%%;/set mobstathpmax=%%P2%%;\
        /set mobstatmana=%%P3%%;/set mobstatmanamax=%%P4%;\
    /send mstat %*
/def -mregexp -t"Timer:[ ]+([0-9]+)[ ]+Prac:[ ]+([0-9]+)[ ]+Bank:[ ]+([0-9]+)" mstat_timer_calc =\
    /set seconds=$[{p1}*{ticksize}]%;\
    /echo -pw @{Cgreen}Idle time: @{hCred}$[seconds/86400] @{xCgreen}days @{hCred}$[mod(seconds/3600,24)] @{xCgreen}hours \
        @{hCred}$[mod(seconds/60,60)] @{xCgreen}mins @{hCred}$[mod(seconds,60)] @{xCgreen}secs.

;;; Morph triggers/gags
/def -wdaeron -ag -msimple -t"      New        Old" gag_new_old
/def -wdaeron -ag -msimple -t"   --------    --------" gag_new_old_line
/def -ag -mregexp -wdaeron -t"^(Hp|Ma|Mv):[ ]+([0-9]+)[ ]+([0-9]+)$" morph_stats_other = \
    /quote -S /set morphMultiplier=!perl div.pl %P2 %P3 %; \
    /echo -p @{Cred}%P1: %P3 -> %P2 (@{Cwhite}Multiplier: @{Cgreen}%{morphMultiplier}@{Cred})

;;; Newbie aliases
/alias newb /send nchat Welcome to Avatar %1!
/alias newbq /send say Any time you have any questions, feel free to ask on "NCHAT" or see if an Angel or Imm is available on "PRAY".
/alias newbhelps /send say We have many helpfiles that you can refer to. For examples, type "HELP A", "HELP B", etc..'
/alias newbhelps2 /send say It is a good idea to scan some of the help files before you start  exploring, especially "HELP MUDGRAD", "HELP MEADOW" and "HELP LEVELING GEAR".
/alias prom promote %1%;/send nchat Hey!  We have a new mudschool grad.  All say hello to %1!%;say Good luck, and have fun!
/alias newbgl /send say Good luck, and have fun!

;;; Macro to create a brainfreeze potion from a orange-red vial (lvl 0) or a 
;;;  glacial milk (lvl 51), or a glowing vial (level 125)
/def mkbfreeze125 = \
    oload 120 125%;\
    ioset glowing name large cold! liquid vial%;\
    ioset cold short |w|a large vial of cold liquid|n|%;\
    ioset cold long You see a large vial of liquid, cold to the touch.%;\
    ioset cold adescr AAARRGH! |bc|Brainfreeze!|n|%;\
    ioset cold edescr cold
/def mkbfreeze51 = \
    oload 14253 51%;\
    ioset glacial name cold! liquid vial%;\
    ioset cold short |w|a vial of cold liquid|n|%;\
    ioset cold long You see a vial of liquid, cold to the touch.%;\
    ioset cold adescr AAARRGH! |bc|Brainfreeze!|n|%;\
    ioset cold edescr cold
/def mkbfreeze = \
    oload 104 0%;\
    ioset orange-red name small cold! liquid vial%;\
    ioset cold short |w|a small vial of cold liquid|n|%;\
    ioset cold long You see a small vial of liquid, cold to the touch.%;\
    ioset cold adescr AAARRGH! |bc|Brainfreeze!|n|%;\
    ioset cold edescr cold

;;; Create a Kool-Aid fountain (/mkkoolaid [colorcode=br])
/def mkkoolaid = \
    /if ({1} =~ "") /let fountainColor=br%;/else /let fountainColor=%{1}%;/endif%;\
    oload 30324%;get fountain%;\
    ioset fountain name kool-aid fountain%;\
    ioset kool-aid short A |%{fountainColor}|Kool-Aid|n| fountain%;\
    ioset kool-aid long A |%{fountainColor}|Kool-Aid|n| fountain flows from the ground.%;\
    /send ioset kool adescr \$n guzzles some |%{fountainColor}|Kool-Aid |n|and \$e exclaims, '|%{fountainColor}|Oh Yeah!|n|'

;;; silly aliases
/def wiggle = \
    /echo -p %%% @{Cred}rwig [character]@{n}  - @{hCblue}You feel your brain wiggling.@{n}%;\
    /echo -p %%% @{Cred}rwig2 [character]@{n} - @{hCyellow}You feel Daeron wiggling your brain.@{n}%;\
    /echo -p %%% @{Cred}rwig3 [character]@{n} - @{hCblue}Daeron wiggles his brain at you.@{n}%;\
    /echo -p %%% @{Cred}ewig@{n}              - @{hCblue}You feel your brain wiggling.@{n}%;\
    /echo -p %%% @{Cred}ewig2@{n}             - @{hCyellow}Daeron wiggles his brain at you.@{n}
/alias rwig \
    /if ({#} = 0) recho |bb|You feel your brain wiggling.%;\
    /else at %1 recho |bb|You feel your brain wiggling.%;/endif
/alias rwig2 \
    /if ({#} = 0) recho |by|You feel Daeron wiggling your brain.%;\
    /else at %1 recho |by|You feel Daeron wiggling your brain.%;/endif
/alias rwig3 \
    /if ({#} = 0) recho |bb|Daeron wiggles his brain at you.%;\
    /else at %1 recho |bb|Daeron wiggles his brain at you.%;/endif
/alias ewig echo |bb|You feel your brain wiggling.|n|
/alias ewig2 echo |by|Daeron wiggles his brain at you.|n|

/alias xfer \
    /if ({#} < 2) \
        /echo -p %%% @{hCred}Syntax: @{xCwhite}xfer @{hCyellow}Who@{n} @{hCyellow}Where@{n}%;\
    /else \
        recho |w| Look out |c|%2|w|, here comes |bc|%1|w|!%;\
        transfer %1 %2%;\
    /endif

;;; Aliases to set long descriptions that I like.
/alias mylongvoices mset daeron long |bb|You hear voices in your head.|n|
/alias mylongeyes mset daeron long |y|You notice three eyes glaring at you from the shadows.|n|

;;; jar/witchtrap aliases
/alias witchtrap \
    /if ({#} = 0) /echo -p @{Cred}Syntax: @{Cwhite}witchtrap PLAYERNAME%;\
    /else jar %1 30693%;\
    /endif
/alias dungeon \
    /if ({#} = 0) /echo -p @{Cred}Syntax: @{Cwhite}dungeon PLAYERNAME%;\
    /else \
        /let jar_vnums=30603 30604 30606 30607 30609 30610 30613 30614 30616 30617 30619 30620%;\
        /let tojarnum=$(/rand 12)%;\
        /let tojar=$(/nth %{tojarnum} %{jar_vnums})%;\
        jar %1 %tojar%;\
    /endif

;;; namethank macroes
/def -mregexp -p1 -wdaeron -t"\[IMM INFO\]\: Daeron has just namethanked ([a-zA-Z]+)!" daeron_namethank = \
    /sys echo %P1 >> char/.namethank.daeron.dat
/def chkthank = /while ({#}) /sys grep -i %1 char/.namethank.daeron.dat%;/shift%;/done
/alias namethank /while ({#}) /send namethank %1%;/shift%;/done

;;; Check duplicates
;;; /chkdupe char1 char2 char3
/def chkdupe = \
	/send config -prompt%;\
    /while ({#})\
        /echo -p @{Cwhite}Checking Duplicates for: @{hCgreen}%1@{xCwhite}.@{n}%;\
        /send duplicate list %1%;\
        /shift%;\
    /done%;\
   	/send config +prompt%;\

;;; Load Quest-related macros
/def lgreed = /load -q %{daeron_quest_dir}/greed.tf
/def lroulette = /load -q %{daeron_quest_dir}/roulette.tf
/def lud = /load -q %{daeron_quest_dir}/ud.tf
/def limmhog = /load -q %{daeron_quest_dir}/immhog.tf

;; /note [Message]
;;      Build a sticky note with the given message
;;      Note is set to imm level, it is invis, inventory, and nolocate.
;; /otal Player1 Player2 ... PlayerN
;;      Build a sticky note for characters to add to db.
/def note = \
    oload 2400%;\
    ioset note name yellow sticky note%;\
    ioset sticky short |y|A Sticky note|n|%;\
    ioset sticky extra +32%;\
    ioset sticky extra +8192%;\
    ioset sticky extra +131072%;\
    ioset sticky owner Daeron%;\
    ioset sticky long |w|%*|n|

;;; Stored restores
/def restore = \
    /echo -p %%% @{Cred}restore@{Cyellow}voices@{n}, @{Cred}restore@{Cyellow}eye@{n}, \
    @{Cred}restore@{Cyellow}snoweye@{n}, @{Cred}restore@{Cyellow}snowtongue@{n},%;\
    /echo -p %%% @{Cred}restore@{Cyellow}wavehello@{n}, @{Cred}restore@{Cyellow}wavebye@{n}, \
    @{Cred}restore@{Cyellow}wiggle@{n}, @{Cred}restore@{Cyellow}tic@{n}%;\
    /echo -p %%% @{Cred}restore@{Cyellow}wednesday@{n}, @{Cred}restore@{Cyellow}udloss@{n}, \
    @{Cred}restore@{Cyellow}udvictory@{n}%;\
    /echo -p %%% @{Cred}restore@{Cyellow}crazy@{n}

/set daeron_restore_dir=../Design/restore
/def restorevoices = /quote -5 '"%{daeron_restore_dir}/daeron.restore2.txt"
/def restoreeye = /quote -5 '"%{daeron_restore_dir}/daeron.restore1.txt"
/def restoresnoweye = /quote -8 '"%{daeron_restore_dir}/daeron.restore.snow.txt"
/def restoresnowtongue = /quote -3 '"%{daeron_restore_dir}/daeron.restore.snow2.txt"
/def restorewavebye = /quote -3 '"%{daeron_restore_dir}/daeron.restore.wavebye.txt"
/def restorewavehello = /quote -3 '"%{daeron_restore_dir}/daeron.restore.wavehello.txt"
/def restorewiggle = /quote -1 '"%{daeron_restore_dir}/daeron.restore.wiggle.txt"
/def restoretic = /quote -1 '"%{daeron_restore_dir}/daeron.restore.missedtic.txt"
/def restorewednesday = /quote -2 '"%{daeron_restore_dir}/daeron.restore.wednesday.txt"
/def restoreudloss = mset daeron short An Ultimate Dragon Victory=restore all=mset daeron short Daeron
/def restorecrazy = /quote -1 '"%{daeron_restore_dir}/restore.crazy.txt"


;; Fix UC Chars...
/def renchar = \
    /if ({#} = 2) \
        /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update avatar_chars set char_name = '%2' where char_name = '%1'"%;\
        /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update char_max_levels set name = '%2' where name = '%1'"%;\
        /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update alt_list set name='%2' where name='%1'"%;\
        /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update alt_list set main_alt='%2' where main_alt='%1'"%;\
    /else /echo -pw @{hCwhite}/fixucchar OldName NewName@{n}%;\
    /endif

;; Testport stuff
/def -mglob -p1 -wdaeronii -t"Reboot by DaeronII." testport_reboot = \
   /tickoff

;; Heal the dead if on cloud
/def -wdaeron -F -p10 -ag -mregexp -t"^\[DEATH INFO\]: ([a-zA-Z]+) killed by (.+) in (.+) \(([0-9]+)\)\." _death_deathinfo = \
    /if ({room_vnum}=8179) \
        /repeat -00:00:60 1 /myundef _div_%p1_dead%;\
        /send last %{p1}%;\
        /def -Fp10 -mregexp -ag -n1 -t'was last logged in [on|from].*' _drone_gag_lastline%;\
        /def -p8 -mregexp -n1 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level ([A-Za-z ]+), was born" _div_%{p1}_dead = \
            /send c divinity %p1=c bless %p1=c 'holy sight' %p1%;\
    /elseif ({room_vnum}=5369) \
        /repeat -00:00:60 1 /myundef _comf_%p1_lord%;\
        /send last %{p1}%;\
        /def -Fp10 -mregexp -ag -n1 -t'was last logged in [on|from].*' _drone_gag_lastline%;\
        /def -Fp10 -mregexp -n1 -ag -t"%p1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level Lord ([A-Za-z ]+), was born" _comf_%{p1}_dead = \
            /send c comfort %p1%;\
    /endif

/def -wdaeron -F -p10 -ag -mregexp -t"^\[DEATH INFO\]: ([a-zA-Z]+) has chosen to expire in (.+) \(([0-9]+)\)\." _drown_deathinfo = \
    /if ({room_vnum}=8179) c divinity %p1%;/endif
