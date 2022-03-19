create table fantasy.driver_picks (
    season int,
    manager_name varchar(20),
    manager_last_name varchar(50),
    driver_id int,
    draft_order int
);

insert into fantasy.driver_picks (season, manager_name, manager_last_name, driver_id, draft_order) values
(2022, 'Dom', 'Mackinnon', 830, 1),
(2022, 'Dom', 'Mackinnon', 842, 8),
(2022, 'Dom', 'Mackinnon', 817, 9),
(2022, 'Dom', 'Mackinnon', 20, 16),
(2022, 'Dom', 'Mackinnon', 840, 17),
(2022, 'Joe', 'Dummer', 844, 2),
(2022, 'Joe', 'Dummer', 846, 7),
(2022, 'Joe', 'Dummer', 825, 10),
(2022, 'Joe', 'Dummer', 852, 15),
(2022, 'Joe', 'Dummer', 848, 18),
(2022, 'Jack', 'Meussdorffer', 1, 3),
(2022, 'Jack', 'Meussdorffer', 815, 6),
(2022, 'Jack', 'Meussdorffer', 4, 11),
(2022, 'Jack', 'Meussdorffer', 822, 14),
(2022, 'Jack', 'Meussdorffer', 855, 19),
(2022, 'Rob', 'Wortham', 832, 4),
(2022, 'Rob', 'Wortham', 847, 5),
(2022, 'Rob', 'Wortham', 839, 12),
(2022, 'Rob', 'Wortham', 854, 13),
(2022, 'Rob', 'Wortham', 849, 20);
