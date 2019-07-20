;;; ---------------------------------------------------------------------------
;;; groupstats.tf
;;;     Triggers/macroes to tally group class info; groupie hp/mana status;
;;;     and lotto winners.
;;;    /glast           - gather "last" info to see what classes are in the group.
;;;    /grp [class|race|"class"|"race"]    - Show what classes are in group.
;;;                     - if class is given, shows who in group is that "class"
;;;                     - if race is given, shows who in group is that "race"
;;;    /gwho            - Group class breakdown.
;;;    /grphp [class]   - If class given, shows hp for class; no param shows
;;;              brute hp breakdown.
;;;    /grpmn [class]   - If class given, shows mana for class; no param shows
;;;              caster mana breakdown
;;;    /hp <char>       - Shows hp status for <char>
;;;    /mana <char>     - Shows mana status for <char>
;;;    /mv <char>       - Shows mv status for <char>
;;;    /hpmn <char>     - Shows hp and mana status for <char>
;;;    /tnl <char>      - Shows tnl status for <char>
;;; ---------------------------------------------------------------------------
/set classlist=Archer Assassin Berserker Black_Circle_Initiate Bladedancer Bodyguard Cleric Druid Fusilier Mage Mindbender Monk Paladin Priest Psionicist Ranger Rogue Shadowfist Soldier Sorcerer Stormlord Warrior Wizard
/set racelist=Black_Dragon Blue_Dragon Centaur Cloud_Giant Cyborg Deep_Gnome Demon Demonseed Devil Draconian Dragon Drow Duergar Dwarf Dust_Imp Elf Ent Firedrake Gargoyle Giant Gnome Goblin Golem Fire_Giant Frost_Giant Green_Dragon Griffon Half_Elf Half_Orc Halfling High_Elf Hobgoblin Human Kobold Kzinti Lesser_Elemental Lizard_Man Minotaur Miraar Ogre Orc Pain_Elemental Pyro_Imp Slug Sprite Troglodyte Stone_Giant Troll True_Fae Tuataur Verbit Verburg Verbull Vapor_Imp Varbin Varsil Wave_Imp White_Dragon
/set remortclasslist=Priest Ranger Sorcerer Paladin Assassin Berserker
/set remortracelist=Black_Dragon Blue_Dragon Cloud_Giant Demon Demonseed Devil Dragon Fire_Giant Frost_Giant Green_Dragon Griffon Hobgoblin Minotaur Sprite Stone_Giant Troll Golem High_Elf True_Fae Tuataur White_Dragon
/set prestigelist=Black_Circle_Initiate Bladedancer Bodyguard Druid Fusilier Mindbender Shadowfist Soldier Stormlord Wizard
/eval /set remortlist=%remortclasslist %remortracelist
/set remortclassabblist=prs ran sor pal asn bzk
/set remortraceabblist=dem dsd dev drg fae grf hob min mir spr trl gol hie tua

/set healerlist=Cleric Druid Paladin Priest
/set casterlist=Mage Mindbender Psionicist Sorcerer Wizard
/set tanklist=Berserker Black_Circle_Initiate Bladedancer Monk Paladin Ranger Shadowfist Warrior
/set stabberlist=Assassin Black_Circle_Initiate Rogue

;;; my alts variable
/quote -S /set my_alts=!%{script_path}listalts.py jekyll

;;; macro to echo the group spam.  Toggle it with /gspam
/set gspam=1
/def gspam = \
    /toggle gspam%;\
    /echoflag %gspam @{Cyellow}Group Spam@{n}%; \
    /if ({gspam} = 1) /send group%; /endif
/def echogroup = /if ({gspam} = 1) /echo -pw %{*}@{n}%; /endif

/def -ag -mglob -t"As a group leader, you can lead a group size of *." group_lead_size

/def -ag -mregexp -t"([a-zA-Z]+)'s group: *([a-zA-Z\ ]*)$" group_leader = \
    /if ({gspam} = 1) \
        /echo -pw @{Cwhite}%{P1}'s @{Cgreen}group: @{Cyellow}%{P2}@{n}%;\
    /endif%;\
    /set grpnum=0 %; \
    /set chkgrp=0 %; \
    /set counter=0 %; \
    /grpstatreset %classlist %racelist%; \
    /unset groupies %; \
    /unset grouplist%;\
    /eval /sys echo leader: %{P1} talent: %{P2} monitor: %{currentMonitor}.> .gstats.dat%;\
    /let extraMsg=%;\
    /if ({autocast}=1) /let extraMsg=%{extraMsg} Cast.%;/endif%;\
    /if ({running}=1) /let extraMsg=%{extraMsg} Running.%;/endif%;\
    /if ({drone}=1) /let extraMsg=%{extraMsg} Drone.%;/endif%;\
    /if ({autoheal}=1) /let extraMsg=%{extraMsg} Heal [%{healRedux}].%;/endif%;\
    /if ({asleep}=1) /let extraMsg=%{extraMsg} Sleep.%;/endif%;\
    /if ({autobrandish}=1) /let extraMsg=%{extraMsg} Brand.%;/endif%;\
    /if ({atarg}=1) /let extraMsg=%{extraMsg} Target.%;/endif%;\
    /eval /sys echo %{extraMsg}>> .gstats.dat

/def -p0 -ag -mglob -t'-------------------------------------------------------------------------------' group_list_headerline
/def -p0 -ag -mglob -t'\#\#\| Level   Name         Pos   HitPoints   ManaPoints  MovePoints  TNL    Align' group_list_header

