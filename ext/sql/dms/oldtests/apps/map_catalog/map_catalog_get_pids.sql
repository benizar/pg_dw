
/*
 * SELECT dms.give_me_pids_by_box_rel('{INE (Spain)}','{padron_2011_ccaa}',40, 5, 30, -5,'2000-01-01', '2015-01-01', 'what_total_pop', 'desc', 5)
 
RESTFUL
{"provider_short": "{INE (Spain)}", "project_short":"{padron_2011_ccaa}", "north":40, "east":5, "south":30, "west":-5, "date_from": "2000-01-01", "date_to":"2015-01-01", "sort_col":"what_total_pop", "sort_dir": "desc", "maxpids":5}
*/

CREATE OR REPLACE FUNCTION dms.give_me_pids_by_box_rel(provider_short text[], 
							project_short text[], 
							north numeric, east numeric, south numeric, west numeric, 
							date_from text, date_to text, 
							maxpids integer default 5)
  RETURNS integer[] AS
$BODY$
SELECT array_agg(pid) FROM (SELECT pid
FROM dms.main
WHERE whose_provider_short = ANY(provider_short::text[]) 
AND what_project_short = ANY(project_short::text[])
AND ST_Intersects(where_centroid, ST_setSRID(ST_MakeEnvelope(west, south, east, north),4326))
AND when_reference BETWEEN to_date( date_from , 'YYYY-MM-DD') AND to_date( date_to , 'YYYY-MM-DD')

ORDER BY what_total_pop DESC

LIMIT maxpids) AS pids;

$BODY$
  LANGUAGE sql VOLATILE;
