
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.spshbook_percentages(raw_data dms.spsh[])
  RETURNS dms.spsh[] AS
$BODY$
DECLARE

  result dms.spsh[];
--temp variables
  tempi integer := 1;
  x dms.spsh;

BEGIN

  FOREACH x IN ARRAY raw_data
  LOOP

    result[tempi] := dms.spsh_percentages(x);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
