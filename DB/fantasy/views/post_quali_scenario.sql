create or replace view fantasy.post_quali_scenario as
select
manager_name,
sum(fantasy_points) as fantasy_points
from (
    select
    manager_name,
    fantasy_points
    from fantasy.current_standings

    union all

    select
    manager_name,
    sum(points) as fantasy_points
    from f1.v_races
    join f1.v_qualifying using (race_id)
    join f1.drivers using (driver_id)
    join f1.v_positions using (position, year)
    join fantasy.driver_picks using (driver_id)
    where year = 2022
    group by manager_name
) as sub
group by manager_name
order by fantasy_points desc
;
