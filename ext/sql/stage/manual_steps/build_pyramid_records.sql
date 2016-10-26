/*SELECT * 
FROM stage.build_pyramid_records('censo_ccaa_1991_join',
				'wkb_geometry',
				'where_geon',
				'Andrea Rosado', 
				'Censo de Población y Viviendas 2001. Resultados por Comunidades Autónomas',
				'2001-11-1',
				'Instituto Nacional de Estadística', 
				'http://www.ine.es/', 
				'INE (Spain)', 
				'censo_ccaa_1991');*/


-- TODO:check number columns
-- TODO:check that population column names are following the predefined pattern (e.g. xx??, xy??)
-- TODO: replace ranges CTE by a loop
CREATE OR REPLACE FUNCTION stage.build_pyramid_records(table_name text, col_geom text, col_geoname text, who text, project text, when_ref text, provider text, url text, project_short text, provider_short text) 
	RETURNS TABLE(
	who_uploaded text,
	what_project text,
	what_data ods.pyrint[],
	where_geoname text,
	where_boundary geometry,
	when_reference date,
	when_accessed timestamp with time zone,
	whose_provider text,
	whose_url text,
	what_variables ods.pyrvars[],
	what_project_short text,
	whose_provider_short text,
	where_centroid geometry
    )
   AS
$func$

BEGIN

RETURN QUERY

EXECUTE E'WITH rangos AS (

SELECT * FROM stage.build_ranges('||quote_literal(table_name)||')'
     
    '), melt AS (
   
SELECT * FROM stage.build_melt('||quote_literal(table_name)||','||quote_literal(col_geom)||','||quote_literal(col_geoname)||')
       
     ), agg AS (
      
SELECT where_geoname, where_boundary, array_agg(xy ORDER BY age) AS xy, array_agg(xx ORDER BY age) AS xx, array_agg(age ORDER BY age) AS age
FROM melt
GROUP BY where_geoname, where_boundary
       
     ), metadata AS (
       
SELECT
' ||quote_literal(who) ||'::text AS who_uploaded,
' ||quote_literal(project) ||'::text AS what_project,
where_geoname::text,
where_boundary,
ST_centroid(where_boundary) AS where_centroid,
' ||quote_literal(when_ref) || '::date  AS when_reference,
now() AS when_accessed,
' ||quote_literal(provider) || '::text AS whose_provider,
' ||quote_literal(url) || '::text AS whose_url,
' ||quote_literal(project_short) || '::text AS what_project_short,
' ||quote_literal(provider_short) || '::text AS whose_provider_short,
xy AS data_xy,
xx AS data_xx,
age AS data_age
FROM agg
     
     ), final AS (
      
SELECT 
  who_uploaded,
  what_project,
  ARRAY[(data_age,data_xy,data_xx)::ods.pyrint] AS what_data,
  where_geoname,
  where_boundary,
  when_reference,
  when_accessed,
  whose_provider,
  whose_url,
  ARRAY['||quote_literal('Population')||'::ods.pyrvars] AS what_variables, --TODO: Define as function parameter
  what_project_short,
  whose_provider_short,
  where_centroid
  
  FROM metadata
      
     )
SELECT * FROM final; ';


END
$func$
LANGUAGE plpgsql;
