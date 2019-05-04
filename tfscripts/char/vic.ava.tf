;;; vic.ava.tf

/def -mglob -wvic -ar -t'a weapon of mass destruction falls to the ground, lifeless\.' dwweaponfall = \
    /send get %{wield}=wield %{wield}%; \
    /if ({autocast} = 1) c 'dancing weapon'%; /endif

;; Vic's spell time echoing.
/def -mregexp -wvic -ag -p1 -t'^Spell: \'([a-zA-Z ]+)\'  for ([a-zA-Z\ ]+).' spellforaff2 = \
    /if ({P2} =~ "seemingly forever") /let durLeft=>50%;\
    /elseif ({P2} =~ "a very long time") /let durLeft=<51%;\
    /elseif ({P2} =~ "a long time") /let durLeft=<26%;\
    /elseif ({P2} =~ "a while") /let durLeft=<11%;\
    /elseif ({P2} =~ "a small amount of time") /let durLeft=<6%;\
    /elseif ({P2} =~ "a tiny amount of time") /let durLeft=<4%;\
    /elseif ({P2} =~ "seems to be wavering") /let durLeft=<2%;\
    /else /let durLeft=%{P2}%;\
    /endif%;\
    /if ({P1} =~ "poison") \
        /let color=@{Cred} %; \
        /set poisonleft=%durLeft %; \
        /set poisonaff=unknown%; \
        /set numpoison=$[++numpoison]%;\
    /elseif ({P1} =~ "biotoxin") \
        /let color=@{Cred} %; \
        /set biotoxinleft=%durLeft%; \
        /set biotoxinaff=unknown %; \
        /set numbiotoxin=$[++numbiotoxin]%;\
    /elseif ({P1} =~ "toxin") \
        /let color=@{Cred} %; \
        /set toxinleft=%durLeft%; \
        /set toxinaff=%unknown%; \
        /set numtoxin=$[++numtoxin]%;\
    /elseif ({P1} =~ "venom") \
        /let color=@{Cred} %; \
        /set venomleft=%P4 %; \
        /set venomaff=unknown%; \
    /elseif ({P1} =~ "doom toxin") \
        /let color=@{Cred} %; \
        /set doomtoxinleft=%durLeft %; \
        /set doomtoxinaff=unknwon%; \
        /set numdoomtoxin=$[++numdoomtoxin]%;\
    /elseif ({P1} =~ "plague") \
        /let color=@{Cred} %; \
        /set plagueleft=%durLeft%; \
        /set plagueaff=unknown%; \
        /set numplague=$[++numplague]%;\
    /elseif ({P1} =~ "virus") \
        /let color=@{Cred} %; \
        /set virusleft=%durLeft%; \
        /set virusaff=unknown%; \
        /set numvirus=$[++numvirus]%;\
    /elseif ({P1} =~ "necrotia") \
        /let color=@{Cred} %; \
        /set necrotialeft=%durLeft%; \
        /set necrotiaaff=unknown%; \
        /set numnecrotia=$[++numdnecrotia]%;\
    /elseif ({P1} =~ "fear") \
        /let color=@{Cblack} %; \
        /set fearleft=%durLeft%; \
        /set fearaff=unknown%; \
    /elseif ({P1} =~ "curse") \
        /let color=@{Cblack} %; \
        /set curseleft=%durLeft%; \
        /set curseaff=unknown%; \
        /set numcurse=$[++numcurse]%;\
    /elseif ({P1} =~ "scramble") \
        /let color=@{Cblack} %; \
        /set scrambleleft=%durLeft%; \
        /set scrambleaff=unknown%; \
        /set numscramble=$[++numscramble]%;\
    /elseif ({P1} =~ "web") \
        /let color=@{hCgreen} %; \
        /set webleft=%durLeft%; \
        /set webaff=unknown%; \
        /set numweb=$[++webnum]%;\
    /else /let color=@{hCyellow}%;\
    /endif %; \
    /if ({qryspell} =~ substr({P1},0,strlen({qryspell}))) \
        /echo -pw @{hCwhite}Spell: '%{color}%{P1}@{hCwhite}' for %{color}%{durLeft} @{hCwhite}hours.@{n}%; \
        /set qryspellnum=$[--qryspellnum]%;\
        /if ({qryspellnum} <= 0) \
            /set qryspell=emptyvalue%;\
        /endif%;\
    /else \
        /echoaffects @{Cgreen}Spell: '%{color}%{P1}@{xCgreen}' for %{color}%{durLeft} @{xCgreen} hours.%; \
    /endif

/load -q char/.vic-state.dat

