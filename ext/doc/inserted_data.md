# Log of data inserted into ods.main

First use build_pyramid_records for checking if your data is OK. Then you can do INSERT as: 

```sql
﻿INSERT INTO ods.main (  who_uploaded,
  what_project,
  what_project_short,
  what_data,
  what_variables,
  where_geoname,
  where_boundary,
  where_centroid,
  when_reference,
  when_accessed,
  whose_provider,
  whose_provider_short,
  whose_url) 
  
SELECT who_uploaded,
  what_project,
  what_project_short,
  what_data,
  what_variables,
  where_geoname,
  where_boundary,
  where_centroid,
  when_reference,
  when_accessed,
  whose_provider,
  whose_provider_short,
  whose_url 
  FROM stage.build_pyramid_records_1y('censo_ccaa_1991_join',
				'wkb_geometry',
				'where_geon',
				'Andrea Rosado', 
				'Censo de Población y Viviendas 1991. Resultados por Comunidades Autónomas',
				'1991-11-1',
				'Instituto Nacional de Estadística', 
				'http://www.ine.es/', 
				'INE (Spain)', 
				'censo_ccaa_1991')
```
