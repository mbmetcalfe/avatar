;; autowalk.tf
;;
;; Speedwalk+ defines
;; Currently only a few of them are written, I can add to these if
;; people want to send me speed walk lists to objects.
;; These are avatar bot rule compliant, they only speed walk you to the mob
;; any further instructions are comments, and up to the user to execute.
;;
;; Usage:
;;    /scorp
;;        Fetches scorpion tattoos
;;    /cross
;;        Fetches marble crosses
/def autowalk = \
    /toggle autowalk %; \
    /echoflag %autowalk Auto-@{Cmagenta}Walk@{n}%;\
    /statusflag %autowalk Walk

;/dirrev <path>     Revert speedwalk path
/def -i dirrev = \
    /if ({#}=0) \
        /echo -p %%% @{Cred}Syntax: /%{0} <speedwalk path>@{n}%;\
    /else \
        /set dir_str %1 %;\
        /set dir_length $[strlen(dir_str)] %;\
        /set double_digit=0%;\
        /set dir_rev=%;\
        /for c 0 $[dir_length-1] \
            /set position $$[dir_length-c] %%;\
            /set cur_char $$[substr(dir_str, position-1, 1)] %%;\
            /set new_char %%{cur_char} %%;\
            /if (cur_char =~ "e") /set new_char w %%;/endif %%;\
            /if (cur_char =~ "s") /set new_char n %%;/endif %%;\
            /if (cur_char =~ "w") /set new_char e %%;/endif %%;\
            /if (cur_char =~ "n") /set new_char s %%;/endif %%;\
            /if (cur_char =~ "u") /set new_char d %%;/endif %%;\
            /if (cur_char =~ "d") /set new_char u %%;/endif %%;\
            /if ((new_char =/ "[0-9]") & (!double_digit)) \
                /set dir_rev $$[strcat(substr(dir_rev, 0, c-1), new_char, substr(dir_rev, c-1, 1))] %%;\
                /if (substr(dir_str, position-2, 1) =/ "[0-9]") \
                    /set dir_rev $$[strcat(substr(dir_rev, 0, c-1), substr(dir_str, position-2, 1), substr(dir_rev, c-1, 2))] %%;\
                    /set double_digit 1 %%;\
                /endif %%;\
            /elseif ( regmatch("[nsewud]", new_char) ) \
                /set dir_rev $$[strcat(dir_rev, new_char)] %%;\
                /set double_digit 0 %%;\
            /endif %;\
        /echo -p %%% @{Cwhite}The reverse of @{Cgreen}%{dir_str} @{Cwhite}is @{Cgreen}%dir_rev@{n}%;\
    /endif

/def scorp = \
    /if ({autowalk} = 1) \
        /send c tele mou lio %; \
        n2w4ndsdsde2d7n2wn5ws2wsdwdsw2nunwe %; \
    /else \
        /echo -p %%% @{Cmagenta}Scorpion tatto: @{hCcyan}pp moun lion=n2w4ndsdsde2d7n2wn5ws2wsdwdsw2nunwe@{n} %; \
    /endif %; \
     /echo -p %%% @{hCcyan}get crow=unlock trap=drop crow=open trap=get arm trap=get tat arm=drop arm@{n}

/def cross = \
    /if ({autowalk} = 1) \
        /send c port aelmon %; \
        enter port %; \
        19en3enw2nwnw2n2en %; \
    /else \
        /echo -p %%% @{Cmagenta}Marble Cross: @{hCcyan}pp aelmon=19en3enw2nwnw2n2en@{n} %; \
    /endif
;;;
;;; Fatewalker Quest
;;;
/def -mglob -t'Atropos*The Cutting Room of Atropos' whereatropos = \
    /if ({autowalk} = 1) \
        sd2nw %; drink %; ki atropos %; \
    /else \
        /echo -p %%% @{Cmagenta}Fates/Atropos: @{hCcyan}sd2nw=drink=ki atropos@{n} %; \
    /endif
/def -mglob -t'Clotho*The Spinning Room of Clotho' whereclotho = \
    /if ({autowalk} = 1) \
        sd4n3w3n2ws %; drink %; ki clotho %; \
    /else \
        /echo -p %%% @{Cmagenta}Fates/Clotho: @{hCcyan}sd4n3w3n2ws\;drink\;ki clotho %; \
    /endif
/def -mglob -t'Lachesis*The Judgement Room of Lachesis' wherelachesis = \
    /if ({autowalk} = 1) \
        sd4n3w3nw2n2ese %; drink %; ki lach %; \
    /else \
        /echo -p %%% @{Cmagenta}Fates/Lachesis:  @{hCcyan}sd4n3w3nw2n2ese\;drink\;ki lachesis %; \
    /endif
/def -mglob -t'Atropos is DEAD!!' fates_atropos = /lootcor scissors
/def -mglob -t'Clotho is DEAD!!' fates_clotho = /lootcor spindle
/def -mglob -t'Lachesis is DEAD!!' fates_lachesis = /lootcor rod
/def givefate = \
    /set ptime=0 %; \
    /if ({#} > 0) /let numFates=%1 %; /else /let numFates=1 %; /endif %; \
    give spindle gyp %; give rod gyp %; \
    /repeat %numFates give sci gyp

;;;
;;; Turquoise mane quest
;;;
/def -mglob -ag -t"A mountain lion is here, gnawing on a mountain goat's carcass." turqmane_mountlion = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}track monk
/def -mglob -ag -t"A blank-eyed monk doesn't even seem to notice you." turqmane_monk = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}track chay
/def -mglob -ag -t"A monk walks towards you with a blank look on his face." turqmane_blankmonk = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}track chay
/def -mglob -ag -t"(Black Aura) Chaykin the evil High Sorcerer stands here amused by your puny attempts to kill him." turqmane_chaykin = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}ki chaykin
/def -mglob -ag -t"Chaykin is DEAD!!" turqmane_chaykin_dead = \
    /if ({autoloot} = 1) /send get seal corpse %; /endif %; \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}get seal cor%%;n%%;track statue
/def -mglob -ag -t"(White Aura) A bronze statue of Daido Sakyamuni stands here." turqmane_daido = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}n%%;unl d%%;track serpent
/def -mglob -ag -t"(Invis) (White Aura) A huge sea-serpent towers over you, its eyes flashing with rage." turqmane_serpent = \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}ki serpent
/def -mglob -ag -t"The guardian of Daido's tomb is DEAD!!" turqmane_daidotomb = \
    /if ({autoloot} = 1) /send get key corpse %; \
    /echo -p %%% @{Ccyan}Turquoise Mane Quest: @{Cyellow}get key cor%%;s%%;unlock coffin%%;get mane coffin

;;;
;;; Seven-league boots quest
;;;
/def -mglob -ag -t"A gargoyle covered with iron scales and spikes stands between you and the door." sevenleague_gargoyle = \
    /echo -p %%% @{Ccyan}Seven-league Boots Quest: @{Cyellow}kill gargoyle
/def -mglob -ag -t"An iron gargoyle is DEAD!!" sevenleague_gargoyle_dead = \
    /if ({autoloot} = 1) /send get key corpse %; unlock north %; open north%; /endif %; \
    /echo -p %%% @{Ccyan}Seven-league Boots Quest: @{Cyellow}get key cor%%;unl n%%;n%%;kill evil
/def -mglob -ag -t"Saliri is DEAD!!" sevenleague_saliri_dead = \
    /if ({autoloot} = 1) /send get key corpse %; unlock north %; open north%; /endif %; \
    /echo -p %%% @{Ccyan}Seven-league Boots Quest: @{Cyellow}get key cor%%;unl n%%;n%%;kill crystal
