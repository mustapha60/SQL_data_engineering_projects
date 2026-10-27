CREATE OR REPLACE TEMPORARY TABLE SOURCE_PRIORITY_JOBS AS
SELECT
    JPF.job_id,
    JPF.job_title_short,
    CD.name AS company_name,
    JPF.job_posted_date,
    JPF.salary_year_avg,
    R.priority_level,
    CURRENT_TIMESTAMP AS updated_at
    FROM data_jobs.job_postings_fact AS JPF
    left join data_jobs.company_dim AS CD
    ON JPF.company_id = CD.company_id
    JOIN staging.priority_roles AS R
    ON LOWER(TRIM(JPF.job_title_short)) = LOWER(TRIM(R.role_name));


--     -- UPDATE THE SNAPSHOT TABLE WITH NEW DATA
--     UPDATE main.priority_jobs_snapshot AS snapshot
--     SET priority_level = source.priority_level,
--         updated_at = source.updated_at
--     FROM SOURCE_PRIORITY_JOBS AS source
--     WHERE snapshot.job_id = source.job_id
--     and snapshot.priority_level is distinct from source.priority_level;

--     -- INSERT NEW RECORDS INTO THE SNAPSHOT TABLE
--         insert into main.priority_jobs_snapshot 
--         (job_id, job_title_short, 
--         company_name, 
--         job_posted_date, 
--         salary_year_avg, 
--         priority_level, 
--         updated_at)

--     SELECT source.job_id,
--     source.job_title_short,
--     source.company_name,
--     source.job_posted_date,
--     source.salary_year_avg,
--     source.priority_level,
--     source.updated_at
--     FROM SOURCE_PRIORITY_JOBS AS source
-- where not exists
--  (select 1 from main.priority_jobs_snapshot as snapshot 
--  where snapshot.job_id = source.job_id);

--  --DELETE RECORDS FROM THE SNAPSHOT TABLE THAT ARE NO LONGER IN THE SOURCE
-- DELETE FROM main.priority_jobs_snapshot AS snapshot
-- WHERE NOT EXISTS
-- (SELECT 1 FROM SOURCE_PRIORITY_JOBS AS source WHERE snapshot.job_id = source.job_id);

merge into main.priority_jobs_snapshot AS snapshot
using SOURCE_PRIORITY_JOBS AS source
on snapshot.job_id = source.job_id

when matched and snapshot.priority_level is distinct from source.priority_level then
    update set priority_level = source.priority_level,
               updated_at = source.updated_at
        when not matched then
        insert (job_id,
         job_title_short,
         company_name, 
         job_posted_date, 
         salary_year_avg,
          priority_level, 
          updated_at)
        values (source.job_id, 
        source.job_title_short, 
        source.company_name, 
        source.job_posted_date, 
        source.salary_year_avg, 
        source.priority_level, 
        source.updated_at)
        when not matched by source then delete;

   --Final check query to see the snapshot table after the update, insert, and delete data pipeline operations     
        select 
    job_title_short,
    count(*) as job_count,
    min(priority_level) as priority_level,
    min(updated_at) as updated_at,
    from main.priority_jobs_snapshot
    group by job_title_short
    order by job_count desc;

    