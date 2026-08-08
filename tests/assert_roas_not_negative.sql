-- FAILS (returns rows) if linear-attributed revenue for a conversion
-- doesn't sum back to that conversion's original revenue.
with linear_totals as (
    select
        conversion_id,
        sum(attributed_revenue) as total_attributed
    from {{ ref('int_attribution_linear') }}
    group by 1
)

select
    lt.conversion_id,
    lt.total_attributed,
    c.revenue
from linear_totals lt
join {{ ref('stg_conversions') }} c
    on lt.conversion_id = c.conversion_id
where abs(lt.total_attributed - c.revenue) > 0.01