/def -mglob -ag -t"The evil crystal is DEAD!!" sevenleague_crystal_dead = \
    /if ({autoloot} = 1) /send get shard corpse %; /endif %; \
    /echo -p %%% @{Ccyan}Seven-league Boots Quest: @{Cyellow}get shard cor%%;track sage%%;give shard sage
/def giveseven=give shard sage

;;;
;;; Antharia trigs to show next room
;;;
/def -mglob -t'Irghum is DEAD!!' irghum2heaustf = \
    /if ({autowalk} = 1) \
        w2nwn %; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki heau %; /endif%; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Irghum -> Heaustf: @{hCcyan}w2nwn@{n}
/def -mglob -t'Heaustf is DEAD!!' heaustf2cyrtpea = \
     /if ({autowalk} = 1) \
                se2nws %; \
                /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki cyrt %; /endif%; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Heaustf -> Cyrtpea: @{hCcyan}se2nws@{n}
/def -mglob -t'Cyrtpea is DEAD!!' cyrtpea2ertuvia = \
    /if ({autowalk} = 1) \
                n3w2s2en %; \
                /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki ert %; /endif%; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Cyrtpea -> Ertuvia: @{hCcyan}n3w2s2en@{n} %; \
    /echo -p %%% @{Cmagenta}Antharia Cyrtpea -> Knights: @{hCcyan}ne@{n}

/def -mglob -t'Ertuvia is DEAD!!' ertuvia2zaertses = \
     /if ({autowalk} = 1) \
                3sw2sws %; \
                /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki zaer %; /endif%; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Ertuvia -> Zaertses: @{hCcyan}3sw2sws@{n} %; \
    /echo -p  %%% @{Cmagenta}Antharia Ertuvia -> Knights: @{hCcyan}2s@{n}

/def -mglob -t'Zaertses is DEAD!!' zaertses2suretin = \
    /if ({autowalk} = 1) \
                n2e %; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Zaertses -> Suretin: @{hCcyan}n2e@{n}
/def -mglob -t'*Suretin, a healer-priest of Anthar, is here.' suretin2irghum = \
    /if ({autowalk} = 1) \
                3ene %; \
                /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki irg %; /endif%; \
    /endif %; \
    /echo -p %%% @{Cmagenta}Antharia Suretin -> Irghum: @{hCcyan}3ene@{n}

;;;
;;; Igecsoz autowalking
;;;
/def -mglob -t'Siguu is DEAD!!' siguu2silup = \
    /if ({autowalk} = 1) o e%;es%;o w%;w %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki silu %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Silup@{Cwhite}: esw %; \
    /endif
/def -mglob -t'Silup is DEAD!!' silup2iovuh = \
    /if ({autowalk} = 1) o e%;es%;o w%;w %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki io %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Iovuh@{Cwhite}: esw%; \
    /endif
/def -mglob -t'Iovuh is DEAD!!' iovuh2weapon = \
    /if ({autowalk} = 1) o e%;ed%;o e%;2esw %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki wea %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}The Keep Weaponsmith@{Cwhite}: ed2esw %; \
    /endif
/def -mglob -t'The Keep Weaponsmith is DEAD!!' weapon2armor = \
    /lootcor whetstone%; \
    /if ({autowalk} = 1) esw %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki arm %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}The Keep Armorer@{Cwhite}: esw %; \
    /endif
/def -mglob -p6 -F -t'The Keep Armorer is DEAD!!' armorer2royalguard = \
;    /if ({autowalk} = 1) e4n %; o e %; sca %; /endif 
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Royal Guards@{Cwhite}: e4ne

/def -mglob -p5 -t'The Keep Armorer is DEAD!!' armorer2brgyjts = \
    /if ({autowalk} = 1) e2sws2e%;/if (({autokill} = 1) & ({leader} =~ "Self")) /send ki brg %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Brgyjts@{Cwhite}: e2sws2e %; \
    /endif
/def -mglob -t'Throne Room' besideroyalguards = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Royal Bodyguards@{Cwhite}: e4n %; \
    /echo -p %%% @{Cwhite}Or @{Ccyan}Brgyjts@{Cwhite}: 6sws2e 
/def -mglob -t'Queen Hcuyj is DEAD!!' queen2brgyjts = \
    /if ({autowalk} = 1) esdw6sws2e %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki brg %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Brgyjts@{Cwhite}: esdw6sws2e %; \
    /endif
/def -mglob -t'Brgyjts the Grocer is DEAD!!' brgyjts2ajuu = \
    /if ({autowalk} = 1) s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki aju %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Ajuu@{Cwhite}: s %; \
    /endif
/def -mglob -t'Ajuu the Housewares Vendor is DEAD!!' ajuu2hjiuysi = \
    /if ({autowalk} = 1) s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki hj %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Hjiuysi@{Cwhite}: s %; \
    /endif
/def -mglob -t'Hjiuysi the Leather Worker is DEAD!!' hjiuysi2ekjuistn = \
    /if ({autowalk} = 1) 2e %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki ek %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Ekjuistn@{Cwhite}: 2e %; \
    /endif
/def -mglob -t'Ekjuistn the Armorer is DEAD!!' ekjuistn2hlutjhlags = \
    /if ({autowalk} = 1) n %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki hl %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Hlutjhlags@{Cwhite}: n %;\
    /endif
/def -mglob -t'Hlutjhlags the Butcher is DEAD!!' hlutjhlags2kinstjlisti = \
    /if ({autowalk} = 1) n %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki kin %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Kinstjlisti@{Cwhite}: n %;\
    /endif
/def -mglob -t'Kinstjlisti the Weaponsmith is DEAD!!' kinstjlisti2hlestn = \
    /if ({autowalk} = 1) swd %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki hle %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Hlestn@{Cwhite}: swd %;\
    /endif
/def -mglob -t'Hlestn the Slaver is DEAD!!' hlestn2abbess = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Abbess@{Cwhite}: uen4w2n6w2e3w2nw
    
/def -mglob -t'The Abbess of Igecsoz is DEAD!!' abbess_dead = \
    /echo -p %%% @{Cwhite}Area done, check Siguu for repop. %; \
/def -mglob -t"Siguu*Siguu\'s Room" abbess2siguu = \
    /if ({autowalk} = 1) \
        e2s7esenwe3n2wu2nw %; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki sig %; /endif%; \
    /else \
        /echo -p %%% @{Cwhite}Next mob @{Ccyan}Siguu@{Cwhite}: e2s7esenwe3n2wu2nw %;\
    /endif

;;;
;;; Hamlet of Kreigstadt
;;;
/def -mglob -t'Otto is DEAD!!' otto_dead = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Wolfie@{Cwhite}: Same Room%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki wolf %; /endif
/def -mglob -t'Wolfie is DEAD!!' wolfie_dead = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Sieghard@{Cwhite}: Same Room%; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki sieg %; /endif
/def -mglob -t'Sieghard is DEAD!!' sieghard_dead = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Uda@{Cwhite}: Same Room%; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki uda %; /endif
/def -mglob -t'Uda is DEAD!!' uda2herr = \
    /if ({autowalk} = 1) wn %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki kru %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Kruger@{Cwhite}: wn %;\
    /endif
/def -mglob -t'Herr Kruger is DEAD!!' herr2frau = \
        /if ({autowalk} = 1) n %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki kru %; /endif%; \
        /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Kruger@{Cwhite}: n %;\
        /endif
