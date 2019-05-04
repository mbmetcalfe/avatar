create table avdupe
(
        dupe_id INT NOT NULL auto_increment,
        name VARCHAR(13) NOT NULL COMMENT 'Player name.',
        serial BIGINT COMMENT 'Item serial #.',
        vnum BIGINT COMMENT 'Item vnum.',
  PRIMARY KEY (dupe_id),
  KEY (name), KEY (serial)
)
        COMMENT = 'Table to hold duplicates info.'
