-- ============================================================
-- Silver Layer: Clean and standardize orders
-- - Cast types
-- - Remove duplicates
-- - Drop rows with invalid quantity or missing keys
-- ============================================================

DROP TABLE IF EXISTS silver_orders;

CREATE TABLE silver_orders AS
SELECT DISTINCT
    order_id,
    customer_id,
    product_id,
    CAST(order_date AS DATE)         AS order_date,
    CAST(quantity AS INTEGER)        AS quantity,
    CAST(unit_price AS DECIMAL(10,2)) AS unit_price
FROM bronze_orders
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND product_id IS NOT NULL
  AND quantity IS NOT NULL
  AND CAST(quantity AS INTEGER) > 0
  AND CAST(unit_price AS DECIMAL(10,2)) >= 0;

-- Sanity check: compare row counts before/after cleaning
SELECT
    (SELECT COUNT(*) FROM bronze_orders) AS bronze_row_count,
    (SELECT COUNT(*) FROM silver_orders) AS silver_row_count;
