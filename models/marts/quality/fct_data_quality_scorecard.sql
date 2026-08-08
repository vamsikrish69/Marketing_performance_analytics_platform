with spend_nulls as (
    select count(*) as cnt
    from {{ ref('stg_ad_spend') }}
    where spend_amount is null
),

orphan_touchpoints as (
    select count(*) as cnt
    from {{ ref('stg_touchpoints') }} t
    left join {{ ref('stg_campaigns') }} c
        on t.campaign_id = c.campaign_id
    where c.campaign_id is null
),

orphan_conversions as (
    select count(*) as cnt
    from {{ ref('stg_conversions') }} co
    left join {{ ref('stg_campaigns') }} c
        on co.campaign_id = c.campaign_id
    where c.campaign_id is null
),

revenue_reconciliation as (
    select
        (select sum(revenue) from {{ ref('stg_conversions') }}) as raw_total_revenue,
        (select sum(total_revenue) from {{ ref('fct_campaign_performance') }}) as mart_total_revenue
)

select
    current_timestamp()                   as checked_at,
    (select cnt from spend_nulls)         as null_spend_rows,
    (select cnt from orphan_touchpoints)  as orphan_touchpoint_rows,
    (select cnt from orphan_conversions)  as orphan_conversion_rows,
    r.raw_total_revenue,
    r.mart_total_revenue,
    abs(r.raw_total_revenue - r.mart_total_revenue) < 0.01 as revenue_reconciles
from revenue_reconciliation r
