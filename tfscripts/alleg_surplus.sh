sqlite3 avatar.db "select sum(amount) || ' - ' || item from gear_inventory where type = 'alleg' group by item having sum(amount) > 5 order by sum(amount);"
