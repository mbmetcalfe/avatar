create table drone_commands
(
        drone_command_id INT NOT NULL auto_increment,
        name VARCHAR(13) NOT NULL COMMENT 'Character name.',
        command VARCHAR(100) NOT NULL COMMENT 'Command issued.',
        command_date TIMESTAMP COMMENT 'Date command was issued.',
  PRIMARY KEY (drone_command_id),
  KEY (name), KEY (command)
)
        COMMENT = 'Table to hold commands players are using.'
