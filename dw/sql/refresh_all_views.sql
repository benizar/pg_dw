

/*
* Add comments
*/
CREATE OR REPLACE FUNCTION dms.refresh_all_views()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
	--refresh materialized view dms.map_catalog;
    	RETURN null;
END $$;


CREATE TRIGGER refresh_all_views
AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
ON ods.main FOR EACH STATEMENT 
EXECUTE PROCEDURE dms.refresh_all_views();


