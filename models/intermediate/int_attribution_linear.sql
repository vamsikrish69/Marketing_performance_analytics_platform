select
    campaign_id,
    spend_date,
    sum(spend_amount) as daily_spend
from {{ ref('stg_ad_spend') }}
group by 1, 2
