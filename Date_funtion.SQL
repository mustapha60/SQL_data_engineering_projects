SELECT job_posted_date,
job_posted_date ::DATE AS date,
job_posted_date ::TIME AS time,
job_posted_date ::TIMESTAMP AS timestamp,
job_posted_date ::TIMESTAMPTZ AS timestamptz
FROM job_postings_fact;

SELECT 
DATE_TRUNC('month', job_posted_date) ::DATE AS job_posted_month,
count(job_id) AS job_count 

FROM job_postings_fact
where job_title_short = 'Data Engineer' AND 
DATE_TRUNC('year', job_posted_date) = '2023-01-01'
--EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY

  job_posted_month
  order by

    job_posted_month;

    SELECT
    job_posted_date,
    DATE_TRUNC('month', job_posted_date)::DATE AS job_posted_month
    FROM job_postings_fact
    limit 10;


    SELECT
    
    '26-01-01 00:00:00+00':: TIMESTAMPTZ AT TIME ZONE 'EST';
    
    SELECT
    job_title_short,
    job_location,
    job_posted_date at time zone 'UTC'at time zone 'EST'
    from job_postings_fact
    where job_location ILIKE 'NEW YORK, NY';

    SELECT
    COUNT(JOB_ID),
    EXTRACT(HOUR FROM job_posted_date at time zone 'UTC'at time zone 'EST') AS job_posted_hour
    from job_postings_fact
    where job_location like 'new york, NY'
    GROUP BY job_posted_hour
    order by job_posted_hour  ;

  
SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS job_posted_hour
FROM job_postings_fact
WHERE job_location ILIKE '%New York%'
GROUP BY job_posted_hour
ORDER BY job_posted_hour;