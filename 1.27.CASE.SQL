--buget salaries
--less than 25 'low'
--less than 50 'medium'
--greater than 50 'high'

SELECT 
    job_id,
    salary_hour_avg,
    CASE 
    WHEN salary_hour_avg IS NULL THEN 'MISSING'
        
        WHEN salary_hour_avg < 25 THEN 'low'
        WHEN salary_hour_avg < 50 THEN 'medium'
        ELSE 'high'
    END AS salary_budget
    FROM data_jobs.job_postings_fact
    LIMIT 10;

    --Categorising categirical data using CASE statement
    SELECT 
    job_title,
    CASE WHEN job_title like '%Data%'  AND job_title like '%Analyst%' THEN 'Data Analyst'
    WHEN job_title like '%Data%' AND job_title like '%Engineer%' THEN 'Data Engineer'
    WHEN job_title like '%Software%' AND job_title like '%Engineer%' THEN 'Software Engineer'
    ELSE 'Other'
    END AS job_category
    from data_jobs.job_postings_fact
    ORDER BY RANDOM() 
    LIMIT 20;

--conditional aggregation using CASE statement
--calculate the average salary for each job category
-- WHEN salary year avg is less than 100k
-- WHEN salary year avg is greater than 100k 
SELECT
job_title_short,
count(*) AS job_count,
MEDIAN
(CASE WHEN salary_year_avg < 100000 THEN salary_year_avg END)AS median_low_salary,
MEDIAN
(CASE WHEN salary_year_avg >= 100000 THEN salary_year_avg END)AS median_high_salary

FROM data_jobs.job_postings_fact
WHERE salary_year_avg IS NOT NULL or salary_hour_avg IS NOT NULL
GROUP BY job_title_short
LIMIT 20;


with salaries as (
    
select 
job_title_short,
salary_year_avg,
salary_hour_avg,

CASE 
    WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
    WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
    end as standardized_salary

) from job_postings_fact
    
    SELECT *,
     CASE
     WHEN standardized_salary IS  NULL THEN 'MISSING'
        WHEN standardized_salary < 75000 THEN 'low'
        WHEN standardized_salary >150000 THEN 'medium'
        else 'high'
        END AS salary_budget

        FROM salaries
        
        LIMIT 10;