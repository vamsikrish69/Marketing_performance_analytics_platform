select
    campaign_id,
    conversion_date as revenue_date,
    sum(revenue) as daily_revenue
from {{ ref('stg_conversions') }}
group by 1, 2
