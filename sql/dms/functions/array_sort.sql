
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_sort(anyarray)
  RETURNS anyarray AS
$BODY$
  SELECT ARRAY(SELECT unnest($1) ORDER BY 1)
$BODY$
  LANGUAGE sql VOLATILE;
