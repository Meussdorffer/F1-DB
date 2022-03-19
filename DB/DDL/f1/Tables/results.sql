create table f1.results (
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
    rank int,
    fastest_lap_time time,
    fastest_lap_speed float, -- in kph
    status_id int
);