/def -mglob -t'Frau Kruger is DEAD!!' frau2clerk = \
    /if ({autowalk} = 1) 3s%;o s%;2s2w%;o s%;s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki cler %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} The council clerk@{Cwhite}: 5s2ws %;\
    /endif
/def -mglob -t'The council clerk is DEAD!!' clerk2schulz = \
    /if ({autowalk} = 1) o s%;s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki sch %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} The schulz@{Cwhite}: s %;\
    /endif
/def -mglob -t'The schulz is DEAD!!' schulz2bowmaster = \
    /if ({autowalk} = 1) o n%;n%;o n%; n%;w %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki bowm %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Sasha@{Cwhite}: 2ne6s2es %;\
    /endif
/def -mglob -t'The village bowmaster is DEAD!!' bowmaster2sasha = \
    /if ({autowalk} = 1) 2e6s2es %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki sash %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Sasha@{Cwhite}: 2e6s2es %;\
    /endif
/def -mglob -t'Sasha is DEAD!!' sasha_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki raj %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Raja@{Cwhite}: Same Room
/def -mglob -t'Raja is DEAD!!' raja_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki iva %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Ivan@{Cwhite}: Same Room
/def -mglob -t'Ivan is DEAD!!' ivan2muriel = \
;    /if ({autowalk} = 1) s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki mur %; /endif%; \
;    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Madam Muriel@{Cwhite}: s %; \
;    /endif
    /if ({autowalk} = 1) /send east%;/if (({autokill} = 1) & ({leader} =~ "Self")) /send ki flesh%;/endif%;\
    /else /echo -pw %%% @{Cwhite}Next mob @{Ccyan} Flesh Golem@{Cwhite}:east%;\
    /endif
/def -mglob -t'Madam Muriel is DEAD!!' muriel2flesh = \
    /if ({autowalk} = 1) ne %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki fle %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Flesh Golem@{Cwhite}: ne %; \
    /endif
/def -mglob -t'A flesh golem is DEAD!!' flesh2wodewose = \
    /if ({autowalk} = 1) wn2e%;o s%;s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki wod %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} The wodewose@{Cwhite}: wn2es %; \
    /endif
/def -mglob -t'The wodewose is DEAD!!' wodewose2holzfrau = \
    /if ({autowalk} = 1) o n%;ne%;o n%;n %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki holz %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} The holzfrau@{Cwhite}: nen %; \
    /endif
/def -mglob -t'The holzfrau is DEAD!!' holzfrau2changling = \
    /if ({autowalk} = 1) o s%;se%;o s%;s %; /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki chang %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} The changling@{Cwhite}: ses %; \
    /endif
/def -mglob -t'The changeling is DEAD!!' changling2shadows = \
    /if ({autowalk} = 1) \
        op north%;north %; open e %; east  %; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki shado %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} Shadows@{Cwhite}: ne %; \
    /endif
/def -mglob -t'A cul-de-sac' countshadows_room = /set numShadows=0
/def -mglob -t'*A shadow hides here.' countshadows = /set numShadows=$[numShadows+1]
/def -mglob -t'A shadow is DEAD!!' shadow_dead = \
    /set numShadows=$[numShadows-1] %; \
    /if ({autowalk} = 1) \
        /if ({numShadows} = 0) \
            o w%;8w%;o s%;s%;o w%;w%;o n%;n %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki warl %; /endif%; \
        /else \
            /echo -p %%% @{Cwhite}Next mob @{Ccyan}Shadow@{Cwhite}: Same Room. %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki wom %; /endif%; \
        /endif %; \
    /else \
        /if ({numShadows} = 0) /echo -p %%% @{Cwhite}Next mob @{Ccyan}Warlock@{Cwhite}: 8wswn %; \
        /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Shadow@{Cwhite}: Same Room. %; \
        /endif %; \
    /endif

/def -mglob -t'A warlock is DEAD!!' warlock_dead = \
    /echo -p %%% @{Cwhite}Area done, check Otto for repop. Dirs to Otto sene8nene %; \
    /echo -p %%% @{Cwhite}Alternatively, Saint of the Blade Temple: sene2nw%;\
    /if ({autowalk} = 1) /send where otto%; /endif
/def -mglob -t'Otto*A table in the corner' warlock2otto = \
    /if ({autowalk} = 1) sene8ne%;o n%;ne %; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Otto@{Cwhite}: sene8nene %; \
    /endif
/def -mregexp -t'^You didn\'t find any (otto|Otto).' nootto = \
    /if ({autowalk} = 1) sene2nw %; \
    /else /echo -p %%% @{Cwhite}Saint of the Blade Temple: sene2nw %; \
    /endif

;;;
;;; Apocalypse
;;;
/def -mglob -t'The black slime is DEAD!!' slime2survivor = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Survivor Guard@{Cwhite}: 2w2n2ed %; \
    /set mobNum=1
/def -mglob -t'The Survivor Guard is DEAD!!' survivor_dead = \
    /if ({mobNum} = 4) \
        /if ({autowalk} = 1) \
            2e%;o d%;dw%;o s%;s %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki ding %; /endif%; \
        /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Dingo@{Cwhite}: 2edws%; \
        /endif %; \
    /elseif ({mobNum} = 3) \
        /if ({autowalk} = 1) \
            4w %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki surv %; /endif%; \
        /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Survivor Guard@{Cwhite}: 4w%; \
        /endif %; \
    /elseif ({mobNum} = 2) \
        /if ({autowalk} = 1) \
            2s2e %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki surv %; /endif%; \
        /else \
            /echo -p %%% @{Cwhite}Next mob @{Ccyan}Survivor Guard@{Cwhite}: 2s2e%; \
            /echo -p %%% @{Cwhite}Or @{Ccyan}Slime @{Cwhite}: up%; \
        /endif %; \
    /elseif ({mobNum} = 1) \
        /if ({autowalk} = 1) \
            4n %; \
            /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki surv %; /endif%; \
        /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Survivor Guard@{Cwhite}: 4n%; \
        /endif %; \
    /endif %; \
    /set mobNum=$[mobNum+1] %; \
    /if ({mobNum} > 4) /set mobNum=1 %; /endif
/def -mglob -t'Dingo is DEAD!!' dingo2shade = \
    /if ({autowalk} = 1) \
        o n%;nw%;o s%;s%;\
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki shad %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Shade@{Cwhite}: nws %; \
    /endif
/def -mglob -t'Shade is DEAD!!' shade2gryphon = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki gry %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Gryphon@{Cwhite}: Same Room
    
/def -mglob -t'Gryphon is DEAD!!' gryphon2fire= \
    /if ({autowalk} = 1) \
        o n%;n2e%;o u%;u2n%;o u%;uw2ne %; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki fire %; /endif%; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan}Whatever@{Cwhite}: n2eu2nu %; \
    /endif

;;;
;;; Padmasa
;;;
/def -mglob -t'Vapul is DEAD!!' vapul2heruta = \
    /if ({autowalk} = 1) e %; /endif%;\
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Heruta Skash@{Cwhite}: e %; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki heru %; /endif
/def -mglob -t'Heruta Skash is DEAD!!' heruta_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki gzu %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Gzug-Therva@{Cwhite}: Same Room
/def -mglob -t'Gzug-Therva is DEAD!!' therva_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki azoz %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Prad Azoz@{Cwhite}: Same Room
/def -mglob -t'Prad Azoz is DEAD!!' azoz_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki gsh %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Gshtunga@{Cwhite}: Same Room
/def -mglob -t'Gshtunga is DEAD!!' gshtunga_dead = \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki dats %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Prad Datse@{Cwhite}: Same Room
/def -mglob -t'Prad Datse is DEAD!!' datse2slave = \
    /if ({autowalk} = 1) o w%;2w %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} slave@{Cwhite}: 2w %; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki slave%; /endif
