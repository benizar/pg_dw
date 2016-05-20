
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_percentages(raw_data dms.pyrint)
  RETURNS dms.pyrfloat AS
$BODY$
DECLARE

  total_pop bigint;
  result dms.pyrfloat;

--temp variables
  tempi integer := 1;
  tempercent float :=0;
  y integer;
  x integer;

BEGIN

result.what_age:=raw_data.what_age;
result.what_xy:=raw_data.what_xy;
result.what_xx:=raw_data.what_xx;

total_pop:=dms.pyrint_total_pop(raw_data);


  FOREACH y IN ARRAY result.what_xy
  LOOP
    tempercent:=(y*100)/total_pop::float;

    result.what_xy[tempi] := tempercent;
    tempi:=tempi+1;

  END LOOP;


  tempi := 1;
  FOREACH x IN ARRAY result.what_xx
  LOOP
    tempercent:=(x*100)/total_pop::float;

    result.what_xx[tempi] := tempercent;
    tempi:=tempi+1;

  END LOOP;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
