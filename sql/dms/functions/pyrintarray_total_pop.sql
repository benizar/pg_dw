
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrintarray_total_pop(raw_data dms.pyrint[])
  RETURNS bigint[] AS
$BODY$
DECLARE

  result bigint[];
--temp variables
  tempi integer := 1;
  x dms.pyrint;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.pyrint_total_pop(x);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
