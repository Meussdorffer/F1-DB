create or replace view f1.v_positions as
with position_point_counts as (
    select
    year, position, points, count(*) as count
    from f1.results
    join f1.races using (race_id)
    group by year, position, points
)
select
year,
position,
points
from position_point_counts
join (
    select year, position, max(count) as count
    from position_point_counts
    group by year, position
) sub
using (year, position, count)

-- union missing point values for positions 11 through 20.
union
select distinct
year,
position,
0 as points
from f1.results
cross join (select distinct year from f1.races) as xj_year
where position between 11 and 20

-- union 2022 position point values carried over from 2021
union
select
2022 as year,
position,
points
from position_point_counts
join (
    select year, position, max(count) as count
    from position_point_counts
    where year = 2021
    group by year, position
) sub
using (year, position, count)

order by position
;