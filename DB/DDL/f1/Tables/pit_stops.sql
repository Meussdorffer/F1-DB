drop table if exists f1.pit_stops;
create table f1.pit_stops (
    race_id int,
    driver_id int,
    stop int,
    lap int,
    time time,
    duration float,
    milliseconds int
);