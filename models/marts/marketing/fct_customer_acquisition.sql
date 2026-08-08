select
    dc.segment,
    dc.region,
    count(distinct co.customer_id) as converted_customers,
    sum(co.revenue) as total_revenue
from {{ ref('stg_conversions') }} co
join {{ ref('dim_customers_current') }} dc
    on co.customer_id = dc.customer_id
group by 1, 2
