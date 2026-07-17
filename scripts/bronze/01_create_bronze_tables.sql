-- ============================================================
-- Bronze Layer: Raw staging table
-- Loads the Superstore CSV exactly as-is, one row per source row.
-- Source: Kaggle Superstore Sales Dataset
-- ============================================================

DROP TABLE IF EXISTS bronze_superstore_raw;

CREATE TABLE bronze_superstore_raw (
    row_id        INTEGER,
    order_id      VARCHAR(50),
    order_date    VARCHAR(20),   -- kept as text at bronze; parsed in silver
    ship_date     VARCHAR(20),
    ship_mode     VARCHAR(50),
    customer_id   VARCHAR(50),
    customer_name VARCHAR(200),
    segment       VARCHAR(50),
    country       VARCHAR(100),
    city          VARCHAR(100),
    state         VARCHAR(100),
    postal_code   VARCHAR(20),
    region        VARCHAR(50),
    product_id    VARCHAR(50),
    category      VARCHAR(100),
    sub_category  VARCHAR(100),
    product_name  VARCHAR(300),
    sales         VARCHAR(20),
    quantity      VARCHAR(20),
    discount      VARCHAR(20),
    profit        VARCHAR(20)
);
