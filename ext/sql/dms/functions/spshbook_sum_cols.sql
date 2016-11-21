
/*
* Sum several arrays from several spsh from a spshbook
*/
CREATE OR REPLACE FUNCTION dms.sum_spshbook_cols(raw_data ods.spsh[])
  RETURNS integer[] AS
$BODY$
DECLARE

  result integer[];
--temp variables
  tempi integer := 1;
  x dms.spsh;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.sum_spsh_cols(x);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
