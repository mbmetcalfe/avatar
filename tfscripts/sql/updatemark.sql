update char_max_levels set max_date = adddate(curdate(),-1) where max_date = curdate();
update avatar_chars
set mark_date = now(),
    mark_tier = char_tier,
    mark_class = char_class,
    mark_race = char_race,
    mark_level = char_level;

