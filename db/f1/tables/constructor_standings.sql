drop table if exists f1.constructor_standings;
create table f1.constructor_standings (
    constructor_standing_id int,
    race_id int,
    constructor_id int,
    points float,
    position int,
    position_text varchar(5),
    wins int
);