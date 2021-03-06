-- Create users for publishing services.

--grant usage once the schemas are created
--GRANT USAGE ON SCHEMA ods TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA ods GRANT SELECT ON TABLES TO apis;

--GRANT USAGE ON SCHEMA dms TO apis;
--ALTER DEFAULT PRIVILEGES IN SCHEMA dms GRANT SELECT ON TABLES TO apis;




GRANT CONNECT ON DATABASE hazard TO hazard_w;
GRANT USAGE ON SCHEMA haz TO hazard_w;
GRANT ALL ON ALL TABLES IN SCHEMA haz TO hazard_w;
GRANT ALL ON ALL SEQUENCES IN SCHEMA haz TO hazard_w;

GRANT CONNECT ON DATABASE hazard TO hazard_r;
GRANT USAGE ON SCHEMA haz TO hazard_r;
GRANT SELECT ON ALL TABLES IN SCHEMA haz TO hazard_r;
GRANT USAGE ON SCHEMA impact TO hazard_r;
GRANT SELECT ON ALL TABLES IN SCHEMA impact TO hazard_r;

GRANT CONNECT ON DATABASE hazard TO impact_w;
GRANT USAGE ON SCHEMA impact TO impact_w;
GRANT ALL ON ALL TABLES IN SCHEMA impact TO impact_w;
GRANT ALL ON ALL SEQUENCES IN SCHEMA impact TO impact_w;
