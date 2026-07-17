-- ============================================================
-- Gold Layer: fact_sales
-- Joins silver orders to dimension keys.
-- Uses the dataset's own Sales/Profit fields directly since they
-- are already provided per line item.
-- ============================================================

DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT
    o.row_id,
    o.order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    o.ship_mode,
    o.quantity,
    o.discount,
    o.sales    AS revenue,
    o.profit
FROM silver_orders o
JOIN dim_customer c ON o.customer_id = c.customer_id
JOIN dim_product  p ON o.product_id  = p.product_id
JOIN dim_date     d ON o.order_date  = d.date;

-- Sanity check
SELECT COUNT(*) AS fact_row_count FROM fact_sales;
SELECT SUM(revenue) AS total_revenue, SUM(profit) AS total_profit FROM fact_sales;
