
-- Add all schemas to the search_path
-- http://www.postgresonline.com/journal/archives/248-Moving-PostGIS-to-another-schema-with-Extensions.html
--http://stackoverflow.com/a/10213161
DO $$
BEGIN
EXECUTE 'ALTER DATABASE ' || current_database() || ' SET search_path="$user", public, stage, ods, dms, logs';
END; $$;

--move bedquilt to the docstore schema
GRANT ALL ON SCHEMA docstore TO public;
ALTER EXTENSION bedquilt SET SCHEMA docstore;


