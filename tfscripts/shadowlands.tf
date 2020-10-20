;;; ----------------------------------------------------------------------------
;;; shadowlands.tf
;;; Triggers to automate some of the Shadowlands run.
;;; ----------------------------------------------------------------------------

;MUNHiHAUSEN gives a piece of shadow to Djehuti.
;Djehuti says 'This will just take a moment.'
;Djehuti shapes the shadow to fit the form of MUNHiHAUSEN.
;Djehuti says 'That will only last a little while before it dissipates.'


;Djehuti says 'This will just take a moment.'
;Djehuti binds a shroud of shadow to you.
;Djehuti shapes the shadow to fit the form of Feir.
;Djehuti gives you a shroud of shadow.
;Djehuti says 'That will only last a little while before it dissipates.'


/def setupshadowlands = \
    /if ({#} == 0) \
        /if /ismacro shadowlands_follow_barrier%; /then \
            /undef shadowlands_follow_barrier shadowlands_give_shadow shadowlands_djehuti_busy djehuti_gives_shroud shadowlands_end%;\
            /echo -pw %%% @{hCcyan}Shadowlands setup cleaned up.@{n}%;\
        /else /echo /setupshadowlands <name>%;\
        /endif%;\
    /else \
        /set numShadowPieces=0%;\
        /let followShadowPorter=%{1}%;\
        /def -mregexp -ah -t"^%{followShadowPorter} is pulled through the barrier." shadowlands_follow_barrier = \
            /if ({folport} == 1) /send die%%;/endif%;\
        /def -ah -mregexp -t"^Djehuti gives a shroud of shadow to %{followShadowPorter}." shadowlands_give_shadow = \
            /if ({folport} == 1) /send give piece djehuti%%;/endif%;\
        /def -ah -mregexp -t"^Djehuti is too busy to take that right now\." shadowlands_djehuti_busy = \
            /if ({folport} == 1) /send give piece djehuti%%;/endif%;\
        /def -ah -mregexp -t"^Djehuti gives you a shroud of shadow." djehuti_gives_shroud = /send wear shroud=enter vortex=e=e%;\
        /def -ah -mregexp -t"^Shadows wrap around %{followShadowPorter}\." shadowlands_end = /send die%;\
        /echo -pw %%% @{hCCyan}Shadowlands setup for @{xCwhite}%{followShadowPorter}@{hCcyan}.@{n}%;\
    /endif

/set numShadowPieces=0
/def -ar -mregexp -t"^The shadow falls to pieces\." highlight_shadowlands_piece = \
    /set numShadowPieces=$[++numShadowPieces]%;\
    /echo -pw %%% @{Cwhite}%{numShadowPieces} shadow pieces.@{n}%;\
    /if ({leader} !~ "Self") /send get "shadow piece"=give "shadow piece" %{leader}%;/endif

