
/*
 *  This materialized view is an entry point for the data marts schema
 */
CREATE MATERIALIZED VIEW dms.main AS 
 SELECT pid,
    who_uploaded,
    what_project,
    what_project_short,
    what_variables,
    dms.pyrintarray_from_ods(what_data) AS what_data, --CAST DATA TO THIS SCHEMA
    where_geoname,
    where_centroid,
    ST_SimplifyPreserveTopology(where_boundary,0.001) AS where_boundary,
    when_reference,
    when_accessed,
    whose_provider,
    whose_provider_short,
    whose_url,

--CALCULATIONS
    dms.pyrintarray_total_pop(dms.pyrintarray_from_ods(what_data)) AS what_total_pop,
    dms.pyrint_shape(dms.pyrint_from_ods(what_data[1])) AS what_shape,

--STYLES
    ('<font size=1>'
    '<table>'
    '<tr bgcolor="#CED8F6"><td><b>pid: </b></td><td>'||pid||'</td></tr>'
    '<tr bgcolor="#FFFFFF"><td><b>where_geoname: </b></td><td>'||where_geoname||'</td></tr>'
    '<tr bgcolor="#CED8F6"><td><b>when_reference: </b></td><td>'||when_reference||'</td></tr>'
    '<tr bgcolor="#FFFFFF"><td><b>what_project: </b></td><td>'||what_project||'</td></tr>'
    '<tr bgcolor="#CED8F6"><td><b>whose_provider: </b></td><td>'||whose_provider||'</td></tr>'
    '<tr bgcolor="#FFFFFF"><td><b>whose_url: </b></td><td>'||whose_url||'</td></tr>'
    '<tr bgcolor="#CED8F6"><td><b>when_accessed: </b></td><td>'||when_accessed||'</td></tr>'
    '<tr bgcolor="#FFFFFF"><td><b>who_uploaded: </b></td><td>'||who_uploaded||'</td></tr>'
    '</table>'
    '</font>'::text) AS how_popup_html_long,

    '{"stroke":true,'
    '"smoothFactor":0.2,'
    '"opacity":1,'
    '"fillOpacity":0.8,'
    '"fillColor":"'||

    CASE
      WHEN dms.pyrint_shape(dms.pyrint_from_ods(what_data[1])) = 'pyramid'::dms.pyrshapes THEN '#ffff99'
      WHEN dms.pyrint_shape(dms.pyrint_from_ods(what_data[1])) = 'tornado'::dms.pyrshapes THEN '#386cb0'
      WHEN dms.pyrint_shape(dms.pyrint_from_ods(what_data[1])) = 'star'::dms.pyrshapes THEN '#fdc086'
      WHEN dms.pyrint_shape(dms.pyrint_from_ods(what_data[1])) = 'bell'::dms.pyrshapes THEN '#7fc97f'
      ELSE '#beaed4'
    END

||'",'
    '"weight":1,'
    '"color":"black"}'::text AS how_boundary_style
   FROM ods.main
WITH DATA;
