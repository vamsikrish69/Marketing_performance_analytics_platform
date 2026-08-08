version: 2

models:
  - name: dim_customers_current
    description: Current (is_current) version of each customer from the SCD2 snapshot.
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null

  - name: fct_campaign_performance
    description: Incremental daily spend/revenue/ROAS by campaign.
    columns:
      - name: campaign_date_key
        tests:
          - unique
          - not_null

  - name: fct_channel_performance
    description: Spend/revenue/ROAS rolled up by channel.

  - name: fct_customer_acquisition
    description: Converted customers and revenue by segment and region.

  - name: fct_attribution_comparison
    description: Incremental first-touch vs last-touch comparison per conversion.
    columns:
      - name: conversion_id
        tests:
          - unique
          - not_null
