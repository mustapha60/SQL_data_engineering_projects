-- Array final example
CREATE OR REPLACE TEMPORARY TABLE job_skills_array as 
SELECT
JPF.job_id,
JPF.job_title_short,
JPF.salary_year_avg,
ARRAY_AGG(SD.skills) AS skills_array


FROM job_postings_fact AS JPF
LEFT JOIN skills_job_dim AS sjd
ON JPF.job_id = SJD.job_id
LEFT JOIN skills_dim AS SD
ON SJD.skill_id = SD.skill_id
GROUP BY
JPF.job_id,
JPF.job_title_short,
JPF.salary_year_avg
LIMIT 10;

WITH flat_skills as (
SELECT 
job_id,
job_title_short,
salary_year_avg,
UNNEST(SKILLS_ARRAY) AS SKILLS
FROM 
JOB_SKILLS_ARRAY limit 50
)
    SELECT
    SKILLS,
    MEDIAN(salary_year_avg) as median_salary

    from flat_skills
    group by skills
    order by median_salary DESC;

-- Array of structs

 CREATE OR REPLACE TEMPORARY TABLE job_skills_struct as 
SELECT
JPF.job_id,
JPF.job_title_short,
JPF.salary_year_avg,
ARRAY_AGG( 
        STRUCT_PACK(
            skill_type := SD.type,
            skill_name := SD.skills
 ) 
)AS skills_type 


FROM job_postings_fact AS JPF
LEFT JOIN skills_job_dim AS sjd
ON JPF.job_id = SJD.job_id
LEFT JOIN skills_dim AS SD
ON SJD.skill_id = SD.skill_id
GROUP BY
JPF.job_id,
JPF.job_title_short,
JPF.salary_year_avg
LIMIT 10;

SELECT 
job_id,
job_title_short,
salary_year_avg,
UNNEST(SKILLS_TYPE).skill_type AS SKILLS,
UNNEST(SKILLS_TYPE).skill_name AS SKILLS
FROM 
JOB_SKILLS_STRUCT;

SELECT * FROM JOB_SKILLS_STRUCT;

-- from the perspective of data analyst find the median salary 
WITH flat_skills as (
SELECT 
job_id,
job_title_short,
salary_year_avg,
UNNEST(SKILLS_TYPE).skill_type AS skill_type,
UNNEST(SKILLS_TYPE).skill_name AS skill_name
FROM 
JOB_SKILLS_STRUCT
)
    
SELECT
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
when median_salary is not null
GROUP BY skill_type;
