drop table if exists f1.constructor_results;
create table f1.constructor_results (
    constructor_result_id int,
    race_id int,
    constructor_id int,
    points float,
    status char(2)
);