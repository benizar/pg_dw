

/*******************************
* projects_list
*/
CREATE TABLE ods.projects_list (
	id serial PRIMARY KEY,
	longname text UNIQUE NOT NULL,
	shortname text UNIQUE NOT NULL,
	loadate date DEFAULT CURRENT_DATE NOT NULL,
	refdate date NOT NULL,

	backer_id integer NOT NULL REFERENCES ods.backers_list,
	provider_id integer NOT NULL REFERENCES ods.providers_list
);

/*
* data_projects_list
*/
CREATE TABLE ods.data_projects_list () inherits (projects_list);

/*
* spatial_projects_list
*/
CREATE TABLE ods.spatial_projects_list () inherits (projects_list);


