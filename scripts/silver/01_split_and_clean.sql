-- ============================================================
-- Silver Layer: Clean and normalize the raw Superstore data
-- Splits the single denormalized source into three clean tables.
-- ============================================================

-- ---- Customers ----
DROP TABLE IF EXISTS silver_customers;

CREATE TABLE silver_customers AS
SELECT DISTINCT
    customer_id,
    TRIM(customer_name) AS customer_name,
    INITCAP(TRIM(segment)) AS segment,
    INITCAP(TRIM(region)) AS region,
    INITCAP(TRIM(state)) AS state,
    INITCAP(TRIM(city)) AS city
FROM bronze_superstore_raw
WHERE customer_id IS NOT NULL;

-- ---- Products ----
DROP TABLE IF EXISTS silver_products;

CREATE TABLE silver_products AS
SELECT DISTINCT
    product_id,
    TRIM(product_name) AS product_name,
    INITCAP(TRIM(category)) AS category,
    INITCAP(TRIM(sub_category)) AS sub_category
FROM bronze_superstore_raw
WHERE product_id IS NOT NULL;

-- ---- Orders (fact-level, still needs type casting) ----
DROP TABLE IF EXISTS silver_orders;

CREATE TABLE silver_orders AS
SELECT DISTINCT
    row_id,
    order_id,
    customer_id,
    product_id,
    TO_DATE(order_date, 'MM/DD/YYYY') AS order_date,
    TO_DATE(ship_date, 'MM/DD/YYYY')  AS ship_date,
    ship_mode,
    CAST(sales AS DECIMAL(10,2))     AS sales,
    CAST(quantity AS INTEGER)        AS quantity,
    CAST(discount AS DECIMAL(5,2))   AS discount,
    CAST(profit AS DECIMAL(10,4))    AS profit
FROM bronze_superstore_raw
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND product_id IS NOT NULL
  AND quantity IS NOT NULL
  AND CAST(quantity AS INTEGER) > 0;

-- Sanity checks
SELECT
    (SELECT COUNT(*) FROM bronze_superstore_raw) AS bronze_row_count,
    (SELECT COUNT(*) FROM silver_orders) AS silver_order_count,
    (SELECT COUNT(*) FROM silver_customers) AS silver_customer_count,
    (SELECT COUNT(*) FROM silver_products) AS silver_product_count;
