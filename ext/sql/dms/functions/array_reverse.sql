
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_reverse(anyarray)
  RETURNS anyarray AS
$BODY$
SELECT ARRAY(
    SELECT $1[i]
    FROM generate_subscripts($1,1) AS s(i)
    ORDER BY i DESC
);
$BODY$
  LANGUAGE sql IMMUTABLE STRICT;
