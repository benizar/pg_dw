
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_intersect(anyarray, anyarray)
  RETURNS anyarray AS
$BODY$
  SELECT ARRAY(SELECT unnest($1) 
               INTERSECT 
               SELECT unnest($2))
$BODY$
  LANGUAGE sql VOLATILE;
