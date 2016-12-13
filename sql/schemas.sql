

-- Basic data warehouse schemas
CREATE SCHEMA IF NOT EXISTS stage_spatial; -- spatial data
CREATE SCHEMA IF NOT EXISTS stage; -- stage area
CREATE SCHEMA IF NOT EXISTS ods; --operational data store
CREATE SCHEMA IF NOT EXISTS dms; --data marts
CREATE SCHEMA IF NOT EXISTS logs; -- Activity registry


--grant usage once the schemas are created
--GRANT USAGE ON SCHEMA ods TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA ods GRANT SELECT ON TABLES TO apis;

GRANT USAGE ON SCHEMA dms TO apis;
ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO apis;
