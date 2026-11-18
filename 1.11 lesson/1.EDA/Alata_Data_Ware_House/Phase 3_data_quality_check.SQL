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
