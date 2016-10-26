


CREATE TABLE stage.censo_ccaa_2001_final AS (

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
  ARRAY['Population'::ods.pyrvars] AS what_variable,
  what_project_short,
  whose_provider_short,
  where_centroid
  
  FROM stage.censo_ccaa_2001_metadata)
