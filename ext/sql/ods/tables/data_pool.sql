

/*
* data_pool
*/
CREATE TABLE ods.data_pool
(
	id serial PRIMARY KEY,
	data_book ods.spsh[] NOT NULL, -- an array of spreadsheets
	geoname text NOT NULL,

	project_id integer NOT NULL REFERENCES ods.projects_list,
	spatial_id integer NOT NULL REFERENCES ods.spatial_pool
);



