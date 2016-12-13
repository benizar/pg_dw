CREATE TABLE stage.censo_ccaa_2001_agg AS (
SELECT where_geoname, where_boundary, array_agg(xy ORDER BY age) AS xy, array_agg(xx ORDER BY age) AS xx, array_agg(age ORDER BY age) AS age
FROM stage.censo_ccaa_2001_melt
GROUP BY where_geoname, where_boundary);
