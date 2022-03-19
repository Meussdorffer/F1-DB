drop table if exists f1.sprint_results;
create table f1.sprint_results (
    id int,
    race_id int,
    driver_id int,
    constructor_id int,
    number int,
    grid int,
    position int,
    position_text char(3),
    position_order int,
    points int,
    laps int,
    time time,
    milliseconds int,
    fastest_lap int,
    fastest_lap_time time,
    status_id int
);