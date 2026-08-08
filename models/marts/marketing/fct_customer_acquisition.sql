{{
    config(
        materialized='incremental',
        unique_key='campaign_date_key',
        incremental_strategy='merge'
    )
}}

-- Late-arriving data handling: on incremental runs, we don't only look
-- at "new" rows since the last run — we re-scan the last 3 days on every
-- run. A conversion dated last Tuesday can still land in today's load,
-- and without this window it would be silently missed.

with spend as (
    select
        campaign_id,
        spend_date as activity_date,
        daily_spend,
        0 as daily_revenue
    from {{ ref('int_campaign_spend_daily') }}
),

revenue as (
    select
        campaign_id,
        revenue_date as activity_date,
        0 as daily_spend,
        daily_revenue
    from {{ ref('int_campaign_revenue_daily') }}
),

combined as (
    select * from spend
    union all
    select * from revenue
)

select
    campaign_id,
    activity_date,
    campaign_id || '-' || activity_date as campaign_date_key,
    sum(daily_spend)   as total_spend,
    sum(daily_revenue) as total_revenue,
    sum(daily_revenue) / nullif(sum(daily_spend), 0) as roas
from combined

{% if is_incremental() %}
where activity_date >= (
    select dateadd('day', -3, max(activity_date)) from {{ this }}
)
{% endif %}

group by 1, 2, 3
