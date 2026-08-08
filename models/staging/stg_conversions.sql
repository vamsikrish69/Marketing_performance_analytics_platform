select
    campaign_id,
    campaign_name,
    channel,
    cast(start_date as date) as start_date,
    cast(end_date as date)   as end_date,
    cast(budget as numeric(12,2)) as budget
from {{ ref('campaigns') }}
