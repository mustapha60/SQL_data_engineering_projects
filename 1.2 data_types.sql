select 
table_name,
column_name,
data_type
from information_schema.columns
where table_name = "job_postings_fact";


describe
select
job_title_short,
salary_year_avg
from job_postings_fact;
select 
cast(job_id as varchar) || '-' cast(company_id as varchar),
cast(job_work_from_home AS INT) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as decimal (10, 0)) as salary_year_avg
from job_postings_fact
where salary_year_avg is not null
limit 10;

select 
job_id::varchar || '-' || company_id::varchar,
job_work_from_home::INT as job_work_from_home,
job_posted_date::date as job_posted_date,
salary_year_avg::decimal (10, 0) as salary_year_avg
from job_postings_fact
where salary_year_avg is not null
limit 10;

select 3 + 5.5 ::INT;
