;; -----------------------------------------------------------------------------
;;; quest_eragora.tf
;;; This script will contain some helpful triggers/macroes to automate some of
;;; the quests in Eragora
;; -----------------------------------------------------------------------------

/def autoquest = /toggle autoquest%;/echoflag %autoquest Auto-@{hCred}Questing@{n}

;; -----------------------------------------------------------------------------
;; Halfling Detective Quest (exp insig):
;; http://avatar.melanarchy.info/index.php/Halfling_Detective_Quest
;; -----------------------------------------------------------------------------
/def checklistExpInsig = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}A halfling "detective" Insignia quest checklist:%;\
    /echo -pw @{Cyellow}  1. a misty elixir (From Throdak: des)%;\
    /echo -pw @{Cyellow}  2. a torn out journal entry (On Halfling Slave: A halfling searches the area for clues)%;\
    /echo -pw @{Cyellow}  3. a commission to explore the mountains (On Nervous Adventurer)%;\
    /echo -pw @{Cyellow}Take tokens to Halfling Spy.%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}
/def findlistExpInsig = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}[QUEST INFO]: Searching for halfling "detective" Insignia Quest Items@{n}%;\
    /findgear misty elixir%;\
    /findgear torn out journal%;\
    /findgear commission to explore%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}

/def -ar -p5 -mglob -t"*A halfling searches the area for clues." highlight_eragora_halflingslave
/def -ar -p5 -mglob -t"*This half-orc walks nervously up the mountain." highlight_eragora_nervousadventurer

/def -mregexp -p1 -t"^A Halfling spy says 'In the bushes\.'$" quest_eragora_exp_insig_001 = \
    /if ({autoquest} == 1) /send examine bushes%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Halfling Detective Quest: @{Cyellow}examine bushes%;\
    /endif
/def -mregexp -p1 -t"^A Halfling spy says 'Please find a way past the half\-orc checkpoint, and bring back any clues that you find\.'$" quest_eragora_exp_insig_002 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give "commission mountains" spy%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Halfling Detective Quest: @{Cyellow}give "commission mountains" spy%;\
    /endif
/def -mregexp -p1 -t"^A Halfling spy says 'Ahh, I see\. Well this is very interesting\. Please return with anything else you can find\.'$" quest_eragora_exp_insig_003 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give "journal! page!" spy%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Halfling Detective Quest: @{Cyellow}give "journal! page!" spy%;\
    /endif
/def -mregexp -p1 -t"^A Halfling spy exclaims 'If you find anything new, please return here at once\!'$" quest_eragora_exp_insig_004 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give "misty elixir" spy%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Halfling Detective Quest: @{Cyellow}give "misty elixir" spy%;\
    /endif
/def -mregexp -p1 -t"^A Halfling spy says 'There you go. Now type insignia to see your reward.'$" quest_eragora_exp_insig_005 = \
    /if ({autoquest} == 1) \
        /autoquest%;/send insignia%;\
    /endif


;;; Log quest tickets for Exp insig
/def -ag -Ph -F -t'a misty elixir(.*)' h_eragora_exp_insig_001 = /test $[echoGearItem({PL}, "a misty elixir",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a torn out journal entry(.*)' h_eragora_exp_insig_002 = /test $[echoGearItem({PL}, "a torn out journal entry",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a commission to explore the mountains(.*)' h_eragora_exp_insig_003 = /test $[echoGearItem({PL}, "a commission to explore the mountains",  "quest", {P1}, {PR})]

;; -----------------------------------------------------------------------------
;; Sanctuary insignia:
;;    it's a mobprog, so you have to wait between each thing
;;    pp seneca, say history, say old, say insane, say convinced, 
;;    give cowl seneca, say root, give dagger seneca
;;
;;    To get the cowl, kill zurik
;;    zurik is pp half-orc mother, track zurik
;;    zurik kindof a wimp, any biggish hero caster can do it
;;
;;    To get the dagger, kill ruddloaf.  ruddloaf is pp seneca, o s;se;o d;dness
;;    ruddloaf is huge, hits stupid hard and animates corpses
;;; -----------------------------------------------------------------------------
/def checklistSancInsig = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}End Of A Well Seasoned Nightmare (Sanctuary) Insignia quest checklist:%;\
    /echo -pw @{Ccyan}https://avatar.melanarchy.info/index.php/Spoiler_-_End_Of_A_Well_Seasoned_Nightmare_Quest%;\
    /echo -pw @{Cyellow}  1. soul splitting spike dagger (Carried by Ruddloaf)%;\
    /echo -pw @{Cyellow}  2. zurik's Cowl (Carried by Zurik)%;\
    /echo -pw @{Cyellow}Take tokens to Seneca.%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}
/def findlistSancInsig = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}[QUEST INFO]: Searching for Sanctuary Insignia Quest Items@{n}%;\
    /findgear soul splitting spike dagger%;\
    /findgear zurik%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n} 

