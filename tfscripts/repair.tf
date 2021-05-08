;;; ----------------------------------------------------------------------------
;;; Repair Mode
;;; ----------------------------------------------------------------------------
/set repairFor Self
/set numRepaired 0
/set numNoRepair 0
/def repmode = \
    /if (regmatch({myrace},"dwf due"))\
        /toggle repairMode%;/echoflag %repairMode Repair-Mode%; \
        /echo -pw %%% Don't forget to get|put gear from container.%;\
; Fail-safe to always turn notake off after finished repair. If an alt wants it on, too bad - do it manually!
        /if ({repairMode}==0) /send config -notake%;/endif%;\
    /else /echo -pw @{hCred}You are neither a Dwarf or Duergar. Maybe you should not repair.%;\
    /endif

/def repstatus = \
    /let totrepair=$[numRepaired + numNoRepair]%; \
    /send say |w|Attempted to repair |bc|%totrepair |w|Items\;  |bc|%numRepaired |w|items needed repairing.

/def -mglob -p0 -t'But you don\'t have that item on you\!' repair_item_nothaveon = \
    /if ({repairMode}=1) repair 1. %; /endif

/def -mglob -p0 -t'You do not have that item\.' repair_item_nothave = \
    /if ({repairMode}=1) /send give 1. %repairFor=config -notake %; /endif

/def -mregexp -p0 -t'^([a-zA-Z]+) gives you (.+)\.$' repair_item_given = \
    /if ({repairMode}=1) \
        /send config +notake%;\
        /set repairFor %P1%;\
        /set repairing %P2%;\
        /send save=repair %repairing%; \
    /endif

/def -mregexp -p0 -t" doesn't need to be fixed!" repair_notneeded = \
    /let repairitem=%PL%; \
    /if ({repairMode}=1) \
        tell %repairFor |w|Repair Status: |c|%repairitem |g|was in pristine condition already.%; \
        /eval give "%repairing" %repairFor%; \
        /send config -notake%;\
        /set numNoRepair=$[++numNoRepair]%; \
    /endif

/def -mregexp -p0 -t"You succeeded in repairing the (.+) without damaging it\!" repair_success = \
    /let repairitem=%P1%; \
    /if ({repairMode}=1) \
        /eval tell %repairFor |w|Repair Status: |g|succeeded in repairing the |c|%repairitem|g|!%; \
        /eval give "%repairitem" %repairFor%; \
        /send config -notake%;\
        /set numRepaired=$[++numRepaired]%; \
    /endif

/def repself = \
    /if (regmatch({myrace},"dwf due"))\
        /set repairMode=0%; \
        wake%;rem all%; \
        /for i 1 20 repair %%{i}.%; \
        /send wield %wield=wear %offhand%; \
        wear all%;\
    /else /echo -pw @{hCred}You are neither a Dwarf or Duergar. Maybe you should not repair.%;\
    /endif

/def repcont = \
    /if ({#} = 0) \
        /echo -p %%% @{hCred}Syntax: @{n}%0 @{Cyellow}<container>@{n}%; \
    /else \
        /set repairMode=0%; \
        /let repaircont=%*%; \
        /if (regmatch({myrace},"dwf due"))\
            wake%;close %{main_bag}%; \
            /for i 1 20 get %%{i}. %%repaircont%%;repair 1.%%;put 1. %%repaircont%; \
            open %{main_bag}%; \
        /else /echo -pw @{hCred}You are neither a Dwarf or Duergar. Maybe you should not repair.%;\
        /endif%;\
    /endif

