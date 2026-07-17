-- ============================================================
-- Bronze Layer: Load raw CSVs into staging tables
-- Adjust file paths and COPY/LOAD syntax to your database engine
-- (example below uses PostgreSQL COPY syntax)
-- ============================================================

COPY bronze_orders (order_id, customer_id, product_id, order_date, quantity, unit_price)
FROM '/absolute/path/to/datasets/orders.csv'
DELIMITER ','
CSV HEADER;

COPY bronze_customers (customer_id, customer_name, region, segment)
FROM '/absolute/path/to/datasets/customers.csv'
DELIMITER ','
CSV HEADER;

COPY bronze_products (product_id, product_name, category, subcategory)
FROM '/absolute/path/to/datasets/products.csv'
DELIMITER ','
CSV HEADER;

-- Quick sanity check after load
SELECT COUNT(*) AS order_count FROM bronze_orders;
SELECT COUNT(*) AS customer_count FROM bronze_customers;
SELECT COUNT(*) AS product_count FROM bronze_products;
