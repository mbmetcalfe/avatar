#sqlite3 mine/av.db "select '\"' || mob_short || '\": ' || 0 from mobiles where area_name = 'Necropolis'"
sqlite3 mine/av.db "select '\"' || zonemob.mob || '\": 0' from zonemob join zone on zone.id = zonemob.zoneid where zone.name like '%Overgrowth%'"
