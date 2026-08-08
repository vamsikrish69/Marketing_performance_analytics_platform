# Marketing Analytics Platform

Snowflake + dbt project consolidating campaign performance, multi-touch
attribution, SCD Type 2 customer history, and data quality monitoring
into one platform.

## Folder structure (must match dbt_project.yml exactly)

```
marketing-analytics-platform/
├── dbt_project.yml
├── packages.yml
├── seeds/                     <- 5 CSVs
├── snapshots/                 <- SCD Type 2 customer history
├── models/
│   ├── staging/                <- cleaned, cast, deduplicated
│   ├── intermediate/           <- joins, attribution logic
│   └── marts/
│       ├── marketing/          <- business-facing fact/dim tables
│       └── quality/            <- data quality scorecard + freshness
├── tests/                      <- singular business-logic tests
├── macros/                     <- reusable macros + custom generic test
├── analyses/business_questions/
└── docs/
```

## Run order

```
dbt deps
dbt seed
dbt snapshot
dbt run
dbt test
```

Run in exactly this order the first time: seeds must exist before the
snapshot can read them, the snapshot must run before
`dim_customers_current` can build, and everything must exist before
tests can check it.

## Business questions this project answers

See docs/business_questions.md.

## Why things are built this way

See docs/decisions.md for short architecture decisions (why SCD2, why
the 3-day incremental lookback, why a 30-day attribution window).

## Incident history

See docs/engineering_journal.md for documented troubleshooting and
optimization work.
