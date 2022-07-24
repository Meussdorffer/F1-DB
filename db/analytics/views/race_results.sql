drop view if exists analytics.race_results;
create or replace view analytics.race_results as
select
races.name as race,
year as season,
date,
circuits.name as circuit,
circuits.location as city,
circuits.country,
constructors.name as constructor,
constructors.nationality as constructor_nationality,
drivers.code as driver_code,
drivers.forename || ' ' || drivers.surname as driver,
drivers.number as driver_number,
drivers.nationality as driver_nationality,
points,
grid as grid_position,
position,
best_position,
worst_position,
grid - position as position_delta,
laps as laps_completed,
make_interval(secs => milliseconds / 1000.0) as race_time,
make_interval(secs => extract(epoch from fastest_lap_time::time)) as fastest_lap_time,
slowest_lap_time,
avg_lap_time,
med_lap_time,
stdev_lap_time,
status
from f1.results
join f1.races using (race_id)
join f1.drivers using (driver_id)
join f1.circuits using (circuit_id)
join f1.constructors using (constructor_id)
left join (
    select
    race_id,
    driver_id,
    min(position) as best_position,
    max(position) as worst_position,
    max(make_interval(secs => milliseconds / 1000.0)) as slowest_lap_time,
    avg(make_interval(secs => milliseconds / 1000.0)) as avg_lap_time,
    percentile_cont(0.5) within group(order by make_interval(secs => milliseconds / 1000.0)) as med_lap_time,
    make_interval(secs => stddev(milliseconds) / 1000.0) as stdev_lap_time
    from f1.lap_times
    group by race_id, driver_id
) lap_stats using (race_id, driver_id)
left join f1.status using (status_id)
;
