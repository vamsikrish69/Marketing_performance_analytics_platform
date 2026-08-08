-- Reads only the CURRENT version of each customer from the SCD Type 2
-- snapshot. Historical versions stay in the customers_snapshot table
-- and are used directly by models that need "segment as of that date"
-- rather than "segment today".

select
    customer_id,
    segment,
    lifecycle_stage,
    signup_date,
    region,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('customers_snapshot') }}
where dbt_valid_to is null