/def -p1 -F -mregexp -t'^You receive [0-9]+ experience points.$' gspam_get_group = \
    /if ({gspam} = 0 & {myclass} !~ "stm") \
        /send group%;\
    /endif

;;; /recordCharStat [Name Tier] [Level] [hp/maxHp] [mana/maxMana] [mv/maxMv]
/def -mregexp -p1 -F -ag -t'[0-9]+\|[ ]*([0-9]+)([ a-zA-Z]+)[ ]+([a-zA-Z ]+)[ ]+(STUN!|DROWN|Busy|Fight|Sleep|Stand|Rest)[ ]+([0-9\-\/]+)[ ]+([0-9\-\/]+)[ ]+([0-9\-\/]+)(.*)' group_list_to_log = \
    /eval /sys echo %{P1} %{P2} %{P3} %{P4} %{P5} %{P6} %{P7} %{P8} %{P9}>> .gstats.dat%;\
    /test $[recordCharStat({P2}, {P1}, {P5}, {P6}, {P7})]%;\

;;; Trigger to catch groupies from group list
;;; P1 - Name       P2 - Position
;;; P3 - HP         P4 - Max HP
;;; P5 - Mana       P6 - Max Mana
;;; P7 - Mv         P8 - Max Mv
;;; P9 - TNL & Align
;;;; need to strip off mud colors:  /set var %Px and then $[strip_attr({var})]
/def -mregexp -p0 -ag -t'\|[ ]*[0-9]+[ ]+[a-zA-Z]+[ ]+([a-zA-Z ]+)[ ]+(BUSY|STUN|DROWN|Busy|Fight|Sleep|Stand|Rest)[ ]+([0-9\-]+)/([0-9\-]+)[ ]+([0-9\-]+)/([0-9\-]+)[ ]+([0-9\-]+)/([0-9\-]+)(.*)' group_list = \
    /let groupiepos=$[pad(strip_attr({P2}), -6)]%; \
    /let groupiename=$[pad(strip_attr({P1}), -13, ':')]%; \
    /let groupiehp=$[pad(strip_attr({P3}), 6, '@{nCwhite}/')]%; \
    /let groupiemaxhp=$[pad(strip_attr({P4}), 6, ' @{nCwhite}hp')]%; \
    /let groupiemana=$[pad(strip_attr({P5}), 6, '@{nCwhite}/')]%; \
    /let groupiemaxmana=$[pad(strip_attr({P6}), 6, ' @{nCwhite}ma')]%; \
    /let groupiemv=$[pad(strip_attr({P7}), 6, '@{nCwhite}/')]%; \
    /let groupiemaxmv=$[pad(strip_attr({P8}), 6, ' @{nCwhite}mv')]%; \
    /let hpperc=$[strip_attr({P3})*100/strip_attr({P4})] %; \
    /if ({P6} != 0) /let mnperc=$[{P5}*100/{P6}]%;/else /let mnperc=100%;/endif%; \
    /let mvperc=$[strip_attr({P7})*100/strip_attr({P8})] %; \
    /let tgroupietnl=$(/first %{P9})%; \
    /let groupiealign=$(/rest %{P9})%; \
    /let groupietnl=$[pad({tgroupietnl}, 6, ' @{nCwhite}tnl')]%; \
    /set counter=$[++counter] %; \
    /let lcgroupiename=$[tolower(replace(" ", "", strip_attr({P1})))] %; \
    /set groupies=%groupies<%lcgroupiename< %; \
    /set grouplist=%grouplist %lcgroupiename %; \
    /set grpnum=$[++grpnum] %; \
    /let gechoHP=@{Ccyan}%{groupiehp}%; \
    /let gechoMN=@{Cyellow}%{groupiemana}%; \
    /let gechoTNL=@{hCwhite}%{groupietnl}%; \
    /if ({qrygroupie} =~ substr({lcgroupiename},0,strlen({qrygroupie}))) \
        /if ({hpperc}<35) /let gechoHP=@{Cred}%{groupiehp}%; \
        /elseif ({hpperc}<50) /let gechoHP=@{Cyellow}%{groupiehp}%; \
        /elseif ({hpperc}<70) /let gechoHP=@{Cmagenta}%{groupiehp}%; \
        /elseif ({hpperc}<85) /let gechoHP=@{Cblue}%{groupiehp}%; \
        /endif%; \
        /if ({mnperc}<35) /let gechoMN=@{Cred}%{groupiemana}%; \
        /elseif ({mnperc}<50) /let gechoMN=@{Cyellow}%{groupiemana}%; \
        /elseif ({mnperc}<70) /let gechoMN=@{Cmagenta}%{groupiemana}%; \
        /elseif ({mnperc}<85) /let gechoMN=@{Cblue}%{groupiemana}%; \
        /endif%; \
        /if ({groupietnl}<100) /let gechoTNL=@{hCred}%{groupietnl}%; /endif%; \
    /endif%; \
    /let gechoHP=%{gechoHP}@{hCcyan}%{groupiemaxhp}%; \
    /let gechoMN=%{gechoMN}@{hCyellow}%{groupiemaxmana}%; \
    /let gechoMV=@{Cgreen}%{groupiemv}@{hCgreen}%{groupiemaxmv}%; \
    /if ({qrygroupie} =~ substr({lcgroupiename},0,strlen({qrygroupie}))) \
        /if ({hpfor} = 1) \
            /if ({mnfor} = 1) \
                /send gt |br|%{P1}|w|: |r|%{P3}|w|/|r|%{P4}|w| hp \(|br|%{hpperc}%%|w|\) |y|%{P5}|w|/|y|%{P6}|w| mana \(|by|%{mnperc}%%|w|\)%; \
                /set mnfor=0 %; \
            /else \
                /send gt |br|%{P1}|w|: |r|%{P3}|w|/|r|%{P4}|w| hp \(|br|%{hpperc}%%|w|\) %; \
            /endif %; \
            /set hpfor=0 %; \
        /endif %; \
        /if ({mnfor} = 1) \
            /send gt |by|%{P1}|w|: |y|%{P5}|w|/|y|%{P6}|w| mana \(|by|%{mnperc}%%|w|\) %; \
            /set mnfor=0 %; \
        /endif %; \
        /if ({mvfor} = 1) \
            /send gt |bg|%{P1}|w|: |g|%{P7}|w|/|g|%{P8}|w| mv \(|bg|%{mvperc}%%|w|\) %; \
            /set mvfor=0%; \
        /endif%; \
        /if ({tnlfor} = 1) \
            /send gt |bc|%{P1}|w|: |c|%{tgroupietnl}|w| tnl%; \
            /set tnlfor=0%; \
        /endif %; \
        /if ({alignfor} = 1) \
            /send gt |k|%{P1}|w|: |r|%{groupiealign}|w| align%; \
            /set alignfor=0%; \
        /endif%; \
