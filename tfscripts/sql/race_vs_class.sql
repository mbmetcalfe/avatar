select count(0) count, char_class, char_race
from avatar_chars
group by char_class, char_race
having count > 20
order by count desc, char_class

select count(0) count, char_race, char_class
from avatar_chars
group by char_race, char_class
having count > 20
order by count desc, char_race
