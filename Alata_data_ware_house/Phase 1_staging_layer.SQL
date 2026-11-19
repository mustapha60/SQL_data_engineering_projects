CREATE database
Ecommerce_DW;

CREATE SCHEMA Staging;

CREATE TABLE staging.customers (
    customer_id INT,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    registration_date DATE
);

CREATE TABLE staging.products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price NUMERIC(10,2)
);

CREATE TABLE staging.orders (
    order_id BIGINT,
    customer_id INT,
    order_timestamp TIMESTAMP
);

CREATE TABLE staging.order_items (
    order_item_id BIGINT,
    order_id BIGINT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE staging.payments (
    payment_id BIGINT,
    order_id BIGINT,
    payment_method VARCHAR(50),
    payment_amount NUMERIC(10,2),
    payment_status VARCHAR(50)
);

