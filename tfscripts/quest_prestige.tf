;;; Triggers to help with prestige-related things
/def _echoprestige = \
    /if ({autoquest} == 1) /send %{*}%;\
    /else /echo -pw @{Cred}[QUEST INFO]: %{*}%;\
    /endif

;;; Soldier fun
/def -mglob -t"Sergeant Snapdragon says 'If you are ready to begin, show me how you greet a superior officer.'" sld_salute =/_echoprestige salute snapdragon
/def -mglob -t"Sergeant Snapdragon exclaims 'I need you to show me how fierce you can be!'" sld_warcry =/_echoprestige warcry
/def -mglob -t"Sergeant Snapdragon exclaims 'Show me you are ready for battle, soldier!'" sld_warcry2 =/_echoprestige warcry
/def -mglob -t"Sergeant Snapdragon exclaims 'Left, Left, Left Right Left!'" sld_march2 =/_echoprestige march
/def -mglob -t"Sergeant Snapdragon says 'About face, forward...'" sld_march3 =/_echoprestige march
/def -mglob -t"Sergeant Snapdragon exclaims 'Stand up straight when I address you, cadet!'" sld_attention =/_echoprestige attention
/def -mglob -t"Sergeant Snapdragon exclaims 'Ten-HUT!'" sld_attention2 =/_echoprestige attention
/def -mglob -t"Sergeant Snapdragon exclaims 'I don't like that look in your eyes cadet, hit the ground!'" sld_pushup =/_echoprestige pushup
/def -mglob -t"Sergeant Snapdragon exclaims 'Drop and give me twenty!'" sld_pushup2 =/_echoprestige pushup
/def -mglob -t"Sergeant Snapdragon says 'When you go into battle, soldier, your armor must be properly fitted.'" sld_adjust =/_echoprestige adjust
/def -mglob -t"Sergeant Snapdragon exclaims 'Blood, sweat, and tears cadet! But sweating and tears are for weaklings!'" sld_bleed =/_echoprestige bleed
/def -mglob -t"Sergeant Snapdragon says 'Strategy is the key to success, even games can help develop your strategy'" sld_chest = /_echoprestige chess
/def -mglob -t"Sergeant Snapdragon asks 'Cadet, how could you let your armor get into such a state?'" sld_polish = /_echoprestige polish
/def -mglob -t"Sergeant Snapdragon exclaims 'You must be ready to defend your honor at any moment!'" sld_duel =/_echoprestige duel
/def -mglob -t"Sergeant Snapdragon exclaims 'It doesn't sound like you are working that hard cadet!'" sld_grunt = /_echoprestige grunt
/def -mglob -t"Sergeant Snapdragon asks 'Will you let a slight to your honor go unanswered?'" sld_honor = /_echoprestige honor

; "Your move, cadet"  -- chess
; Sergeant Snapdragon exclaims 'You'll never make it as a Soldier with that kind of excess individualism. Cut that hair! Lose the attitude! I want 50 laps around the courtyard by lunch, cadet!' -- desc clear
; unknowns
; Sergeant Snapdragon asks 'Will you let a slight to your honor go unanswered?'
; Sergeant Snapdragon exclaims 'Show me you are putting your whole effort into your training!'
; Sergeant Snapdragon asks 'When the time comes, what will you be willing to do for your company?'
; Sergeant Snapdragon says 'Spit and shine cadet! Spit and shine...'
; Sergeant Snapdragon says 'Strategy is the key to success, even games can help develop your strategy'
; Sergeant Snapdragon says 'Your armor is looking a little disheveled, cadet...'
