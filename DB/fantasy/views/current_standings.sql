select
manager_name,
sum(total_points) fantasy_points
from analytics.driver_standings_by_year
join fantasy.driver_picks using (driver_id)
where year = 2021
group by manager_name
order by fantasy_points desc
;
