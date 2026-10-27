--subquery
SELECT * FROM (
    SELECT * FROM data_jobs.job_postings_fact
) AS j where salary_year_avg is not null
or salary_hour_avg is not null
LIMIT 10;

--CTE
with valid_salaries as (
    SELECT * FROM data_jobs.job_postings_fact
    WHERE salary_year_avg is not null
    or salary_hour_avg is not null
)SELECT * FROM valid_salaries;

-- select each job title and the median salary for that job title, along with the overall market median salary
SELECT 
JOB_TITLE_SHORT, 
salary_year_avg,

(SELECT MEDIAN(salary_year_avg)
FROM job_postings_fact) AS MARKET_MEDIAN_SALARY
FROM job_postings_fact 
where salary_year_avg is not null
or salary_hour_avg is not null
LIMIT 10;

-- select each job title and the median salary for that job title, 
--along with the overall market median salary for remote jobs

SELECT 
JOB_TITLE_SHORT, 
MEDIAN(salary_year_avg),

(SELECT MEDIAN(salary_year_avg)
FROM job_postings_fact
WHERE JOB_WORK_FROM_HOME = 'TRUE')
AS MARKET_REMOTE_MEDIAN_SALARY

FROM 
(SELECT
 JOB_TITLE_SHORT, salary_year_avg
 FROM job_postings_fact WHERE JOB_WORK_FROM_HOME = 'TRUE' )AS clean_jobs
where salary_year_avg is not null
GROUP BY JOB_TITLE_SHORT
LIMIT 10;

-- select each job title and the median salary for that job title, 
--along with the overall market median salary for remote jobs,
--but only include job titles where the median salary is greater than the overall market median salary for remote jobs

SELECT 
JOB_TITLE_SHORT, 
MEDIAN(salary_year_avg),

(SELECT MEDIAN(salary_year_avg)
FROM job_postings_fact
WHERE JOB_WORK_FROM_HOME = 'TRUE')
AS MARKET_REMOTE_MEDIAN_SALARY

FROM 
(SELECT
 JOB_TITLE_SHORT, salary_year_avg
 FROM job_postings_fact WHERE JOB_WORK_FROM_HOME = 'TRUE' )AS clean_jobs
where salary_year_avg is not null
GROUP BY JOB_TITLE_SHORT
HAVING MEDIAN(salary_year_avg) > (SELECT MEDIAN(salary_year_avg)
FROM job_postings_fact
WHERE JOB_WORK_FROM_HOME = 'TRUE')
LIMIT 10;

--CTES example
WITH TITLE_median AS (
    SELECT
    job_title_short,
    job_work_from_home,
    MEDIAN(salary_year_avg):: INTEGER AS median_salary
    FROM job_postings_fact
    WHERE JOB_COUNTRY = 'United States'
    GROUP BY job_title_short,job_work_from_home)

    SELECT 
    R.JOB_TITLE_SHORT,
    R.median_salary as remote_median_salary,
    O.median_salary AS onsite_median_salary,
    R.median_salary - O.median_salary AS salary_premium
FROM TITLE_median AS R
INNER JOIN TITLE_median AS O 
ON R.job_work_from_home = O.job_work_from_home
WHERE R.job_work_from_home = 'TRUE'
OR O.job_work_from_home = 'FALSE'
ORDER BY salary_premium DESC;

SELECT *
from RANGE (3) AS SOURCE (KEY);

SELECT *
from RANGE (2) AS TARGET (KEY);

SELECT *
from RANGE (3) AS SOURCE (KEY)
where not exists (SELECT * from RANGE (2) AS TARGET (KEY) where SOURCE.KEY = TARGET.KEY);

SELECT * FROM job_postings_fact
order by job_id limit 40;

SELECT * FROM SKILLS_JOB_DIM
ORDER BY JOB_ID LIMIT 40;

SELECT * FROM job_postings_fact AS target
WHERE NOT EXISTS
 (SELECT * FROM SKILLS_JOB_DIM as source 
 WHERE target.job_id = source.job_id)
order by job_id;
