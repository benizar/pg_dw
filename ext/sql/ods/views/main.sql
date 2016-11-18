
/*
* Main view used for inserting on multiple tables or dms queries
* when provider and backer already exist
*/
CREATE VIEW ods.main AS

SELECT dt.data_series AS dt_data, 
	dt.data_vars AS dt_variables, 
	dt.geoname AS dt_geoname, 
	--dt.boundary AS dt_boundary, 
	--dt.labelpoint AS dt_labelpoint,
	proj.longname AS proj_longname, 
	proj.shortname AS proj_shortname, 
	proj.refdate AS proj_refdate,
	proj.backer_id AS proj_backerid,  -- backer_id already known
	proj.provider_id AS proj_providerid -- provider_id already known
	
FROM ods.data_pool dt INNER JOIN ods.projects_list proj ON proj.id = dt.project_id;



