-- create a new role that will be used for application SELECT queries only.
CREATE ROLE chichinabo NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
CREATE ROLE chibo LOGIN ENCRYPTED PASSWORD 'md5ea4c9e85db3ee26e23d65bb44d7e7733' NOSUPERUSER INHERIT NOCREATEDB  NOCREATEROLE NOREPLICATION VALID UNTIL '2020-06-02 00:00:00';
GRANT chichinabo TO chibo;

-- Basic data warehouse schemas
CREATE SCHEMA IF NOT EXISTS stage; -- stage area
CREATE SCHEMA IF NOT EXISTS ods; --operational data store
CREATE SCHEMA IF NOT EXISTS dms; --data marts
CREATE SCHEMA IF NOT EXISTS logs; -- Activity registry

-- One schema per project.
-- You can rename them as "project_scale_year" e.g. census_province_2011
-- Create as many as necessary
CREATE SCHEMA IF NOT EXISTS what_project1;
CREATE SCHEMA IF NOT EXISTS what_project2;

GRANT USAGE ON SCHEMA dms TO chichinabo;
ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO chichinabo;
