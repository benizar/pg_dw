
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_append_distinct(anyarray, anyelement)
  RETURNS anyarray AS
$BODY$ 
  SELECT ARRAY(SELECT unnest($1) union SELECT $2) 
$BODY$
  LANGUAGE sql VOLATILE;
