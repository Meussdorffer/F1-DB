drop view if exists fantasy.driver_draft_optimality;
create or replace view fantasy.driver_draft_optimality as (
    with pick_optimality as (
        select
        standings.manager,
        standings.draft_order,
        standings.driver as picked_driver,
        standings.points as picked_driver_points,
        optimal_picks.driver as optimal_driver,
        optimal_picks.points as optimal_driver_points,
        optimal_driver_managers.manager as optimal_pick_manager,
        optimal_driver_managers.manager = standings.manager as manager_has_optimal_pick,
        case
            -- Optimal driver if one of the following conditions met:
            -- 1. picked driver = optimal driver
            -- 2. two subsequent optimal drivers & picked drivers swapped due to snake-draft.
            -- 3. optimal driver and picked driver both have 0 points.
            when standings.driver = optimal_picks.driver
            or (
                lead(standings.manager) over(order by draft_order) = standings.manager
                and lead(optimal_picks.driver) over(order by draft_order) = standings.driver
            )
            or (
                lag(standings.manager) over(order by draft_order) = standings.manager
                and lag(optimal_picks.driver) over(order by draft_order) = standings.driver
            )
            or (standings.points = 0 and optimal_picks.points = 0)
                then 'optimal'

            -- sub/super optimal classifications simply determined by point differential.
            when standings.points > optimal_picks.points then 'super-optimal'
            when standings.points < optimal_picks.points then 'sub-optimal'
        end as pick_classification
        from fantasy.current_driver_standings as standings
        join fantasy.optimal_picks using(draft_order)
        join (
            select manager, driver
            from fantasy.current_driver_standings
        ) as optimal_driver_managers
        on optimal_driver_managers.driver = optimal_picks.driver
    )
    select
    manager,
    draft_order,
    picked_driver,
    picked_driver_points,
    optimal_driver,
    optimal_driver_points,
    optimal_pick_manager,
    pick_classification,
    case
        when pick_classification = 'optimal' or manager_has_optimal_pick then 0
        else picked_driver_points - optimal_driver_points
    end as points_differential
    from pick_optimality
    order by draft_order
);
