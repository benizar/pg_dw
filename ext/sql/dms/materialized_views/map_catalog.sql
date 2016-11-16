


/*
*  This materialized view is an entry point for the data marts schema
*/
CREATE MATERIALIZED VIEW dms.map_catalog AS 

WITH ods AS (
		SELECT pid,
			project,
			project_id,
			pyrvariables,
			dms.pyrintarray_from_ods(pyrdata) AS pyrdata, --CAST DATA TO THIS SCHEMA
			geoname,
			labelpoint,
			ST_GeoHash(labelpoint, 8) AS geohash,
			refdate,
			provider,
			provider_id,
			url
		FROM ods.main

	), calculations AS (
		SELECT *,
			dms.pyrintarray_total_pop(pyrdata) AS totalpop,
			dms.pyrint_shape(pyrdata[1]) AS shape,

			--dms.pyrintarray_bucketing(pyrdata, '5 years'::dms.pyrages) AS pyrdata_5,
			--dms.pyrintarray_bucketing(pyrdata, '10 years'::dms.pyrages) AS pyrdata_10,
			--dms.pyrintarray_bucketing(pyrdata, 'Big groups'::dms.pyrages) AS pyrdata_big,

			--dms.pyrintarray_percentages(pyrdata) AS pyrcent,
			dms.pyrintarray_percentages(dms.pyrintarray_bucketing(pyrdata, '5 years'::dms.pyrages)) AS pyrcent_5,
			dms.pyrintarray_percentages(dms.pyrintarray_bucketing(pyrdata, '10 years'::dms.pyrages)) AS pyrcent_10
			--dms.pyrintarray_percentages(dms.pyrintarray_bucketing(pyrdata, 'Big groups'::dms.pyrages)) AS pyrcent_big
		
		FROM ods

	), ordering AS (
		SELECT * FROM calculations ORDER BY totalpop DESC


	), docstore AS (
		SELECT lg.pid,
			lg.project_id,
			lg.totalpop,
			lg.shape,
			lg.geoname,
			lg.geohash,
			lg.refdate,
			lg.provider_id,

			json_build_object(
				'type', 'Feature',
				'geometry', st_asgeojson(st_collect(ARRAY[lg.labelpoint]), 4)::json,
				'properties', json_build_object(
					'pid', lg.pid,
					'project', lg.project,
					'project_id', lg.project_id,
					'pyrvariables', lg.pyrvariables,
					--'pyrdata', lg.pyrdata,
					--'pyrdata_5', lg.pyrdata_5,
					--'pyrdata_10', lg.pyrdata_10,
					--'pyrdata_big', lg.pyrdata_big,
					--'pyrcent', lg.pyrcent,
					'pyrcent_5', lg.pyrcent_5,
					'pyrcent_10', lg.pyrcent_10,
					--'pyrcent_big', lg.pyrcent_big,
					'totalpop', lg.totalpop,
					'shape', lg.shape,
					'geoname', lg.geoname,
					'geohash', lg.geohash,
					'refdate', lg.refdate,
					'provider', lg.provider,
					'provider_id', lg.provider_id,
					'url', lg.url
					)
			)::jsonb AS pyramid
		FROM ordering lg
	)

SELECT * FROM docstore

WITH DATA;
