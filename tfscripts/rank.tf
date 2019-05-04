;;; rank.tf
;;;
;;; Steps to get the ranks:
;;;	1.) /lordlist - to go through lordlist and put all lords names in a file.
;;; 2.) /herolist - to go through herolist and put all heros names in a file.
;;; 3.) /readlasts - take output from "/lordlist" and "/herolist" and create a list to
;;;         be read back into tf to run "last" commands on all heros.
;;;	4.) /highest - Add characters from "help highest" list.
;;;	5.) /tally - Tally character info as they level.
;;; 6.) /rank <who> <channel> - get rank for <who> and display on <channel>
/load -q settings.tf

/set lordlistFile=lordlist.dat
/set herolistFile=herolist.dat
/set charlastFile=avatarcharlast.dat
/set charFile=avatarChars.dat
/set findFile=findThis.dat
/set resultFile=countres.dat
/set tallyFile=tally.dat
/set deleteFile=deletes.dat
/set highestFile=highest.dat
/set toprankFile=toprank.dat
/set levelsFile=charlevels.dat

;;; /lordlist to log the help lordlist file
/def lordlist = \
    /sys rm -f %lordlistFile %lordlastFile %; \
    /log %lordlistFile  %; \
    help lordlist

;;; /herolist to log the help herolist file
/def herolist = \
    /sys rm -f %herolistFile %herolastFile %; \
    /log %herolistFile  %; \
    help herolist %; \
    /repeat -00:00:30 1 /log off %; \
    /repeat -00:00:31 1 /echo -pw %% @{hCgreen}Hero list has been captured.@{n}

/def -mregexp -t'See also WIZLIST, HELP RETIRED, HELP GUESTS, HEROLIST' endlordlist = \
    /log off %; \
    /repeat -0:0:02 1 /echo -pw %% @{hCgreen}Lord list has been captured.@{n}

/set tallyrank=0

;;; Output format: Tier,Name,Race,Level,Class
;;; Hero/Lord Params: 1 - Name, 2 - Race, 3 - Level, 5 - Hero/Lord, 6 - Class
;;; Lowmort Params: 1 - Name, 2 - Race, 3 - Level, 5 - Class
;;; Legend Params: 1 - Name, 2 - Race, 3 - Lord Level, 5 - Class, 6 - Legend Level
/def rankon = \
    /send config -prompt%; \
    /set tallyrank=1 %; \
    /def -mregexp -ag -t'was last logged in [on|from].*' gag_lastline2%; \
    /def -mregexp -p8 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord) ([A-Za-z ]+), was born" last_char_trig = \
        /sys echo %%P5,%%P1,%%P2,%%P3,%%P6 >> %charFile%; \
    /def -mregexp -p9 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level Lord ([A-Za-z ]+) \(Legend ([0-9]+) .*\)," last_lgnd_char_trig = \
        /sys echo Lord,%%P1,%%P2,%%P3,%%P5 >> %charFile%; \
    /def -ag -mregexp -p8 -t"^([A-Za-z]+) doesn't exist on this Realm as a player\." char_notexist = \
        /sys echo Lowmort,%%P1,delete,000,delete >> %charFile%; \
    /def -mregexp -F -p7 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level ([A-Za-z ]+), was born" last_lowmort_trig = \
        /sys echo Lowmort,%%P1,%%P2,%%P3,%%P5 >> %charFile

/def rankoff = \
    /if ({tallyrank} = 1) \
        /set tallyrank=0%; \
        /undef gag_lastline2 %; \
        /undef last_char_trig %; \
        /undef last_lgnd_char_trig %; \
        /undef char_notexist %; \
        /undef highest_char_trig %; \
        /undef last_lowmort_trig %; \
        /send config +prompt%; \
    /endif

;;; /highest adds the "help highest" to the "highest last char" file
;;; /readhighest does last on them, preparing for update.
/def highest = \
        /sys rm -f %highestFile%; \
        /def -mregexp -t"(Mag|Pal|Arc)-([a-zA-Z]+)[ ]+(Cle|Ran|Sor)-([a-zA-Z]+)[ ]+(Rog|Psi|Prs)-([a-zA-Z]+)[ ]+(War|Mon|Asn)-([a-zA-Z]+)" highest_char_trig = \
                /if ({P2} !~ "vacant") /let highestLine=%%P2%%; /endif %%; \
                /if ({P4} !~ "vacant") /let highestLine=%%highestLine %%P4%%; /endif %%; \
                /if ({P6} !~ "vacant") /let highestLine=%%highestLine %%P6%%; /endif %%; \
                /if ({P8} !~ "vacant") /let highestLine=%%highestLine %%P8%%; /endif %%; \
		/if ({highestLine} !~ "") /sys echo %%highestLine >> %highestFile%%; /endif%; \
        /repeat -00:00:05 1 help highest

