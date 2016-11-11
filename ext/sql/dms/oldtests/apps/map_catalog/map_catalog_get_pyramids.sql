
/*
 *  Add comments
 * SELECT dms.chibo_give_me_pyramids(dms.chibo_give_me_pids('INE (Spain)', 'padron_2011_ccaa', 40, 5, 30, -5, DATE '2000-01-01', DATE '2015-01-01', 5))
 */

CREATE OR REPLACE FUNCTION dms.give_me_pyramids(pids integer[])
  RETURNS text AS
$BODY$
SELECT row_to_json(fc)::text FROM ( 
SELECT 'FeatureCollection' As type, array_to_json(array_agg(payload)) As features
 FROM dms.docstore WHERE pid IN (SELECT(unnest(pids))))  As fc;
$BODY$
  LANGUAGE sql VOLATILE;


