select
    spend_id,
    campaign_id,
    cast(spend_date as date) as spend_date,
    cast(spend_amount as numeric(10,2)) as spend_amount
from {{ ref('ad_spend') }}
where spend_amount is not null
qualify row_number() over (
    partition by spend_id
    order by spend_date desc
) = 1