/def readhighest = \
    /rankon %; \
    /set tallylevels=0%; \
    /sys rm -f %charFile %; \
    /quote -1 last '"%highestFile"
;;; Read in and gather information about the heros class/race/level
/def readlasts2 = \
    /rankon %; \
    /sys rm -f %charFile %; \
;    /sys perl buildLast.pl %; \
    /sys buildLast.pl %; \
    /repeat -0:0:10 1 /quote -1 last '"%charlastFile"
;	/sys perl ranksort.pl

;;; Read in and gather information about the heros class/race/level
;;; This version uses names generated from the database.
/def readlasts = \
    /rankon %; \
    /set tallylevels=0%; \
;    /sys perl getnames.pl %*%; \
    /sys getnames.pl %*%; \
    /sys rm -f %charFile %; \
    /repeat -0:0:10 1 /quote -1 last '"%charlastFile"

;;; /rank <character> <channel> to start the search
/def rank-old = \
	/rankoff %; \
	/let findavachar=$(/first %{*})%; \
	/let displaychan=$(/rest %{*})%; \
        /sys rm -f %findFile %; \
        /def -F -ag -n1 -mregexp -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Lord|Hero|Titan|Legend| ) ([A-Za-z ]+), was born" last_%{1}_trig = \
        	/let rName=%%P1%%;/let rRace=%%P2%%;/let rLevel=%%P3%%;/let rTier=%%P5%%;/let rClass=%%P6%%; \
        	/sys echo %%rTier > %findFile %%; \
        	/sys echo %%rName >> %findFile %%; \
        	/sys echo %%rRace >> %findFile %%; \
        	/sys echo %%rLevel >> %findFile %%; \
        	/sys echo %%rClass >> %findFile %; \
        /send last %{findavachar} %; \
        /repeat -0:0:05 1 /sys rank.pl %; \
        /repeat -0:0:05 1 /quote %{displaychan} '"%resultFile"

/def rank = \
    /let findavachar=$(/first %{*})%;\
    /let displaychan=$(/rest %{*})%;\
    /quote -S /set charrank=!php charrank.php %{findavachar} %;\
    /eval %{displaychan} %{charrank}
;/def rank = \
;    /let findavachar=$(/first %{*})%;\
;    /let displaychan=$(/rest %{*})%;\
;    /sys php charrank-outfile.php %{findavachar} %;\
;    /repeat -0:0:01 1 /quote %{displaychan} '"%resultFile"


;;; /top [-o channel] [-r race] [-c class] [-t tier] [-n max rank]
/def top = \
    /sys rm %toprankFile%; \
;    /sys perl toprank.pl %*%; \
    /sys toprank.pl %*%; \
    /repeat -0:0:03 1 /quote '"%toprankFile"

;;; /clev [-o channel] character names
;;; Echoes character levels to [channel] (gtell by default)
/def clev = \
    /sys rm %levelsFile%; \
;    /sys perl charlevels.pl %*%;\
    /sys charlevels.pl %*%;\
    /repeat -0:0:03 1 /quote '"%levelsFile"
/def xlev = /clev -x %*
/def grlev = /clev %grouplist -o gt
/def grxlev = /clev -x -o gt %grouplist
/def mylev = /clev Jekyll AshA Bauchan Duskrta Eronak Feir Ganik Gengis Gouki Granuja Helfyre Iratavo Kaboo Keiko Kromlee Mahal Maxine Muerte Odium Paxon Phenyx Ronco Rygar Skia Tanzah Tahn Tiati Torvald Verlegenheit Xurukk
/def infolev = \
	/let infotier=Hero%; \
	/if ({1} !~ "") /let infotier=%1%; /endif %; \
	/send playerinfo clear%; \
	/clev -t %infotier -o "playeri +" %*
/def tagsite = playeri + |w|Check out: |c|http:///www.shellprompt.co.uk/~mbm |w|(- is tilde sign)

/def clevalts = \
    /if ({P2} !~ "") /quote -S /clev !php listalts.php %{P1} -o "%{P2}"%; \
    /else /quote -S /clev !php listalts.php %{P1}%; \
    /endif
/def xlevalts = \
    /if ({P2} !~ "") /quote -S /clev !php listalts.php %{P1} -x -o %P2%; \
    /else /quote -S /clev -x !php listalts.php %{P1}%; \
    /endif

;;; Macro to update chars from flat file into DB.
/def updatedb = \
	/let updfile=%1%;\
        /let forceUpdMax=%2%;\
	/echo -pw %% @{Ccyan}Updating characters to database from file: @{Cyellow}%updfile@{Ccyan}.@{n}%;\
	/echo -pw %% @{Ccyan}To ensure accuracy in other scripts, remove first line of %charFile.%; \
