--.read 1.2 DDL_DML_P1.SQL;
CREATE table staging.job_postings_flat as
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,

    cd.company_id AS cd_company_id,
    cd.name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;

    SELECT count(*) from staging.job_postings_flat limit 10;



    show tables from staging;
    SELECT * from staging.priority_roles;
    SELECT * from staging.job_postings_flat limit 10;
    SELECT * from staging.Preferred_roles;
    SELECT COUNT(*)from staging.priority_jobs_flat_view ;

CREATE  VIEW or replace staging.priority_jobs_flat_view AS
    SELECT DISTINCT jpf.*
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS r
  ON LOWER(TRIM(jpf.job_title_short)) = LOWER(TRIM(r.role_name))
WHERE r.priority_level = 1;

SELECT job_title_short, COUNT(*) AS job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;



CREATE TEMPORARY TABLE senior_jobs_flat_temp AS
SELECT *
FROM staging.priority_jobs_flat_view
WHERE LOWER(TRIM(job_title_short)) = 'senior data engineer';

SELECT * FROM staging.priority_jobs_flat_view
WHERE LOWER(TRIM(job_title_short)) = 'data engineer';

SELECT job_title_short, COUNT(*) AS job_count
FROM Senior_jobs_flat_temp
GROUP BY job_title_short
ORDER BY job_count DESC;

DELETE FROM staging.JOB_POSTINGS_FLAT
WHERE job_POSTED_DATE < '2024-01-01';



TRUNCATE TABLE staging.JOB_POSTINGS_FLAT;

INSERT INTO staging.JOB_POSTINGS_FLAT 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,

    cd.company_id AS cd_company_id,
    cd.name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
    WHERE jpf.job_posted_date >=  '2024-01-01';

    SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;
