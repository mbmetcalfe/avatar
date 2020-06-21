;;; ---------------------------------------------------------------------------
;;; gear-logging.tf
;;; Log certain gear to a database for easier searching.
;;;
;;; Table: gear_inventory - Contains the gear held by a character.
;;;     Columns:
;;;         character:  Character gear was logged for.
;;;         item:       The gear character has.
;;;         type:       The type of gear: i.e. alleg, treasure, ...
;;; ---------------------------------------------------------------------------
/loaded __TFSCRIPTS__/gear-logging.tf

; Toggle logging gear.
/def logGear = \
    /if ({#} > 0) \
        /send examine %{*}%;\
        /def generalPromptHookCheck=/logGear%%;/undef generalPromptHookCheck%;\
    /endif%;\
    /toggle LOG_GEAR%;\
    /if ({LOG_GEAR} == 1) \
        /sys sqlite3 avatar.db 'delete from gear_inventory where character = "${world_name}"'%;\
    /endif%;\
    /statusflag %{LOG_GEAR} GEAR

; Show the gear item and optionally log it to the database.
/def echoGearItem = \
    /if ({#} != 5) \
        /echo -pw @{Cred}/echoGearItem @{Cwhite}[PL] [item] [type] [P1] [PR]@{n}%;\
    /else \
        /let _pl=%{1}%;\
        /let _item=%{2}%;\
        /let _type=%{3}%;\
        /let _p1=%{4}%;\
        /let _pr=%{5}%;\
        /let numItems=1%;\
        /if (regmatch("\( ?([0-9]+)\) .*", {_pl})) /let numItems=%{P1}%;/endif%;\
        /echo -pw @{Cwhite}%{_pl}@{n}%{_item} (%{_type})%{_p1}%{_pr}%;\
        /if ({LOG_GEAR} == 1) \
            /test $[recordGearItem(${world_name}, {_item}, {numItems}, {_type})]%;\
        /endif%;\
    /endif

/def recordGearItem = \
    /let _item=$[replace("'", "'\''", {2})]%;\
    /sys sqlite3 avatar.db 'insert into gear_inventory (character, item, amount, type) values ("%{1}", "%{_item}", "%{3}", "%{4}")'
    
/def findgear = \
    /quote -S /echo -pw %%% @{Cred}[GEAR INFO]:@{hCred} !sqlite3 avatar.db "select upper(substr(character,1,1)) || substr(character,2) || ' has ' || amount || ' ''' || item || '''.' from gear_inventory where item like '\%%{*}\%'"

/def -ag -p999 -mglob -t"*I have the following possible Allegaagse item*" gag_allegaagse_tells
/def -p20 -mregexp -t"^\{([a-zA-Z]+)} alleg\? (.*)" buddyset_find_alleg = /quote -S tell %{P1} |r|I have the following possible Allegaagse item:|y| !sqlite3 avatar.db "select distinct item from gear_inventory where item like '\%%{P2}\%' and type='alleg'"

;;;-----------------------------------------------------------
/def -Ph -F -t'a perfect (amethyst|diamond|emerald|ruby|sapphire)' highlight_perfect_gem = \
    /let _pl=%{PL}%;\
    /let _item=perfect %{P1}%;\
    /let _type=gem%;\
    /let numItems=1%;\
    /if (regmatch("\( ?([0-9]+)\) .*", {_pl})) /let numItems=%{P1}%;/endif%;\
    /if ({LOG_GEAR} == 1) \
        /test $[recordGearItem(${world_name}, {_item}, {numItems}, {_type})]%;\
    /endif

/def -Ph -F -t'a (fully intact|partially burnt) grimoire' highlight_grimoire = \
    /let _pl=%{PL}%;\
    /let _item=%{P1} grimoire%;\
    /let _type=quest%;\
    /let numItems=1%;\
    /if (regmatch("\( ?([0-9]+)\) .*", {_pl})) /let numItems=%{P1}%;/endif%;\
    /if ({LOG_GEAR} == 1) \
        /test $[recordGearItem(${world_name}, {_item}, {numItems}, {_type})]%;\
    /endif

