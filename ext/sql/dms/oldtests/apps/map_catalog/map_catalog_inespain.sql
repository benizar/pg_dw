

-- DROP MATERIALIZED VIEW dms.inespain;
/*
*  This materialized view is an entry point for the data marts schema
*/
CREATE MATERIALIZED VIEW dms.map_catalog_inespain AS 

WITH ods AS (
		SELECT pid,
			what_project,
			what_project_short,
			what_variables,
			dms.pyrintarray_from_ods(what_data) AS what_data, --CAST DATA TO THIS SCHEMA
			where_geoname,
			ST_centroid(where_boundary) AS where_centroid,
			ST_SimplifyPreserveTopology(where_boundary,0.001) AS where_boundary,
			when_reference,
			whose_url
		FROM ods.main
		WHERE whose_provider_short = 'INE (Spain)'

	), calculations AS (
		SELECT *,
			dms.pyrintarray_total_pop(what_data) AS what_total_pop,
			dms.pyrint_shape(what_data[1]) AS what_shape,

			dms.pyrintarray_bucketing(what_data, '5 years'::dms.pyrages) AS what_data_5,
			dms.pyrintarray_bucketing(what_data, '10 years'::dms.pyrages) AS what_data_10,
			dms.pyrintarray_bucketing(what_data, 'Big groups'::dms.pyrages) AS what_data_big,

			dms.pyrintarray_percentages(what_data) AS what_percentages,
			dms.pyrintarray_percentages(dms.pyrintarray_bucketing(what_data, '5 years'::dms.pyrages)) AS what_percentages_5,
			dms.pyrintarray_percentages(dms.pyrintarray_bucketing(what_data, '10 years'::dms.pyrages)) AS what_percentages_10,
			dms.pyrintarray_percentages(dms.pyrintarray_bucketing(what_data, 'Big groups'::dms.pyrages)) AS what_percentages_big
		
		FROM ods

	), ordering AS (
		SELECT * FROM calculations ORDER BY what_total_pop DESC


	), styled AS ( 
		SELECT *,
			('<font size=1>'
			'<table>'
			'<tr bgcolor="#CED8F6"><td><b>pid: </b></td><td>'||pid||'</td></tr>'
			'<tr bgcolor="#FFFFFF"><td><b>where_geoname: </b></td><td>'||where_geoname||'</td></tr>'
			'<tr bgcolor="#CED8F6"><td><b>when_reference: </b></td><td>'||when_reference||'</td></tr>'
			'<tr bgcolor="#FFFFFF"><td><b>what_project: </b></td><td>'||what_project||'</td></tr>'
			'<tr bgcolor="#FFFFFF"><td><b>whose_url: </b></td><td>'||whose_url||'</td></tr>'
			'</table>'
			'</font>'::text) AS how_popup_html_long,

			'{"stroke":true,'
			'"smoothFactor":0.2,'
			'"opacity":1,'
			'"fillOpacity":0.8,'
			'"fillColor":"'||

			CASE
				WHEN dms.pyrint_shape(what_data[1]) = 'pyramid'::dms.pyrshapes THEN '#ffff99'
				WHEN dms.pyrint_shape(what_data[1]) = 'tornado'::dms.pyrshapes THEN '#386cb0'
				WHEN dms.pyrint_shape(what_data[1]) = 'star'::dms.pyrshapes THEN '#fdc086'
				WHEN dms.pyrint_shape(what_data[1]) = 'bell'::dms.pyrshapes THEN '#7fc97f'
				ELSE '#beaed4'
			END

			||'",'
			'"weight":1,'
			'"color":"black"}'::text AS how_boundary_style
		FROM ordering
	), docstore AS (
		SELECT lg.pid, lg.where_boundary,lg.where_centroid,
			json_build_object(
				'type', 'Feature',
				'geometry', st_asgeojson(st_collect(ARRAY[lg.where_centroid]), 4)::json,
				'style', lg.how_boundary_style::json,
				'properties', json_build_object(
					'pid', lg.pid,
					'what_project', lg.what_project,
					'what_project_short', lg.what_project,
					'what_variables', lg.what_variables,
					'what_data', lg.what_data,
					'what_data_5', lg.what_data_5,
					'what_data_10', lg.what_data_10,
					'what_data_big', lg.what_data_big,
					'what_percentages', lg.what_percentages,
					'what_percentages_5', lg.what_percentages_5,
					'what_percentages_10', lg.what_percentages_10,
					'what_percentages_big', lg.what_percentages_big,
					'what_total_pop', lg.what_total_pop,
					'what_shape', lg.what_shape,
					'where_geoname', lg.where_geoname,
					'when_reference', lg.when_reference,
					'whose_url', lg.whose_url,
					'how_popup_html_long', lg.how_popup_html_long
					)
			)::jsonb AS pyramid
		FROM styled lg
	)

SELECT * FROM docstore

WITH DATA;
