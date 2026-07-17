-- ============================================================
-- Bronze Layer: Raw staging tables
-- Purpose: land source data exactly as received, no transformation
-- ============================================================

DROP TABLE IF EXISTS bronze_orders;
CREATE TABLE bronze_orders (
    order_id     VARCHAR(50),
    customer_id  VARCHAR(50),
    product_id   VARCHAR(50),
    order_date   VARCHAR(20),   -- kept as text at bronze; parsed properly in silver
    quantity     VARCHAR(20),
    unit_price   VARCHAR(20)
);

DROP TABLE IF EXISTS bronze_customers;
CREATE TABLE bronze_customers (
    customer_id   VARCHAR(50),
    customer_name VARCHAR(200),
    region        VARCHAR(100),
    segment       VARCHAR(100)
);

DROP TABLE IF EXISTS bronze_products;
CREATE TABLE bronze_products (
    product_id   VARCHAR(50),
    product_name VARCHAR(200),
    category     VARCHAR(100),
    subcategory  VARCHAR(100)
);
