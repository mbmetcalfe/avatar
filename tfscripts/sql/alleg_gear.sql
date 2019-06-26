create table alleg_gear
(
    _id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    item TEXT NOT NULL,
    plane TEXT,
    difficulty TEXT,
    instructions TEXT,
    unique(item, plane, difficulty, instructions)
);

create table gear_inventory
(
    _id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    character TEXT NOT NULL,
    item TEXT NOT NULL,
    amount INTEGER DEFAULT 1,
    type TEXT not null
);

-- Status: Active, Complete, Gave Up
create table char_alleg
(
    _id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    character TEXT NOT NULL,
    item TEXT,
    status TEXT NOT NULL,
    level TEXT,
    updated DATE
);

insert into char_alleg(character, item, status, updated) values ('Asha', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Duskrta', null, 'Complete', 20160726);
insert into char_alleg(character, item, status, updated) values ('Eronak', null, 'Complete', 20160726);
insert into char_alleg(character, item, status, updated) values ('Feir', 'Flaming Phoenix Feather', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Gengis', 'Show Of Loyalty', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Granuja: an Ice Collar^Airscape', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Jekyll', 'A Suit Of Dress Plate', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Kaboo', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Kromlee', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Mahal', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Maxine', null, 'Gave Up', date('now'));
insert into char_alleg(character, item, status, updated) values ('Paxon: an Aurora Bow', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Phenyx', 'Panthrodrine-Skin Leggings', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Skia', 'the earthen mace of might', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Tahn', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Tarkara', null, 'Gave Up', 20160726);
insert into char_alleg(character, item, status, updated) values ('Tiati', null, 'Complete', 20160726);
insert into char_alleg(character, item, status, updated) values ('Torvald', 'Stone Disc', 'Active', null);
insert into char_alleg(character, item, status, updated) values ('Verlegenheit', null, 'Gave Up', 20160726);

select character from char_alleg where (status = 'Complete') or (status = 'Gave Up' and updated <= date('now', '-2 day'));
select character, item from char_alleg where status = 'Active';

-- http://avatar.melanarchy.info/index.php/User:MEEP
insert into alleg_gear (item, plane, difficulty, instructions) values ('Havynne''s Lantern', 'Noctopia', 'Medium', 'You can find Havynne in the Obsidian Arena Stands. She wanders, but is trackable. (Hard if no anchor set)');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Golden Bow', 'Astral', 'Easy', 'The Fae wandering memory lane carry these.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Bloodletter Flail', 'Noctopia', 'Medium', 'Many mobs in Noctopia carry this. There are several bloodguard Fae wandering in Under the Stars (near anchor), which are the easiest to get to. (Hard if no anchor set)');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Sacrifical Knife', 'Karnath', 'Hard', 'Many mobs on the Crown of Aziz-Ra run carry this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Diamond Dagger', 'Arcadia', 'Medium', 'This is on the gear mob for the Glyph run in Arc Citadel.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Ring Of The White Flame', 'Fire', 'Medium', 'Some of the numerous Crusader mobs in Fire proper carry this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Signet Of Pure Flame', 'Fire', 'Medium', 'Some of the numerous Crusaders in Fire proper carry this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Ram''s Head staff', 'Tarterus', 'Hard', 'You''ll find this on the Ring of Higher Power run in the gear room.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Shard-Embedded Whip', 'Stone', 'Easy', 'Krakor the overseer on the Daemonstone run carries this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Heavy Shroud', 'Karnath', 'Medium', 'The first room in Patriarch''s Gulch has 3 of these on shrouded warders. Plane Karn and go north then all west until you reach them.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Sultans Turban', 'Water', 'Easy', 'The Sultan is located in the Merman gate inside Bo''Vul''s vault.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Sceptre Of Creation', 'Kzinti', 'Hard', 'This is reboot only and located on the pgem run in Kzin.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Exotic Robes', 'Arcadia', 'Medium', 'Located on the fae advisors on the third level of Arcadia citadel on the Glyph run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Broken Blade Of Karnath', 'Karnath', 'Hard', 'Aziz-Ra carries this. You can find him on the way to the gear room in the Crown of Aziz-Ra run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Ice Collar','Airscape', 'Medium', 'This is in the Menagerie section of Bo''Vul''s vault on the Nothing level. Kill the ice hound.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Netherworld Dagger', 'Karnath', 'Hard', 'Located in the gear room on the Crown of Aziz-Ra run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Black Sword Of The Keep', 'Outland', 'Easy', 'The gith champion carries this and is portalable from Outland shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Ice Collar','Water', 'Easy', 'This is in Blizzard''s room 2 west, down from water shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Golden Sleeves', 'Astral', 'Medium', 'Sygerion at the end of the memory lane run carries this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Sun Staff', 'Astral', 'Medium', 'These are available in two locations. One is in the rooms leading up to and in the final room of memory lane, and the other is on the same mobs on the Shield of Lords run. The Shield of Lords run mobs are reboot only.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Ice Hound Tooth', 'Airscape', 'Medium', 'This is in the Menagerie section of Bo''Vul''s vault on the Nothing level. Kill the ice hound.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Ice Bow', 'Water', 'Easy', 'This is in Blizzard''s room 2 west, down from water shift, along with the ice collar and ice hound''s tooth from water.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Vial Of Unfinished Portal Serum', 'Kzinti', 'Medium', 'This is carried by Hidden Anxiety in Spire of Knowledge Unleashed.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('seething ball of blue flame', 'Arcadia', 'Medium', 'Located on the advisors on the third level of Arcadia citadel on the Glyph run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Stone Platemail', 'Stone', 'Medium', 'Gaius carries this and is in the gear room on the Daemonstone run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Dark Purple Robe', 'Outland', 'Easy', 'Located on the mistress of the south, one of the four leaders in the basement of Outland keep.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a lavabomb','Stone', 'Easy', 'Elemental telepaths and territorial elementals carry these, as do the huge elementals guarding the Earth Lord. You will need a Mnd or Psi to decept them to initiate combat.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a lavabomb','Fire', 'Medium', 'Large/Huge fire elementals and mephits carry these. You will need a Mnd or Psi to decept them to initiate combat, otherwise the mobs throw them at you. Located in the maze section of Fire proper en route to the inferno dragon.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Dancing Katana', 'Arcadia', 'Medium', 'Located on Duke Zarradyn.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Viper Fang', 'Noctopia', 'Medium', 'The viper troops on the Shield of Shadows run carry these. They are reboot only, but each boot yields a large number of them.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Buckler Bracelet', 'Noctopia', 'Medium', 'Many mobs in Noctopia carry this. In Under the Stars (near anchor), you can get them from the Fae stargazer, Unseelie she-Fae, Noctopian she-Fae and Dark Fae dancer. (Hard if no anchor set)');
insert into alleg_gear (item, plane, difficulty, instructions) values ('A small steam gun', 'Air', 'Medium', 'Diminutive automatons in Bo''Vul''s Vault carry these.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Pair Of Wind-Ravaged Boots', 'Water', 'Easy', 'The shopkeeper in Shunned World will give you this for a storm-skin cloak. Storm-skin cloaks are located on the storm wyrms in Water proper, which wander and are portalable.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an incantation note', 'Kzinti', 'Medium', 'This is located on Alchyzar in the room preceeding the Spires run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Aurora Bow', 'Air', 'Medium', 'Oriad the Windprincess carries this. Plane air and portal to vortex, then skin the corpse. Enter vortex and you''ll be taken to her room. This mob is not aggro, but stuns the tank every round with lightning arrows, so kill the rest of the room first and then kill her.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('the earthen mace of might', 'Stone', 'Medium', 'The Earth Lord holds this and also the elemental earth ring.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Cape Of Angel Feathers', 'Arcadia', 'Medium', 'Manon of the Spring carries this. You find her on the way up the tower on the Glyph run in Arcadia Citadel.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a grim bone shield', 'Tarterus', 'Trivial', 'Several demons in Tarterus proper carry this. Trivial to solo on any caster.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Ritual Purification Wand', 'Fire', 'Medium', 'This is a kspawn item that loads when you kill the cleansing flame in Cinderheim.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Staff Of The Lower Planes', 'Tarterus', 'Medium', 'Anthraxus carries this. You can reach him by drinking from the fountain in the gargoyle room in Tarterus.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Decaying Vest Made From Cracked Leather', 'Astral', 'Medium', 'Located on Lord Gith. Portal to lich queen from Astral shift and go 2 down.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Massive Slate-grey Sledgehammer', 'Astral', 'Easy', 'Located on the astral guardians that wander between Astral shift and the room below it.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a black whip', 'Tarterus', 'Medium', 'You can get this from the Demogorgon in Tarterus. It is campable in a smaller group, but the mob hits fairly hard.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a green web veil', 'Astral', 'Medium', 'The astral invasion commander carries this. Annoying to camp due primarily to irritating mobspecs that bash tanks.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Bloodstained Blindfold', 'Karnath', 'Medium', 'The oni augur in Patriarch''s Gulch carries this. From the anchor in Gulch, go down, south and kill the mob there for the Golden Scarab. Then go north, up and unlock east. This section is 5 rooms big and the oni wanders.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Obsidian Sledgehammer', 'Kzinti', 'Medium', 'Located on the magmage on the Sceptre of Blazing Fury run. There are two magmages, but only one carries this item. They both wander.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Crumpled Note', 'Kzinti', 'Easy', 'The kzinti scientist located all north, east from Kzin shift carries this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Crystal Ball', 'Outland', 'Easy', 'This item loads on the ground on the top level of Outland Keep in the room with the gith seer.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Storm-skin Cloak', 'Water', 'Easy', 'You can get these on Water by portaling to storm wyrm. There are 3 storm wyrms, but only 2 carry this item.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Black Wand With A Grinning Skull', 'Outland', 'Easy', 'This is on one of the four gith leaders in the basement of Outland keep.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('an Ethereal Blade', 'Noctopia', 'Medium', 'These are carried by ethereal stalkers in Under the Stars. If the anchor is in Noctopia and you plane to it, they come to you. (Hard if no anchor set)');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Dancing Rapier', 'Arcadia', 'Medium', 'Located on Kipparielle, preceeding Duke Zarradyn on the Zarradyn''s Gauntlets run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Omayras Kit', 'Noctopia', 'Medium', 'Located on the broken oni in the pits of blood and chain in Noctopia. (Hard if no anchor set)');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Blades of Discord', 'Tarterus', 'Medium', 'These are located on the statues of Tiamat and Anthraxus in the Garden in Tarterus.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Radiance Of Wickedness', 'Stone', 'Medium', 'Elaxor carries this. He is in the gear room on the Daemonstone run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('A Suit Of Dress Plate', 'Noctopia', 'Hard', 'This piece is reboot only and carried by Duke Malafont.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Black Masters Hood', 'Outland', 'Easy', 'The Githzerai master of death carries this. He is portable from Outland shift, but most people use female trainee as a portal point since other mobs in the area have the keywords gith and master.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Clear Psi-Blade', 'Nowhere', 'Medium', 'This and all the other psi-blades are in the Nothing area accessible from the four elemental planes. The mobs all wander and all det.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Blue Psi-Blade', 'Nowhere', 'Medium', 'This and all the other psi-blades are in the Nothing area accessible from the four elemental planes. The mobs all wander and all det.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Ring Of Minor Imagery', 'Air', 'Medium', 'Apprentice Verte in the imagery gate in Bo''Vul''s vault carries this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Pair Of Kzinti Slaughter Gloves', 'Kzinti', 'Easy', 'The kzinti bodyguards in the astral invasion area carry these. There are many of them, but they are invis. Wandering the area will yield several.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('the whip, "Death-Tamer"', 'Tarterus', 'Medium', 'This is on the gravemaster in the Garden area of Tarterus.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Silver Dagger With A Golden Handle', 'Outland', 'Easy', 'Gith mages in Outland keep carry this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a blueish-white stone', 'Astral', 'Easy', 'The shopkeeper in Shunned World gives you this in exchange for a devilish talisman from Astral Proper (on the night hag).');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Aura Of Domination', 'Kzinti', 'Medium', 'This is in the gear room on the Spires run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Mark Of Madness', 'Stone', 'Easy', 'This is on Krakor the overseer in the Daemonstone run. Mob wanders.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Amulet With A Small Silver Sword Inscribed On It', 'Outland', 'Easy', 'The fake gith king and his entourage have this as well as the blood red robe. He is all south from the gith training area.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Panthrodrine-Skin Leggings', 'Tarterus', 'Medium', 'The shopkeeper in Shunned World will give you this for the Blade of Discord, which is carried by the statues of Anthraxus and Tiamat on the Garden run in Tarterus.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Flaming Phoenix Feather', 'Fire', 'Medium', 'This one is in fire proper. You will need to kill Malarauko and Valarauko and then skin the inferno dragon for the three tickets. Give one to Puritan (who takes the other two) to open the portal to the Phoenix.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Ice Hound''s Tooth', 'Water', 'Easy', 'This is in Blizzard''s room 2 west, down from water shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Devilish Lance', 'Fire', 'Medium', 'The hunting imps wandering in Cinderheim carry these.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Show Of Loyalty', 'Karnath', 'Hard', 'Several of these load in the gear room on the Shackles of Broken Tyranny run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Dress Of Silk And Velvet Rags', 'Noctopia', 'Hard', 'This one is challenging. Located on Kipparielle preceeding Queen Zydarielle on the Black Widow Bodice run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Glowing Iron Skewer', 'Noctopia', 'Hard', 'These are held by the Iron Claw soulstealers in the Shiftwatch Orb in Noctopia.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Shaleskin Arm Guard', 'Stone', 'Easy', 'The rock wyrm mother skins to this. It is 5 north from Stone shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Baleflame', 'Arcadia', 'Easy', 'The balefire beasts in Arcadia proper carry this. You can portal to them.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Steel Broadsword', 'Fire', 'Medium', 'Ralthar the Unerring drops this and is located on the ramp 2 north, up from Fire shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Stone Disc', 'Midgaard', 'Medium', 'You need to kill the sun guardian for this. It''s no-spell and on midgard, so you will be shadowed while fighting it. To get to the mob, portal to black circle master, enter house, and move west, south.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Red Bracer','Thorngate', 'Medium', 'This is reboot only. The Temple of Gorn is on Thorngate but nospell.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a crude spear', 'Kzinti', 'Easy', 'These are carried by reptilian yorials in Kzin proper (near shift).');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Whirl Of Elusive Feathers', 'Arcadia', 'Easy', 'Skin the chimerical griffon in Arcadia proper for this. The griffon is portalable, but only the griffon that loads in The River skins.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Clasp Of Eternal Anguish', 'Fire', 'Medium', 'Several mobs in Fire proper carry this. Malarauko and Valarauko load in proper but typically wander into the emberforge. When inside the forge, they are not portalable but can be tracked from shift. Watch out for no-spell rooms inside the emberforge.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Axe Of The Third Plane', 'Tarterus', 'Hard', 'Several mobs on the Ring of Higher Power run carry this. They are very heavy.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Iron Dha', 'Karnath', 'Medium', 'Several mobs in Karnath proper load with this. Look for crazed cynic and accursed blasphemer.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Green Psi-Blade', 'Nowhere', 'Medium', 'This and all the other psi-blades are in the Nothing area accessible from the four elemental planes. The mobs all wander and all det.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a stone hammer', 'Water', 'Medium', 'Many mobs in the Earth section of the Lodestone run carry these. This section is no-spell.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a rock hammer', 'Stone', 'Medium', 'The golem immediately preceding the gear room on the Daemonstone run carries this.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Unicorn Horn', 'Air', 'Medium', 'Wisp carries this. Wisp is in the same room as Orius and Oriad, which is accessible from Airrealm by portaling to vortex and skinning its corpse, then entering.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a flametongue called Firebrand', 'Kzinti', 'Medium', 'Pyrrhan carries this. From Kzin shift, go east, all south, all up, 2 south.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Dancing Dagger', 'Arcadia', 'Medium', 'Located on Misfit, preceeding Duke Zarradyn on the Zarradyn''s Gauntlets run.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a side of venison', 'Thorngate', 'Trivial', 'Located in the cabinet in Bandu''s kitchen 3 west, north, west from Thorngate Center.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Air Gun', 'Air', 'Easy', 'Several invis mobs in Air Realm proper carry this. Depending on time of day, it can be helpful to use danger scan on an alt that gets that skill to hunt them.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Yellow Psi-Blade', 'Nowhere', 'Medium', 'This and all the other psi-blades are in the Nothing area accessible from the four elemental planes. The mobs all wander and all det.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Devilish Talisman', 'Astral', 'Easy', 'The night hag in Astral proper has this. Portalable from shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a dagger of dark rites', 'Karnath', 'Hard', 'Many of these appear during the Shackles run. Most of the mobs in the gear section carry them.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Assassins Armband', 'Outland', 'Easy', 'Skin the gith lookouts for this. There are two rooms of lookouts in Outland proper, with up to two lookouts per room. The mobs are portalable. You can identify whether or not you have the right room by checking if the mobs have the keyword lookout.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Blood Red Robe', 'Outland', 'Easy', 'Located in the room with the fake gith king and his entourage, all south from the gith training area in Outland Keep.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('a Faerie script', 'Thorngate', 'Easy', 'You get this in exchange for the black etched tablet found on the Lich Queen in astral.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Coarse Leather Boots', 'Noctopia', 'Hard', 'The shopkeeper in Shunned World will give you this in exchange for an iron web shield. Iron web shields are located on Iron Claw dominators in the Shiftwatch Orb at Noctopia shift.');
insert into alleg_gear (item, plane, difficulty, instructions) values ('Staff Of Prophecy', 'Water', 'Hard', 'This is reboot only and available in the gear room on the Lodestone run.');
