# Datasets

Place raw source CSV files here. This project expects three files:

## orders.csv
| Column | Type | Notes |
|---|---|---|
| order_id | string | unique order identifier |
| customer_id | string | FK to customers.csv |
| product_id | string | FK to products.csv |
| order_date | date | format: YYYY-MM-DD |
| quantity | integer | units sold |
| unit_price | decimal | price per unit |

## customers.csv
| Column | Type | Notes |
|---|---|---|
| customer_id | string | unique customer identifier |
| customer_name | string | |
| region | string | e.g., North, South, East, West |
| segment | string | e.g., Consumer, Corporate, Home Office |

## products.csv
| Column | Type | Notes |
|---|---|---|
| product_id | string | unique product identifier |
| product_name | string | |
| category | string | |
| subcategory | string | |

## Suggested source

Any public retail/e-commerce dataset with similar fields works — for example, Kaggle's "Superstore Sales Dataset" or "Online Retail Dataset." Rename columns to match the schema above, or adjust the bronze ingestion scripts to match the actual column names.
