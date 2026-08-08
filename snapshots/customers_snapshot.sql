{% snapshot customers_snapshot %}
{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['segment', 'lifecycle_stage']
    )
}}

select
    customer_id,
    segment,
    lifecycle_stage,
    signup_date,
    region
from {{ ref('customers') }}

{% endsnapshot %}
