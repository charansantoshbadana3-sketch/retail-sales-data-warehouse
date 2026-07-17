# Retail Sales Data Warehouse

A SQL-based data warehouse built using Medallion Architecture (Bronze / Silver / Gold) to analyze retail sales data and answer real business questions.

## Dataset

This project uses the [Superstore Sales Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final) (Kaggle) — ~9,994 order line items from a US retail superstore, including customer, product, region, and profit/loss data.

## Problem Statement

The raw source is a single flat, denormalized file with customer, product, and order details all mixed into one table. This project normalizes it into a proper star schema so business questions about revenue, profit, and customer behavior can be answered with simple, fast SQL queries instead of repeatedly parsing a flat file.

## Architecture

```
Raw CSV → Bronze (staging) → Silver (cleaned + split) → Gold (star schema) → Reports
```

- **Bronze**: Raw CSV loaded as-is into a single staging table (`bronze_superstore_raw`), no transformation.
- **Silver**: Split into three clean tables — `silver_orders`, `silver_customers`, `silver_products` — with proper types, deduplication, and standardized text casing.
- **Gold**: Business-ready star schema — `fact_sales` plus `dim_customer`, `dim_product`, `dim_date` — optimized for analytical queries.

See `docs/architecture.md` for the full diagram and design decisions.

## Tech Stack

- PostgreSQL (via Supabase free tier)
- SQL only — no external orchestration tools, to keep the pipeline auditable end-to-end

## Project Structure

```
retail-sales-data-warehouse/
├── datasets/
│   └── superstore.csv    raw source data
├── scripts/
│   ├── bronze/           staging table + load
│   ├── silver/           cleaning + normalization into 3 tables
│   └── gold/             dimension + fact table creation
├── reports/               analytical SQL queries
├── docs/
│   └── architecture.md    diagram + design decisions
└── README.md
```

## How to Run

1. Create a free Postgres database (e.g., via [Supabase](https://supabase.com)).
2. Run `scripts/bronze/01_create_bronze_tables.sql` to create the staging table.
3. Load `datasets/superstore.csv` into `bronze_superstore_raw` (Supabase Table Editor → Import CSV, or `COPY` if using psql directly).
4. Run `scripts/silver/01_split_and_clean.sql` to clean and split the data.
5. Run `scripts/gold/01_create_dimensions.sql` then `scripts/gold/02_create_fact_sales.sql` to build the star schema.
6. Run queries in `reports/business_questions.sql` against the Gold layer.

## Sample Business Questions Answered

- Top 10 products by revenue
- Monthly sales trend
- Customer segments by purchase frequency
- Revenue and profit by region and category
- Top 5 customers by lifetime revenue
- Products that are losing money (negative profit)

## Status

✅ Data loaded and pipeline running against the Superstore dataset.
