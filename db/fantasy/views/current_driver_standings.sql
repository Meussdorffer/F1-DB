drop view if exists fantasy.current_driver_standings;
create or replace view fantasy.current_driver_standings as
with race_results as (
    select
    draft_order,
    manager_name as manager,
    d.forename || ' ' || d.surname as driver,
    driver_id,
    sum(r.points) as points
    from f1.results as r
    join fantasy.driver_picks using (driver_id)
    join f1.drivers as d using (driver_id)
    where race_id in (select race_id from f1.races where year = (select max(year) from f1.seasons))
    group by draft_order, manager_name, d.forename || ' ' || d.surname, driver_id
)
select
draft_order,
manager,
driver_id,
driver,
rr.points + sr.points as points
from race_results as rr
join f1.v_sprint_results as sr using (driver_id)
order by points desc
;
