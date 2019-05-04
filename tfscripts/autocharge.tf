;;; ----------------------------------------------------------------------------
;;; autocharge.tf
;;; Automatically charge shields.
;;; ----------------------------------------------------------------------------
/set autocharge=0

/alias charge \
    /toggle autocharge%;\
    /if ({autocharge}=1) \
        /set chargeshield=%1%;\
        /set chargetype=%2%;\
        /set chargeBackfire=0%;/set chargeNothing=0%;/set chargeSilent=0%;/set chargeSuccess=0%;\
        c charge %1 %2%;\
    /else \
        /unset chargeshield chargetype%;\
    /endif

/def chargestatus = \
    /let totalAttempts=$[{chargeBackfire}+{chargeNothing}+{chargeSilent}+{chargeSuccess}]%;\
    /echo -pw %%% @{Cwhite}%{chargeSuccess} @{Cmagenta}Successes, @{Cwhite}%{chargeBackfire} @{Cmagenta}Backfires, @{Cwhite}%{chargeSilent} @{Cmagenta}Silenced@{Cwhite}, %{chargeNothing} @{Cmagenta}Nothings, @{Cwhite}%{totalAttempts} @{Cmagenta}Total attempts.@{n}

/def -p2 -F -mglob -t"You failed your charge shield due to lack of concentration!" autocharge_fail_spell = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        c charge %{chargeshield} %{chargetype}%;\
    /endif

/def -p1 -ah -mglob -t"* hums briefly, and then falls silent." autocharge_silent = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        /set chargeSilent=$[++chargeSilent]%;\
        c charge %{chargeshield} %{chargetype}%;\
        /chargestatus%;\
    /endif

/def -p1 -ah -mglob -t"* begins to hum with the power of your spell!" autocharge_success = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        /set chargeSuccess=$[++chargeSuccess]%;\
        c charge %{chargeshield} %{chargetype}%;\
        /chargestatus%;\
    /endif

/def -p1 -ah -mglob -t"* already stores all the magic it can hold." autocharge_done = \
    /if ({autocharge}=1) \
        charge%;\
        /send sleep%;\
        /chargestatus%;\
        /beep%;\
    /endif

/def -p1 -ah -mglob -t"The spell goes off in your face!" autocharge_backfire = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        /set chargeBackfire=$[++chargeBackfire]%;\
        /if ({mytier} =~ "lord") c 'heal ii'%;\
        /else c heal%;\
        /endif%;\
        c charge %{chargeshield} %{chargetype}%;\
        /chargestatus%;\
    /endif

/def -p1 -ah -mglob -t"Nothing seems to happen." autocharge_nothing = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        /set chargeNothing=$[++chargeNothing]%;\
        c charge %{chargeshield} %{chargetype}%;\
        /chargestatus%;\
    /endif

/def -p1 -ah -mglob -t"You do not have enough mana to cast charge shield." autocharge_oom = \
    /if ({autocharge}=1 & {chargetype} !~ "" & {chargeshield} !~ "") \
        /send sleep%;\
        /def full_mana_action = stand%%;c charge %{chargeshield} %{chargetype}%;\
        /chargestatus%;\
    /endif
    
