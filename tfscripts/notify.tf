;;; ----------------------------------------------------------------------------
;;; notify.tf
;;; Helper macroes and triggers to send automatic email notifications
;;; Can use this to send an SMS message if the provider allows it.  A list
;;; can be found here: http://tips.slaw.ca/2011/technology/send-a-text-message-to-a-mobile-phone-via-email/
;;; usage: sendemail.py [-h] -m MESSAGE -r RECIPIENT [-s SENDER]
;;; ----------------------------------------------------------------------------
/load -q settings.tf

/set notify=1
/def notify = \
    /toggle notify %; \
    /let msg=% @{Ccyan}Notify is %; \
    /if ({notify} == 1) \
    	/echo -p %msg @{Cgreen}ON@{Ccyan}.@{n} %; \
    /else \
    	/echo -p %msg @{Cred}OFF@{Ccyan}.@{n} %; \
    /endif

/def -i sendEmail = \
    /if ({notify} == 1) \
        /if ({#} > 0) \
            /quote -S /echo -pw !%{script_path}sendemail.py --recipient "%{NOTIFY_EMAIL}" --message "%{*}"%;\
        /else \
            /echo -pw @{hCred}%%% /sendEmail MESSAGE@{n}%;\
        /endif%;\
    /endif

;;; Slack Notifications
/def -i nothing = 
/def -i sendSlackNotificationMsg = \
    /if ({notify} == 1) \
        /let message=$[replace("'","",{*})]%;\
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"#game-notifications","username":"AvNotifier","text":"%message", "icon_emoji": ":mega:", "unfurl_links": true}' %{SLACK_NOTIFICATION_HOOK}%;\
    /endif
    
/def -i sendSlackGeneralMsg = \
    /if ({notify} == 1) \
        /let message=$[replace("'","",{*})]%;\
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"#general","username":"AvNotifier","text":"%message", "icon_emoji": ":loudspeaker:", "unfurl_links": true}' %{SLACK_GENERAL_HOOK}%;\
    /endif

/def -i sendSlackPersonalMsg = \
    /if ({notify} == 1) \
        /let message=$[replace("'","",{*})]%;\
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"@jekyll","username":"AvNotifier","text":"%message", "icon_emoji": ":squirrel:", "unfurl_links": true}' %{SLACK_GENERAL_HOOK}%;\
    /endif

;;; Discord Notifications
/def -i sendDiscordGeneralMsg = \
    /if ({notify} == 1) \
        /let message=$[replace("'","",{*})]%;\
        /quote -S /nothing !curl -H "Content-Type: application/json" -X POST -d '{"username": "AvNotifier", "content": "%message"}' %{DISCORD_GENERAL_HOOK}%;\
    /endif

/def -i sendDiscordNotifyMsg = \
    /if ({notify} == 1) \
        /let message=$[replace("'","",{*})]%;\
        /quote -S /nothing !curl -H "Content-Type: application/json" -X POST -d '{"username": "AvNotifier", "content": "%message"}' %{DISCORD_NOTIFY_HOOK}%;\
    /endif


;;; ----------------------------------------------------------------------------
;;; Specific channel logging.
;;; ----------------------------------------------------------------------------
;;; Buddy chat
/set buddy_to_slack=0
/def slackbuddy = \
    /toggle buddy_to_slack%;\
    /echoflag %buddy_to_slack Sending buddychan messages to Slack@{n}
/def -p10 -F -mregexp -t"^\{([a-zA-Z]+)} (.*)" buddychat_to_slack = /sendSlackBuddyChanMsg %{*}
/def -i sendSlackBuddyChanMsg = \
;    /let message=$[ftime("%H:%M:%S %Z")]: %{message}%;\
    /let message=$[replace("'","",{*})]%;\
    /let message=$[replace('"','',{message})]%;\
    /let message=$[replace("{", "{*", {message})]%;\
    /let message=$[replace("}", "*}", {message})]%;\
    /if ({buddy_to_slack} == 1 & {notify} == 1) \
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"#buddy-chat","username":"BuddychatNotifier", "mrkdwn": "true","text":"%message", "icon_emoji": ":b:", "unfurl_links": true}' %{SLACK_GENERAL_HOOK}%;\
    /endif

