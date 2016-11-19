

/********************
* Create a spatial_pool child table
*/
CREATE OR REPLACE FUNCTION ods.create_spatial_child(long_name text, short_name text, ref_date date, backid int, provid int)
  RETURNS int AS
$func$
DECLARE
  new_spatial_project_id int;
BEGIN

-- Create a new spatial project
INSERT INTO ods.spatial_projects_list (longname, shortname, refdate, backer_id, provider_id) VALUES (long_name, short_name, ref_date, backid, provid) RETURNING id INTO new_spatial_project_id;

-- Create a child table to store this project's spatial data
EXECUTE format('CREATE TABLE IF NOT EXISTS %I () inherits (ods.spatial_pool);', 'ods.' || short_name);

-- Check the new project's id so it can be used when you insert your spatial data
RETURN new_spatial_project_id;

END
$func$ LANGUAGE plpgsql;


