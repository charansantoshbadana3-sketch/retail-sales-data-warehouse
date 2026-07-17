-- ============================================================
-- Bronze Layer: Load the raw CSV into the staging table
--
-- In Supabase: use the Table Editor's "Insert" -> "Import data from CSV"
-- feature on bronze_superstore_raw, OR run this COPY command if you
-- have direct psql access.
-- ============================================================

-- Option A: psql / direct Postgres access
-- COPY bronze_superstore_raw (row_id, order_id, order_date, ship_date, ship_mode,
--     customer_id, customer_name, segment, country, city, state, postal_code,
--     region, product_id, category, sub_category, product_name, sales,
--     quantity, discount, profit)
-- FROM '/absolute/path/to/datasets/superstore.csv'
-- DELIMITER ','
-- CSV HEADER;

-- Option B (recommended for Supabase free tier):
-- Use the Supabase dashboard: Table Editor -> bronze_superstore_raw ->
-- Insert -> Import data from CSV -> upload superstore.csv directly.
-- Supabase handles the column mapping automatically since the CSV
-- headers are close to the column names above.

-- Sanity check after load
SELECT COUNT(*) AS row_count FROM bronze_superstore_raw;
SELECT * FROM bronze_superstore_raw LIMIT 5;