;        /set qrygroupie=emptyvalue%; \
    /endif%; \
    /if ({qrygroupie} =~ substr({lcgroupiename},0,strlen({qrygroupie}))) \
        /echo -pw @{Cwhite}%{groupiename} %{gechoHP} %{gechoMN} %{gechoMV} %{gechoTNL} @{nCyellow}%{groupiepos} %; \
;        /set qrygroupie=emptyvalue%; \
    /else \
        /echogroup @{Cwhite}%{groupiename} %{gechoHP} %{gechoMN} %{gechoMV} %{gechoTNL} @{nCyellow}%{groupiepos} %; \
    /endif%; \
    /if ({qrygroupie} =~ substr({lcgroupiename},0,strlen({qrygroupie}))) \
        /set qrygroupie=emptyvalue%; \
    /endif%; \
    /if ({grpnum} = {grprandnum}) \
        /let winner=$[{lcgroupiename}=~{myname}?"me":{P1}] %; \
        /let congrats=$[{winner}!~"me"?"Congrats":"Woot!  That's"] %; \
        /send gt The lucky # is |by|%{grpnum}|w|.  %{congrats} |bc|%{winner}|w|! %; \
        /set grprandnum=0 %; \
    /endif %; \
    /getstats %lcgroupiename %P3 %P4 %P5 %P6

;; getstats is used to add up hps and mana for the classes and races.  It is used
;; by other macroes, not to be used by itself.
/def -i getstats = \
    /set classarray=$[replace(" ","|",{classlist})]| %; \
    /while ({classarray} !~ "") \
        /let thisclass=$[substr({classarray},0,strchr({classarray},"|"))] %; \
        /let tempclasslist=$[tolower($(/listvar -vmglob charlst_%thisclass))] %; \
        /if (strstr({tempclasslist},{1}) > -1) \
            /let temphp1=$(/listvar -vmglob charhp1_%thisclass) %; \
            /let temphp2=$(/listvar -vmglob charhp2_%thisclass) %; \
            /let tempmn1=$(/listvar -vmglob charmn1_%thisclass) %; \
            /let tempmn2=$(/listvar -vmglob charmn2_%thisclass) %; \
            /set charhp1_%thisclass=$[temphp1+{2}] %; \
            /set charhp2_%thisclass=$[temphp2+{3}] %; \
            /set charmn1_%thisclass=$[tempmn1+{4}] %; \
            /set charmn2_%thisclass=$[tempmn2+{5}] %; \
        /endif %; \
        /set classarray=$[substr({classarray},strchr({classarray},"|")+1)] %; \
    /done%; \
    /set racearray=$[replace(" ","|",{racelist})]| %; \
    /while ({racearray} !~ "") \
        /let thisrace=$[substr({racearray},0,strchr({racearray},"|"))] %; \
        /let tempracelist=$[tolower($(/listvar -vmglob charlst_%thisrace))] %; \
        /if (strstr({tempracelist},{1}) > -1) \
            /let temphp1=$(/listvar -vmglob charhp1_%thisrace) %; \
            /let temphp2=$(/listvar -vmglob charhp2_%thisrace) %; \
            /let tempmn1=$(/listvar -vmglob charmn1_%thisrace) %; \
            /let tempmn2=$(/listvar -vmglob charmn2_%thisrace) %; \
            /set charhp1_%thisrace=$[temphp1+{2}] %; \
            /set charhp2_%thisrace=$[temphp2+{3}] %; \
            /set charmn1_%thisrace=$[tempmn1+{4}] %; \
            /set charmn2_%thisrace=$[tempmn2+{5}] %; \
        /endif %; \
        /set racearray=$[substr({racearray},strchr({racearray},"|")+1)] %; \
    /done

