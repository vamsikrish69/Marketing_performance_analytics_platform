{{
    config(
        materialized='incremental',
        unique_key='conversion_id',
        incremental_strategy='merge'
    )
}}

select
    ft.conversion_id,
    ft.customer_id,
    ft.first_touch_campaign_id,
    lt.last_touch_campaign_id,
    ft.conversion_date,
    ft.revenue
from {{ ref('int_attribution_first_touch') }} ft
left join {{ ref('int_attribution_last_touch') }} lt
    on ft.conversion_id = lt.conversion_id

{% if is_incremental() %}
where ft.conversion_date >= (
    select dateadd('day', -3, max(conversion_date)) from {{ this }}
)
{% endif %}
