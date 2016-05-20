
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_xx_pop(dms.pyrint)
  RETURNS bigint AS
$BODY$
DECLARE
  xx_arr integer[]:= $1.what_xx;
  s bigint := 0;
  x integer;
BEGIN
  FOREACH x IN ARRAY xx_arr
  LOOP
    s := s + x;
  END LOOP;
  RETURN s;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
