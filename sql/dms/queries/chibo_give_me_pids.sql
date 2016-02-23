
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.chibo_give_me_pids(provider_short text, project_short text, north numeric, east numeric, south numeric, west numeric, date_from date, date_to date, maxpids integer)
  RETURNS integer[] AS
$BODY$
SELECT array_agg(pid) FROM (SELECT pid
FROM dms.main
WHERE whose_provider_short=provider_short AND what_project_short=project_short AND ST_Intersects(where_centroid, ST_setSRID(ST_MakeEnvelope(west, south,east, north),4326)) AND when_reference BETWEEN date_from AND date_to
ORDER BY what_total_pop desc
Limit maxpids) AS pids;
$BODY$
  LANGUAGE sql VOLATILE;
