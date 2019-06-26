;;; ---------------------------------------------------------------------------
;;; quest_allegaagse.tf
;;; Lord, Allegaagse quest helper macroes and triggers.
;;; http://avatar.melanarchy.info/index.php/Allegaagse
;;; hounds tooth info:
;;;  exam, one is spikey one is spiky'
;;;  the spiky one is ctibor, so from vault'
;;; ---------------------------------------------------------------------------
;;; Mark this file as already loaded, for /require.
/loaded __TFSCRIPTS__/quest_allegaagse.tf

;; Include the highlights
/load -q highlight_allegaagse.tf

;;; ---------------------------------------------------------------------------- 
;;; Macro to display what character needs.
;;; ----------------------------------------------------------------------------
;/def alleg = \
;    /if ({#}=1 & {1} =/ "show") \
;        /sh alleg.pl%;\
;    /else \
;        /if ({allegItem} !~ "Completed") \
;            /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Allegaagse Quest item: @{Cred}%{allegItem}@{n}%;\
;        /elseif ({allegItem} =~ "Completed") \
;            /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Allegaagse Quest completed.@{n}%;\
;        /elseif ($(/listvar -vmglob allegItem) > 0) \
;            /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Allegaagse Quest not started.@{n}%;\
;        /endif%;\
;    /endif

/def alleg = \
    /if ({#} == 1) \
        /if ({1} =~ "all") \
            /quote -S /echo -pw @{Cred}[ALLEG INFO]: !sqlite3 avatar.db "select '@{Cwhite}' || upper(substr(character,1,1)) || substr(character,2) || '@{Cred}: ' || status || '. ' || case(IFNULL(item, 'none')) when 'none' then '' else 'Item: ' || item end || ' @{Cwhite}Date@{Cred}: ' || IFNULL(updated, '') || '. @{Cwhite}Level@{Cred}: ' || IFNULL(level, 'n/a') || '.' from char_alleg order by status, character"%;\
        /elseif ({1} =~ "needs")\
            /quote -S /echo -pw @{Cred}[ALLEG INFO]: !sqlite3 avatar.db "select '@{Cwhite}' || upper(substr(character,1,1)) || substr(character,2) || '@{Cred} needs: ' || IFNULL(item, '') || ' @{Cwhite}Date@{Cred}: ' || IFNULL(updated, '') || '. @{Cwhite}Level@{Cred}: ' || IFNULL(level, 'n/a') || '.' from char_alleg where status = 'Active' order by character"%;\
        /elseif ({1} =~ "ready")\
            /quote -S /echo -pw @{Cred}[ALLEG INFO]: !sqlite3 avatar.db "select '@{Cwhite}' || upper(substr(character,1,1)) || substr(character,2) || '@{Cred}: ' || status || '. ' || ' @{Cwhite}Date@{Cred} ' || IFNULL(updated, '') || '. @{Cwhite}Level@{Cred}: ' || IFNULL(level, 'n/a') || '.' from char_alleg where (status = 'Complete' and updated < date()) or (status = 'Gave Up' and updated <= date('now', '-2 day')) order by character"%;\
            /quote -S /echo -pw @{Cred}[ALLEG INFO]: !sqlite3 avatar.db "select '@{Cwhite}Total@{Cred}: ' || count(0) || '.' from char_alleg where (status = 'Complete' and updated < date()) or (status = 'Gave Up' and updated <= date('now', '-2 day'))"%;\
        /elseif ({1} =~ "inline")\
            /quote -S /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}!%{script_path}alleg_inline.sh @{n}%;\
        /endif%;\
    /else \
        /quote -S /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Allegaagse Quest item: @{Cred}!sqlite3 avatar.db "select status || '. ' || IFNULL(item, '') || ' @{Cwhite}Date:@{Cred} ' || IFNULL(updated, '') || '. @{Cwhite}Level@{Cred}: ' || IFNULL(level, 'n/a') || '.' from char_alleg where lower(character) = '${world_name}'"%;\
    /endif

/def alleggear = \
    /quote -S /echo -pw @{Cred}[ALLEG INFO]: !sqlite3 avatar.db "select '@{Cwhite}' || item || '@{Cred} on @{Cwhite} ' || plane || '@{Cred}. Difficulty: @{Cwhite}' || difficulty || '@{Cred} Instructions: @{Cwhite}' || instructions || '@{n}' from alleg_gear where item like '\%%{*}\%'"

/def allegplane = \
    /unset allegByPlane%;\
    /quote -S /set allegByPlane=!sqlite3 avatar.db "select item from alleg_gear where plane like '\%%{*}\%'" | tr '\\n' '.  '%;\
    /echo -pw @{Cred}[ALLEG INFO]: Allegaagse items on %{*}: %{allegByPlane}@{n}

;;; ---------------------------------------------------------------------------- 
;;; Triggers to set character's Allegaagse item.
;;; ----------------------------------------------------------------------------
/def -mglob -p6 -t"Allegaagse says 'Exactly what I wanted, thank you.'" allegaagse_quest_complete = \
    /setAllegStatus Complete%;\
    /send save=insignia
/def -mglob -p6 -t"Allegaagse says 'Fine, I will find someone else to get that for me.'" allegaagse_quest_give_up = \
    /setAllegStatus Gave Up%;\
    /send save=insignia
/def -mglob -p6 -t"Allegaagse says 'You have done such a good job that I have raised my estimation of your worth as a searcher.'" allegaagse_quest_complete2 = \
    /setAllegStatus Complete%;\
    /send save=insignia

/def -mglob -p7 -ag -t"Allegaagse asks 'What do I need?'" allegaagse_quest_gag
/def -mglob -p7 -ag -t"Allegaagse says 'Now go away. Maybe I will see if you can be useful some other time." allegaagse_quest_gag3

/def setAllegItem = \
    /set allegItem=%{*}%;\
    /let _item=$[replace("'", "'\''", {allegItem})]%;\
    /sys sqlite3 avatar.db 'delete from char_alleg where lower(character) = "${world_name}"'%;\
    /sys sqlite3 avatar.db 'insert into char_alleg (character, item, status, updated) values ("${world_name}", "%{allegItem}", "Active", date())'

/def setAllegStatus = \
    /sys sqlite3 avatar.db 'delete from char_alleg where lower(character) = "${world_name}"'%;\
    /sys sqlite3 avatar.db 'insert into char_alleg (character, status, updated) values ("${world_name}", "%{*}", date())'

/def -mregexp -p5 -t"Allegaagse (says|asks) \'(.*)\'" allegaagse_quest = \
    /if ({P2} =~ 'A beacon from the stands would make me happy.') /setAllegItem Havynne's Lantern%;\
    /elseif ({P2} =~ 'A bow made of gold would be a fine addition to my collection.') /setAllegItem Golden Bow%;\
    /elseif ({P2} =~ 'A river of blood should make for some interesting flails.') /setAllegItem Bloodletter Flail%;\
    /elseif ({P2} =~ 'Be a lamb and fetch me a knife from Karnath.') /setAllegItem a sacrificial knife%;\
    /elseif ({P2} =~ 'Bring me a dagger I can use to cut glass.') /setAllegItem Diamond Dagger%;\
    /elseif ({P2} =~ 'Bring me a fiery ring.') /setAllegItem Ring Of The White Flame%;\
    /elseif ({P2} =~ 'Bring me a fiery signet.') /setAllegItem Signet Of Pure Flame%;\
    /elseif ({P2} =~ 'Bring me a goat\'s head from the demons. Mount it on a stick or something.') /setAllegItem Ram's Head staff%;\
    /elseif ({P2} =~ 'Bring me a madman\'s embedded whip.') /setAllegItem Shard-Embedded Whip%;\
    /elseif ({P2} =~ 'Bring me a shroud. Be sure it has some heft to it.') /setAllegItem Heavy Shroud%;\
    /elseif ({P2} =~ 'Bring me a Sultan\'s head! Or the turban that rests on it at least.') /setAllegItem Sultans Turban%;\
    /elseif ({P2} =~ 'Bring me something golden that will keep me well fed.') /setAllegItem Sceptre Of Creation%;\
    /elseif ({P2} =~ 'Bring me something truly exotic.') /setAllegItem Exotic Robes%;\
    /elseif ({P2} =~ 'Bring me the blade of Karnath, intact preferably but I will take what I get.') /setAllegItem Broken Blade Of Karnath%;\
    /elseif ({P2} =~ 'Can domesticated frozen dogs be collared? Find out for me.') /setAllegItem an Ice Collar^Airscape%;\
    /elseif ({P2} =~ 'Dagger of the dead, what else would you expect a spirit to wield?') /setAllegItem Netherworld Dagger%;\
    /elseif ({P2} =~ 'Defeat a champion and bring me his sword.') /setAllegItem Black Sword Of The Keep%;\
    /elseif ({P2} =~ 'Do wild ice hounds still get collared? Return with one if they do.') /setAllegItem an Ice Collar^Water%;\
    /elseif ({P2} =~ 'Do you think I would look good in sleeves of gold?') /setAllegItem Golden Sleeves%;\
    /elseif ({P2} =~ 'Each Cabal member has a staff of office, bring me one.') /setAllegItem Sun Staff%;\
    /elseif ({P2} =~ 'Even domesticated frozen dogs will yield their teeth.') /setAllegItem an Ice Hound Tooth^Airscape%;\
    /elseif ({P2} =~ 'Find a bow that is truly worthy of firing ice arrows.') /setAllegItem an Ice Bow%;\
    /elseif ({P2} =~ 'Find me some unfinished kzinti serum; I want to make Killaris jealous.') \
        /setAllegItem Vial Of Unfinished Portal Serum%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cred}%{allegItem} @{Cwhite}is from pgem run.@{n}%;\
    /elseif ({P2} =~ 'Flaming blue balls doesn\'t sound like something I would want a pair of so just relieve the owner of one for me please.') /setAllegItem seething ball of blue flame%;\
    /elseif ({P2} =~ 'Gaius has interesting armor, heavy, but interesting.') /setAllegItem Stone Platemail%;\
    /elseif ({P2} =~ 'Go and de-robe the mistress of the south.') /setAllegItem Dark Purple Robe%;\
    /elseif ({P2} =~ 'Go play the ultimate game of hot potato in the realm of earth.') /setAllegItem a lavabomb^Stone%;\
    /elseif ({P2} =~ 'Go play the ultimate game of hot potato in the realm of fire.') /setAllegItem a lavabomb^Fire%;\
    /elseif ({P2} =~ 'Have you ever seen a katana dance? Neither have I. Please bring me this wonder.') /setAllegItem Dancing Katana%;\
    /elseif ({P2} =~ 'Hmm, according to my list I need the fang of a snake of some sort, like a viper.') /setAllegItem Viper Fang%;\
    /elseif ({P2} =~ 'I am not sure what use the Fae have for shield bracelets, get me one so I can take a look at it.') /setAllegItem Buckler Bracelet%;\
    /elseif ({P2} =~ 'I can\'t decide if a steam gun would add to my collection or not. I should make up my mind by the time you get back with one.') /setAllegItem A small steam gun%;\
    /elseif ({P2} =~ 'I can\'t decide if a steam gun would add to my collection or not.') /setAllegItem A small steam gun%;\
    /elseif ({P2} =~ 'I could use some custom made boots.') /setAllegItem Pair Of Wind-Ravaged Boots%;\
    /elseif ({P2} =~ 'I could use some custom made boots. I don\'t want them to look too new though so leave them out in the wind a bit before bringing them to me.') /setAllegItem Pair Of Wind-Ravaged Boots%;\
    /elseif ({P2} =~ 'I desire a kzinti incantation, hop to.') /setAllegItem a incantation note%;\
    /elseif ({P2} =~ 'I desire the bow of the air lord, be a dear and fetch it for me.') /setAllegItem an Aurora Bow%;\
    /elseif ({P2} =~ 'I desire the mace of the earth lord. Be kind to an old dragon and fetch it for me please.') /setAllegItem the earthen mace of might%;\
    /elseif ({P2} =~ 'I don\'t know whether or not you will have to gather each feather individually, but I would like a cape of Durin feathers or the like.') /setAllegItem Cape Of Angel Feathers%;\
    /elseif ({P2} =~ 'I doubt there are any happy bone shields but find one with some sort of emotion.') /setAllegItem a grim bone shield%;\
    /elseif ({P2} =~ 'I find myself needing to purify a few sections of my hoard; perhaps a wand would aid me with this.') /setAllegItem Ritual Purification Wand%;\
    /elseif ({P2} =~ 'I found a bare spot in my collection that would benefit from a plain staff, or staff of a plane.') /setAllegItem Staff Of The Lower Planes%;\
    /elseif ({P2} =~ 'I have a leather restorer and preservative I would like to test on some leather armor that has seen better days.') /setAllegItem Decaying Vest Made From Cracked Leather%;\
    /elseif ({P2} =~ 'I just want you to do a quick trip to Astral shift and grab me a guardian\'s weapon.') /setAllegItem Massive Slate-grey Sledgehammer%;\
    /elseif ({P2} =~ 'I need you to go visit with the Demogorgon and see if you can purchase his whip, or maybe he would give it to me as a gift.') /setAllegItem a black whip%;\
    /elseif ({P2} =~ 'I probably wouldn\'t want to encounter bugs attached to green webbing, but a veil made of such stuff intrigues me.') /setAllegItem a green web veil%;\
    /elseif ({P2} =~ 'I require a blindfold that has seen some action. Don\'t waste my time with the one that blind Fae wears.') /setAllegItem Bloodstained Blindfold%;\
    /elseif ({P2} =~ 'I still don\'t understand why a mage would wield a sledgehammer, maybe it has something to do with the black rock from which it is made.') /setAllegItem Obsidian Sledgehammer%;\
    /elseif ({P2} =~ 'I think there might be some hidden information on a crumpled note on the Kzinti plane.' | \
            {P2} =~ 'I think there might be some hidden information on a crumpled note on the Kzinti plane. Bring me this information.') /setAllegItem Crumpled Note%;\
    /elseif ({P2} =~ 'I used to like to walk the straight and narrow line. Please bring me something that will help tell me where I\'m going.') /setAllegItem Crystal Ball%;\
    /elseif ({P2} =~ 'I would just love to get my hands on the cloak of the Ruler of the Water plane.') /setAllegItem Storm-skin Cloak%;\
    /elseif ({P2} =~ 'Imagine the most Goth wand possible then find it and bring it back to me.') /setAllegItem Black Wand With A Grinning Skull%;\
    /elseif ({P2} =~ 'Is it there or isn\'t it? Your back will know when you encounter this blade.') /setAllegItem an Ethereal Blade%;\
    /elseif ({P2} =~ 'It is no katana, but it is still a dancing sword. Bring me this minor wonder.') /setAllegItem Dancing Rapier%;\
    /elseif ({P2} =~ 'It isn\'t Oni\'s kit, maybe it should be mine.') /setAllegItem Omayras Kit%;\
    /elseif ({P2} =~ 'Let\'s sow a little discord; we just need the right weapon.') /setAllegItem Blades of Discord%;\
    /elseif ({P2} =~ 'Madness and wickedness, Elaxor radiates both.') /setAllegItem Radiance Of Wickedness%;\
    /elseif ({P2} =~ 'Malafont\'s armor, I want it.') /setAllegItem A Suit Of Dress Plate%;\
    /elseif ({P2} =~ 'The master of death needs to lose his hood.') /setAllegItem black master's hood%;\
    /elseif ({P2} =~ 'Maybe if it was pure the elder wouldn\'t throw this clear thing around.') /setAllegItem Clear Psi-Blade%;\
    /elseif ({P2} =~ 'Maybe they should be rainbow disciples rather than nihilistic.') /setAllegItem Blue Psi-Blade%;\
    /elseif ({P2} =~ 'Minor illusions can be just as powerful as major ones. Bring me a minor illusionist\'s ring.') \
        /setAllegItem Ring Of Minor Imagery%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cred}%{allegItem} @{Cwhite}is a pain to get.@{n}%;\
    /elseif ({P2} =~ 'My collection needs a heartbane loaded weapon in case I ever want to slaughter foes.') /setAllegItem Pair Of Kzinti Slaughter Gloves%;\
    /elseif ({P2} =~ 'My collection won\'t be complete without a way to tame death itself.') /setAllegItem the whip, "Death-Tamer"%;\
    /elseif ({P2} =~ 'My dagger set just won\'t be complete without a golden handled weapon capable of damaging werewolves.') /setAllegItem Silver Dagger With A Golden Handle%;\
    /elseif ({P2} =~ 'My rock collection seems incomplete. See if you can turn up a blue or white stone for me.') /setAllegItem a blueish-white stone%;\
    /elseif ({P2} =~ 'No clerics have this aura, just the kzinti war leader.') /setAllegItem Aura Of Domination%;\
    /elseif ({P2} =~ 'Peel the mark off of a madman.') /setAllegItem Mark Of Madness%;\
    /elseif ({P2} =~ 'Pick me up a memento I can use to remember the Gith.') /setAllegItem Amulet With A Small Silver Sword Inscribed On It%;\
    /elseif ({P2} =~ 'Please acquire custom made leggings made of panthrodrine. I wear a size 30.') /setAllegItem Panthrodrine-Skin Leggings%;\
    /elseif ({P2} =~ 'Pluck a phoenix for me please.') /setAllegItem Flaming Phoenix Feather%;\
    /elseif ({P2} =~ 'Pry the frozen tooth from a wild hound.') /setAllegItem Ice Hounds Tooth^Water%;\
    /elseif ({P2} =~ 'Retrieve a dark energy lance for me.') /setAllegItem Devilish Lance%;\
    /elseif ({P2} =~ 'Show me how loyal you can be.') /setAllegItem Show Of Loyalty%;\
    /elseif ({P2} =~ 'Silk and velvet, but it is still just a dress of rags.') /setAllegItem Dress Of Silk And Velvet Rags%;\
    /elseif ({P2} =~ 'Skewer me something from the Orb.') /setAllegItem Glowing Iron Skewer%;\
    /elseif ({P2} =~ 'Skin a rock wyrm for me please.') /setAllegItem Shaleskin Arm Guard%;\
    /elseif ({P2} =~ 'Some merrily dancing fire would be appreciated.') /setAllegItem Baleflame%;\
    /elseif ({P2} =~ 'Something easy this time? Just grab Ralthar\'s weapon for me.') /setAllegItem Steel Broadsword%;\
    /elseif ({P2} =~ 'The location of the disc I want is considered a secret by some.') /setAllegItem Stone Disc%;\
    /elseif ({P2} =~ 'The monks are guarding something. Have a "talk" with Harold and see what you can bring me.') /setAllegItem Red Bracer^Temple Of Gorn%;\
    /elseif ({P2} =~ 'The thing I desire from you mostly resembles a spear, though it hardly qualifies.') /setAllegItem a crude spear%;\
    /elseif ({P2} =~ 'These feathers may try to elude you but I expect you to get them for me anyway.') /setAllegItem Whirl Of Elusive Feathers%;\
    /elseif ({P2} =~ 'Though the item would make one think otherwise, I would be eternally happy if you were to gather a clasp for me.') /setAllegItem Clasp Of Eternal Anguish%;\
    /elseif ({P2} =~ 'Thy task involves an axe. Four shalt thou not count, neither count thou two.') /setAllegItem Axe Of The Third Plane%;\
    /elseif ({P2} =~ 'Try not to get eaten while retrieving a dha for me.') /setAllegItem Iron Dha%;\
    /elseif ({P2} =~ 'Try not to lose anything yourself while gathering a green blade for me.') /setAllegItem Green Psi-Blade%;\
    /elseif ({P2} =~ 'Turning big rocks into little rocks by having big rocks wield little rocks I reckon could be useful.') /setAllegItem a stone hammer%;\
    /elseif ({P2} =~ 'Turning big rocks into little rocks by having big rocks wield little rocks, what madness.') /setAllegItem a rock hammer%;\
    /elseif ({P2} =~ 'Unicorn horns are said to possess great magic. I want one to test out the properties it possesses.') /setAllegItem Unicorn Horn%;\
    /elseif ({P2} =~ 'What else would you call a flametongue?') /setAllegItem a flametongue called Firebrand%;\
    /elseif ({P2} =~ 'What is it with the fae and sharp objects that dance?') /setAllegItem Dancing Dagger%;\
    /elseif ({P2} =~ 'What is it with the fae and sharp objects that dance? I refuse to add dancing butter knives to my collection.') /setAllegItem Dancing Dagger%;\
    /elseif ({P2} =~ 'Where\'s the beef? Actually, I prefer some venison.') /setAllegItem a side of venison%;\
    /elseif ({P2} =~ 'Which is mightier, earth or air? Bring me a gun where one pushes the other around.') /setAllegItem Air Gun%;\
    /elseif ({P2} =~ 'Why the senior has to dance with yellow I will never know. He has two so it shouldn\'t hurt him too bad to give one up.') /setAllegItem Yellow Psi-Blade%;\
    /elseif ({P2} =~ 'Would you please bring me a talisman of evil? Something an evil witch or hag would hold onto.') /setAllegItem Devilish Talisman%;\
    /elseif ({P2} =~ 'You don\'t have to learn the actual ritual, just get an implement used in dark rites.') /setAllegItem a dagger of dark rites%;\
    /elseif ({P2} =~ 'You don\'t look to be all that skilled at basket weaving but perhaps you could make something nice from some gith hair.') /setAllegItem Assassins Armband%;\
    /elseif ({P2} =~ 'You might have to bleed a bit to get the red just right on the robe I would like you to gather for me.') /setAllegItem Blood Red Robe%;\
    /elseif ({P2} =~ 'You will have to jump through a few hurdles but I know you have it in you to find a faeriex script for my collection.') \
        /setAllegItem a Faerie script%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}To get @{Cred}%{allegItem} @{Cwhite}retrieve @{Cred}a black etched tablet@{Cwhite} from @{Cgreen}Lich Queen in Astral@{Cwhite}.@{n}%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Give @{Cred}a black etched tablet @{Cwhite}to @{Cgreen}Ashara@{Cwhite} on Thorngate, she will give you @{Cred}a silken scarf@{Cwhite}.@{n}%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Give @{Cred}a silken scarf@{Cwhite} to @{Cgreen}Ceilican@{Cwhite} on Midgaard, he will give you @{Cred}a strand of golden hair@{Cwhite}.@{n}%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Give @{Cred}a strand of golden hair@{Cwhite} to @{Cgreen}Laz@{Cwhite} on Thorngate, he will give you @{Cred}%{allegItem}@{Cwhite}.@{n}%;\
    /elseif ({P2} =~ 'You will probably have to get them custom made, but I would like some coarse leather boots.') \
        /setAllegItem Coarse Leather Boots%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}To get @{Cred}%{allegItem} @{Cwhite}retrieve @{Cred}an iron web shield @{Cwhite}in Noctopia.@{n}%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Give @{Cred}an iron web shield @{Cwhite}to Haggler in Shunned World on Kzinti Homeworld.@{n}%;\
        /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}The Haggler will give you @{Cred}%{allegItem}@{Cwhite}.@{n}%;\
    /elseif ({P2} =~ 'You would think that the boy will know you are coming to take his prophetic staff away and give it to me.') /setAllegItem Staff Of Prophecy%;\
    /endif%;\
    /echo -pw @{Cred}[ALLEG INFO]: @{Cwhite}Allegaagse Quest item: @{Cred}%{allegItem}@{n}%;\
    /alleggear %{allegItem}%;\
    /findgear %{allegItem}

