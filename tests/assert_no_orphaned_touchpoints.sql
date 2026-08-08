-- FAILS (returns rows) if any campaign shows a negative ROAS.
select
    campaign_id,
    roas
from {{ ref('fct_campaign_performance') }}
where roas < 0
