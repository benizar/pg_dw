CREATE TABLE stage.censo_ccaa_2001_metadata AS(
SELECT
'Andrea Rosado'::text AS who_uploaded,

'Censo de Población y Viviendas 2001. Resultados por Comunidades Autónomas'::text AS what_project,


where_geoname,
where_boundary,
ST_centroid(where_boundary) AS where_centroid,

'2001-11-1'::date  AS when_reference,
now() AS when_accessed,

'Instituto Nacional de Estadística'::text AS whose_provider,
'http://www.ine.es/'::text AS whose_url,

'INE (Spain)'::text AS what_project_short,
'censo_ccaa_2001'::text AS whose_provider_short,

xy AS data_xy,
xx AS data_xx,
age AS data_age

FROM stage.censo_ccaa_2001_agg)
