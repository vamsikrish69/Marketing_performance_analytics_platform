select
    customer_id,
    campaign_id,
    channel,
    touchpoint_date,
    row_number() over (
        partition by customer_id
        order by touchpoint_date
    ) as touch_position,
    count(*) over (
        partition by customer_id
    ) as total_touches
from {{ ref('stg_touchpoints') }}
