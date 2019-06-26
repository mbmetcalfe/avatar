CREATE TABLE alt_list
(
        alt_list_id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
        name TEXT NOT NULL,
        main_alt TEXT NOT NULL
, imm integer);

        COMMENT = 'Table to hold known characters and their alternates.'
