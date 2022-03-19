drop table if exists f1.driver_standings;
create table f1.driver_standings (
    id int,
    race_id int,
    driver_id int,
    points int,
    position int,
    position_text int,
    wins int
);