

/*
*  Add comments
*/
CREATE OR REPLACE FUNCTION dms.array_indexof(anyarray, anyelement)
  RETURNS integer AS
$BODY$ 
  SELECT i 
     FROM generate_subscripts($1,1) g(i) 
    WHERE $1[i] = $2 
    LIMIT 1
$BODY$
  LANGUAGE sql VOLATILE;


