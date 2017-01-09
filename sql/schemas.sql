

-- Basic data warehouse schemas.
-- Extend it with extensions such as pg_popyramids 
CREATE SCHEMA IF NOT EXISTS stage;
COMMENT ON SCHEMA stage IS 'Stage area. A JSONB document store. These documents must defined following the geojson specification and semantics from schemas.org';

CREATE SCHEMA IF NOT EXISTS ods;
COMMENT ON SCHEMA ods IS 'Operational data store. Extract here general or specific data from the stage area. The pg_dw extension has some general views, but it can be extended with extensions such as pg_popyramids';
 
CREATE SCHEMA IF NOT EXISTS dms;
COMMENT ON SCHEMA dms IS 'Data marts for publishing data throught services. Publish here general or specific data from the ods schema. The pg_dw extension has some general views, but it can be extended with extensions such as pg_popyramids';

CREATE SCHEMA IF NOT EXISTS logs;
COMMENT ON SCHEMA logs IS 'Log activity.';


-- Add all dw schemas to the search_path and move bedquilt to the stage schema
-- http://www.postgresonline.com/journal/archives/248-Moving-PostGIS-to-another-schema-with-Extensions.html
--http://stackoverflow.com/a/10213161
DO $$
BEGIN
EXECUTE 'ALTER DATABASE ' || current_database() || ' SET search_path="$user", public, stage, ods, dms, logs';
END; $$;

GRANT ALL ON SCHEMA stage TO public;
ALTER EXTENSION bedquilt SET SCHEMA stage;


-- Create users for publishing services.

--grant usage once the schemas are created
--GRANT USAGE ON SCHEMA ods TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA ods GRANT SELECT ON TABLES TO apis;

--GRANT USAGE ON SCHEMA dms TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO apis;
