create or replace procedure f1.load_qualifying()
language plpgsql
as $$
declare
begin
    insert into f1.qualifying (qualifying_id, race_id, driver_id, constructor_id, number, position, q1, q2, q3)
    select
    (select max(qualifying_id) from f1.qualifying) + row_number() over (order by stg.position) as qualifying_id,
    r.race_id,
    d.driver_id,
    c.constructor_id,
    d.number,
    stg.position,
    stg.q1,
    stg.q2,
    stg.q3
    from f1_staging.qualifying as stg
    join f1.drivers as d using(driver_ref)
    join f1.constructors as c using(constructor_ref)
    join f1.races as r using(year, round)
    left join f1.qualifying as rpt using(race_id, driver_id)
    where rpt.driver_id is null and rpt.race_id is null
    ;
end;
$$;
