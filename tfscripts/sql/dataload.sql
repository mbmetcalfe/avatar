LOAD DATA INFILE '/home/mbm/tfscripts/sqlimp.dat'
INTO TABLE avatar_chars
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(char_tier, char_name, char_race, char_level, char_class);