/set hpfor=0
/set mnfor=0
/set mvfor=0
/set qrygroupie=emptyvalue
/set tnlfor=0
/set alignfor=0
/def align = /set qrygroupie=$[tolower({1})]%;/set alignfor=1%; /send group
/def tnl = /set qrygroupie=$[tolower({1})]%;/set tnlfor=1%; /send group
/def hp = /set qrygroupie=$[tolower({1})]%;/set hpfor=1%; /send group
/def mana = /set qrygroupie=$[tolower({1})]%;/set mnfor=1%; /send group
/def mv = /set qrygroupie=$[tolower({1})]%;/set mvfor=1%; /send group
/def hpmn = /set qrygroupie=$[tolower({1})]%;/set hpfor=1%;/set mnfor=1%; /send group
/def qg =/set qrygroupie=$[tolower({1})]%; /send group

/def lotto = \
    /toggle randtoggle%;\
    /echoflag %randtoggle Lotto triggers are%;\
    /if ({gspam} = 1 & {randtoggle} = 1) /gspam%; /endif

/def setlead = \
    /undef leader_random%; \
    /set leader=%1 %; \
    /echo -pw %%% Leader set to @{hCcyan}%leader@{n}.%; \
    /if ({leader} =~ "Self") \
        /def -mregexp -t"The random number generator picks ([0-9]+)\." leader_random = \
            /if ({randtoggle} = 1) \
                /set grprandnum=%%P1 %%; \
                /send group %%; \
            /endif%; \
    /else \
        /def -mregexp -t"The random generator produces ([0-9]+) out of [0-9]+ for %{leader}\." leader_random = \
            /if ({randtoggle} = 1) \
                /set grprandnum=%%P1 %%; \
                /send group %%; \
            /endif%; \
    /endif

;;; Commands/triggers to count the classes in the group

