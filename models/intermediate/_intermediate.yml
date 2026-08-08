with first_touch as (
    select
        customer_id,
        campaign_id as first_touch_campaign_id,
        touchpoint_date as first_touch_date
    from {{ ref('int_user_journey') }}
    where touch_position = 1
)

select
    c.conversion_id,
    c.customer_id,
    ft.first_touch_campaign_id,
    c.conversion_date,
    c.revenue
from {{ ref('stg_conversions') }} c
left join first_touch ft
    on c.customer_id = ft.customer_id
