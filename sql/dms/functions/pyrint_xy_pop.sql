
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_xy_pop(dms.pyrint)
  RETURNS bigint AS
$BODY$
DECLARE
  xy_arr integer[]:= $1.what_xy;
  s bigint := 0;
  x integer;
BEGIN
  FOREACH x IN ARRAY xy_arr
  LOOP
    s := s + x;
  END LOOP;
  RETURN s;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
