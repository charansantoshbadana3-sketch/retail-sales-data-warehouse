-- ============================================================
-- Silver Layer: Clean and standardize customers and products
-- ============================================================

DROP TABLE IF EXISTS silver_customers;

CREATE TABLE silver_customers AS
SELECT DISTINCT
    customer_id,
    TRIM(customer_name)               AS customer_name,
    INITCAP(TRIM(region))             AS region,
    INITCAP(TRIM(segment))            AS segment
FROM bronze_customers
WHERE customer_id IS NOT NULL
  AND customer_name IS NOT NULL;

DROP TABLE IF EXISTS silver_products;

CREATE TABLE silver_products AS
SELECT DISTINCT
    product_id,
    TRIM(product_name)   AS product_name,
    INITCAP(TRIM(category))    AS category,
    INITCAP(TRIM(subcategory)) AS subcategory
FROM bronze_products
WHERE product_id IS NOT NULL
  AND product_name IS NOT NULL;

-- Sanity checks
SELECT
    (SELECT COUNT(*) FROM bronze_customers) AS bronze_customer_count,
    (SELECT COUNT(*) FROM silver_customers) AS silver_customer_count;

SELECT
    (SELECT COUNT(*) FROM bronze_products) AS bronze_product_count,
    (SELECT COUNT(*) FROM silver_products) AS silver_product_count;
