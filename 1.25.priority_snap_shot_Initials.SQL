CREATE OR REPLACE TABLE main.priority_jobs_snapshot (
    job_id INT PRIMARY KEY,
    job_title_short VARCHAR,
    company_name VARCHAR,
    job_posted_date DATE,
    salary_year_avg DOUBLE,
    priority_level INT,
    updated_at TIMESTAMP
);

INSERT INTO main.priority_jobs_snapshot (
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_level,
    updated_at
)
SELECT
    JPF.job_id,
    JPF.job_title_short,
    CD.name AS company_name,
    JPF.job_posted_date,
    JPF.salary_year_avg,
    R.priority_level,
    CURRENT_TIMESTAMP AS updated_at
FROM data_jobs.job_postings_fact AS JPF
LEFT JOIN data_jobs.company_dim AS CD
    ON JPF.company_id = CD.company_id
JOIN staging.priority_roles AS R
    ON LOWER(TRIM(JPF.job_title_short)) = LOWER(TRIM(R.role_name));

SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_level) AS min_priority_level,
    MAX(updated_at) AS last_updated_at
FROM main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;