
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrintarray_percentages(raw_data dms.pyrint[])
  RETURNS dms.pyrfloat[] AS
$BODY$
DECLARE

  result dms.pyrfloat[];
--temp variables
  tempi integer := 1;
  x dms.pyrint;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.pyrint_percentages(x);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