;	/sys perl updatechars.pl %updfile%; \
        /sys updatechars.pl %updfile %forceUpdMax%; \
	/sys rm -f %updfile
;	/sys ./avatarchars.bash

/def updatechars = /updatedb %charFile 1
/def updatetally = \
    /let forceupdmax=1%;\
    /if ({#} > 0) /let forceupdmax=1%;/endif%;\
    /updatedb %tallyFile %forceupdmax
;;; When F3 is pressed update db from file.
/def updtal = /if ({tallylevels} = 1) /updatetally%;/else /updatechars%;/endif
;/def key_f3 = /updtal

;;; Macro to tally characters from alt_list table.
/def updchars = /quote -S /tal !php listalts.php %{1}

;;; A macro to add a new person to the tally.dat file
/def -i addtally = \
    /def -mregexp -n1 -ag -t"%1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord|Titan|Legend) ([A-Za-z ]+), was born" tally_%{1}_trig = \
        /sys echo %%P4,%1,%%P1,%%P2,%%P5 >> %tallyFile%; \
    /def -mregexp -ag -n1 -p4 -t'was last logged in [on|from].*' gag_%{1}_levelline2%;\
    /send last %1
/def -i addLMtally = \
    /def -mregexp -n1 -p4 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level ([A-Za-z ]+), was born" tally_%{1}_lowmort_trig = \
        /sys echo Lowmort,%%P1,%%P2,%%P3,%%P5 >> %tallyFile%; \
    /def -mregexp -ag -n1 -t'was last logged in [on|from].*' gag_%{1}_levelline2%;\
    /send last %1
/def tal = /while ({#}) /addtally %1 %; /shift %; /done
/def lmtal = /while ({#}) /addLMtally %1 %; /shift %; /done
/alias tal /tal %*

;;; A trigger to gather hero/lord levels from hero info and output them
;;; to be updated later.
/def tally = \
	/toggle tallylevels %; \
	/if ({tallylevels} = 1) \
		/rankoff%; \
;		/sys rm -f %tallyFile%; \
;		/def -mregexp -p0 -ag -t'was last logged in [on|from].*' gag_levelline2%; \
	/else \
		/undef gag_levelline2%; \
	/endif %; \
	/echoflag %tallylevels @{Ccyan}Tally Character Levels@{n}

;; April 4, 2005: Altered the tally trigger to only tally for < Hero 200 since
;;                  anything Hero 200 or greater can be accessed via herolist.
/def -ag -mregexp -F -p5 -t"\[HERO INFO\]\: ([a-zA-Z]*) has just increased in power to (Hero|Lord|Titan|Legend) Level ([0-9]*)\!" level_tally = \
    /if ({tallylevels} = 1 & {P2} =~ "Hero" & {P3} <= 200) \
;	/if ({tallylevels} = 1 & ({P2} =~ "Hero" | {P2} =~ "Lord")) \
;		/def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord|Titan|Legend) ([A-Za-z ]+), was born" tally_%{P1}_trig = \
;                	/sys echo %%P4,%P1,%%P1,%%P2,%%P5 >> %tallyFile %; \
;	    	/send last %P1 %; \
        /addtally %P1%;\
    /elseif ({tallylevels} = 1) \
       /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update avatar_chars set char_level = %P3,  char_tier = '%P2' where char_name = '%P1'"%;\
    /endif

;; June 5, 2007 -- Added host trigger for gathering char data
;/def -mregexp -t"\[HOSTSR INFO\]\: ([a-zA-Z]+) \(.*\) has connected, (51|125|250)\(([0-9]+)\)\." tally_from_connect = \
;    /let cPlayer=%P1%;/let cTier=%P2%;/let cLevel=%P3%;\
;    /if ({tallylevels} = 1) \
;        /if ({cTier} = 51 & {cLevel} <= 200) \
;            /tal %{cPlayer}%;\
;        /elseif ({cTier} >= 51) \
;            /if ({cTier} = 51) /let sTier=Hero%;\
;            /elseif ({cTier} = 125) /let sTier=Lord%;\
;;            /elseif ({cTier} = 250) /let sTier=Legend%;\
;;            /elseif ({cTier} = 500) /set sTier=Titan%;\
;            /endif%;\
;            /quote -S /echo !mysql -u %{DB_USERNAME} --password=%{DB_PASSWORD} %{DB_NAME} -s -e "update avatar_chars set char_level = %cLevel,  char_tier = '%sTier' where char_name = '%cPlayer' and char_level <> %cLevel"%;\
;        /endif%;\
;    /endif
;; September 2010 - Re-added the trigger but with just the /tal option for heroes since the !mysql command is not functional on the shell
/def -mregexp -t"\[HOSTSR INFO\]\: ([a-zA-Z]+) \(.*\) has connected, (51|125|250)\(([0-9]+)\)\." tally_from_connect = \
    /if ({tallylevels} = 1 & ({P2} = 51 | {P2} = 125)) \
        /tal %{P1}%;\
    /endif

;; Legend morph
/def -ag -mregexp -F -p5 -t"\[HERO INFO\]: (.*) successfully morphs from Lord ([0-9]+) to become Legend (.*)\." legendary_morph = \
    /if ({tallylevels} = 1) \
;       /def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a 1st level Legend ([A-Za-z ]+), was born" tally_${P1}_trig = \
;          /sys echo Legend,%P1,%%P1,1,%%P2 >> %tallyFile %; \
;          /send last %P1%; \
        /addtally %P1%;\
    /endif%; \
    /echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}just ascended from level @{hCyellow}%P2@{nCred}.@{n}
/def -ag -mregexp -F -p5 -t"\[HERO INFO\]\: ([A-Za-z]+) successfully morphs from Hero ([0-9]+) to become (Lord|Lady) ([A-Za-z]+)\." lordly_morph = \
;    /if ({tallylevels} = 1) \
        /def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord) ([A-Za-z ]+), was born" tally_%{P1}_trig = \
            /sys echo Hero,%P1,%%P1,%P2,%%P5 >> %tallyFile %%; \
            /sys echo Lord,%P1,%%P1,1,%%P5 >> %tallyFile %; \
        /send last %P1 %; \
;    /endif%; \
    /echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}just morphed from level @{hCyellow}%P2@{nCred}.@{n}

/def -mregexp -ag -p5 -F -t"\[HERO INFO\]\: There is a disturbance in the realm as ([a-zA-Z]+) fails to become a Lord at sublevel ([0-9]+)\." char_morphfail = \
;	/if ({tallylevels} = 1) \
        /def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord) ([A-Za-z ]+), was born" tally_%{P1}_trig = \
            /sys echo %%P4,%P1,%%P1,%P2,%%P5 >> %tallyFile %%; \
            /sys echo %%P4,%P1,%%P1,%%P2,%%P5 >> %tallyFile %; \
        /send last %P1 %; \
;	/endif%; \
	/echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}failed morph at level @{hCyellow}%P2@{nCred}.@{n}

/def -ag -mregexp -p5 -t"\[HERO INFO\]\: ([A-Za-z]+) has just made level 51\!" char_newhero = \
;    /if ({tallylevels} = 1) \
;        /def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level Hero ([A-Za-z ]+), was born" tally_%{P1}_trig = \
;            /sys echo Hero,%P1,%%P1,%%P2,%%P4 >> %tallyFile%; \
;        /send last %P1 %; \
        /addtally %P1%;\
;    /endif%; \
    /echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}just heroed.@{n}

;/def -ag -mregexp -p5 -t"\[HERO INFO\]\: ([A-Za-z]+) has become [a|an] (.*)\." char_newprestige = \
;    /if ({tallylevels} = 1) \
;        /def -mregexp -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a 50th level (.*), was born" tally_%{P1}_trig = \
;            /sys echo Lowmort,%P1,%%P1,50,%%P2 >> %tallyFile%; \
;        /send last %P1 %; \
;        /addLMtally %P1%;\
;    /endif%; \
;    /echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}has become @{hCyellow}%P2@{nCred}.@{n}
        
/def -ag -mregexp -p5 -t"\[HERO INFO\]\: ([A-Za-z]+) has become [a|an] (.*)\." char_newprestige = \
    /if /!ismacro gag_prclastline%; /then \
        /def -mregexp -ag -n1 -t'was last logged in [on|from].*' gag_prclastline%; \
    /endif%;\
    /def -mregexp -p5 -n1 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level Hero ([A-Za-z ]+), was born" %{P1}_heroprestige = \
        /sys echo Hero,%%P1,%%P2,%%P3,%%P6 >> %tallyFile%%;/undef %{P1}_lmprestige%; \
    /def -mregexp -F -p4 -n1 -ag -t"%P1 the ([-A-Za-z ]+) is a 50th level (.*), was born" %{P1}_lmprestige = \
        /sys echo Lowmort,%P1,%%P1,50,%%P2 >> %tallyFile%%;/undef %{P1}_heroprestige%; \
    /send last %P1 %; \
    /echo -pw @{Cred}[HERO INFO]: @{hCcyan}%P1 @{nCred}has become @{hCyellow}%P2@{nCred}.@{n}

/def -mregexp -ag -p5 -t"\[IMM INFO\]: ([A-Za-z]+) has remorted into a .*\." char_remort = \
    /addLMtally %P1
