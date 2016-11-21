

/******************************
* spatial_pool
*/
CREATE TABLE ods.spatial_pool
(
	id serial PRIMARY KEY,
	statscode text NOT NULL,
	geoname text NOT NULL,
	geohash text NOT NULL,
	labelpoint geometry, -- Additional column to store a labelpoint.

	spatial_project_id integer NOT NULL REFERENCES ods.projects_list

);

/*
* spatial_pool_pl
* check if the new geometry is a polygon or a multipolygon
* then we want both geometries
*/
CREATE TABLE ods.spatial_pool_pol
(
	CHECK (GeometryType(labelpoint) = 'POLYGON' OR GeometryType(labelpoint) = 'MULTIPOLYGON'),
	boundary geometry -- Additional column to store a multi/polygon.

) INHERITS (ods.spatial_pool);

/*
* spatial_pool_pt
* check if the new geometry is a point or multipoint; Then we keep that point.
*/
CREATE TABLE ods.spatial_pool_pt
(
	CHECK (GeometryType(labelpoint) = 'POINT' OR GeometryType(labelpoint) = 'MULTIPOINT')

) INHERITS (ods.spatial_pool);

/*
* on_spatial_pool_insert()
* check if the new geometry is a point or multipoint.
*/
CREATE OR REPLACE FUNCTION on_spatial_pool_insert()
RETURNS TRIGGER AS $$
BEGIN
	IF (GeometryType(new.geom) = 'POLYGON' OR GeometryType(new.geom) = 'MULTIPOLYGON') THEN
        	INSERT INTO ods.spatial_pool_pol (statscode, geoname, geohash, labelpoint, spatial_project_id, boundary)
		VALUES (new.statscode, new.geoname, ST_GeoHash(ST_PointOnSurface(new.geom), 8), ST_PointOnSurface(new.geom), new.spatial_project_id, new.geom);

	ELSEIF (GeometryType(new.geom) = 'POINT' OR GeometryType(new.geom) = 'MULTIPOINT') THEN
        	INSERT INTO ods.spatial_pool_pt (statscode, geoname, geohash, labelpoint, project_id)
		VALUES (new.statscode, new.geoname, ST_GeoHash(labelpoint, 8), new.geom, new.spatial_project_id);

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
    BEFORE INSERT ON ods.spatial_pool
    FOR EACH ROW EXECUTE PROCEDURE on_spatial_pool_insert();



