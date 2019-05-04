create table char_stat
(
    _id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
    character TEXT NOT NULL,
    tier TEXT,
    level INTEGER NOT NULL,
    class TEXT,
    race TEXT,
    hp INTEGER NOT NULL,
    mana INTEGER DEFAULT 0,
    mv TEXT not null,
    last_seen TEXT NOT NULL
);

