# Architecture

## Overview

This project follows the Medallion Architecture pattern: Bronze, Silver, and Gold layers, each with a distinct responsibility.

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Raw CSVs   │ --> │   Bronze    │ --> │   Silver    │ --> │    Gold     │
│  (source)   │     │  (staging)  │     │  (cleaned)  │     │(star schema)│
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
                                                                    │
                                                                    v
                                                          ┌─────────────────┐
                                                          │  Reports / BI   │
                                                          └─────────────────┘
```

## Layer Details

### Bronze — Raw Ingestion
- Purpose: land raw data exactly as received, no transformation.
- Tables: `bronze_orders`, `bronze_customers`, `bronze_products`
- Design decision: keeping raw data untouched means any downstream error can be traced back and the pipeline can be re-run from scratch without needing the original files again.

### Silver — Cleaned & Standardized
- Purpose: fix data quality issues before modeling.
- Steps applied:
  - Deduplicate records
  - Handle nulls (drop or impute depending on field)
  - Standardize date formats and text casing
  - Validate business rules (e.g., quantity > 0, valid customer_id)
- Tables: `silver_orders`, `silver_customers`, `silver_products`

### Gold — Star Schema
- Purpose: business-ready model optimized for analytical queries.
- **Fact table**: `fact_sales`
  - order_id, customer_key, product_key, date_key, quantity, unit_price, revenue
- **Dimension tables**:
  - `dim_customer` (customer_key, customer_id, name, region, segment)
  - `dim_product` (product_key, product_id, name, category, subcategory)
  - `dim_date` (date_key, date, day, month, quarter, year)
- Design decision: star schema (rather than snowflake) chosen for query simplicity — analytical tools and SQL reports run fewer joins, which matters more than storage normalization at this data volume.

## Why Medallion Architecture

This structure separates concerns cleanly:
- Bronze protects the raw source of truth.
- Silver isolates all data-quality logic in one place, so it's auditable.
- Gold is the only layer analysts and BI tools query directly, keeping the interface stable even if upstream cleaning logic changes.