/def -mglob -t'A blinded slave is DEAD!!' slave2administrator = \
    /if ({autowalk} = 1) w2us%;o s%;s %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Administrator@{Cwhite}: w2u2s %; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki admin %; /endif
/def -mglob -t'Administrator Gru-Dzek is DEAD!!' administrator2doom = \
    /if ({autoloot} = 1) /lootcor wafer %; /endif %; \
    /if ({autowalk} = 1) 2nd3e %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan} Doom@{Cwhite}: 2nd3e %; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki doom %; /endif
;A Padmasa guard is DEAD!!
;Mesomaster Scanner is DEAD!!
/def -mglob -t'The Doom is DEAD!!' doom2padmasaguard = \
    /if ({autoloot} = 1) /lootcor shard%;/lootcor collar%; /endif%; \
    /if ({autowalk} = 1) 3w3us %; /endif%; \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Padmasa Guard@{Cwhite}: 3w3us %; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki guar %; /endif

/def -mglob -t'General Lukash is DEAD!!' lukash_dead = \
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}An army of imps and trolls@{Cwhite}: Same Room%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki army %; /endif
;;/def -mglob -t'An army of imps and trolls is DEAD!!' imparmy_dead = \
;;    /if ({autowalk} = 1) <<Directions>> %; 
;;    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} <<Next Mob Name>>@{Cwhite}: <<Directions>>%; \
;;    /endif

;;;
;;; Tortuga Cay
;;;
/def -mglob -t'* A weathered man is here tending his oats\.' conian_room = \
    /set numGigantoise=2%;\
    /if ({autowalk} = 1) es%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -p %%% @{Cwhite}Next mob @{Ccyan}Broad-headed Tortuga@{Cwhite}: es

/def -mglob -t'Broad-headed Tortuga is DEAD!!' broadheadedtortuga_dead = \
    /if ({autowalk} = 1) es%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Horned Tortuga@{Cwhite}: es

/def -mglob -t'Horned Tortuga is DEAD!!' hornedtortuga_dead = \
    /if ({autowalk} = 1) 3wn%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan} Soft-Shelled Tortuga@{Cwhite}: 3wn

/def -mglob -t'Oat Herding' resetshoftshellcount = /set numSoftshelled=0
/def -mregexp -t'A tortuga with a smooth shell (eats up oats|grazes here)\.' countsoftshelledtortuga = \
    /set numSoftshelled=$[numSoftshelled+1]
/def -mglob -t'Soft-shelled Tortuga is DEAD!!' softshelledtortuga_dead = \
    /set numSoftshelled=$[numSoftshelled-1]%;\
    /if ({numSoftshelled} = 0) \
        /if ({autowalk} = 1) n3w%;/endif%;\
        /echo -p %%% @{Cwhite}Next mob @{Ccyan}Gigantoise Tortuga@{Cwhite}: n3w.%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /else \
        /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Soft-Shelled Tortuga@{Cwhite}: Same Room%; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%; \
    /endif

/def -mglob -t'Gigantoise Tortuga is DEAD!!' gigantoise_dead = \
    /set numGigantoise=$[numGigantoise-1] %; \
    /if ({numGigantoise} = 0) \
        /echo -p %%% @{Cwhite}Next mob @{Ccyan}Egg-laying Tortuga@{Cwhite}: 2s. %; \
        /if ({autowalk} = 1) 2s%;/endif%;\
    /else \
        /if ({autowalk} = 1) 2wse%;/endif%;\
        /echo -p %%% @{Cwhite}Next mob @{Ccyan} Immature Tortuga@{Cwhite}: 2wse%; \
    /endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif

/def -mglob -t'Learning to stomp its feet here is a young tortuga\.' countimmaturetortuga = \
    /set numImmatures=$[numImmatures+1]
/def -mglob -t'Immature Tortuga is DEAD!!' immaturetortuga_dead = \
    /set numImmatures=$[numImmatures-1] %; \
    /if ({numImmatures} = 0) \
        /echo -p %%% @{Cwhite}Next mob @{Ccyan}Snapping Turtle@{Cwhite}: s. %; \
        /if ({autowalk} = 1) s%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki turt %; /endif%;\
    /else \
        /echo -p %%% @{Cwhite}Next mob @{Ccyan}Immature Tortuga@{Cwhite}: Same Room.%; \
        /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%; \
    /endif

/def -mglob -t'Snapping Turtle is DEAD!!' snappingturtle_dead = \
    /if ({autowalk} = 1) nw%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Gigantoise Tortuga@{Cwhite}: nw

/def -mglob -t'Egg-Laying Tortuga is DEAD!!' egglayingtortuga_dead = \
    /if ({autowalk} = 1) es%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan} Bearded Tortuga@{Cwhite}: es

/def -mglob -t'Bearded Tortuga is DEAD!!' beardedtortuga_dead = \
    /if ({autowalk} = 1) ne%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Spiny Tortuga@{Cwhite}: ne

/def -mglob -t'Spiny Tortuga is DEAD!!' spinytortuga_dead = \
    /if ({autowalk} = 1) n2wnesdd%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki matr %; /endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Matriarch Tortuga@{Cwhite}: n2wnesdd

/def -mglob -t'Tortuga Matriarch is DEAD!!' matriarchtortuga_dead = \
    /if ({autowalk} = 1) 2un5e%;/endif%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki tort %; /endif%;\
    /echo -pw %%% @{Cwhite}Skin corpse for ticket for Tortuga Shell Amulet%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Wise Tortuga@{Cwhite}: 2un5e\;give fragment wise

/def -mglob -t'Wise Tortuga is DEAD!!' wisetortuga_dead = \
    /if ({autowalk} = 1) n%;/endif%;\
    /echo -pw %%% @{Cwhite}Next mob @{Ccyan}Conian Hermit@{Cwhite}: n\;give egg conian

;;;
;;; Serpent Weyr
;;;
/def -mglob -t'The hill giant king is DEAD!!' giant_king_dead = \
    /if ({autowalk} = 1) get key cor %; 3s4en %; unl n %; 4n%; \
    /if (({autokill} = 1) & ({leader} =~ "Self")) /send ki witch %; /endif %; \
    /else /echo -p %%% @{Cwhite}Next mob @{Ccyan} witch@{Cwhite}: get key cor%%;3s4en%%;unl n%%;4n%%;ki witch %; \
    /endif


