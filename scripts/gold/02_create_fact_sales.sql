-- ============================================================
-- Gold Layer: fact_sales
-- Joins silver orders to dimension keys, adds calculated revenue
-- ============================================================

DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT
    o.order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    o.quantity,
    o.unit_price,
    (o.quantity * o.unit_price) AS revenue
FROM silver_orders o
JOIN dim_customer c ON o.customer_id = c.customer_id
JOIN dim_product  p ON o.product_id  = p.product_id
JOIN dim_date     d ON o.order_date  = d.date;

-- Sanity check
SELECT COUNT(*) AS fact_row_count FROM fact_sales;
SELECT SUM(revenue) AS total_revenue FROM fact_sales;
