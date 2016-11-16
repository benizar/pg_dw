/*
* Main view used for inserting on multiple tables
* when provider and backer already exist
*/

CREATE VIEW ods.projects AS

SELECT pyr.pyrdata AS pyr_data, 
	pyr.pyrvariables AS pyr_variables, 
	pyr.geoname AS pyr_geoname, 
	pyr.boundary AS pyr_boundary, 
	pyr.labelpoint AS pyr_labelpoint,
	proj.longname AS proj_longname, 
	proj.shortname AS proj_shortname, 
	proj.refdate AS proj_refdate,
	proj.backer_id AS proj_backerid,  -- backer_id already known
	proj.provider_id AS proj_providerid, -- provider_id already known
	back.nickname AS backer_nickname, 
	back.firstname AS backer_firstname, 
	back.lastname AS backer_lastname, 
	prov.longname AS provider_longname, 
	prov.shortname AS provider_shortname, 
	prov.url  AS provider_url
	
FROM ods.pyramids pyr INNER JOIN ods.projects_list proj ON proj.id = pyr.projects_id
INNER JOIN ods.backers_list back ON back.id = bakers_id
INNER JOIN ods.providers_list prov ON prov.id = providers_id