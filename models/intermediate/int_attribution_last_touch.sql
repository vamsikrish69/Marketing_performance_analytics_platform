-- Attribution window: 30 days. A touchpoint older than 30 days before
-- the conversion is not considered part of the converting journey.
-- (Documented decision — see docs/decisions.md)

with touches_before_conversion as (
    select
        c.conversion_id,
        c.customer_id,
        c.conversion_date,
        c.revenue,
        t.campaign_id as touch_campaign_id,
        t.touchpoint_date,
        row_number() over (
            partition by c.conversion_id
            order by t.touchpoint_date desc
        ) as rn
    from {{ ref('stg_conversions') }} c
    join {{ ref('stg_touchpoints') }} t
        on c.customer_id = t.customer_id
        and t.touchpoint_date <= c.conversion_date
        and t.touchpoint_date >= dateadd('day', -30, c.conversion_date)
)

select
    conversion_id,
    customer_id,
    touch_campaign_id as last_touch_campaign_id,
    conversion_date,
    revenue
from touches_before_conversion
where rn = 1
