

/*******************************
* data_pool
*/
CREATE TABLE ods.data_pool
(
	id serial PRIMARY KEY,
	statscode text NOT NULL,
	spshbook ods.spsh[] NOT NULL, -- an array of spreadsheets, ods.spsh[] or other types specified by an extension (e.g. ods.spsh_pyramids[])
	geoname text NOT NULL,

	data_project_id integer NOT NULL REFERENCES ods.projects_list,
	spatial_project_id integer NOT NULL REFERENCES ods.projects_list -- Specify a project to do a spatial join by a statscode

);


