

/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_total_pop(dms.pyrint)
  RETURNS bigint AS
$BODY$
DECLARE
  pop_arr integer[]:= $1.what_xy||$1.what_xx;
  s bigint := 0;
  x integer;
BEGIN
  FOREACH x IN ARRAY pop_arr
  LOOP
    s := s + x;
  END LOOP;
  RETURN s;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE


