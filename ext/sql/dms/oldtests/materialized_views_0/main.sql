
/*
 *  This materialized view is an entry point for the data marts schema
 */
CREATE MATERIALIZED VIEW dms.main AS 
	SELECT pid,
		what_project_short,
		what_variables,
		where_geoname,
		ST_centroid(where_boundary) AS where_centroid,
		ST_SimplifyPreserveTopology(where_boundary,0.001) AS where_boundary,
		when_reference,
		whose_provider_short
   FROM ods.main
WITH DATA;
