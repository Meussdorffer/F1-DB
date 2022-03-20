drop table if exists f1.circuits;
create table f1.circuits (
    circuit_id int,
    circuit_ref varchar(100),
    name varchar(200),
    location varchar(100),
    country varchar(50),
    lat float,
    lng float,
    alt int,
    url varchar(200)
);