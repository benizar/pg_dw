

/*
*  Add comments
*/
CREATE OR REPLACE FUNCTION dms.array_subtraction(anyarray, anyarray)
  RETURNS anyarray AS
$BODY$
  SELECT ARRAY(SELECT unnest($1) 
               EXCEPT 
               SELECT unnest($2))
$BODY$
  LANGUAGE sql VOLATILE;