;;; Group tells
/set groupchat_to_slack=0
/def slackgtells = \
    /toggle groupchat_to_slack%;\
    /echoflag %groupchat_to_slack Sending Group chat to Slack@{n}

/def -p10 -F -mregexp -t"\*?([a-zA-Z]+)\*? tells? the group '(.*)'" groupchat_to_slack = \
    /let chatter=$[strip_attr({P1})]%;\
    /let lcChatter=$[tolower({chatter})]%;\
    /if ({lcChatter} =~ "you" & {lcChatter} !~ "jekyll") /let chatter=${world_name}%;/endif%;\
    /let message=$[strip_attr({P2})]%;\
    /let message=$[ftime("%H:%M:%S")]: *%{chatter}*: %{message}%;\
    /let message=$[replace("'","",{message})]%;\
    /let message=$[replace('"','',{message})]%;\
    /if ({groupchat_to_slack} == 1 & {notify} == 1) \
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"#group-chat","username":"GroupchatNotifier", "mrkdwn": "true","text":"%message", "icon_emoji": ":speech_balloon:", "unfurl_links": true}' %{SLACK_GENERAL_HOOK}%;\
    /endif

/def -p10 -mregexp -t"^The winner of the Lotto is:  ([a-zA-Z]+)\!" lottowinner_to_slack = \
    /let message=$[ftime("%H:%M:%S")]: Lotto winner: *%{P1}*.%;\
    /if ({groupchat_to_slack} == 1 & {notify} == 1) \
        /quote -S /nothing !curl -X POST --data-urlencode 'payload={"channel":"#group-chat","username":"GroupchatNotifier", "mrkdwn": "true","text":"%message", "icon_emoji": ":tada:", "unfurl_links": true}' %{SLACK_GENERAL_HOOK}%;\
    /endif
    
;;; Triggers to notify of.
/def -mregexp -p1 -ah -t"^A HOGathon has just BEGUN!!!" hogathon_begun = \
    ;/sendEmail A HoG just started!%;\
    /sendDiscordPrivateMsg @here: :pig: @here A HoG just started! :pig2:%;\
    /sendSlackNotificationMsg :piggy: A HoG just started! :piggy:%;\
    /sendDiscordNotifyMsg :pig: @here A HoG just started! :pig2:

/def -mregexp -p1 -ah -t"^The HOGathon has ENDED\. HOG is no longer a valid command\." hogathon_ended = \
    ;/sendEmail The HoG is now over.%;\
    /sendDiscordPrivateMsg @here: :pig: @here The HoG is now over. :pig2:%;\
    /sendSlackNotificationMsg :piggy: The HoG is now over. :piggy:%;\
    /sendDiscordNotifyMsg :pig: @here The HoG is now over. :pig2:

/def -mregexp -p5 -F -ah -t"^The Mail Fairy chats '([a-zA-Z]+) just sent an immortal note \(\#([0-9]+)\) to everyone.'" notify_new_imm_note = \
    /sendSlackNotificationMsg %{P1} just posted an immortal note.%;\
    /sendDiscordNotifyMsg :incoming_envelope: %{P1} just posted an immortal note.
;;; TBD:    /logNote 7 %{P1}

/def logNote = \
    /toggle log_note%;\
    /if ({log_note} == 1) \
        /def -ag -n1 -mregexp -t"Your current board has been switched to the '.+' board\." gag_board_switch = /send note read %2%%;/repeat -00:00:01 1 /log -w note_%2.log%;\
        /def generalPromptHookCheck=/logNote %2%%;/undef generalPromptHookCheck%%;/log OFF%;\
        /send board %1%;\
    /else \
        /noteNotify %1%;\
    /endif

