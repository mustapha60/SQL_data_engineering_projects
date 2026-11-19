-- step 1 -- create star schema table
CREATE TABLE company_dim (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(255)
);
CREATE TABLE skills_dim (
    skill_id INT PRIMARY KEY,
    skills VARCHAR(255),
    type VARCHAR(255)
);

CREATE TABLE JOB_POSTINGS_FACT (
    job_id INT PRIMARY KEY,
    company_id INT ,
    job_title_short VARCHAR(255),
    job_title_ VARCHAR(255),
    job_location VARCHAR(255),
    job_via VARCHAR(255),
    job_schedule_type VARCHAR(255),
    job_work_from_home BOOLEAN,
    search_location VARCHAR(255),
    job_posted_date timestamp,
    job_no_degree_mentions BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country VARCHAR(255),
    salary_rate VARCHAR(255),
    salary_year_avg double,
    salary_hour_avg double,
    FOREIGN KEY (company_id) REFERENCES company_dim(company_id) 
);

CREATE TABLE skills_job_dim (
    job_id INT,
    skill_id INT,
    primary key (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES JOB_POSTINGS_FACT(job_id),
    FOREIGN KEY (skill_id) REFERENCES skills_dim(skill_id)
);

show tables
from information_schema.tables
where table_schema = 'main';

show databases;