/*
* Main view used for inserting on multiple tables
*/

CREATE VIEW ods.main AS

SELECT pyr.pyrdata AS pyr_data, 
	pyr.pyrvariables AS pyr_variables, 
	pyr.geoname AS pyr_geoname, 
	pyr.boundary AS pyr_boundary, 
	pyr.labelpoint AS pyr_labelpoint,
	proj.longname AS proj_longname, 
	proj.shortname AS proj_shortname, 
	proj.refdate AS proj_refdate, 
	back.nickname AS backer_longname, 
	back.firstname AS backer_firstname, 
	back.lastname AS backer_lastname, 
	prov.longname AS provider_longname, 
	prov.shortname AS provider_shortname, 
	prov.url  AS provider_url
	
FROM ods.pyramids pyr INNER JOIN ods.projects_list proj ON proj.id = pyr.projects_id
INNER JOIN ods.backers_list back ON back.id = bakers_id
INNER JOIN ods.providers_list prov ON prov.id = providers_id