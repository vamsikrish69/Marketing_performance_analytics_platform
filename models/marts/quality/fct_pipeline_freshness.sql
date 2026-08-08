select
    'ad_spend' as source_name,
    max(spend_date) as latest_date,
    datediff('day', max(spend_date), current_date()) as days_stale
from {{ ref('stg_ad_spend') }}

union all

select
    'conversions' as source_name,
    max(conversion_date) as latest_date,
    datediff('day', max(conversion_date), current_date()) as days_stale
from {{ ref('stg_conversions') }}

union all

select
    'touchpoints' as source_name,
    max(touchpoint_date) as latest_date,
    datediff('day', max(touchpoint_date), current_date()) as days_stale
from {{ ref('stg_touchpoints') }}
