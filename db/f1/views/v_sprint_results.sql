drop view if exists f1.v_sprint_results cascade;
create view f1.v_sprint_results as
select distinct
driver_id, driver_ref, forename, surname, code,
case code
    when 'VER' then 8 + 8
    when 'LEC' then 7 + 7
    when 'PER' then 6 + 4
    when 'SAI' then 5 + 6
    when 'NOR' then 4
    when 'RIC' then 3
    when 'BOT' then 2
    when 'MAG' then 1 + 2

    -- Austrian gp
    when 'RUS' then 5
    when 'OCO' then 3
    when 'HAM' then 1

    else 0
end as points
from f1.drivers
join f1.results using (driver_id)
join f1.races using (race_id)
where year = 2022
order by points desc
;
