
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrintarray_bucketing(raw_data dms.pyrint[], age_groups dms.pyrages)
  RETURNS dms.pyrint[] AS
$BODY$
DECLARE

  result dms.pyrint[];
--temp variables
  tempi integer := 1;
  x dms.pyrint;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.pyrint_bucketing(x,age_groups);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
