select
    customer_id,
    segment,
    lifecycle_stage,
    cast(signup_date as date) as signup_date,
    region
from {{ ref('customers') }}
