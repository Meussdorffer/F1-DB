create or replace procedure f1.load_results()
language plpgsql
as $$
declare
begin
    insert into f1.results (
        result_id, race_id, driver_id, constructor_id, number, grid, position, position_text,
        position_order, points, laps, time, milliseconds, fastest_lap, rank, fastest_lap_time,
        fastest_lap_speed, status_id
    )
    select
    (select max(result_id) from f1.results) + row_number() over (order by stg.position) as result_id,
    r.race_id,
    d.driver_id,
    c.constructor_id,
    d.number,
    stg.grid,
    stg.position,
    stg.position_text,
    stg.position_order,
    stg.points,
    stg.laps,
    stg.time,
    stg.milliseconds,
    stg.fastest_lap,
    stg.rank,
    stg.fastest_lap_time,
    stg.fastest_lap_speed,
    st.status_id
    from f1_staging.results as stg
    join f1.drivers as d using(driver_ref)
    join f1.constructors as c using(constructor_ref)
    join f1.races as r using(year, round)
    left join f1.status as st using (status)
    left join f1.results as rpt using(race_id, driver_id)
    where rpt.driver_id is null and rpt.race_id is null
    ;
end;
$$;
