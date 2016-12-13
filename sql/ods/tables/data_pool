

/*******************************
* data_pool
*/
CREATE TABLE ods.data_pool
(
	id serial PRIMARY KEY,
	statscode text NOT NULL,
	book jsonb NOT NULL,
	geoname text NOT NULL,

	data_project_id integer NOT NULL REFERENCES ods.projects_list,
	spatial_project_id integer NOT NULL REFERENCES ods.projects_list -- Specify a project to do a join by a statscode

);


comment on table ods.data_pool is '';
comment on column ods.data_pool.id is '';
comment on column ods.data_pool.statscode is '';
comment on column ods.data_pool.book is 'A spreadsheet book in json format. Column oriented.';
comment on column ods.data_pool.geoname is '';
comment on column ods.data_pool.data_project_id is '';
comment on column ods.data_pool.spatial_project_id is 'A spatial project id that can be joinde by this and the statscode';
