

/******************************
* spatial_pool
*/
CREATE TABLE ods.spatial_pool
(
	id serial NOT NULL,
	statscode text NOT NULL,
	geoname text NOT NULL,
	geohash text NOT NULL,

	spatial_project_id integer NOT NULL REFERENCES ods.spatial_projects_list

);

/*
* spatial_pool_pl
* check if the new geometry is a polygon or a multipolygon
* then we want both geometries
*/
CREATE TABLE ods.spatial_pool_pol
(
	CHECK (GeometryType(geom) = 'POLYGON' OR GeometryType(geom) = 'MULTIPOLYGON'),
	boundary geometry, -- Additional column to store a multi/polygon.
	labelpoint geometry -- Additional column to store a labelpoint.

) inherits (spatial_pool);

/*
* spatial_pool_pt
* check if the new geometry is a point or multipoint; Then we keep that point.
*/
CREATE TABLE ods.spatial_pool_pt
(
	CHECK (GeometryType(geom) = 'POINT' OR GeometryType(geom) = 'MULTIPOINT'),
	labelpoint geometry -- Additional column to store a labelpoint.

) inherits (spatial_pool);

/*
* on_spatial_pool_insert()
* check if the new geometry is a point or multipoint.
*/
CREATE OR REPLACE FUNCTION on_spatial_pool_insert()
RETURNS TRIGGER AS $$
BEGIN
	IF (GeometryType(new.geom) = 'POLYGON' OR GeometryType(new.geom) = 'MULTIPOLYGON') THEN
        	INSERT INTO ods.spatial_pool_pol (statscode, geoname, geohash, spatial_project_id, boundary, labelpoint)
		VALUES (new.statscode, new.geoname, ST_GeoHash(ST_PointOnSurface(new.geom), 8), new.spatial_project_id, new.geom, ST_PointOnSurface(new.geom));

	ELSEIF (GeometryType(new.geom) = 'POINT' OR GeometryType(new.geom) = 'MULTIPOINT') THEN
        	INSERT INTO ods.spatial_pool_pt (statscode, geoname, geohash, project_id, labelpoint)
		VALUES (new.statscode, new.geoname, ST_GeoHash(labelpoint, 8), new.spatial_project_id, ST_PointOnSurface(new.geom));

	ELSE
		RAISE EXCEPTION 'Geometry is not a multi/polygon or a multi/point';
	END IF;

	RETURN null;
END;
$$ LANGUAGE plpgsql;

/*
* spatial_pool_insert
*/
CREATE TRIGGER spatial_pool_insert
    BEFORE INSERT ON spatial_pool
    FOR EACH ROW EXECUTE PROCEDURE on_spatial_pool_insert();



