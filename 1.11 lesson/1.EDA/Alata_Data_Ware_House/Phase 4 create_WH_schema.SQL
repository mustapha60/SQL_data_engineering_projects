--create schema and tables for Alata_dw data warehouse

CREATE SCHEMA Alata_dw;

CREATE TABLE Alata_dw.dim_customer (
    customer_id int PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE
);

CREATE TABLE Alata_dw.dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE Alata_dw.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    day INT
);

CREATE TABLE Alata_dw.fact_sales (
    sales_key BIGINT PRIMARY KEY,

    customer_key INT,
    product_key INT,
    date_key INT,

    order_id BIGINT,
    quantity INT,
    sales_amount NUMERIC(12,2)
);