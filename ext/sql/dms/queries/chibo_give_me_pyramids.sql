
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.chibo_give_me_pyramids(pids integer[])
  RETURNS text AS
$BODY$
SELECT row_to_json(fc)::text FROM ( 
SELECT 'FeatureCollection' As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_raw WHERE pid IN (SELECT(unnest(pids))))  As fc;
$BODY$
  LANGUAGE sql VOLATILE;
