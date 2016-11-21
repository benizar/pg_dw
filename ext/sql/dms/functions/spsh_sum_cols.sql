

/*
* Sum several arrays from a spsh
* TODO: check coldata type
* TODO: add a parameter for specifying what columns to sum
*/
CREATE OR REPLACE FUNCTION dms.sum_spsh_cols(ods.spsh)
  RETURNS integer AS
$BODY$
DECLARE
  catcols integer[]:= $1.b||$1.c;
  s integer := 0;
  x integer;
BEGIN
  FOREACH x IN ARRAY catcols
  LOOP
    s := s + x;
  END LOOP;
  RETURN s;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE


