select
    conversion_id,
    customer_id,
    campaign_id,
    cast(conversion_date as date) as conversion_date,
    cast(revenue as numeric(10,2)) as revenue
from {{ ref('conversions') }}
where revenue is not null
qualify row_number() over (
    partition by conversion_id
    order by conversion_date desc
) = 1
