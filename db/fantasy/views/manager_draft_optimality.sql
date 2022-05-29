drop view if exists fantasy.manager_draft_optimality;
create view fantasy.manager_draft_optimality as (
    select
    manager,
    sum(points_differential) as total_points_differential
    from fantasy.driver_draft_optimality
    group by manager
    order by total_points_differential desc
);
