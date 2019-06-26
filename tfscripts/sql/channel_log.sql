create table channel_log
(
	channel_log_id INT NOT NULL auto_increment,
	to_char VARCHAR(13) NOT NULL COMMENT 'Character name.',
	from_char VARCHAR(13) NOT NULL COMMENT 'Character that sent message.',
	channel VARCHAR(10) NOT NULL COMMENT 'Channel message was directed to.',
	channel_text VARCHAR(255) NOT NULL COMMENT 'Text logged from channel.',
	channel_date TIMESTAMP COMMENT 'Date text was logged.',
  PRIMARY KEY (channel_log_id),
  KEY (to_char, channel), KEY (channel_date)
) COMMENT = 'Table to hold channel chatter.'


create table channel_log
(
	_id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
	chatter VARCHAR(13) NOT NULL,
	channel VARCHAR(10) NOT NULL,
	channel_text VARCHAR(255) NOT NULL,
	channel_date TEXT NOT NULL
)
