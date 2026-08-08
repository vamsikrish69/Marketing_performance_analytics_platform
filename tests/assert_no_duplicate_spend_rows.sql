-- FAILS (returns rows) if the same spend_id shows up more than once
-- after staging dedup — i.e. the dedup logic itself broke.
select
    spend_id,
    count(*) as occurrences
from {{ ref('stg_ad_spend') }}
group by spend_id
having count(*) > 1
