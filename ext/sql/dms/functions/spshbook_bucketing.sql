

/*
*  Add comments
*/
CREATE OR REPLACE FUNCTION dms.spshbook_bucketing(databook dms.spsh[], age_groups text)
  RETURNS dms.spsh[] AS
$BODY$
DECLARE

  result dms.spsh[];
--temp variables
  tempi integer := 1;
  x dms.spsh;

BEGIN

  FOREACH x IN ARRAY databook
  LOOP

    result[tempi] := dms.spsh_bucketing(x,age_groups);
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;


