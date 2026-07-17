# Retail Sales Data Warehouse

A SQL-based data warehouse built using Medallion Architecture (Bronze / Silver / Gold) to analyze retail sales data and answer real business questions.

## Problem Statement

A retail business has raw transactional data (orders, customers, products) scattered across CSV exports with no consistent structure. This project builds a data warehouse that cleans, models, and organizes that data into a query-ready analytical schema, then uses it to answer specific business questions about revenue, customer behavior, and product performance.

## Architecture

```
Raw CSVs → Bronze (staging) → Silver (cleaned) → Gold (star schema) → Reports
```

- **Bronze**: Raw data loaded as-is into staging tables. No transformation, just ingestion.
- **Silver**: Cleaned and standardized data — deduplicated, nulls handled, types fixed, validation rules applied.
- **Gold**: Business-ready star schema — one fact table, three dimension tables — optimized for analytical queries.

See `docs/architecture.md` for the full diagram and design decisions.

## Tech Stack

- SQL (PostgreSQL/MySQL syntax — adjust as needed)
- Python (optional, for orchestration/ingestion scripting)
- Power BI (optional, for dashboard layer)

## Project Structure

```
retail-sales-data-warehouse/
├── datasets/           raw source CSV files
├── scripts/
│   ├── bronze/         ingestion scripts (raw load)
│   ├── silver/         cleaning/transformation scripts
│   └── gold/           fact/dimension table creation
├── reports/             analytical SQL queries
├── docs/
│   └── architecture.md  diagram + design decisions
└── README.md
```

## How to Run

1. Place raw CSVs in `datasets/` (see `datasets/README.md` for expected columns).
2. Run scripts in order: `scripts/bronze/` → `scripts/silver/` → `scripts/gold/`.
3. Run queries in `reports/` against the Gold layer tables.

## Sample Business Questions Answered

- Top 10 products by revenue
- Monthly sales trend
- Customer segments by purchase frequency
- Revenue by region/category

## Status

🚧 In progress — building out bronze/silver/gold scripts and reports.
