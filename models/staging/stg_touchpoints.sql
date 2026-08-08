select
    touchpoint_id,
    customer_id,
    campaign_id,
    cast(touchpoint_date as date) as touchpoint_date,
    channel
from {{ ref('marketing_touchpoints') }}
qualify row_number() over (
    partition by touchpoint_id
    order by touchpoint_date desc
) = 1
