;; File: cmdinfusion.tf
;; Commands to run commands in the cmdfusion table
/load -q settings.tf

; /botcmd - checks table for commands if any exist, executes all the commands
/def botcmd = \
    /if ({drone}=1) \
        /perfallcmd%;\
        /repeat -0:05:00 1 /botcmd%; \
    /endif

/def -b'^P' perfbotcmd = \
    /quote -S /set tCmd=!mysql -D%{DB_NAME} -u%{DB_USERNAME} -p%{DB_PASSWORD} -sNe"select concat_ws('#', cmd_id, cmd) from cmdfusion order by priority limit 1"%;\
    /if ({tCmd} !~ "") \
        /let off=$[strchr(tCmd,"#")]%;\
        /if (off>-1) \
            /let cmd_id=$[substr(tCmd,0,off)]%; \
            /let this_cmd=$[substr(tCmd,off+1)]%; \
            /eval %{this_cmd}%;\
            /quote -S /echo !mysql -D%{DB_NAME} -u%{DB_USERNAME} -p%{DB_PASSWORD} -sNe"delete from cmdfusion where cmd_id=%{cmd_id}"%;\
        /endif%;\
    /endif%;\
    /unset tCmd

/def perfallcmd = \
    /quote -S /set tCount=!mysql -D%{DB_NAME} -u%{DB_USERNAME} -p%{DB_PASSWORD} -sNe"select count(*) from cmdfusion"%;\
    /if ({tCount}>0) /echo -p %%% @{Ccyan}Executing comands from DB.@{n}%;/endif%;\
    /while ({tCount}>0) \
        /perfbotcmd%;\
        /quote -S /set tCount=!mysql -D%{DB_NAME} -u%{DB_USERNAME} -p%{DB_PASSWORD} -sNe"select count(*) from cmdfusion"%;\
    /done%;\
    /unset tCount
