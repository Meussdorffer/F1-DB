drop table if exists f1.races;
create table f1.races (
    race_id int,
    year int,
    round int,
    circuit_id int,
    name varchar(50),
    date date,
    time varchar(20),
    url varchar(200),

    -- No definition for the following columns:
    p1 varchar(100),
    p2 varchar(100),
    p3 varchar(100),
    p4 varchar(100),
    p5 varchar(100),
    p6 varchar(100),
    p7 varchar(100),
    p8 varchar(100),
    p9 varchar(100),
    p10 varchar(100)
);