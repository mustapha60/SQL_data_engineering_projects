SELECT UNNEST([1,1,1,3])
EXCEPT
SELECT UNNEST([1,1,2]);

CREATE TEMP TABLE jobs_2023 AS
SELECT * 
EXCLUDE(JOB_id,job_posted_date)
from job_postings_fact
WHERE EXTRACT(year from job_posted_date) = 2023;

select* from jobs_2024;

CREATE TEMP TABLE jobs_2024 AS
SELECT * 
EXCLUDE(JOB_id,job_posted_date)
from job_postings_fact
WHERE EXTRACT(year from job_posted_date) = 2024;

-- which unique jobs appear in both 2023 and 2024
select 
'job_2023' AS table_name,
count(*)
from jobs_2023
union
select
'job_2024' AS table_name,
count(*)
from jobs_2024;

-- what job postings apprear accross both years counting dupliacte.
SELECT * FROM JOBS_2023

UNION ALL

 SELECT* FROM  JOBS_2024;

 -- Which jobs postings apprear in 2023 but not in 2024.

 SELECT * FROM JOBS_2023

EXCEPT


 SELECT* FROM  JOBS_2024;

 -- Which job posting remain after subtracting matching 2024 postings one for one.

 SELECT * FROM JOBS_2023
 
EXCEPT ALL


 SELECT* FROM  JOBS_2024;

 -- Which jobs posting appear in both 202 and 2024.
 SELECT * FROM JOBS_2023
 
INTERSECT


 SELECT* FROM  JOBS_2024;

 --Which jobs posting appear in both 2023 and 2024 preserving dupliacte.

SELECT * FROM JOBS_2023
 
INTERSECT ALL


 SELECT* FROM  JOBS_2024;
 


