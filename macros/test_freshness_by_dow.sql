-- Day-of-week-aware freshness test. A flat threshold fires every Monday
-- because weekend volume is naturally lower — this test allows a wider
-- window on weekends and a tighter one on weekdays.
{% test freshness_by_dow(model, date_column, weekday_max_days=1, weekend_max_days=3) %}

with checked as (
    select
        max({{ date_column }}) as latest_date,
        datediff('day', max({{ date_column }}), current_date()) as days_stale,
        dayofweek(current_date()) as today_dow
    from {{ model }}
)

select *
from checked
where
    (today_dow not in (0, 6) and days_stale > {{ weekday_max_days }})
    or
    (today_dow in (0, 6) and days_stale > {{ weekend_max_days }})

{% endtest %}
