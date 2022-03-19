drop table if exists f1.lap_times;
create table f1.lap_times (
    race_id int,
    driver_id int,
    lap int,
    position int,
    time time,
    milliseconds int
);