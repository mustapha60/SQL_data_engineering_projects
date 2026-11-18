
--loading data from staging layer to dim_customer table in Alata_dw schema

INSERT INTO Alata_dw.dim_customer
(
    customer_id,
    customer_name,
    country,
    registration_date
)
SELECT
    customer_id,
     customer_name,
    country,
    registration_date
FROM staging.customers;

--loading data from staging layer to dim_product table in Alata_dw schema
INSERT INTO Alata_dw.dim_product
(
    product_id,
    product_name,
    category,
    unit_price
)
SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM staging.products;

---loading data from staging layer to dim_date table in Alata_dw schema
INSERT INTO Alata_dw.dim_date
    (date_key, full_date, year, month, day)
SELECT DISTINCT
    CAST(strftime(order_timestamp, '%Y%m%d') AS INTEGER),
    CAST(order_timestamp AS DATE),
    CAST(EXTRACT(YEAR FROM order_timestamp) AS INTEGER),
    CAST(EXTRACT(MONTH FROM order_timestamp) AS INTEGER),
    CAST(EXTRACT(DAY FROM order_timestamp) AS INTEGER)
FROM staging.orders
WHERE order_timestamp IS NOT NULL;


 ---loading data from staging layer to fact_sales table in Alata_dw schema

INSERT INTO Alata_dw.fact_sales
    (sales_key, customer_key, product_key, date_key,
     order_id, quantity, sales_amount)
SELECT
    COALESCE(
        (SELECT MAX(sales_key) FROM Alata_dw.fact_sales), 0
    ) + ROW_NUMBER() OVER (ORDER BY o.order_id, oi.order_item_id),
    dc.customer_id,
    dp.product_id,
    dd.date_key,
    o.order_id,
    oi.quantity,
    oi.quantity * oi.unit_price
FROM staging.orders o
JOIN staging.order_items oi
    ON o.order_id = oi.order_id
JOIN Alata_dw.dim_customer dc
    ON o.customer_id = dc.customer_id
JOIN Alata_dw.dim_product dp
    ON oi.product_id = dp.product_id
JOIN Alata_dw.dim_date dd
    ON dd.full_date = CAST(o.order_timestamp AS DATE);