;;; ---------------------------------------------------------------------------- 
;;; Macros to display what items can be found on a particular plane
;;; ----------------------------------------------------------------------------
/def allegair = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Air|w|: |y|A small steam gun, an Aurora Bow, Ring of Minor Imagery, Unicorn Horn, Air Gun, an Ice Collar, an Ice Hound's Tooth|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg}%;\
    /endif
/def allegarcadia = \
    /let echochan=/echo%;\
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Arcadia|w|: |y|Diamond Dagger, Exotic Robes, seething ball of blue flame, Dancing Katana, Cape Of Angel Feathers, Dancing Rapier, Baleflame, Whirl Of Elusive Feathers, Dancing Dagger|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegastral = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Astral|w|: |y|Golden Bow, Golden Sleeves, Sun Staff, Decaying Vest Made From Cracked Leather, Massive Slate-grey Sledgehammer, a green web veil, a blueish-white stone, Devilish Talisman|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegfire = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Fire|w|: |y|Ring Of The White Flame, Signet Of Pure Flame, a lavabomb, Ritual Purification Wand, Flaming Phoenix Feather, Devilish Lance, Steel Broadsword, Clasp Of Eternal Anguish|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg}%;\
    /endif
/def allegkarnath = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Karnath|w|: |y|Sacrifical Knife, Heavy Shroud, Netherworld Dagger, Bloodstained Blindfold, Show Of Loyalty, Iron Dha, a dagger of dark rites|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegkzinti = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Kzinti|w|: |y|Sceptre Of Creation, Vial Of Unfinished Portal Serum, an incantation note, Obsidian Sledgehammer, Crumpled Note, Slaughter Gloves, Aura Of Domination, a crude spear, a flametongue called 'Firebrand'|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegmidgaard = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Midgaard|w|: |y|Stone Disc|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegnoctopia = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Noctopia|w|: |y|Havynne's Lantern, Bloodletter Flail, Viper Fang, Buckler Bracelet, an Ethereal Blade, Omayra's Kit, A Suit Of Dress Plate, Dress Of Silk And Velvet Rags, Glowing Iron Skewer, Coarse Leather Boots|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegnowhere = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Nowhere|w|: |y|Blue Psi-Blade, Green Psi-Blade, Yellow Psi-Blade|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegoutland = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Outland|w|: |y|Black Sword Of The Keep, Dark Purple Robe, Crystal Ball, Black Wand With A Grinning Skull, Black Master's Hood, Silver Dagger With A Golden Handle, Amulet With A Small Silver Sword Inscribed On It, Assassin's Armband, Blood Red Robe|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegstone = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Stone|w|: |y|Shard-Embedded Whip, Platemail, a lavabomb, the earthen mace of might, Radiance Of Wickedness, Mark Of Madness, Shaleskin Arm Guard, a rock hammer|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegtarterus = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Tarterus|w|: |y|Ram's Head staff, a grim bone shield, Staff Of The Lower Planes, a black whip, Blades of Discord, the whip, "Death-Tamer", Panthrodrine-Skin Leggings, Axe Of The Third Plane|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegthorngate = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Thorngate|w|: |y|Red Bracer (Temple Of Gorn), a side of venison, a Faerie script|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif
/def allegwater = \
    /let echochan=/echo%; \
    /if ({#} > 0) /let echochan=%*%; /endif %; \
    /let allegmsg=|w|Allegaagse@|r|Water|w|: |y|Sultan's Turban, an Ice Collar, an Ice Bow, Pair Of Wind-Ravaged Boots, Storm-skin Cloak, Ice Hound's Tooth, a stone hammer, Staff Of Prophecy|n|.%;\
    /if ({echochan} =~ "/echo") /chgcolor %%% %{allegmsg}%;\
    /else /eval %{echochan} %{allegmsg} %; \
    /endif

;;; ---------------------------------------------------------------------------
;;; Insignia Level Logging
;;; ---------------------------------------------------------------------------
;Your insignia:
;    Goto Guy/Gal/Person
;    Busybody
/def -mregexp -p5 -t"^    (Scratcher|Busybody|Deed Doer|Goto Guy\/Gal\/Person)$" alleg_insignia_level = \
    /sys sqlite3 avatar.db 'update char_alleg set level = "%{P1}" where lower(character) = "${world_name}"'
