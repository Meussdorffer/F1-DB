drop table if exists f1_staging.qualifying;
create table f1_staging.qualifying (
    year int,
    round int,
    driver_ref varchar(50),
    constructor_ref varchar(50),
    position int,
    q1 varchar(20),
    q2 varchar(20),
    q3 varchar(20)
);