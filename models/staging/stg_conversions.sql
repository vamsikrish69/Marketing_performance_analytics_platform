version: 2

models:
  - name: stg_campaigns
    description: One row per campaign, cleaned and cast.
    columns:
      - name: campaign_id
        tests:
          - unique
          - not_null

  - name: stg_customers
    description: One row per customer, cleaned and cast.
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null

  - name: stg_touchpoints
    description: Deduplicated marketing touchpoints.
    columns:
      - name: touchpoint_id
        tests:
          - unique
          - not_null
      - name: campaign_id
        tests:
          - relationships:
              to: ref('stg_campaigns')
              field: campaign_id
      - name: customer_id
        tests:
          - relationships:
              to: ref('stg_customers')
              field: customer_id

  - name: stg_conversions
    description: Deduplicated conversions with non-null revenue.
    columns:
      - name: conversion_id
        tests:
          - unique
          - not_null
      - name: revenue
        tests:
          - not_null
      - name: campaign_id
        tests:
          - relationships:
              to: ref('stg_campaigns')
              field: campaign_id
      - name: customer_id
        tests:
          - relationships:
              to: ref('stg_customers')
              field: customer_id

  - name: stg_ad_spend
    description: Deduplicated daily ad spend by campaign.
    tests:
      - freshness_by_dow:
          date_column: spend_date
          weekday_max_days: 1
          weekend_max_days: 3
    columns:
      - name: spend_id
        tests:
          - unique
          - not_null
      - name: spend_amount
        tests:
          - not_null
      - name: campaign_id
        tests:
          - relationships:
              to: ref('stg_campaigns')
              field: campaign_id
