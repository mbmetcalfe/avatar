SELECT char_tier, char_name, char_race, char_level, char_class
INTO OUTFILE '/home/mbm/tfscripts/testChars.dat'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM avatar_chars
order by char_tier DESC, char_level DESC;
