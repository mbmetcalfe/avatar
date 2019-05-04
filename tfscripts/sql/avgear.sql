create table avgear
(
        gear_id INT NOT NULL auto_increment,
        name VARCHAR(50) NOT NULL COMMENT 'Gear name.',
        level INT COMMENT 'Level of the item.',
        type VARCHAR(5) COMMENT 'What type gear. AC/HIT/MANA.',
        tier INT COMMENT 'What tier item is (1st, 2nd, etc).',
        slot VARCHAR(10) COMMENT 'What slot item belongs (wrist, arms, etc).',
        grandfathered CHAR(1) DEFAULT 'N' COMMENT 'Is item grandfathered? (Y/N)',
        modifiers VARCHAR(200) COMMENT 'Any modifiers on the item.',
  PRIMARY KEY (gear_id),
  KEY (name), KEY (name)
)
        COMMENT = 'Table to hold gear statistics.'
/*
mana:
<used as light>     (Demonic) (Magical) (Glowing) (Humming) a Mystical Glow
<worn on finger>    a strand of Haghair
<worn on finger>    a strand of Haghair
<worn around neck>  (Magical) (Glowing) SuPerPluto's Cape
<worn around neck>  (Magical) (Glowing) (Humming) a talisman of innocent blood
<worn on body>      (Magical) gold chased armor
<worn on head>      (Invis) (Magical) a Golden Dragonskull
<worn on legs>      (Magical) waterlace leggings
<worn on feet>      (Magical) (Glowing) a small toe-ring
<worn on hands>     a watershape
<worn on arms>      (Magical) (Glowing) a silver iguana
<held in offhand>   (Magical) (Glowing) the rod of elemental power
<worn about body>   (Magical) the Nethershroud
<worn about waist>  (Glowing) a silver belly chain
<worn on wrist>     (Humming) a jade bracer
<worn on wrist>     a watershape
<wielded>           (Demonic) (Magical) (Glowing) (Humming) a staff of ancient magicks
<held>              (Demonic) (Magical) a lord's head chalice
*/
/* AC Gear Inserts */
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('an elemental earth ring', 125, 1, 'finger', 'N', '-40 AC +3 STR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('an Inferno stone', 125, 1, 'light', 'N', '-100 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the Ruling Glyph', 125, 1, 'neck', 'N', '-50 AC, +2 INT', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver amulet with sword', 125, 2, 'neck', 'N', '-30 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver armor chestplate', 125, 1, 'on body', 'N', '-120 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('stone demonhide', 125, 2, 'on body', 'N', '-50 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('blue dragonscale cloak', 125, 1, 'on body', 'Y', '-50 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the jeweled crown of Aziz-Ra', 125, 1, 'head', 'N', '-110 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver helm', 125, 2, 'head', 'N', '-80 AC, +3 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('mobius headdress', 125, 2, 'head', 'N', '-50 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the living daemonstone', 125, 1, 'legs', 'N', '-50 AC, +3/+6 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver leggings', 125, 2, 'legs', 'N', '-30 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('boots of the conquerer', 125, 1, 'feet', 'N', '-40 AC, +2/+3 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('boots of the righteous path', 125, 2, 'feet', 'N', '-20 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('Zarradyn''s Gauntlets', 125, 1, 'hands', 'N', '-30 AC, +7 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('gauntlets of protection', 125, 2, 'hands', 'N', '-10 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('black armband', 125, 1, 'arms', 'N', '-20 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('black dragonscale sleeves', 125, 1, 'arms', 'Y', '-20 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('billowing sleeves of vapor', 125, 2, 'arms', 'N', '-15 AC, -75 save vs magic', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the Shield of Lords', 125, 1, 'offhand', 'N', '-125 AC, +2 DEX', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the Great Shield, "Tyranny"', 125, 2, 'offhand', 'N', '-50 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('golden shield', 125, 3, 'offhand', 'Y', '-40 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a pair of stone wings', 125, 1, 'about body', 'N', '-40 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('red dragonscale cloak', 125, 1, 'about body', 'N', '-40 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('black cloak', 125, 2, 'about body', 'N', '-20 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a crimson bloodsash', 125, 1, 'waist', 'N', '-50 AC, +2/3 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a kzintium blade bracer', 125, 1, 'wrist', 'N', '-25 AC, +2 HR/DR', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('coral bracer', 125, 2, 'wrist', 'N', '-10 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the Lodestone', 125, 1, 'held', 'N', '-20 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('basilisk field', 125, 2, 'held', 'Y', '-10 AC', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('guiding Light of Ronan', 125, 1, 'light', 'N', '-100 AC, -50 save vs spell, detects', 'AC');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver leggings', 125, 2, 'legs', 'N', '-30 AC, +2 HR/DR', 'AC');
/* HIT Gear inserts */
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('an ice collar', 125, 2, 'neck', 'N', '+3 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a flaming phoenix feather', 125, 1, 'light', 'N', '+3/+6 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the sceptre of Blazing Fury', 125, 1, 'light', 'N', '+7 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the ring of higher power', 125, 1, 'finger', 'N', '+6 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the ring of the Burning River', 125, 2, 'finger', 'Y', '+5 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a necklace of severed Fae ears', 125, 1, 'neck', 'N', '+5 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('holy symbol of war', 125, 3, 'neck', 'N', '+2/+3 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a Tuatar battle tunic', 125, 1, 'on body', 'N', '+7 DR, +100 HP', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a crown of wire and broken glass', 125, 1, 'head', 'N', '+10 DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver helm', 125, 2, 'head', 'N', '-80 AC, +3 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the living daemonstone', 125, 1, 'legs', 'N', '-50 AC, +3/+6 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver leggings', 125, 2, 'legs', 'N', '-30 AC, +2 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('Zarradyn''s Gauntlets', 125, 1, 'hands', 'N', '-30 AC, +7 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('boots of planewalking', 125, 1, 'feet', 'N', '-10 AC, +3/+8 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a watermark tattoo', 125, 1, 'arms', 'N', '+4/+8 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('mark of madness', 125, 1, 'arms', 'N', '+5/+5 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('silver sword', 125, 1, 'weapon', 'N', '+30/+30 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('ancient dragon claw', 125, 1, 'piercer', 'N', '+20/+25 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('diamond dagger', 125, 3, 'piercer', 'N', '+17/+17 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('ruby dagger', 125, 2, 'piercer', 'N', '+15/+15 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a cloud of dancing shards', 125, 1, 'about body', 'N', '+5 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('a belt of souls', 125, 1, 'waist', 'N', '-10 AC, +5 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('severed gith hand', 125, 1, 'held', 'N', '+12/+12 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('the broken shackles of tyranny', 125, 1, 'wrist', 'N', '+6 HR/DR', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('baleflame', 125, 3, 'wrist', 'N', '+3/+4 HR/DR, -50 HP', 'HIT');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('slaughtering gloves', 125, 2, 'hands', 'N', '+3/+5 HR/DR', 'HIT');

insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('', 125, 1, '', 'N', '', 'MANA');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('', 125, 1, '', 'N', '', 'MANA');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('', 125, 1, '', 'N', '', 'MANA');
insert into avgear (name, level, tier, slot, grandfathered, modifiers, type) values ('', 125, 1, '', 'N', '', 'MANA');
