drop table if exists f1.constructor_standings;
create table f1.constructor_standings (
    id int,
    race_id int,
    constructor_id int,
    points int,
    position int,
    position_text varchar(5),
    wins int
);