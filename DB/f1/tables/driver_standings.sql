drop table if exists f1.driver_standings;
create table f1.driver_standings (
    driver_standings_id int,
    race_id int,
    driver_id int,
    points float,
    position int,
    position_text varchar(3),
    wins int
);