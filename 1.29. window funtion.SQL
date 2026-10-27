--order by window function 
SELECT 
job_title_short,
salary_hour_avg, 
Rank() over(
    order by salary_hour_avg DESC
) as avg_salary
from job_postings_fact
where salary_hour_avg is not null
order by salary_hour_avg DESC
limit 10;

select
avg(salary_hour_avg)
from job_postings_fact;


--order by and partition by window function 
SELECT 
job_posted_date,
job_title_short,
round(salary_hour_avg), 
AVG(salary_hour_avg) over( partition by job_title_short 
    order by job_posted_date DESC
) as running_avg_salary
from job_postings_fact
where salary_hour_avg is not null AND job_title_short =  ('Data Engineer')
order by job_title_short,
 job_posted_date DESC
limit 10;

SELECT
job_id, 
job_title_short,
salary_hour_avg, 
Rank() over(partition by job_title_short
    order by salary_hour_avg DESC
) as rank_hourly_salary
from job_postings_fact
where salary_hour_avg is not null
order by
salary_hour_avg DESC,
job_title_short
 
limit 10;

SELECT 
job_posted_date,
job_title_short,
round(salary_hour_avg), 
MIN(salary_hour_avg) over( partition by job_title_short 
    order by job_posted_date DESC
) as running_avg_salary
from job_postings_fact
where salary_hour_avg is not null AND job_title_short =  ('Data Engineer')
order by job_title_short,
 job_posted_date DESC
limit 40;

SELECT 
job_title_short,
salary_hour_avg, 
ROW_NUMBER() over(
    order by salary_hour_avg DESC
) as avg_salary desc
from job_postings_fact
where salary_hour_avg is not null
order by salary_hour_avg DESC
limit 140;

--LAG FUNTION
SELECT
job_id,
company_id,
job_posted_date,
job_title,
job_title_short,
salary_year_avg,
lag(salary_year_avg) over(partition by company_id order by job_posted_date) 
as previous_salary,
salary_year_avg - lag(salary_year_avg) over(partition by company_id order by job_posted_date) 
as salary_change

from job_postings_fact
where salary_year_avg is not null
order by company_id,
job_posted_date
limit 60;

--LEAD FUNTION
SELECT
job_id,
company_id,
job_posted_date,
job_title,
job_title_short,
salary_year_avg,
lEAD(salary_year_avg) over(partition by company_id order by job_posted_date) 
as NEXT_salary,
salary_year_avg - LEAD(salary_year_avg) over(partition by company_id order by job_posted_date) 
as salary_change

from job_postings_fact
where salary_year_avg is not null
order by company_id,
job_posted_date
limit 60;


SELECT
user_id,
event.page,
event.time
from website_click,
UNNEST(event) as events;
 SELECT 
 customer_ID,
 order
 from customer,
 UNNEST(order) as order;

 SELECT
 customer_id,
 orders.order_id,
 order.product_id
 from customers,
 UNNEST(ORDERS)as order;