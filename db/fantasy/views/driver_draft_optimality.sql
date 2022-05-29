drop view if exists fantasy.driver_draft_optimality;
create or replace view fantasy.driver_draft_optimality as (
    with opt as (
        select
        manager as optimal_pick_manager,
        driver as optimal_driver,
        points as optimal_driver_points,
        row_number() over(order by points desc) as standing
        from fantasy.current_driver_standings
    ),
    cur as (
        select
        manager,
        driver picked_driver,
        points picked_driver_points,
        draft_order
        from fantasy.current_driver_standings
    ),

    comp as (
        select
        manager,
        draft_order,
        picked_driver,
        picked_driver_points,
        optimal_driver,
        optimal_driver_points,
        optimal_pick_manager,
        optimal_pick_manager = manager as manager_has_optimal_pick,
        case
            -- Optimal driver if one of the following conditions met:
            -- 1. picked driver = optimal driver
            -- 2. two subsequent optimal drivers & picked drivers swapped due to snake-draft.
            -- 3. optimal driver and picked driver both have 0 points.
            when picked_driver = optimal_driver
            or (
                lead(manager) over(order by draft_order) = manager
                and lead(optimal_driver) over(order by draft_order) = picked_driver
            )
            or (
                lag(manager) over(order by draft_order) = manager
                and lag(optimal_driver) over(order by draft_order) = picked_driver
            )
            or (picked_driver_points = optimal_driver_points)
                then 'optimal'

            -- sub/super optimal classifications simply determined by point differential.
            when picked_driver_points > optimal_driver_points then 'super-optimal'
            when picked_driver_points < optimal_driver_points then 'sub-optimal'
        end as pick_classification
        from cur
        join opt on opt.standing = cur.draft_order
    )
    select
    manager,
    draft_order,
    picked_driver,
    picked_driver_points,
    optimal_driver,
    optimal_driver_points,
    pick_classification,
    case
        when pick_classification = 'optimal' or manager_has_optimal_pick then 0
        else picked_driver_points - optimal_driver_points
    end as points_differential
    from comp
    order by draft_order
);
