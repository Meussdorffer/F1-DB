drop table if exists f1.pit_stops;
create table f1.pit_stops (
    race_id int,
    driver_id int,
    stop int,
    lap int,
    time varchar(20),
    duration varchar(20),
    milliseconds int
);