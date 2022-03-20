drop view if exists fantasy.current_driver_standings;
create or replace view fantasy.current_driver_standings as
select
manager_name as manager,
forename || ' ' || surname as driver,
sum(points) as points
from f1.results
join fantasy.driver_picks using (driver_id)
join f1.drivers using (driver_id)
where race_id in (select race_id from f1.races where year = (select max(year) from f1.seasons))
group by manager_name, forename || ' ' || surname
order by points desc
;
