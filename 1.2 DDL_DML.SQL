--.read1.2 DDL_DML.SQL

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

SELECT *
from information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

--DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT * FROM
information_schema.tables
WHERE table_catalog = 'jobs_mart';

INSERT INTO staging.preferred_roles(role_id,role_name)
VALUES (1,'Data engineer'),
(2,'Senior data engineer'),
(3,'Software engineer');

 SELECT * from staging.preferred_roles;

 AlTER TABLE staging.preferred_roles
 ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = True
WHERE role_id = 1 or role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = false
WHERE role_id = 3;

AlTER table staging.preferred_roles
RENAME to priority_roles;

AlTER table staging.priority_roles
RENAME column preferred_role to priority_level;

AlTER table staging.priority_roles
AlTER COLUMN priority_level TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_level = 3
where role_id = 3;

SELECT * from staging.priority_roles;
