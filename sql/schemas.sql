

-- Basic data warehouse schemas
CREATE SCHEMA IF NOT EXISTS stage; -- Stage area for bedquilt docstore
CREATE SCHEMA IF NOT EXISTS ods; -- Operational data store. Extract data from stage area.
CREATE SCHEMA IF NOT EXISTS dms; -- Data marts for publishing data throught services.
CREATE SCHEMA IF NOT EXISTS logs; -- Log activity.


-- Create users for publishing services.

--grant usage once the schemas are created
--GRANT USAGE ON SCHEMA ods TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA ods GRANT SELECT ON TABLES TO apis;

--GRANT USAGE ON SCHEMA dms TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO apis;
