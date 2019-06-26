CREATE TABLE char_max_levels
(
	monthly_max_id INT NOT NULL auto_increment,
	name VARCHAR(13) NOT NULL COMMENT 'Character name.',
	tier VARCHAR(7) COMMENT 'Character tier.',
	class VARCHAR(12) COMMENT 'Character class.',
	race VARCHAR(20) COMMENT 'Character race.',
	levels INT DEFAULT 0 COMMENT 'Levels character gained.',
	max_date DATE COMMENT 'Date in which the max levels were last checked.',
  PRIMARY KEY (monthly_max_id),
  KEY (name), KEY (tier), KEY (class), KEY (race)
)
	COMMENT = 'Table to hold max levels gained by a character with given tier/class/race.'

	INSERT INTO monthly_max (name, tier, class, race, levels, max_date)
  SELECT char_name, char_tier, char_class, char_race, (char_level - mark_level), mark_date
	FROM avatar_chars
	WHERE (char_level - mark_level) > 0
	UNION
	SELECT char_name, char_tier, char_class, char_race, char_level-1, mark_date
	FROM avatar_chars
	WHERE char_level > 1 and char_tier <> mark_tier
