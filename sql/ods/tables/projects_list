

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
CREATE TABLE ods.data_projects_list () inherits (ods.projects_list);

/*
* spatial_projects_list
*/
CREATE TABLE ods.spatial_projects_list () inherits (ods.projects_list);


/*
* Sample data. Delete this when your database is in production.
*/
INSERT INTO ods.data_projects_list (longname, shortname, refdate, backer_id, provider_id) VALUES ('long project name', 'short project name', '1900-01-01', 1, 1);

INSERT INTO ods.spatial_projects_list (longname, shortname, refdate, backer_id, provider_id) VALUES ('long spatial project name', 'short spatial project name', '1900-01-01', 1, 1);


