create or replace view analytics.driver_standings_by_year as
with race_results as (
    select
    year,
    driver_id,
    forename,
    surname,
    sum(r1.points) as total_points,
    sum(case when r1.position = 1 then 1 else 0 end) as wins,
    sum(case when r1.position <= 3 then 1 else 0 end) as podiums
    from f1.results as r1
    join f1.drivers using (driver_id)
    join f1.races using (race_id)
    group by year, driver_id, forename, surname
)
select
year,
rr.driver_id,
rr.forename,
rr.surname,
total_points + sr.points as total_points,
wins,
podiums
from race_results as rr
join f1.v_sprint_results as sr using (driver_id)
order by total_points desc
;
