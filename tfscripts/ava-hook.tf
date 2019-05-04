;; a hook to allow the semi-colon as a separator. 
;; Works ok for sending avatar commands, but doesn't work for macros "/blah", etc.
/def -p1 -ag -mregexp -h'SEND (.*);(.*)' hook_semicolon_sep = \
    /let command_param1=%P1%;/let command_param2=%P2%; \
    /docmd %{command_param1}%;/docmd %{command_param2}

/def docmd = /eval -s0 %{*}
        
; This hook is just to reset the page length to max before quitting
; so that when char logs back in they don't have to enter on the
; motds.
/def -p0 -ag -mglob -h'SEND quit' hook_quit = /send page 50=quit
        
/def -p0 -ag -mglob -h'SEND who gruop' hook_who_group_typo = /send who group
/def -p0 -ag -mglob -h'SEND who imm' hook_who_imm = /send who 700 1000
/def -p0 -ag -mregexp -h'SEND who (lm|LM|lowmort)' = /send who 1 50

/def -p1 -ag -mglob -h'SEND who remort' hook_whoremort = who %remortclassabblist%;who %remortraceabblist
/def -p1 -ag -mregexp -h'SEND who prc ?([0-9a-zA-Z]*)' hook_whoprc = /send who bci bld bod dru fus mnd shf sld wzd %{P1}

;; Hooks for finding particular class 'groups'
/def -p1 -ag -mregexp -h'SEND who healer ?([0-9a-zA-Z]*)' hook_who_healer = /send who cle prs dru pal %{P1}
/def -p1 -ag -mregexp -h'SEND who caster ?([0-9a-zA-Z]*)' hook_who_caster = /send who mag stm wzd psi mnd sor %{P1}
/def -p1 -ag -mregexp -h'SEND who bot' hook_who_bot = /send who tag ?bot

; temp hook for getting all when moving in Heartwood
;/def -p1 -ag -mregexp -h'SEND ([neswud])' hook_heartwood_move_get = %{P1}%;get all

/def -p0 -ag -mregexp -h'SEND ^who([a-zA-Z]+)' hook_whoalts = \
    /quote -S /set alts=!%{script_path}listalts.py %{P1}%;\
    /echo -pw Looking for: %{alts}%;\
    whois %{alts}
;/def -p0 -ag -mregexp -h'SEND ^last([a-zA-Z]+)' hook_lastalts = /eval last %%{%P1_alts}
/def -p0 -ag -mregexp -h'SEND ^tal([a-zA-Z]+)' hook_talalts = \
    /quote -S /set alts=!%{script_path}listalts.py %{P1}%;\
    config -prompt%;/tal %{alts}%;config +prompt
/def -p0 -ag -mregexp -h'SEND ^last([a-zA-Z]+)' hook_lastalts = \
    /quote -S /set alts=!%{script_path}listalts.py %{P1}%;\
    config -prompt%;last %{alts}%;config +prompt

/def -p0 -ag -mregexp -h'SEND ^clev([a-zA-Z]+)[ ]*(.*)' hook_clevalts = \
    /if ({P2} !~ "") /quote -S /clev !%{script_path}listalts.py %{P1} -o "%{P2}"%; \
    /else /quote -S /clev !%{script_path}listalts.py %{P1}%; \
    /endif
/def -p0 -ag -mregexp -h'SEND ^xclev([a-zA-Z]+)[ ]*(.*)' hook_xlevalts = \
    /if ({P2} !~ "") /quote -S /clev !%{script_path}listalts.py %{P1} -x -o %P2%; \
    /else /quote -S /clev -x !%{script_path}listalts.py %{P1}%; \
    /endif

;; A hook to set the page size when window is resized.
/def -p0 -h'RESIZE' hook_resize = \
    /def -n1 -ag -mglob -t"Page pause set to * lines." gag_page_setting%;\
    /let numLines=$[lines() - (visual ? isize+1 : 0)]%;\
    /if ({numLines} > 50) /let numLines=50%;\
    /elseif ({numLines} < 3) /let numLines=3%;\
    /endif%;\
    /set wrapsize=$[columns()]%;\
    /send page %{numLines}

;; A hook to adjust status line things
/def -p1 -h'WORLD' hook_adjust_status = \
    /status_edit_world $[strlen(${world_name})]

