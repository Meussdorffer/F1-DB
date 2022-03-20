drop table if exists f1_staging.results;
create table f1_staging.results (
    year int,
    round int,
    driver_ref varchar(50),
    constructor_ref varchar(50),
    grid int,
    position int,
    position_text char(3),
    position_order int,
    points int,
    laps int,
    time varchar(20),
    milliseconds int,
    fastest_lap int,
    rank int,
    fastest_lap_time varchar(20),
    fastest_lap_speed float,
    status varchar(100)
);
