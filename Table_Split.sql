INSERT INTO customers (customer_id, customer_name, segment)
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore_raw;

INSERT INTO orders (
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, country, city, state, postal_code, region,
    product_id, category, sub_category, product_name,
    sales, quantity, discount, profit
)
SELECT
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, country, city, state, postal_code, region,
    product_id, category, sub_category, product_name,
    sales, quantity, discount, profit
FROM superstore_raw;