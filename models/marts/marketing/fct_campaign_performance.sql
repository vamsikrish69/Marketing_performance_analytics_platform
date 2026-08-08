select
    c.channel,
    sum(f.total_spend)   as total_spend,
    sum(f.total_revenue) as total_revenue,
    sum(f.total_revenue) / nullif(sum(f.total_spend), 0) as roas
from {{ ref('fct_campaign_performance') }} f
join {{ ref('stg_campaigns') }} c
    on f.campaign_id = c.campaign_id
group by 1
