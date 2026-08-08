-- Splits conversion revenue evenly across every touchpoint in the
-- 30-day attribution window (linear attribution model).

with touches_in_window as (
    select
        c.conversion_id,
        c.customer_id,
        c.conversion_date,
        c.revenue,
        t.campaign_id as touch_campaign_id,
        t.touchpoint_date
    from {{ ref('stg_conversions') }} c
    join {{ ref('stg_touchpoints') }} t
        on c.customer_id = t.customer_id
        and t.touchpoint_date <= c.conversion_date
        and t.touchpoint_date >= dateadd('day', -30, c.conversion_date)
),

touch_counts as (
    select
        conversion_id,
        count(*) as num_touches
    from touches_in_window
    group by 1
)

select
    w.conversion_id,
    w.customer_id,
    w.touch_campaign_id,
    w.conversion_date,
    w.revenue / tc.num_touches as attributed_revenue
from touches_in_window w
join touch_counts tc
    on w.conversion_id = tc.conversion_id
