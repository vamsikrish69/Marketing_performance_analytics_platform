version: 2

models:
  - name: fct_data_quality_scorecard
    description: >
      Point-in-time snapshot of key data quality checks — null spend,
      orphaned foreign keys, and revenue reconciliation between raw
      conversions and the campaign performance mart.

  - name: fct_pipeline_freshness
    description: >
      Latest loaded date and days-stale for each core source, used to
      answer "can I trust today's numbers?"