;;;
;;; Auto-walk macroes
;;;
;;; /walk2dir <Source> <Destination> <directions>
;;; Show <directions> to <Destination> from <Source>.  If Auto-Walk is on, then
;;; also walk <directions>
/def walk2dir = \
    /if ({#}<3) \
        /echo -p %%% @{Cred}/walk2dir @{Cyellow}SOURCENAME DESTINATIONNAME DIRECTIONS@{n}%;\
    /else \
        /let source=%1 %; /let destination=%2 %; /let directions=%3 %; \
        /echo -p %%% @{Ccyan}%destination@{n} From@{Ccyan} %source@{n}:@{Ccyan} %directions %; \
        /if ({autowalk} = 1) /eval %directions %; /endif%;\
    /endif

;;; Guild directions
/set dirs=Githzerai Tower (@{Ccyan}/githtower@{Cwhite}), Guilds (@{Ccyan}/classguild@{Cwhite}), Statue of Utami (@{Ccyan}/utami@{Cwhite}), Doom (@{Ccyan}/admin2doom@{Cwhite}), Recall Dirs (@{Ccyan}/recalldirs@{Cwhite})
/def recalldirs = /echo -p %%% @{Cwhite}@{Cwhite}Recall Paths: Aelmon To Sol (@{Ccyan}ael2sol@{Cwhite}), Aelmon to Zin (@{Ccyan}ael2zin@{Cwhite}), @{Cwhite}Sol To Aelmon (@{Ccyan}sol2ael@{Cwhite}), Zin To Aelmon (@{Ccyan}zin2ael@{Cwhite})

/def cleguild = /echo -p %%% @{Cwhite}@{Ccyan}Guildmaster High Priest (Cleric Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 5wn2wu %; \
    /if ({autowalk} = 1) 5wn2wu%; /endif
/def magguild = /echo -p %%% @{Cwhite}@{Ccyan}Guildmaster Arch Mage (Mage Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 8s2w3n\;o n\;n\;o w\;w\;o n\;n2u%; \
    /if ({autowalk} = 1) 8s2w3n%;o n%;n%;o w%;w%;o n%;n2u %; /endif
/def monguild = /echo -p %%% @{Cwhite}@{Ccyan}Huran (Monk Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14nw3nwn\;o e\;e2n2w3s\;o s\;s %; \
    /if ({autowalk} = 1) 14nw3nwn%;o e%;e2n2w3s%;o s%;s%; /endif
/def revmonguild = /echo -p %%% @{Cwhite}Out of @{Ccyan}Monk Guild@{Cwhite}: o n\;4n2e2s\;o w;wse3se14s%; \
    /if ({autowalk} = 1) o n%;4n2e2s%;o w%;wse3se14s%; /endif 
/def unmonguild = /revmonguild

/def psiguild = /echo -p %%% @{Cwhite}@{Ccyan}Guildmaster Psionicist Mistress (Psion Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 8s2w3n\;o n\;n\;o w\;w\;o w\;w%; \
    /if ({autowalk} = 1) 8s2w3n%;o n%;n%;o w%;w%;o w%;w%; /endif
/def rogguild = /echo -p %%% @{Cwhite}@{Ccyan}Guildmaster Thief (Rogue Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 7n2e3se\;o s\;s %; \
    /if ({autowalk} = 1) 7n2e3se%;o s%;s %; /endif
/def ranguild = /echo -p %%% @{Cwhite}@{Ccyan}Ex-Wayfinder (Ranger Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan}8e3n\;o w\;w%; \
    /if ({autowalk} = 1) 8e3n;o w;w%; /endif
/def warguild = /echo -p %%% @{Cwhite}@{Ccyan}Weaponsmaster (Warrior Guild)@{Cwhite} From@{Ccyan} Hulk War@{Cwhite}:@{Ccyan} sen%; \
    /if ({autowalk} = 1) sen%; /endif
/def arcguild = /echo -p %%% @{Cwhite}@{Ccyan}Lord of the Hunt (Archer Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 5s3e2nunw%; \
    /if ({autowalk} = 1) 5s3e2nunw%; /endif
/def asnguild = /echo -p %%% @{Cwhite}@{Ccyan}Hitman (Assassin Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 9s8w\;o w\;w\;o u\;2u%;\
    /if ({autowalk} = 1) 9s8w%;o w%;w%;o u%;2u%; /endif
/def bodguild = /echo -p %%% @{Cwhite}@{Ccyan}Gruuntak (Bodyguard Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19n3w5nd3nwnw3nu2ne3nwnw11n3e\;o n\;n%;\
    /if ({autowalk} = 1) 19n3w5nd3nwnw3nu2ne3nwnw11n3e;o n;n%;/endif
/def bzkguild = /echo -p %%% @{Cwhite}@{Ccyan}Hairy Barbarian (Berserker Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 6en%;\
    /if ({autowalk} = 1) 6en%; /endif
/def bciguild = /echo -p %%% @{Cwhite}@{Ccyan}Black Circle Master (Black Circle Initiate Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14n8w3n6w4nwunwdnd2ne2n2w2nwu2wn2ueu3nese2nwnd2ndwde2d3n2w%;\
    /if ({autowalk} = 1) 14n8w3n6w4nwunwdnd2ne2n2w2nwu2wn2ueu3nese2nwnd2ndwde2d3n2w%; /endif
/def bldguild = /echo -p %%% @{Cwhite}@{Ccyan}Araxia (Bladedancer Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14n4w4n2d4enes%;\
    /if ({autowalk} = 1) 14n4w4n2d4enes%; /endif
/def druguild = /echo -p %%% @{Cwhite}@{Ccyan}Tari (Druid Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 17ws5w3n3wnwn2ws2wsdwun6wn2w%;\
    /if ({autowalk} = 1) 17ws5w3n3wnwn2ws2wsdwun6wn2w%; /endif
/def fusguild = /echo -p %%% @{Cwhite}@{Ccyan}Shen (Fusilier Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16e\;o e\;e2en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2ne2s%;\
    /if ({autowalk} = 1) 16e%;o e%;e2en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2ne2s%; /endif
/def mndguild = /echo -p %%% @{Cwhite}@{Ccyan}Ngataki (Mindbender Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 13e3ne%;\
    /if ({autowalk} = 1) 13e3ne%; /endif
/def palguild = /echo -p %%% @{Cwhite}@{Ccyan}Ganastrikos (Paladin Guild)@{Cwhite} From@{Ccyan} Aleryia@{Cwhite}:@{Ccyan} se%;\
    /if ({autowalk} = 1) se%; /endif
/def prsguild = /echo -p %%% @{Cwhite}@{Ccyan}Paean (Priest Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 2w\;o n\;2n2u2es\;o w\;w%;\
    /if ({autowalk} = 1) 2w%;o n%;2n2u2es%;o w%;w%; /endif
/def shfguild = /echo -p %%% @{Cwhite}@{Ccyan}Diryn (Shadowfist Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n10eneseunenwened4en%;\
    /if ({autowalk} = 1) 24n10eneseunenwened4en%; /endif
/def sorguild = /echo -p %%% @{Cwhite}@{Ccyan}Master of Pain (Sorcerer Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 9w4s\;o e\;e%;\
    /if ({autowalk} = 1) 9w4s%;o e%;e%; /endif
/def stmguild = /echo -p %%% @{Cwhite}@{Ccyan}Yazimetra (Stormlord Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 8n7e\;o e\;e\;o u\;3u2n%;\
    /if ({autowalk} = 1) 8n7e%;o e%;e%;o u%;3u2n%; /endif
/def wzdguild = /echo -p %%% @{Cwhite}@{Ccyan}Threnadir (Wizard Guild)@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} UNKNOWN

/def classguild = /echo -p %%% @{Cwhite}@{Cwhite} Guild Paths:@{Ccyan} <Class Abbreviation>guild@{Cwhite}

/def myguild = /eval /%{myclass}guild
;;; Walk between recalls

/def sol2nom = /walk2dir "Sol" "Nom" "9es2e"
/def nom2sol = /echo -p %%% @{Ccyan}Sol@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 2wn9w %; \
    /if ({autowalk} = 1) 2wn9w%; /endif
/def sol2ael = /echo -p %%% @{Ccyan}Aelmon@{Cwhite} From@{Ccyan} Sol@{Cwhite}:@{Ccyan} 15e5s2es2es19e %; \
    /if ({autowalk} = 1) 15e5s2es2es19e%; /endif
/def ael2sol = /echo -p %%% @{Ccyan}Sol@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 17ws5w3n3w1n3w %; \
    /if ({autowalk} = 1) 17ws5w3n3w1n3w%; /endif
/def ael2zin = /echo -p %%% @{Ccyan}Zin@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16e%%;o e%%;3e2s2d%%;o e%%;e4u %; \
    /if ({autowalk} = 1) 16e %; o e %; 3e2s2d %; o e %; e4u%; /endif
/def zin2ael = /echo -p %%% @{Ccyan}Aelmon@{Cwhite} From@{Ccyan} Zin@{Cwhite}:@{Ccyan} 4d%%;o w%%;w2u2n3w%%;o w%%;16w %; \
    /if ({autowalk} = 1) 4d %; o w %; w2u2n3w %; o w %; 16w%; /endif

;;; Walking macroes from Aelmon
/def ael2anth = /echo -p %%% @{Ccyan}Antharia@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s3ed %; \
    /if ({autowalk} = 1) 34se2s3ed%; /endif
/def ael2apoc = /echo -p %%% @{Ccyan}Apocalypse@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene5nese %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene5nese%; /endif
/def ael2batt = /echo -p %%% @{Ccyan}Battleground@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2n %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2n%; /endif
/def ael2borl = /echo -p %%% @{Ccyan}Borley Manor@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n4e2nueuwunu2ne5n %; \
    /if ({autowalk} = 1) 24n4e2nueuwunu2ne5n%; /endif
/def ael2cov = /echo -p %%% @{Ccyan}Coven@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en3enwn %; \
    /if ({autowalk} = 1) 19en3enwn%; /endif
/def ael2cry = /echo -p %%% @{Ccyan}Dragon Crypt@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n10eue %; \
    /if ({autowalk} = 1) 24n10eue%; /endif
/def ael2desp = /echo -p %%% @{Ccyan}Caverns of Despair@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3n2e2s %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3n2e2s%; /endif
/def ael2dre = /echo -p %%% @{Ccyan}Midsummer Nights Dream@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n9e2n %; \
    /if ({autowalk} = 1) 24n9e2n%; /endif
/def ael2eri = /echo -p %%% @{Ccyan}Erisian Temple@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3n2e2s4ene %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3n2e2s4ene%; /endif
/def ael2fate = /echo -p %%% @{Ccyan}Cavern of the Fates@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3n2e2s3e3s %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3n2e2s3e3s%; /endif
/def ael2freep = /echo -p %%% @{Ccyan}Freeport@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s7e2n9e2ned2n5ws %; \
    /if ({autowalk} = 1) 34se2s7e2n9e2ned2n5ws%; /endif
/def ael2grav = /echo -p %%% @{Ccyan}Graveyard@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 15e:o s:s %; \
    /if ({autowalk} = 1) 15e %; o s %; s%; /endif
/def ael2ham = /echo -p %%% @{Ccyan}Hamlet of Kreigstadt@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3nws %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3nws%; /endif
/def ael2hea = /echo -p %%% @{Ccyan}Heather Flats@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 13wn  %; \
    /if ({autowalk} = 1) 13wn %; /endif
/def ael2hive = /echo -p %%% @{Ccyan}Alien Hive@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene5nese2n7e4nen %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene5nese2n7e4nen%; /endif
/def ael2ige = /echo -p %%% @{Ccyan}Igecsoz@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 17se %; \
    /if ({autowalk} = 1) 17se%; /endif
/def ael2gorn = /echo -p %%% @{Ccyan}Temple of Gorn@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14nwn %; \
    /if ({autowalk} = 1) 14nwn%; /endif
/def ael2ker = /echo -p %%% @{Ccyan}Kerofk@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n15e %; \
    /if ({autowalk} = 1) 24n15e%; /endif
/def ael2kzno = /echo -p %%% @{Ccyan}Kzinti Outpost@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene6n %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene6n%; /endif
/def ael2lake = /echo -p %%% @{Ccyan}Lake Triumph@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 13en %; \
    /if ({autowalk} = 1) 13en%; /endif
/def ael2mic = /echo -p %%% @{Ccyan}Sir Michael's Stronghold@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e4n2e %; \
    /if ({autowalk} = 1) 19en2e3s3e4n2e%; /endif
/def ael2mide = /echo -p %%% @{Ccyan}Miden'nir@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14ws %; \
    /if ({autowalk} = 1) 14ws%; /endif
/def ael2midgc = /echo -p %%% @{Ccyan}Midgaard Country@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n5es %; \
    /if ({autowalk} = 1) 24n5es%; /endif
/def ael2moo = /echo -p %%% @{Ccyan}Moose Lodge@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 18en %; \
    /if ({autowalk} = 1) 18en%; /endif
/def ael2mus = /echo -p %%% @{Ccyan}Museum@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 5s2e2sw %; \
    /if ({autowalk} = 1) 5s2e2sw%; /endif
/def ael2noc = /echo -p %%% @{Ccyan}Nocte Abbey@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 13e:o s:s %; \
    /if ({autowalk} = 1) 13e %; o s %; s%; /endif
/def ael2nofc = /echo -p %%% @{Ccyan}North of Ofcol@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n4en %; \
    /if ({autowalk} = 1) 24n4en%; /endif
/def ael2nub = /echo -p %%% @{Ccyan}Nubrius@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s4ws2w3se %; \
    /if ({autowalk} = 1) 34se2s4ws2w3se%; /endif
/def ael2oce = /echo -p %%% @{Ccyan}Ocean@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s %; \
    /if ({autowalk} = 1) 34se2s%; /endif
/def ael2ofc = /echo -p %%% @{Ccyan}Ofcol@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 20n %; \
    /if ({autowalk} = 1) 20n%; /endif
/def ael2pad = /echo -p %%% @{Ccyan}Padmasa@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s7es %; \
    /if ({autowalk} = 1) 34se2s7es%; /endif
/def ael2pir = /echo -p %%% @{Ccyan}Pirate Lord Isles@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s7e2n8en %; \
    /if ({autowalk} = 1) 34se2s7e2n8en%; /endif
/def ael2que = /echo -p %%% @{Ccyan}House of Quests@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s6ws2w2n %; o n %; n %; \
    /if ({autowalk} = 1) 34se2s6ws2w2n %; o n %; n%; /endif
/def ael2qui = /echo -p %%% @{Ccyan}Quifael's House@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 8s2w3n2w:o w:w %; \
    /if ({autowalk} = 1) 8s2w3n2w %; o w %; w%; /endif
/def ael2rava = /echo -p %%% @{Ccyan}Rivers of Avatar@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 14e6n2e %; \
    /if ({autowalk} = 1) 14e6n2e%; /endif
/def ael2rdrg = /echo -p %%% @{Ccyan}Red Dragon's Lair@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s4e2s2e2nd %; \
    /if ({autowalk} = 1) 19en2e3s4e2s2e2nd%; /endif
/def ael2rui = /echo -p %%% @{Ccyan}Ruins of Keresh@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16sw %; \
    /if ({autowalk} = 1) 16sw%; /endif
/def ael2scur = /echo -p %%% @{Ccyan}S.S. Scurvy@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2swu %; \
    /if ({autowalk} = 1) 34se2swu%; /endif
/def ael2sea = /echo -p %%% @{Ccyan}Seas of Pirate Lords@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s7e2n8e %; \
    /if ({autowalk} = 1) 34se2s7e2n8e%; /endif
/def ael2sec = /echo -p %%% @{Ccyan}Secrets@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 23n9en:o d:d %; \
    /if ({autowalk} = 1) 23n9en %; o d %; d%; /endif
/def ael2seno = /echo -p %%% @{Ccyan}Senex Operis@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16s2wnwn %; \
    /if ({autowalk} = 1) 16s2wnwn%; /endif
/def ael2serp = /echo -p %%% @{Ccyan}Serpent Weyr@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 19en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2ne2sd3nw2ne9n2w3n3wu %; \
    /if ({autowalk} = 1) 19en2e3s3e3n2w3nwnene3n2e2s3e2s2e3s3en2ene2ne2sd3nw2ne9n2w3n3wu%; /endif
/def ael2sew = /echo -p %%% @{Ccyan}Sewer@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n2e:o d:d %; \
    /if ({autowalk} = 1) 24n2e %; o d %; d%; /endif
/def ael2shad = /echo -p %%% @{Ccyan}Shadow Keep@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n4e2nueuwnunu2ne3n2enen2u %; \
    /if ({autowalk} = 1) 24n4e2nueuwnunu2ne3n2enen2u%; /endif
/def ael2sil = /echo -p %%% @{Ccyan}Silmavar Labyrinth@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16e:o e:es:o d:dw %; \
    /if ({autowalk} = 1) 16e %; o e %; es %; o d %; dw%; /endif
/def ael2solo = /echo -p %%% @{Ccyan}Solomon's Treasure@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 16e:o e:es %; \
    /if ({autowalk} = 1) 16e %; o e %; es%; /endif
/def ael2tha = /echo -p %%% @{Ccyan}New Thalos@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 21s %; \
    /if ({autowalk} = 1) 21s%; /endif
/def ael2uta = /echo -p %%% @{Ccyan}Island of Utami@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 34se2s5es %; \
    /if ({autowalk} = 1) 34se2s5es%; /endif
/def ael2will = /echo -p %%% @{Ccyan}Kingdom of the Willows@{Cwhite} From@{Ccyan} Aelmon@{Cwhite}:@{Ccyan} 24n6ws %; \
    /if ({autowalk} = 1) 24n6ws%; /endif

;;; Walking macroes from Nom
/def nom2ava = /echo -p %%% @{Ccyan}Air of Avatar@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w6su %; \
    /if ({autowalk} = 1) n8w6su%; /endif
/def nom2cata = /echo -p %%% @{Ccyan}Dwarven Catacombs@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n3w4n2w2nw2n3e2sd %; \
    /if ({autowalk} = 1) n8w2n3e5n3w4n2w2nw2n3e2sd%; /endif
/def nom2cimm = /echo -p %%% @{Ccyan}Cimmeria@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 4ses %; /if ({autowalk} = 1) 4ses%; \
    /endif
/def nom2crys = /echo -p %%% @{Ccyan}Crystalmir Lake@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8ws3e6s %; \
    /if ({autowalk} = 1) n8ws3e6s%; /endif
/def nom2day = /echo -p %%% @{Ccyan}Dwarven Day Care@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 5es3e2s %; \
    /if ({autowalk} = 1) 5es3e2s%; /endif
/def nom2dwfk = /echo -p %%% @{Ccyan}Dwarven Kingdom@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n3wn %; \
    /if ({autowalk} = 1) n8w2n3e5n3wn%; /endif
/def nom2drw = /echo -p %%% @{Ccyan}Drow City@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n3w4n2e2d2e2den5e3n3esw %; \
    /if ({autowalk} = 1) n8w2n3e5n3w4n2e2d2e2den5e3n3esw%; /endif
/def nom2due = /echo -p %%% @{Ccyan}Duergar Stronghold@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n3w4ne:o e:e2d2ed %; \
    /if ({autowalk} = 1) n8w2n3e5n3w4ne %; o e %; e2d2ed%; /endif
/def nom2elev = /echo -p %%% @{Ccyan}Elemental Valley@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e9nw  %; \
    /if ({autowalk} = 1) n8w2n3e9nw %; /endif
/def nom2elvf = /echo -p %%% @{Ccyan}Elven Foothills@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e8n3esd3wneu %; \
    /if ({autowalk} = 1) n8w2n3e8n3esd3wneu%; /endif
/def nom2few = /echo -p %%% @{Ccyan}Fewmaster's Folly@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w11s4w3n2w %; \
    /if ({autowalk} = 1) n8w11s4w3n2w%; /endif
/def nom2fire = /echo -p %%% @{Ccyan}Fire Ants@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 4s3ed %; \
    /if ({autowalk} = 1) 4s3ed%; /endif
/def nom2fizz = /echo -p %%% @{Ccyan}Fizzdop's Lair@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5nws %; \
    /if ({autowalk} = 1) n8w2n3e5nws%; /endif
/def nom2gnov = /echo -p %%% @{Ccyan}Gnome Village@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n2ws %; \
    /if ({autowalk} = 1) n8w2n3e5n2ws%; /endif
/def nom2gobc = /echo -p %%% @{Ccyan}Goblin Caverns@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 5es3eun %; \
    /if ({autowalk} = 1) 5es3eun%; /endif
/def nom2gobp = /echo -p %%% @{Ccyan}Goblin Pass@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 4s5e %; \
    /if ({autowalk} = 1) 4s5e%; /endif
/def nom2hell = /echo -p %%% @{Ccyan}Descent to Hell@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w11sw4n3wseue2s %; \
    /if ({autowalk} = 1) n8w11sw4n3wseue2s%; /endif
/def nom2hive = /echo -p %%% @{Ccyan}Alien Hive@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w11s4w3nw4swn %; \
    /if ({autowalk} = 1) n8w11s4w3nw4swn%; /endif
/def nom2mist = /echo -p %%% @{Ccyan}Forest of Mist@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n9wn2ws2wsdwun3w3n %; \
    /if ({autowalk} = 1) n9wn2ws2wsdwun3w3n%; /endif
/def nom2newt = /echo -p %%% @{Ccyan}Land of the Fire Newts@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e8n6e %; \
    /if ({autowalk} = 1) n8w2n3e8n6e%; /endif
/def nom2high = /echo -p %%% @{Ccyan}HighWays/Great Wall@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w %; \
    /if ({autowalk} = 1) n8w%; /endif
/def nom2hgrov = /echo -p %%% @{Ccyan}Holy Grove@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2nen %; \
    /if ({autowalk} = 1) n8w2nen%; /endif
/def nom2llo = /echo -p %%% @{Ccyan}Lloth's Peak@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e8n3esd3wn3wd %; \
    /if ({autowalk} = 1) n8w2n3e8n3esd3wn3wd%; /endif
/def nom2midg = /echo -p %%% @{Ccyan}Midgaard@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 4s6es2es9e %; \
    /if ({autowalk} = 1) 4s6es2es9e%; /endif
/def nom2mob = /echo -p %%% @{Ccyan}Mob Factory@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 3w7s2e %; \
    /if ({autowalk} = 1) 3w7s2e%; /endif
/def nom2mor = /echo -p %%% @{Ccyan}Morgan Vale@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n2en %; \
    /if ({autowalk} = 1) n8w2n3e5n2en%; /endif
/def nom2mush = /echo -p %%% @{Ccyan}Mushroom Caves@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} 5es3eue %; \
    /if ({autowalk} = 1) 5es3eue%; /endif
/def nom2oak = /echo -p %%% @{Ccyan}Oak Circle@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n9wn %; \
    /if ({autowalk} = 1) n9wn%; /endif
/def nom2ogrv = /echo -p %%% @{Ccyan}Ogre Village@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w11s4w3nws %; \
    /if ({autowalk} = 1) n8w11s4w3nws%; /endif
/def nom2ridd = /echo -p %%% @{Ccyan}Riddles of the Sands@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e9nwunwdnd2ne2n2w2nwu2wn2ueu3nese2nwnd2ndwde2d6n %; \
    /if ({autowalk} = 1) n8w2n3e9nwunwdnd2ne2n2w2nwu2wn2ueu3nese2nwnd2ndwde2d6n%; /endif
/def nom2rivt = /echo -p %%% @{Ccyan}River Tunnels@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e5n3w4n2e2d2e2den5e3n3e2s %; \
    /if ({autowalk} = 1) n8w2n3e5n3w4n2e2d2e2den5e3n3e2s%; /endif
/def nom2sar = /echo -p %%% @{Ccyan}Sarphyre's Court@{Cwhite} From@{Ccyan} Nom@{Cwhite}:@{Ccyan} n8w2n3e8n3es %; \
    /if ({autowalk} = 1) n8w2n3e8n3es%; /endif

;;; Walking macroes from Sol
/def sol2deep = /echo -p %%% @{Ccyan}Deephome@{Cwhite} From@{Ccyan} Sol@{Cwhite}:@{Ccyan} 3e2n3e5n2ws2e5sen2d4ed4e:o e:e %; \
    /if ({autowalk} = 1) 3e2n3e5n2ws2e5sen2d4ed4e %; o e %; e%; /endif
/def sol2grunk = /echo -p %%% @{Ccyan}Grunka's Kombat Skool@{Cwhite} From@{Ccyan} Sol@{Cwhite}:@{Ccyan} 3e13sw2n %; \
    /if ({autowalk} = 1) 3e13sw2n%; /endif
/def sol2hun = /echo -p %%% @{Ccyan}Hundred Acre Woods@{Cwhite} From@{Ccyan} Sol@{Cwhite}:@{Ccyan} 3es3e4ses %; \
    /if ({autowalk} = 1) 3es3e4ses%; /endif
/def sol2zoo = /echo -p %%% @{Ccyan}Petting Zoo@{Cwhite} From@{Ccyan} Sol@{Cwhite}:@{Ccyan} 3esw %; \
    /if ({autowalk} = 1) 3esw%; /endif

;;; Miscellaneous walking macroes
/def admin2doom = /echo -p %%% @{Cwhite}@{Ccyan} Doom@{Cwhite} From@{Ccyan} Administrator@{Cwhite}:@{Ccyan} 2nd3e %; \
    /if ({autowalk} = 1) 2nd3e%; /endif
/def abb2sig = /echo -p %%% @{Ccyan}Siguu@{Cwhite} From@{Ccyan} Abbess@{Cwhite}:@{Ccyan} e2s7esenwe3n2wu2nw %; \
    /if ({autowalk} = 1) e2s7esenwe3n2wu2nw%; /endif
/def flet2shas = /echo -p %%% @{Ccyan}Shashwat Nisha@{Cwhite} From@{Ccyan} Fletcher's Shop@{Cwhite}:@{Ccyan} sdnd2ne2n2w2nwu2wn2ueu3nen %; /if ({autowalk} = 1) sdnd2ne2n2w2nwu2wn2ueu3nen%; /endif
/def githtower = /echo -p %%% @{Cwhite}@{Ccyan} Githzerai Tower@{Cwhite} From@{Ccyan} Ulrich@{Cwhite}:@{Ccyan} nw6ne2nw %; \
    /if ({autowalk} = 1) nw6ne2nw%; /endif
/def mud2spir = /echo -p %%% @{Ccyan}Downward Spiral@{Cwhite} From@{Ccyan} Mudman@{Cwhite}:@{Ccyan} s:drink %; \
    /if ({autowalk} = 1) s %; drink%; /endif
/def myrecall = /echo -p %%% @{Cwhite}@{Ccyan} My Recall@{Cwhite} From@{Ccyan} Suretin@{Cwhite}:@{Ccyan} 3w5neu %; \
    /if ({autowalk} = 1) 3w5neu%; /endif
/def olympic = /echo -p %%% @{Ccyan}Olympic Grounds@{Cwhite} From@{Ccyan} Gnomish Tinker@{Cwhite}:@{Ccyan}  %; \
    /if ({autowalk} = 1) %; /endif
/def san2lair = /echo -p %%% @{Ccyan}Lair of Shyu'Yao@{Cwhite} From@{Ccyan} Tysiln San (san)@{Cwhite}:@{Ccyan} sesdwdse %; \
    /if ({autowalk} = 1) sesdwdse%; /endif
/def utami = /echo -p %%% @{Cwhite}@{Ccyan} Statue of Utami@{Cwhite} From@{Ccyan} Merline@{Cwhite}:@{Ccyan} wsw2ne %; \
    /if ({autowalk} = 1) wsw2ne%; /endif
/def zin2mist = /echo -p %%% @{Ccyan}Chasm of Mists@{Cwhite} From@{Ccyan} Zin@{Cwhite}:@{Ccyan} 4d:o w:ws %; \
    /if ({autowalk} = 1) 4d %; o w %; ws%; /endif

;;; To/From Divide/Morte
/def div2mort = /echo -p %%% @{Ccyan} Morte Vallta@{Cwhite} From@{Ccyan} Wartha@{Cwhite}:@{Ccyan} 2e5suw %; \
    /if ({autowalk} = 1) 2e5suw%; /endif
/def mort2div = /echo -p %%% @{Ccyan} The Great Divide@{Cwhite} From@{Ccyan} Giant Vulture@{Cwhite}:@{Ccyan} ed5n2w %; \
    /if ({autowalk} = 1) ed5n2w%; /endif
/def sho2div = /echo -p %%% @{Ccyan} The Great Divide@{Cwhite} From@{Ccyan} Pansho@{Cwhite}:@{Ccyan} w3sen2w %; \
    /if ({autowalk} = 1) w3sen2w%; /endif
/def div2sho = /echo -p %%% @{Ccyan} Shogun@{Cwhite} From@{Ccyan} Wartha@{Cwhite}:@{Ccyan} 2esen %; \
    /if ({autowalk} = 1) 2esen%; /endif
/def sho2mort = /echo -p %%% @{Ccyan} Morte Vallta@{Cwhite} From@{Ccyan} Pansho@{Cwhite}:@{Ccyan} w3se4suw %; \
    /if ({autowalk} = 1) w3se4suw%; /endif
/def tys2sum = /echo -p %%% @{Cwhite}@{Ccyan} The Summoning@{Cwhite} From@{Ccyan} Tysiln San@{Cwhite}:@{Ccyan} 2sunus4u %; \
    /if ({autowalk} = 1) 2sunus4u%;/echo %%% All up to The Summoning.%; /endif

/def bigfis2alpha = /echo -p %%% @{Cwhite}@{Ccyan} Alpha Thule@{Cwhite} From@{Ccyan} Big Fish@{Cwhite}:@{Ccyan} n5w12n %; \
    /if ({autowalk} = 1) n5w12n%; /endif

;;; To EHA zones
;s, [s], s, e, s, d, e, d, e, s
/def kelsee2Aculeata = /echo -p %%% @{Cwhite}@{Ccyan}Aculeata Jatha-La@{Cwhite} From@{Ccyan} Kelsee@{Cwhite}:@{Ccyan} 3sesdedes%;\
    /if ({autowalk}=1) 3sesdedes%;/echo p %%% @{Cwhite}Private rooms to zone: Go 2s%;/endif

;;; /def ANAME = /echo -p %%% @{Cwhite}@{Ccyan} PLACE@{Cwhite} From@{Ccyan} PPTARGET@{Cwhite}:@{Ccyan} DIRS %; \
;;;    /if ({autowalk} = 1) DIRS%; /endif
