create or replace view fantasy.current_standings as
select
manager_name,
sum(total_points) fantasy_points
from analytics.driver_standings_by_year
join fantasy.driver_picks using (driver_id)
join (
    select
    manager_name,
    sum(total_points) fantasy_points
    from analytics.driver_standings_by_year
    where
) as prior_week
where year = 2022
group by manager_name
order by fantasy_points desc
;