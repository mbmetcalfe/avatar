-- This part tallies levels for all but new remorts/morphers
select ac.char_name, at.tnl, (ac.char_level - ac.mark_level) as levels,
        at.tnl * (ac.char_level - ac.mark_level) as exp
from avatar_chars ac, avatar_tnls at
where ac.char_tier = 'Hero' and
    (ac.char_level - ac.mark_level) > 0 and
    (   at.race = ac.char_race and
        (char_level between at.lower_level and at.upper_level) and
        (at.lower_tier = ac.char_tier and at.upper_tier = ac.char_tier)
    )
union
-- This part tallies levels for morphers/remorts since mark_date
select ac.char_name, at.tnl, ac.char_level as levels, (at.tnl * ac.char_level) as exp
from avatar_chars ac, avatar_tnls at
where ac.char_tier = 'Hero' and
    ac.char_level > 1 and
    ac.char_tier <> ac.mark_tier and
    (   at.race = ac.char_race and
        (char_level between at.lower_level and at.upper_level) and
        (at.lower_tier = ac.char_tier and at.upper_tier = ac.char_tier)
    )
order by exp desc

