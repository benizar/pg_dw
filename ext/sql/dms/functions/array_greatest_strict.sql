

/*
*  Add comments
*/
CREATE OR REPLACE FUNCTION dms.array_greatest_strict(VARIADIC anyarray)
  RETURNS anyelement AS
$BODY$
  SELECT unnest($1) 
    ORDER BY 1 DESC NULLS FIRST 
    LIMIT 1 
$BODY$
  LANGUAGE sql VOLATILE;


