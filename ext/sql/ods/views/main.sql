

/*******************************
* Main view used for inserting on multiple tables or dms queries
* when provider and backer already exist
*/
CREATE VIEW ods.main AS

SELECT dp.spsh_book AS spsh_book, 
	dp.geoname AS geoname, 
	pr.longname AS longname, 
	pr.shortname AS shortname, 
	pr.refdate AS refdate
	
FROM ods.data_pool dp INNER JOIN ods.projects_list pr ON pr.id = dp.project_id;


