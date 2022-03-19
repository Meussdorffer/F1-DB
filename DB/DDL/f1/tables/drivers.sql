drop table if exists f1.drivers;
create table f1.drivers (
    id int,
    driver_ref varchar(50),
    number int,
    code char(3),
    forename varchar(50),
    surname varchar(50),
    dob date,
    nationality varchar(20),
    url varchar(200)
);