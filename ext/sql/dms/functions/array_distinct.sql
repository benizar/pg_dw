
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_distinct(anyarray)
  RETURNS anyarray AS
$BODY$
  SELECT ARRAY(SELECT DISTINCT unnest($1))
$BODY$
  LANGUAGE sql VOLATILE;
