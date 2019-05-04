create table avatar_tnls (
    race varchar(20),
    tnl int(11),
    lower_tier varchar(7),
    lower_level int(11),
    upper_tier varchar(7),
    upper_level int(11)
    );

LOAD DATA INFILE '/home/mbm/tfscripts/docs/tnls.dat'
INTO TABLE avatar_tnls
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(race, tnl, lower_tier, lower_level, upper_tier, upper_level);

insert into avatar_tnls (race, tnl, lower_tier, lower_level, upper_tier, upper_level)
    select race, tnl+3*cast(tnl/2 as signed), 'Lord', 900, 'Lord', 999
    from avatar_tnls
    where (lower_tier = 'Lowmort' and upper_tier = 'Lowmort') and
        (lower_level = 1 and upper_level = 51)

