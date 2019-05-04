create table alt_list
(
        alt_list_id INT NOT NULL auto_increment,
        name VARCHAR(13) NOT NULL COMMENT 'Character name.',
        main_alt VARCHAR(13) NOT NULL COMMENT 'Main character name.',
  PRIMARY KEY (alt_list_id),
  KEY (name), KEY (main_alt)
)
        COMMENT = 'Table to hold known characters and their alternates.'
