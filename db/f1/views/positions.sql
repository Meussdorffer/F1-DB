-- create or replace view f1.positions as
-- with position_point_counts as (
--     select
--     year, position, points, count(*) as count
--     from f1.results
--     join f1.races using (race_id)
--     group by year, position, points
-- )
-- select
-- year,
-- position,
-- points
-- from position_point_counts
-- join (
--     select year, position, max(count) as count
--     from position_point_counts
--     group by year, position
-- ) sub
-- using (year, position, count)
--
-- -- union missing point values for positions 11 through 20.
-- union
-- select distinct
-- year,
-- position,
-- 0 as points
-- from f1.results
-- cross join (select distinct year from f1.races) as xj_year
-- where position between 11 and 20
--
-- -- union 2022 position point values carried over from 2021
-- union
-- select
-- 2022 as year,
-- position,
-- points
-- from position_point_counts
-- join (
--     select year, position, max(count) as count
--     from position_point_counts
--     where year = 2021
--     group by year, position
-- ) sub
-- using (year, position, count)
--
-- order by position
-- ;

drop view f1.positions cascade;
create or replace view f1.positions as
select 2022 as year, 1 as position, 25 as points union all
select 2022 as year, 2 as position, 18 as points union all
select 2022 as year, 3 as position, 15 as points union all
select 2022 as year, 4 as position, 12 as points union all
select 2022 as year, 5 as position, 10 as points union all
select 2022 as year, 6 as position, 8 as points union all
select 2022 as year, 7 as position, 6 as points union all
select 2022 as year, 8 as position, 4 as points union all
select 2022 as year, 9 as position, 2 as points union all
select 2022 as year, 10 as position, 1 as points union all
select 2022 as year, 11 as position, 0 as points union all
select 2022 as year, 12 as position, 0 as points union all
select 2022 as year, 13 as position, 0 as points union all
select 2022 as year, 14 as position, 0 as points union all
select 2022 as year, 15 as position, 0 as points union all
select 2022 as year, 16 as position, 0 as points union all
select 2022 as year, 17 as position, 0 as points union all
select 2022 as year, 18 as position, 0 as points union all
select 2022 as year, 19 as position, 0 as points union all
select 2022 as year, 20 as position, 0 as points
;
