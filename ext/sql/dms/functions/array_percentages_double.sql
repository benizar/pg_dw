
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_percentages(pop_array double precision[], total_pop bigint)
  RETURNS double precision[] AS
$BODY$
DECLARE
  result_array float[];

--temp variables
  tempi integer := 0;
  tempercent float :=0;
  x float;

BEGIN
  FOREACH x IN ARRAY pop_array
  LOOP
    tempercent:=(x*100)/total_pop::float;

    result_array[tempi] := tempercent;
    tempi:=tempi+1;

  END LOOP;
  RETURN result_array;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