;;; Log quest tickets for Sanctuary insig
/def -ag -Ph -F -t'soul splitting spike dagger(.*)' h_eragora_sanc_insig_001 = /test $[echoGearItem({PL}, "soul splitting spike dagger",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'zurik\'s Cowl(.*)' h_eragora_sanc_insig_002 = /test $[echoGearItem({PL}, "zurik's Cowl",  "quest", {P1}, {PR})]

/def -mregexp -p1 -t"^1\. History of this place\.\.\.$" quest_eragora_sanc_insig_1 = \
    /if ({autoquest} == 1) /send say history%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}say history%;\
    /endif
    
/def -mregexp -p1 -t"^3\. Hoooow old are you again\?$" quest_eragora_sanc_insig_2 = \
    /if ({autoquest} == 1) /send say old%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}say old%;\
    /endif
    
/def -mregexp -p1 -t"^4\. Insane\!$" quest_eragora_sanc_insig_3 = \
    /if ({autoquest} == 1) /send say insane%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}say insane%;\
    /endif

/def -mregexp -p1 -t"^10\. Actually\, it is me who is convinced\. The half-orcs deserve death at the hands of the undead horde\.\.\.$" quest_eragora_sanc_insig_4 = \
    /if ({autoquest} == 1) /send say convinced%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}say convinced%;\
    /endif
    
/def -mregexp -p1 -t"^Seneca Rotberry says 'Bring me proof their leader is \.\.\. neutralized\.'$" quest_eragora_sanc_insig_5 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give cowl seneca%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}give cowl seneca%;\
    /endif
    
/def -mregexp -p1 -t"^10\. The root of your problems lies with ulexite\. You're using it to raise the dead and by extension all of you are doomed\.\.\.$" quest_eragora_sanc_insig_6 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say root%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}say root%;\
    /endif
    
/def -mregexp -p1 -t"^Seneca Rotberry says 'Bring me his dagger\.'$" quest_eragora_sanc_insig_7 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /repeat -0:0:03 1 /send give dagger seneca%;/autoquest%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Sanctuary Insignia Quest: @{Cyellow}give dagger seneca%;\
    /endif

;;; -----------------------------------------------------------------------------
;;; Fingerbone insignia
;;; https://docs.google.com/document/d/1V5ZS8IFWviwavj_ibpFkg4Y70q3SJb0Z7-Bt-cOhgNU/edit
;;; -----------------------------------------------------------------------------
/def checklistFingerbone = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}Fingerbone quest checklist:%;\
    /echo -pw @{Cyellow}  1. a half-orc torch (pp night dancer. From down exit: 2dw)%;\
    /echo -pw @{Cyellow}  2. a luminescent stalk (mammoth iwei)%;\
    /echo -pw @{Cyellow}  3. a baby eyestalk (small uwei)%;\
    /echo -pw @{Cyellow}  4. a limp eyestalk (medium uwei)%;\
    /echo -pw @{Cyellow}  5. a juicy steak (pp akrikto)%;\
    /echo -pw @{Cyellow}  6. an ornate lockbox (from drop: 2d2euwn)%;\
    /echo -pw @{Cyellow}  7. a silver key (iron key from Arakos: 2dwdne, silver key from Drago: 2dwd2s).%;\
    /echo -pw @{Cyellow}Take tokens to Grogbert.%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}
/def findlistFingerbone = \
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------%;\
    /echo -pw @{Cred}[QUEST INFO]: Searching for Fingerbone Quest Items@{n}%;\
    /findgear half-orc torch%;\
    /findgear luminescent%;\
    /findgear eyestalk%;\
    /findgear steak%;\
    /findgear ornate lockbox%;\
    /findgear silver key%;\
    /echo -pw @{Cwhite}-----------------------------------------------------------------------------@{n}

;;; Log quest tickets for Sanctuary insig
/def -ag -Ph -F -t'a half-orc torch(.*)' h_eragora_fingerbone_insig_001 = /test $[echoGearItem({PL}, "a half-orc torch",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a luminescent stalk(.*)' h_eragora_fingerbone_insig_002 = /test $[echoGearItem({PL}, "a luminescent stalk",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a baby eyestalk(.*)' h_eragora_fingerbone_insig_003 = /test $[echoGearItem({PL}, "a baby eyestalk",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a limp eyestalk(.*)' h_eragora_fingerbone_insig_004 = /test $[echoGearItem({PL}, "a limp eyestalk",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a juicy steak(.*)' h_eragora_fingerbone_insig_005 = /test $[echoGearItem({PL}, "a juicy steak",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'an ornate lockbox(.*)' h_eragora_fingerbone_insig_006 = /test $[echoGearItem({PL}, "an ornate lockbox",  "quest", {P1}, {PR})]
/def -ag -Ph -F -t'a silver key(.*)' h_eragora_fingerbone_insig_007 = /test $[echoGearItem({PL}, "a silver key",  "quest", {P1}, {PR})]

/def -mregexp -p1 -t"^4\. Any quests\?$" quest_eragora_fingerbone_1 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say quests%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}say quests%;\
    /endif

/def -mregexp -p1 -t"^1\. Light\? Very well\.$" quest_eragora_fingerbone_2 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say light%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}say light%;\
    /endif

/def -mregexp -p1 -t"^Better find four light sources then\.$" quest_eragora_fingerbone_3 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give torch grogbert%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}give torch grogbert%;\
    /endif

;Grogbert Thunderbeard says 'Moore lights, p'eease.'
/def -mregexp -p1 -t"^Grogbert Thunderbeard says \'Moore lights\, p\'eease\.\'$" quest_eragora_fingerbone_4 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give eyestalk grogbert%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}give stalk grogbert (Need baby, limp, and luminescent stalks)%;\
    /endif

/def -mregexp -p1 -t"^2\. Anything for you\, buddy\.$" quest_eragora_fingerbone_5 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say anything%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}say anything%;\
    /endif

/def -mregexp -p1 -t"^1\. One steak coming up\.$" quest_eragora_fingerbone_6 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say steak%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}say steak%;\
    /endif
    
