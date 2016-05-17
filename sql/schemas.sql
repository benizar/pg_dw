
-- Basic data warehouse schemas
CREATE SCHEMA IF NOT EXISTS stage; -- stage area
CREATE SCHEMA IF NOT EXISTS ods; --operational data store
CREATE SCHEMA IF NOT EXISTS dms; --data marts
CREATE SCHEMA IF NOT EXISTS logs; -- Activity registry

-- One schema per project.
-- You can rename them as "project_scale_year" e.g. census_province_2011
-- Create as many as necessary
CREATE SCHEMA IF NOT EXISTS stage_1;
CREATE SCHEMA IF NOT EXISTS stage_2;
