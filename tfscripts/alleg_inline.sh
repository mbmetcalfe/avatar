sqlite3 avatar.db "select case when count(*) > 1 then count(*) || ' x ' || item else item end as item from char_alleg where item is not null group by item" | awk '{printf("%s. ", $0)}'
