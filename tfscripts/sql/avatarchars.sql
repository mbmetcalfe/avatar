use mbm;
SELECT concat_ws(',', char_tier, char_name, char_race, char_level, char_class) as "char_tier,char_name,char_race,char_level,char_class"
FROM avatar_chars
WHERE delete_date is null
order by case char_tier 
		when 'titan' then 5 
		when 'legend' then 4 
		when 'lord' then 3 
		when 'hero' then 2 
		when 'lowmort' then 1 
		else null end DESC, 
	char_level DESC, 
	char_name;
