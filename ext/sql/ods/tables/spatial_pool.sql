

/*
* spatial_pool
*/
CREATE TABLE ods.spatial_pool
(
	id serial PRIMARY KEY,
	statscode text NOT NULL,
	refdate date NOT NULL,
	geoname text NOT NULL,
	boundary geometry NOT NULL,
	labelpoint geometry NOT NULL

);



