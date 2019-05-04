/def -mregexp -p5 -t"^Legend Power State for current Epoch \(([0-9]+)\):" legend_powerstate_reset = \
    /set ppSilver=0%;/set ppGold=0%;/set ppAzure=0%;/set epochNumber=%{P1}

/def -mregexp -ag -p1 -t"^started: ([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+)$" legend_powerstate_epoch_start_date = \
    /set epochStartDate=%{P1}/%{P2}/%{P3} %{P4}:%{P5}:%{P6} 

;; Highlights of power points when in the room
/def -mglob -aCred -p1 -t"*A slender spear floats inches above a simple pedestal." legend_high_skewer = \
    /echo -p @{Cred}Skewer of Sublime Supremecy (@{Cyellow}+hp/mana regen@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A shimmering dagger floats inches above a simple pedestal." legend_high_dagger = \
    /echo -p @{Cred}Dagger of the Three Fates (@{Cyellow}random@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A flowing ribbon floats inches above a simple pedestal." legend_high_ribbon = \
    /echo -p @{Cred}Ribbon of Valor (@{Cyellow}+hp/mana@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A red blade floats inches above a simple pedestal." legend_high_blade = \
    /echo -p @{Cred}Blade of Victory (@{Cyellow}+exp@{Cred})@{n}
/def -mglob -aCred -p1 -t"*An ancient tree sits rooted to a simple pedestal." legend_high_tree = \
    /echo -p @{Cred}Tree of Life (@{Cyellow}+heal@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A tiny point of light twinkles inches above a simple pedestal." legend_high_will = \
    /echo -p @{Cred}Will o' the Wisp (@{Cyellow}+30hr/dr@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A glimmering cube floats inches above a simple pedestal." legend_high_cube = \
    /echo -p @{Cred}Infinity Cube (@{Cyellow}+exp@{Cred})@{n}
/def -mglob -aCred -p1 -t"*A large orb floats inches above a simple pedestal." legend_high_orb = \
    /echo -p @{Cred}Righteous Orb of the Sage (@{Cyellow}+spell duration@{Cred})@{n}

;; Parse the powerpoint show command and re-show with the affects.
/def -mregexp -ag -p5 -t"^(Silver|Golden|Azure) Legend (Keep|Bastion|Fortress|Citadel|Tower)[ ]+\(([0-9 ])+\)[ ]+(Silver|Golden|Azure)[ ]+the ([a-zA-Z \']+)" legend_powerstate = \
    /if ({P4} =~ "Silver") /set ppSilver=$[ppSilver+1]%; /endif%;\
    /if ({P4} =~ "Golden") /set ppGold=$[ppGold+1]%; /endif%;\
    /if ({P4} =~ "Azure") /set ppAzure=$[ppAzure+1]%; /endif%;\
    /let startMessage=%{P1} Legend %{P2}%;\
    /if ({P5} =~ "Skewer of Sublime Supremecy") /let endMessage=%{P5} (@{Cyellow}+hp/mana regen@{Cred})%;\
    /elseif ({P5} =~ "Ribbon of Valor") /let endMessage=%{P5} (@{Cyellow}+hp/mana@{Cred})%;\
    /elseif ({P5} =~ "Scales of Destiny") /let endMessage=%{P5} (@{Cyellow}+hp/mana (regen)@{Cred})%;\
    /elseif ({P5} =~ "Dagger of the Three Fates") /let endMessage=%{P5} (@{Cyellow}random@{Cred})%;\
    /elseif ({P5} =~ "Blade of Victory") /let endMessage=%{P5} (@{Cyellow}+exp@{Cred})%;\
    /elseif ({P5} =~ "Tree of Life") /let endMessage=%{P5} (@{Cyellow}+healing@{Cred})%;\
    /elseif ({P5} =~ "Will o' the Wisp") /let endMessage=%{P5} (@{Cyellow}+30hr/dr@{Cred})%;\
    /elseif ({P5} =~ "Infinity Cube") /let endMessage=%{P5} (@{Cyellow}+exp@{Cred})%;\
    /elseif ({P5} =~ "Righteous Orb of the Sage") /let endMessage=%{P5} (@{Cyellow}+spell duration@{Cred})%;\
    /else /let endMessage=%{P5}%;\
    /endif%;\
    /echo -p @{Cred}$[pad({startMessage},-24)] (%{P3})    @{Cyellow}$[pad({P4},-8)] @{Cred}%{endMessage}@{n}

/def -mregexp -p6 -F -t"^(Silver|Golden|Azure) Legend Tower[ ]+\(([0-9 ])+\)[ ]+(Silver|Golden|Azure)[ ]+the Monolith" legend_powerstate_summary = \
    /repeat -0:0:01 1 /legend_epoch_summary
    
/def -i legend_epoch_summary = /echo -p @{CRed}Epoch @{CYellow}%{epochNumber}@{CRed} (@{CYellow}%{epochStartDate}@{CRed}) - Azure: @{CYellow}%{ppAzure}@{CRed}    Gold: @{CYellow}%{ppGold}@{CRed}    Silver: @{CYellow}%{ppSilver}@{n}

/def -washa -mregexp -p8 -F -t"\*?([a-zA-Z]+)\*? tells the group '(bashd|bd) (n|north|e|east|s|south|w|west|u|up|d|down)'" legend_leader_bashdoor = \
    /if ({running}=1) bashdoor %{P3}%;\
    /endif

