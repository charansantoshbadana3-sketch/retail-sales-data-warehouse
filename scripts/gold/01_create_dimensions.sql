-- ============================================================
-- Gold Layer: Dimension tables (star schema)
-- ============================================================

DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    customer_name,
    segment,
    region,
    state,
    city
FROM silver_customers;

DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
    product_id,
    product_name,
    category,
    sub_category
FROM silver_products;

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date AS
SELECT
    ROW_NUMBER() OVER (ORDER BY order_date) AS date_key,
    order_date                              AS date,
    EXTRACT(DAY FROM order_date)            AS day,
    EXTRACT(MONTH FROM order_date)          AS month,
    EXTRACT(QUARTER FROM order_date)        AS quarter,
    EXTRACT(YEAR FROM order_date)           AS year
FROM (SELECT DISTINCT order_date FROM silver_orders) AS distinct_dates;
