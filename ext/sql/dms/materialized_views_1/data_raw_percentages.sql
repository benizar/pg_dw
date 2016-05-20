
/*
 *  Add comments
 */
CREATE MATERIALIZED VIEW dms.data_raw_percentages AS 
 SELECT (row_to_json(f.*) #>> '{properties,pid}'::text[])::bigint AS pid,
    row_to_json(f.*) AS row_to_json
   FROM ( SELECT 'Feature' AS type,
            st_asgeojson(st_collect(ARRAY[lg.where_boundary, lg.where_centroid]), 4)::json AS geometry,
            row_to_json(( SELECT l.*::record AS l
                   FROM ( SELECT lg.pid,
                            lg.who_uploaded,
                            lg.what_project,
                            lg.what_variables,
                            dms.pyrintarray_percentages(lg.what_data) AS what_data,
                            lg.what_total_pop,
                            lg.what_shape,
                            lg.where_geoname,
                            lg.when_reference,
                            lg.when_accessed,
                            lg.whose_provider,
                            lg.whose_url,
                            lg.how_popup_html_long) l)) AS properties,
            lg.how_boundary_style::json AS style
           FROM dms.main lg) f
  ORDER BY (row_to_json(f.*) #>> '{properties,pid}'::text[])::bigint
WITH DATA;
