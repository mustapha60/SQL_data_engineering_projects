--Loading data from csv files to staging layer tables

select * from read_csv('C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\customers.csv', AUTO_DETECT = TRUE
) limit 10;

COPY staging.customers
FROM 'C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\customers.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Data quality check for customers table
SELECT *
FROM staging.customers
WHERE customer_id IS  NULL;

-- Data quality check for duplicates in customers table
SELECT customer_id, COUNT(*) as duplicate_count
FROM staging.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--order without customers
SELECT o.*
FROM staging.orders o
LEFT JOIN staging.customers c
       ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--loading data from csv files to staging.order_items layer tables

select * from read_csv('C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\order_items.csv', AUTO_DETECT = TRUE
) limit 10;

COPY staging.order_items
FROM 'C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\order_items.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');

--loading data from csv files to staging.orders layer tables
select * from read_csv('C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\orders.csv', AUTO_DETECT = TRUE
) limit 10;

COPY staging.orders
FROM 'C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\orders.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');

---loading data from csv files to staging.products layer tables

select * from read_csv('C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\products.csv', AUTO_DETECT = TRUE
) limit 10;

COPY staging.products
FROM 'C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\products.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');

---loading data from csv files to staging.payments layer tables

select * from read_csv('C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\payments.csv', AUTO_DETECT = TRUE
) limit 10;

COPY staging.payments
FROM 'C:\Users\musta\SQL_DATA_ENGINEERING_PROJECT\1.11 lesson\1.EDA\payments.csv'
(FORMAT CSV, HEADER TRUE, DELIMITER ',');






