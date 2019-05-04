SELECT char_name, char_tier, char_class, char_race, char_level
FROM avatar_chars
WHERE char_name IN (SELECT name FROM alt_list WHERE main_alt =  'jekyll')
order by CASE char_tier
  WHEN 'lord' THEN 3
  WHEN 'hero' THEN 2
  WHEN 'lowmort' THEN 1
  ELSE NULL END DESC,
  char_level desc
