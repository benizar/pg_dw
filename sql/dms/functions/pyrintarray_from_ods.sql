CREATE OR REPLACE FUNCTION dms.pyrintarray_from_ods(raw_data ods.pyrint[])
  RETURNS dms.pyrint[] AS
$BODY$
DECLARE

  result dms.pyrint[];
--temp variables
  tempi integer := 1;
  x ods.pyrint;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.pyrint_from_ods(x);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
