sqlite3 mine/av.db "select '# ' || zone.name from zone where lower(zone.name) like '%$1%'"
sqlite3 mine/av.db "select '\"' || zonemob.mob || '\": 0' from zonemob join zone on zone.id = zonemob.zoneid where lower(zone.name) like '%$1%' order by zone.id"