/def -i noteNotify = \
    /if ({#} == 1) \
        /quote -S /nothing !%{script_path}note_to_discord.sh %{1}%;\
    /else /echo -pw Something went wrong.%;\
    /endif

/def -mregexp -p1 -ah -t"^A message from Thorngate: Thank ([a-zA-Z]+) for their generous contribution. There is (.+) on for (.+)\.$" notify_boon = \
    /sendSlackNotificationMsg :speaking_head_in_silhouette: %{P1} has started %{P2}, active %{P3}.%;\
    /sendDiscordNotifyMsg :speaking_head: **%{P1}** has started *%{P2}*, active *%{P3}*.

/def -mglob -p1 -ah -t"The boon is halfway done." notify_boon_half = \
    /sendSlackNotificationMsg The boon is halfway done. :thinking_face:%;\
    /sendDiscordNotifyMsg :timer: The boon is halfway done. :thinking:

/def -mregexp -p1 -ah -t"^Be sure to thank ([a-zA-Z]+) for their generosity. The boon is now over\.$" notify_boon_over = \
    /sendSlackNotificationMsg The boon is now over. :unamused:%;\
    /sendDiscordNotifyMsg The boon is now over. :unamused:

/def -mregexp -p1 -ah -t"^We are preparing to reboot!$" notify_rebooting = \
    /sendDiscordPrivateMsg @here: Reboot incoming!%;\
    /sendSlackNotificationMsg Reboot, incoming.%;\
    /sendDiscordNotifyMsg :exclamation: Reboot incoming! :exclamation: 

/def -mglob -p1 -t"      ! MULTIDAY HAS STARTED !" notify_multiday_start = \
    /sendDiscordNotifyMsg :mega: @here MULTIDAY HAS BEGUN! :busts_in_silhouette:
/def -mglob -p1 -t"      ! MULTIDAY HAS ENDED !" notify_multiday_end = \
    /sendDiscordNotifyMsg :mega: @here MULTIDAY IS OVER! :busts_in_silhouette:

;;; ----------------------------------------------------------------------------
;;; Personal notifications
;;; ----------------------------------------------------------------------------
;; Send notification on beep, but turn it off for 30 seconds to avoid spam.
/def -mregexp -p1 -ah -t"^You are being BEEPED by ([\w]+)!" email_beep = \
    /sendDiscordPrivateMsg @here: :bell: **${world_name}** is getting **BEEPED** by **%{P1}**! :bell:%;\
    /edit -c0 email_beep%;\
    /repeat -0:0:30 1 /edit -c100 email_beep

/def -mregexp -p1 -ah -t"You have ([0-9]+) new personal note\." notify_personal_note = \
    /sendDiscordPrivateMsg @here: :e_mail: **${world_name}** has *%{P1}* personal notes.

/def -mregexp -p1 -ah -t"^Nom says '([a-zA-Z]+) has sent a personal note \(\#([0-9]+)\) to you\.'" notify_new_personal_note = \
    /sendDiscordPrivateMsg @here: :e_mail: **${world_name}** has received a personal note from **%{P1}**.

/def -mregexp -p1 -ah -t"^The Mortician tells you 'Something of yours just ended up in my shop\.'" notify_morgue = \
    /sendDiscordPrivateMsg @here: :skull_crossbones: Something of **${world_name}'s** has ended up in the morgue. :coffin:%;\
    /send morgue list

;;; ----------------------------------------------------------------------------
;;; General interest items
;;; ----------------------------------------------------------------------------
/def -mregexp -p9 -t"\[LORD INFO\]\: ([a-zA-Z]+) transports the Planar Anchor to (.*)\." notify_planar_anchor = \
    /sendSlackNotificationMsg :anchor: The Planar Anchor has been set to _%{P2}_.%;\
    /sendDiscordNotifyMsg :anchor: The Planar Anchor has been set to **%{P2}**.
