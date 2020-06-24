/def -hGMCP received-gmcp = /do-gmcp-stuff %*

/def send-gmcp = /test gmcp("$[replace("\"","\\\"",{*})]")

; Only normal macros to use for GMCP...toggles whether you see GMCP messages 
; echoed to screen, or GMCP channel messages echoed to screen. Useful to get 
; a feel for what GMCP messages are sent when, and to periodically check for 
; more goodies being added after a reboot. Spammy otherwise. No current way
; to turn off the normal channel messages when receiving via GMCP (would have
; to gag...not hard to do, but defeats the main purpose of GMCP or tags IMO).
; I hardcoded an initialization to N of each of them...change to taste.

/def gmcp-echo = \
	/if (gmcp_echo=~"N") \
		/echo You're now going to see raw GMCP messages %; \
		/set gmcp_echo=Y %; \
	/else \
		/echo You're NOT going to see the raw GMCP messages %; \
		/set gmcp_echo=N %; \
	/endif
/set gmcp_echo=N

/def gmcp-channel-echo = \
	/if (gmcp_channel_echo=~"N") \
		/echo You're now going to see GMCP channel messages %; \
		/set gmcp_channel_echo=Y %; \
	/else \
		/echo You're NOT going to see the GMCP channel messages %; \
		/set gmcp_channel_echo=N %; \
	/endif
/set gmcp_channel_echo=N

/def gmcp-trig = \
  /if (gmcp_trig=~"N") \
    /echo You're now executing gmcp python %; \
    /set gmcp_trig=Y %; \
  /else \
    /echo You're NOT going execute gmcp python %; \
    /set gmcp_trig=N %; \
  /endif



/def do-gmcp-stuff = \
  /let this $[world_info()]%;\
  /if (gmcp_echo =~ "Y") \
    /echo GMCP: $[decode_ansi({*})] %; \
  /endif%;\
  /if (gmcp_trig =~ "Y") \
    /python_call gmcp.trigger %{this} %*%;\
  /endif%;\

/python_load gmcp
/set gmcp_trig=Y
/def setgmcp =\
  /send-gmcp Core.Supports.Set ["Room 1", "Char 1" ]%;\
  /send-gmcp char.group.list