;;; findmatch is in here for now, if I use it more, should be moved to the main macros file.
/def findmatch = \
    /set matchvar=0 %; \
    /set matchcomp=$[tolower({1})] %; \
    /while ({#}) \
        /if (tolower({2}) =~ {matchcomp}) /set matchvar=1 %; /endif %; \
        /shift %; \
        /done %; \
    /result {matchvar}

/def showgr = /echo -pw % @{Cwhite}Groupies: @{Cyellow}%grouplist@{n}

/def grphp = \
    /if (({1} =~ "")) \
        /grphpbreakdown %; \
    /else \
        /if ($(/listvar -vmglob charcnt_%1*) > 0) \
            /let grpcls=$[substr($(/listvar -smglob charcnt_%1*),8)] %; \
            /let hp1=$(/listvar -vmglob charhp1_%grpcls)%; \
            /let hp2=$(/listvar -vmglob charhp2_%grpcls)%; \
            /let hpperc=$[{hp1}*100/{hp2}] %; \
            /send gt $(/listvar -vmglob charcnt_%grpcls) |r|%{grpcls}|w|: |r|%{hp1}|w|/|br|%{hp2} hp |w|\(|br|%{hpperc}%%|w|\)%; \
        /endif %; \
    /endif

/def grpmn = \
    /if (({1} =~ "")) \
        /grpmnbreakdown %; \
    /else \
        /if ($(/listvar -vmglob charcnt_%1*) > 0) \
            /let grpcls=$[substr($(/listvar -smglob charcnt_%1*),8)] %; \
            /let mn1=$(/listvar -vmglob charmn1_%grpcls)%; \
            /let mn2=$(/listvar -vmglob charmn2_%grpcls)%; \
            /let mnperc=$[{mn1}*100/{mn2}] %; \
            /send gt $(/listvar -vmglob charcnt_%grpcls) |y|%{grpcls}|w|: |y|%{mn1}|w|/|by|%{mn2}|w| mana |w|\(|by|%{mnperc}%%|w|\)%; \
        /endif %; \
    /endif

/def -i grpmnbreakdown = \
    /let healerflag=0%; /let damageflag=0%; \
    /if ({charmn2_Cleric} != 0) \
        /let healerflag=1%; \
        /let healmanastatus=|c|%charcnt_Cleric |bc|Clerics|w|: |c|%{charmn1_Cleric}|w|/|bc|%{charmn2_Cleric} |w|(|c|$[{charmn1_Cleric}*100/{charmn2_Cleric}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Druid} != 0) \
        /let healerflag=1%; \
        /let healmanastatus=%healmanastatus |y|%charcnt_Druid |by|Druids|w|: |y|%{charmn1_Druid}|w|/|by|%{charmn2_Druid} |w|(|y|$[{charmn1_Druid}*100/{charmn2_Druid}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Paladin} != 0) \
        /let healerflag=1%; \
        /let healmanastatus=%healmanastatus |y|%charcnt_Paladin |by|Paladins|w|: |y|%{charmn1_Paladin}|w|/|by|%{charmn2_Paladin} |w|(|y|$[{charmn1_Paladin}*100/{charmn2_Paladin}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Priest} != 0) \
        /let healerflag=1%; \
        /let healmanastatus=%healmanastatus |y|%charcnt_Priest |by|Priests|w|: |y|%{charmn1_Priest}|w|/|by|%{charmn2_Priest} |w|(|y|$[{charmn1_Priest}*100/{charmn2_Priest}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Mage} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |g|%charcnt_Mage |bg|Mages|w|: |g|%{charmn1_Mage}|w|/|bg|%{charmn2_Mage} |w|(|g|$[{charmn1_Mage}*100/{charmn2_Mage}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Mindbender} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |g|%charcnt_Mindbender |bg|Mindbenders|w|: |g|%{charmn1_Mindbender}|w|/|bg|%{charmn2_Mindbender} |w|(|g|$[{charmn1_Mindbender}*100/{charmn2_Mindbender}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Psionicist} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |p|%charcnt_Psionicist |bp|Psis|w|: |p|%{charmn1_Psionicist}|w|/|bp|%{charmn2_Psionicist} |w|(|p|$[{charmn1_Psionicist}*100/{charmn2_Psionicist}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Sorcerer} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |r|%charcnt_Sorcerer |br|Sorcerers|w|: |r|%{charmn1_Sorcerer}|w|/|br|%{charmn2_Sorcerer} |w|(|r|$[{charmn1_Sorcerer}*100/{charmn2_Sorcerer}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Wizard} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |y|%charcnt_Wizard |by|Wizards|w|: |y|%{charmn1_Wizard}|w|/|by|%{charmn2_Wizard} |w|(|y|$[{charmn1_Wizard}*100/{charmn2_Wizard}]%%|w|) %; \
    /endif %; \
    /if ({charmn2_Stormlord} != 0) \
        /let damageflag=1%; \
        /let damagemanastatus=%damagemanastatus |y|%charcnt_Stormlord |by|Stormlords|w|: |y|%{charmn1_Stormlord}|w|/|by|%{charmn2_Stormlord} |w|(|y|$[{charmn1_Stormlord}*100/{charmn2_Stormlord}]%%|w|) %; \
    /endif %; \
    /if ({healerflag}==1) /send gt |bc|Healing Mana|w|: %{healmanastatus}|w|%; /endif %; \
    /if ({damageflag}==1) /send gt |bc|Firepower|w|: %{damagemanastatus}|w|%; /endif

/def -i grphpbreakdown = \
    /let tankflag=0%; /let otherflag=0%; \
    /if ({charhp2_Bodyguard} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |c|%charcnt_Bodyguard |bc|Bodyguards|w|: |c|%{charhp1_Bodyguard}|w|/|bc|%{charhp2_Bodyguard} |w|(|c|$[{charhp1_Bodyguard}*100/{charhp2_Bodyguard}]%%|w|)%; \
    /endif %; \
    /if ({charhp2_Berserker} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |r|%charcnt_Berserker |br|Berserkers|w|: |r|%{charhp1_Berserker}|w|/|br|%{charhp2_Berserker} |w|(|g|$[{charhp1_Berserker}*100/{charhp2_Berserker}]%%|w|)%; \
    /endif %; \
    /if ({charhp2_Monk} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |y|%charcnt_Monk |by|Monks|w|: |y|%{charhp1_Monk}|w|/|by|%{charhp2_Monk} |w|(|y|$[{charhp1_Monk}*100/{charhp2_Monk}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Paladin} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |g|%charcnt_Paladin |bg|Paladins|w|: |g|%{charhp1_Paladin}|w|/|bg|%{charhp2_Paladin} |w|(|g|$[{charhp1_Paladin}*100/{charhp2_Paladin}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Ranger} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |g|%charcnt_Ranger |bg|Rangers|w|: |g|%{charhp1_Ranger}|w|/|bg|%{charhp2_Ranger} |w|(|g|$[{charhp1_Ranger}*100/{charhp2_Ranger}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Shadowfist} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |g|%charcnt_Shadowfist |bg|Shadowfists|w|: |g|%{charhp1_Shadowfist}|w|/|bg|%{charhp2_Shadowfist} |w|(|g|$[{charhp1_Shadowfist}*100/{charhp2_Shadowfist}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Warrior} != 0) \
        /let tankflag=1%; \
        /let tankhpstatus=%tankhpstatus |c|%charcnt_Warrior |bc|Warriors|w|: |c|%{charhp1_Warrior}|w|/|bc|%{charhp2_Warrior} |w|(|c|$[{charhp1_Warrior}*100/{charhp2_Warrior}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Archer} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |b|%charcnt_Archer |bb|Archers|w|: |b|%{charhp1_Archer}|w|/|bb|%{charhp2_Archer} |w|(|b|$[{charhp1_Archer}*100/{charhp2_Archer}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Assassin} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |r|%charcnt_Assassin |br|Assassins|w|: |r|%{charhp1_Assassin}|w|/|br|%{charhp2_Assassin} |w|(|r|$[{charhp1_Assassin}*100/{charhp2_Assassin}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Black_Circle_Initiate} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |r|%charcnt_Black_Circle_Initiate |br|BCIs|w|: |r|%{charhp1_Black_Circle_Initiate}|w|/|br|%{charhp2_Black_Circle_Initiate} |w|(|r|$[{charhp1_Black_Circle_Initiate}*100/{charhp2_Black_Circle_Initiate}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Bladedancer} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |p|%charcnt_Bladedancer |bp|Bladedancers|w|: |p|%{charhp1_Bladedancer}|w|/|bp|%{charhp2_Bladedancer} |w|(|p|$[{charhp1_Bladedancer}*100/{charhp2_Bladedancer}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Fusilier} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |b|%charcnt_Fusilier |bb|Fusiliers|w|: |b|%{charhp1_Fusilier}|w|/|bb|%{charhp2_Fusilier} |w|(|b|$[{charhp1_Fusilier}*100/{charhp2_Fusilier}]%%|w|) %; \
    /endif %; \
    /if ({charhp2_Rogue} != 0) \
        /let otherflag=1%; \
        /let otherhpstatus=%otherhpstatus |p|%charcnt_Rogue |bp|Rogues|w|: |p|%{charhp1_Rogue}|w|/|bp|%{charhp2_Rogue} |w|(|p|$[{charhp1_Rogue}*100/{charhp2_Rogue}]%%|w|) %; \
    /endif %; \
    /if ({tankflag}==1) /send gt |br|Tanking HP|w|: %{tankhpstatus}|w|%; /endif %; \
    /if ({otherflag}==1) /send gt |bc|Others HP|w|: %{otherhpstatus}|w|%; /endif

/def glast = \
    /send prompt=groupstat %; \
    /set grpchkstatus=1 %; \
    /set grpsize=0 %; \
    /grpcntreset %classlist %; \
    /grpcntreset %racelist %; \
    last %grouplist%; \
    /send prompt

/def grp = \
    /if (({1} =~ "") | ({1} =~ "class")) \
        /grptally %classlist %; \
    /elseif ({1} =~ "race") \
        /grptally %racelist %; \
    /else \
        /if ($(/listvar -vmglob charcnt_%1*) > 0) \
            /let grpcls=$[substr($(/listvar -smglob charcnt_%1*),8)] %; \
            /let newparm=$[replace("_", " ", {grpcls})]%; \
            /if ($(/findmatch %grpcls %remortlist) = 1) /let clscol=r %; \
            /elseif ($(/findmatch %grpcls %prestigelist) = 1) /let clscol=c %; \
            /else /let clscol=g %; \
            /endif%; \
            /send gt $(/listvar -vmglob charcnt_%grpcls) |%{clscol}|%{newparm}|w|: |bw|[|y|$[substr($(/listvar -vmglob charlst_%grpcls),2)]|bw|]|w| %; \
        /endif %; \
    /endif

/def -i grptally = \
        /unset grptal %; \
        /while ({#}) \
            /if ($(/listvar -vmglob charcnt_%1) > 0) \
                /let newrace=$[replace("_", " ", {1})]%; \
                /let grpcls=$[substr($(/listvar -smglob charcnt_%1*),8)] %; \
                /if ($(/findmatch %grpcls %remortlist) = 1) /let clscol=r %; \
                /elseif ($(/findmatch %grpcls %prestigelist) = 1) /let clscol=c %; \
                /else /let clscol=g %; \
                /endif%; \
                /set grptal=%grptal, |bw|$(/listvar -vmglob charcnt_%1) |%{clscol}|%newrace|w| %; \
            /endif %; \
            /shift %; \
        /done %; \
        /send gt $[substr($(/listvar -v grptal),2)]

/def gwho = /grpreport %classlist

/def -i grpcntreset = \
    /while ({#}) \
        /unset $(/listvar -smglob charcnt_%1) %; \
        /unset $(/listvar -smglob charlst_%1) %; \
        /shift %; \
    /done

/def -i grpstatreset = \
    /while ({#}) \
        /unset $(/listvar -smglob charhp1_%1) %; \
        /unset $(/listvar -smglob charhp2_%1) %; \
        /unset $(/listvar -smglob charmn1_%1) %; \
        /unset $(/listvar -smglob charmn2_%1) %; \
        /shift %; \
    /done

/def -i grpreport = \
        /set grpchkstatus=0 %; \
        /while ({#}) \
            /if ($(/listvar -vmglob charcnt_%1) > 0) \
                /let grpcls=$[substr($(/listvar -smglob charcnt_%1*),8)] %; \
                /if ($(/findmatch %grpcls %remortlist) = 1) /let clscol=r %; \
                /elseif ($(/findmatch %grpcls %prestigelist) = 1) /let clscol=c %; \
                /else /let clscol=g %; \
                /endif%; \
                /send gt $(/listvar -vmglob charcnt_%1) |%{clscol}|%1s|w|: |bw|[|y|$[substr($(/listvar -vmglob charlst_%1),2)]|bw|]|w| %; \
            /endif %; \
            /shift %; \
        /done

/def -mregexp -t" is leading ([0-9]+) player[s ]+with [0-9]+/[0-9]+ hp, [0-9]+/[0-9]+ ma, and [0-9]+/[0-9]+ mv\." group_groupstats = \
    /set grpqty=%P1

;;; P1 - Race        P2 - Level
;;; P3 - Tier        P4 - Class
;;;/def -F -p0 -mregexp -t" the ([A-Za-z -]+) is a ([0-9]+)[a-z]+ level.* ([A-Za-z]+), was born .+, and$" Group_tally = \
;/def -F -p0 -mregexp -t" the ([A-Za-z -]+) is a ([0-9]+)[a-z]+ level (Hero|Lord)*[ ]*([A-Za-z ]+), was born .+, and$" Group_tally = \
/def -F -p0 -mregexp -t" the ([A-Za-z -]+) is a ([0-9]+)[a-z]+ level (Hero|Lord)*[ ]*([A-Za-z ]+) ?[\(\)\ 0-9a-zA-Z]*," Group_tally = \
        /if ({grpchkstatus} == 1) \
            /if ({grpsize} < {grpqty}) \
                /let newrace=$[replace(" ", "_", {P1})]%; \
                /let newrace=$[replace("-", "_", {newrace})]%; \
                /let newclass=$[replace(" ", "_", {P4})]%; \
                /let newclass=$[replace("-", "_", {newclass})]%; \
                /set tempcnt=$(/listvar -vmglob charcnt_%newclass) %; \
                /let tracecnt=$(/listvar -vmglob charcnt_%newrace) %; \
                /set templist=$(/listvar -vmglob charlst_%newclass) %; \
                /let tracelist=$(/listvar -vmglob charlst_%newrace) %; \
                /set nameproper=$[toupper(substr({PL},0,1))]$[substr({PL},1)] %; \
                /set charlst_%newclass=%templist, %nameproper %; \
                /set charcnt_%newclass=$[++tempcnt] %; \
                /set charlst_%newrace=%tracelist, %nameproper %; \
                /set charcnt_%newrace=$[++tracecnt] %; \
                /set grpsize=$[++grpsize] %; \
                /set $[strcat("grpmem_",{PL})]=%P4 %; \
                /set $[strcat("grpmem_",{PL})]=%P1 %; \
            /endif %; \
        /endif %; \
        /if ($(/findmatch %PL %my_alts) = 1) \
;            /substitute -p @{Cyellow}%PL @{Cwhite}(%P2 %P1 %P3 %P4) %; \
            /substitute -p @{Cyellow}%PL @{hCgreen}(That's me!)@{nCwhite}(%P2 %P1 %P3 %P4) %; \
        /endif

;;; Other group-related macros
/def wagr = wake %;/mapcar wake %grouplist

;;; What groupies are missing from room.  Only works for lords.
/def -mregexp -t"(Lady|Lord) ([a-zA-Z]+) is (sleeping|resting| )*here\.$" in_room = \
    /if ({chkgrp}=1) \
        /set chkgrpname=$[tolower({P2})]%;\
        /set missinggroupies=$(/remove %{chkgrpname} %{missinggroupies})%;\
    /endif

/def chkgrp = \
    /set chkgrp=1%;\
    /set missinggroupies=$(/remove %{myname} %{grouplist})%;\
    /send look

/def mgrp = \
    /if ({missinggroupies} !~ "") \
        /if ({#} = 0) /echo -pw %%% Missing groupies: @{hCred}%missinggroupies@{n}%; \
        /else /eval %{*} MIA: |br|%{missinggroupies}|w|%; \
        /endif%; \
    /else /echo -pw %%% No missing groupies.%; \
    /endif

;;; List alts adding/listing
;;; /insalt            - Used to insert main char and any alts.
;;; /altlist [channel] - List any (known) alts to channel (/echo -w is default if not given).
/def insalt = \
     /if ({#} = 0) \
         /echo -pw @{Cred}Syntax: @{Cwhite}/insalt main_char alt1 alt2 ... altN@{n}%; \
     /else \
         /sys %{script_path}insalt.py -m %1 -a "%-1"%; \
     /endif

/def altlist = \
    /if ({#} > 1) \
        /let param=-f%;\
        /let listaltchan=%-1%; \
    /else \
        /let listaltchan=/echo%; \
    /endif %; \
    /if ({#} == 0) \
        /let qryAlt=${world_character}%;\
    /else \
        /let qryAlt=%{1}%;\
    /endif%;\
    /quote -S /set listaltlist=!%{script_path}listalts.py %{param} %{qryAlt}%;\
    /if ({listaltlist} =/ "* has no registered alts.") \
        /echo -pw %%% @{Cwhite}%{qryAlt} @{Cgreen}has no registered alts.@{n}%;\
    /elseif ({listaltlist} =/ "* not found.") \
        /echo -pw %%% @{Cwhite}%{qryAlt} @{Cgreen}has not been registered.@{n}%;\
    /else \
        /let main_alt=$(/first %{listaltlist})%;\
        /let char_alts=$(/rest %{listaltlist})%;\
        /let num_alts=$(/length %{char_alts})%;\
        /if ({listaltchan} =~ "/echo") \
            /let listaltmsg=|w|%main_alt (%{num_alts}) |g|AKA|y| %char_alts%;\
            /chgcolor %%% %listaltmsg%;\
        /else \
            /let listaltmsg=|w|%main_alt (%{num_alts}) |g|AKA|y| %char_alts%;\
            /eval %listaltchan %listaltmsg %; \
        /endif %; \
    /endif %;\
    /unset listaltlist

; -- to do, gag "You tell JeKyll '" on the following 2 triggers.
/def -mregexp -p1 -ag -t"^([a-zA-Z]+) tells you '!altlist ([a-zA-Z]+)'$" tell_altlist = \
    /if ("Daeron" !~ ${world_character}) /altlist %{P2} tell %{P1}%; /endif
/def -mregexp -p1 -ag -t"^([a-zA-Z]+) tells you '!top ([a-zA-Z\ \"]+) ([a-zA-Z\ \"]+)'$" tell_top_race_class = \
    /if ("Daeron" !~ ${world_character}) /top -r %{P2} -c %{P3} -o "tell %{P1}"%; /endif


/def altlist2= \
    /if ({#} > 1) /let listaltchan=%-1%; /else /let listaltchan=/echo%; /endif %; \
    /echo %listaltchan%;\
    /if ({#} = 0) \
        /echo -pw @{Cred}Syntax: @{Cwhite}/listalt char [channel]@{n}%; \
    /else \
        /quote -S /set listaltlist=!%{script_path}listalts.py -t all %{1}%;\
        /if ({listaltlist} =/ "* has no registered alts.") \
            /echo -pw %%% @{Cwhite}%{1} @{Cgreen}has no registered alts.@{n}%;\
        /else \
            /let main_alt=$(/first %{listaltlist})%;\
            /let char_alts=$(/rest %{listaltlist})%;\
            /let listaltmsg=|w|%main_alt |g|AKA|y| %char_alts%;\
            /if ({listaltchan} =~ "/echo") \
                /echo -pw %%% $[$(/chgcolor %listaltmsg)]%;\
;                /let listaltmsg=$(/chgcolor %listaltmsg)%; \
;                /echo -pw %%% %listaltmsg %; \
            /else \
                /eval %listaltchan %listaltmsg %; \
            /endif %; \
        /endif %;\
        /unset listaltlist%; \
    /endif
 

;;; ---------------------------------------------------------------------------
;;; Record player stats for comparison
;;; ---------------------------------------------------------------------------
/def logCharStat = \
    /toggle log_char_stat%;\
    /echoflag %{log_char_stat} Capturing Character stats%;\
    /if ({log_char_stat} == 0) \
        /if /ismacro gag_lastline2%; /then /undef gag_lastline2 last_char_trig last_lgnd_char_trig last_lowmort_trig%;/endif%;\
    /else \
        /def generalPromptHookCheck=/logCharStat%%;/undef generalPromptHookCheck%;\
        /send group%;\
    /endif

/def -i nothingStat = 
;; /recordCharStat [Name Tier] [Level] [hp/maxHp] [mana/maxMana] [mv/maxMv]
/def recordCharStat = \
    /let _tier_name=$[strip_attr({1})]%;\
    /let _tier=$[replace(" ", "", substr({_tier_name}, 1, strstr({_tier_name}, " ", 1)))]%;\
    /let _name=$[replace(" ", "", substr({_tier_name}, strstr({_tier_name}, {_tier}) + strlen({_tier}) + 1))]%;\
    /let _lcname=$[tolower({_name})]%;\
    /set displayMonitorHP_%{_lcname}=%{_name}: %{3} hp%;\
    /set displayMonitorMN_%{_lcname}=%{_name}: %{4} mn%;\
    /set displayMonitorMV_%{_lcname}=%{_name}: %{5} mv%;\
    /let _hp=$[substr({3}, strstr({3}, "/")+1)]%;\
    /let _mana=$[substr({4}, strstr({4}, "/")+1)]%;\
    /let _mv=$[substr({5}, strstr({5}, "/")+1)]%;\
    /if ({log_char_stat} == 1) \
        /quote -S /nothingStat !sqlite3 avatar.db 'delete from char_stat where character = "%{_name}"'%;\
        /quote -S /nothingStat !sqlite3 avatar.db 'insert into char_stat (character, tier, level, hp, mana, mv, last_seen) values ("%{_name}", "%{_tier}", "%{2}", "%{_hp}", "%{_mana}", "%{_mv}", "$[ftime("%Y%m%d", time())]")'%;\
    /endif

/def charstat = /quote -S /echo -pw %%% @{Cred}[CHAR INFO]:@{hCred} !sqlite3 avatar.db "select upper(substr(character,1,1)) || substr(character,2) || '@' || level || ' ' || tier || ': ' || hp || ' hp ' || mana || ' mana ' || mv || ' mv.' from char_stat where lower(character) = lower('%{*}')"

;;; Output format: Tier,Name,Race,Level,Class
;;; Hero/Lord Params: 1 - Name, 2 - Race, 3 - Level, 5 - Hero/Lord, 6 - Class
;;; Lowmort Params: 1 - Name, 2 - Race, 3 - Level, 5 - Class
;;; Legend Params: 1 - Name, 2 - Race, 3 - Lord Level, 5 - Class, 6 - Legend Level
;zaffer the Sprite is a 70th level Lord Priest, was born a long time ago, and
;caree the High Elf is a 999th level Lord Sorcerer (Legend 1 High Elf Sorcerer),
;zalera the Centaur is a 24th level Mage, was born on 2015/10/13, and
/def updateChar = \
    /if ({log_char_stat} == 0) /logCharStat%;/endif%;\
    /def -mregexp -ag -t'was last logged in [on|from].*' gag_lastline2%; \
    /def -mregexp -p8 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level (Hero|Lord) ([A-Za-z ]+), was born" last_char_trig = \
        /sys sqlite3 avatar.db 'update char_stat set tier="%%{P5}", level="%%{P3}", class="%%{P6}", race="%%{P2}" where character="%%{P1}"%;\
    /def -mregexp -p9 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level Lord ([A-Za-z ]+) \(Legend ([0-9]+) .*\)," last_lgnd_char_trig = \
        /sys sqlite3 avatar.db 'update char_stat set tier="Lord", level="%%{P3}", class="%%{P6}", race="%%{P2}" where character="%%{P1}"%;\
    /def -mregexp -F -p7 -ag -t"([A-Za-z]+) the ([-A-Za-z ]+) is a ([0-9]+)(st|nd|rd|th) level ([A-Za-z ]+), was born" last_lowmort_trig = \
        /sys sqlite3 avatar.db 'update char_stat set tier="Lowmort", level="%%{P3}", class="%%{P5}", race="%%{P2}" where character="%%{P1}"


;;; ----------------------------------------------------------------------
;;; Miscellaneous
; Macroes to give an item to each group member
/def givegroup = /set giveGroupieItem=%{*}%;/mapcar /_givegroup %{grouplist}
/def _givegroup = /echo /send give %{giveGroupieItem} %{1}
