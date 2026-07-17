-- ============================================================
-- Analytical Reports: real business questions against
-- the Gold layer star schema (Superstore dataset)
-- ============================================================

-- 1. Top 10 products by revenue
SELECT
    p.product_name,
    p.category,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Monthly sales trend
SELECT
    d.year,
    d.month,
    SUM(f.revenue) AS monthly_revenue,
    COUNT(DISTINCT f.order_id) AS order_count
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 3. Customer segments by purchase frequency
SELECT
    c.segment,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(DISTINCT f.customer_key) AS unique_customers,
    ROUND(COUNT(DISTINCT f.order_id)::DECIMAL / COUNT(DISTINCT f.customer_key), 2) AS avg_orders_per_customer
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.segment
ORDER BY total_orders DESC;

-- 4. Revenue and profit by region and category
SELECT
    c.region,
    p.category,
    SUM(f.revenue) AS total_revenue,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY c.region, p.category
ORDER BY c.region, total_revenue DESC;

-- 5. Top 5 customers by lifetime revenue
SELECT
    c.customer_name,
    c.segment,
    SUM(f.revenue) AS lifetime_revenue,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_name, c.segment
ORDER BY lifetime_revenue DESC
LIMIT 5;

-- 6. Products with negative profit (loss-making items)
SELECT
    p.product_name,
    p.category,
    SUM(f.revenue) AS total_revenue,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
HAVING SUM(f.profit) < 0
ORDER BY total_profit ASC
LIMIT 10;
