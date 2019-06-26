use mbm;
SELECT char_name AS "Name", 
	char_tier AS "Tier", 
	substr(char_class, 1, 3) AS "Class",
	substr(char_race, 1, 3) as "Race",
	char_level AS "Level", 
	(char_level - mark_level) as "Levels",
	mark_date as "Mark Date"
FROM avatar_chars
WHERE char_name in (
	select name 
	from alt_list 
	where main_alt in (
		select main_alt from alt_list where name='jekyll')) AND
	(char_level - mark_level) > 0
union
select name, tier, substr(class, 1, 3), substr(race, 1, 3), "N/A" as "Level", levels, max_date as "Mark Date" 
from char_max_levels
WHERE name in (
	select name 
	from alt_list 
	where main_alt in (
		select main_alt from alt_list where name='jekyll')) and
	levels > 0
ORDER BY 1, 7 asc,
	CASE 2
		WHEN 'titan' THEN 5 
		WHEN 'legend' THEN 4 
		WHEN 'lord' THEN 3 
		WHEN 'hero' THEN 2 
		WHEN 'lowmort' THEN 1 
		ELSE NULL END DESC, 
	6 DESC;
