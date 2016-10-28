
/*
 *  Add comments
 */
/*CREATE OR REPLACE FUNCTION dms.chibo_give_me_pyramids(pids integer[], age_groups dms.pyrages, percentages boolean)
  RETURNS text AS
$BODY$
DECLARE
  result text;
BEGIN

IF age_groups = 'Raw data' AND percentages = false THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_raw WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = 'Raw data' AND percentages = true THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_raw_percentages WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = '5 years' AND percentages = false THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_five_years WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = '5 years' AND percentages = true THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_five_years_percentages WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = '10 years' AND percentages = false THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_ten_years WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = '10 years' AND percentages = true THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_ten_years_percentages WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = 'Big groups' AND percentages = false THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_big_groups WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

ELSIF age_groups = 'Big groups' AND percentages = true THEN
    EXECUTE format('SELECT row_to_json(fc)::text FROM ( 
SELECT %L As type, array_to_json(array_agg(row_to_json)) As features
 FROM dms.data_big_groups_percentages WHERE pid IN (SELECT(unnest($1))))  As fc;','FeatureCollection') USING pids INTO result;

END IF;

  RETURN result;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

 */