;Grogbert Thunderbeard thanks you heartily.
/def -mregexp -p1 -t"^Grogbert Thunderbeard thanks you heartily\.$" quest_eragora_fingerbone_7 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give steak grogbert%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}give steak grogbert%;\
    /endif

/def -mregexp -p1 -t"^1. Uh-huh.$" quest_eragora_fingerbone_8 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say uh-huh%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}say uh-huh%;\
    /endif

/def -mregexp -p1 -t"^You say 'Fine, fine, I get the idea, you're no ordinary Midgaardia\-issue zombie. I'll go get it for you\.'$" quest_eragora_fingerbone_9 = \
    /if ({autoquest} == 1) /repeat -00:00:05 1 /send give "ornate lockbox box" grogbert%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}give "ornate lockbox box" grogbert%;\
    /endif

/def -mregexp -p1 -t"^Grogbert Thunderbeard asks \'Thank yee fer tha box\, bu\'\, where\'s tha key\?\'$" quest_eragora_fingerbone_10 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send give "silver key" grogbert%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Fingerbone Quest: @{Cyellow}give "silver key" grogbert%;\
    /endif
    
;;; -----------------------------------------------------------------------------
;;; Auspice insignia quest
;;; notes: https://docs.google.com/document/d/1Kca1ZJA35Z8ufKJBHr0stmMCh1vAXg0HMnh2-It7zus/edit
;;;   From default recall, go sen2eu
;;;   Find Haruspex (esen)
;;;   Parchment can be bought from the store keeper, swn for Haruspex.
;;;   Bird can be bought from
;;; -----------------------------------------------------------------------------
/def -mregexp -p1 -t"^The Haruspex says 'Hurry back\.  My memory is not what it was\.'" quest_eragora_auspice_1 = \
    /if ({autoquest} == 1) \
        /repeat -0:0:03 1 /send give parchment haruspex%;\
        /autoquest%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}give parchment haruspex%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex says 'Of winter's major signs, the magister and the burning man are two\.'" quest_eragora_auspice_2 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say warhammer%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say warhammer%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'To which season does the minor sign of the fox belong\?'" quest_eragora_auspice_2 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say winter%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say winter%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'Of which stone is her pillar constructed?\'" quest_eragora_auspice_3 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say sandstone%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say sandstone%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'Which sign is a bad omen for sailors\?'" quest_eragora_auspice_4 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say gaping maw%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say gaping maw%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'To which season does the minor sign of the snake belong\?'" quest_eragora_auspice_5 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say autumn%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say autumn%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex says 'Of summer's major signs, the priest and the lovers are two\.'" quest_eragora_auspice_6 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say unicorn%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say unicorn%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'How many of those stars are red\?'" quest_eragora_auspice_7 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say two%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say two%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex says 'Of spring's major signs, the immortal bird and the gladius are two\.'" quest_eragora_auspice_8 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say ship%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say ship%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex says 'of autumns major signs, the harvest and the fallen angel are two\.'" quest_eragora_auspice_9 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say hand%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say hand%;\
    /endif

/def -mregexp -p1 -t"^To which season does the minor sign of the amphora belong\?" quest_eragora_auspice_10 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say spring%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say spring%;\
    /endif

/def -mregexp -p1 -t"^The Haruspex asks 'Which of the four seasonal houses has a strong connection with wisdom?'" quest_eragora_auspice_11 = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send say winter%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Auspices of the Temple Quest: @{Cyellow}say winter%;\
    /endif

;; Spirits of Eragora
/def -mglob -p50 -F -t"Zurik the Elder Shaman is DEAD!!" spirits_eragora_statuette = /lootcor "relic wooden statuette hunter"
/def -mglob -p50 -F -t"Captain Tyrana is DEAD!!" spirits_eragora_shawl = /lootcor shawl

;; Animal Handler
/def -mglob -p50 -F -t"The united army of the remaining fauna is DEAD!!" animal_handler_inno = \
    /if ({autoquest} == 1) /repeat -0:0:03 1 /send innocence%;\
    /else /echo -pw @{Cred}[QUEST INFO]: Animal Handler: @{Cyellow}innocence%;\
    /endif
