CREATE MATERIALIZED VIEW dms.docstore AS 

SELECT lg.pid, lg.where_boundary,lg.where_centroid,
        json_build_object(
		'type', 'Feature',
                'geometry', st_asgeojson(st_collect(ARRAY[lg.where_boundary, lg.where_centroid]), 4)::json,
                'style', lg.how_boundary_style::json,
                'properties', json_build_object(
                            'pid', lg.pid,
                            'who_uploaded', lg.who_uploaded,
                            'what_project', lg.what_project,
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
                            'when_accessed', lg.when_accessed,
                            'whose_provider', lg.whose_provider,
                            'whose_url', lg.whose_url,
                            'how_popup_html_long', lg.how_popup_html_long
                        )
    )::jsonb AS payload
from dms.main lg

WITH DATA;
