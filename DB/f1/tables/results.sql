drop table if exists f1.results;
create table f1.results (
    result_id int,
    race_id int,
    driver_id int,
    constructor_id int,
    number int,
    grid int,
    position int,
    position_text char(3),
    position_order int,
    points float,
    laps int,
    time varchar(20),
    milliseconds int,
    fastest_lap int,
    rank int,
    fastest_lap_time varchar(20),
    fastest_lap_speed float, -- in kph
    status_id int
);