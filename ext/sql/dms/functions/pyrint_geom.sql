
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_geom(raw_data dms.pyrint)
  RETURNS geometry AS
$BODY$
DECLARE

  percentages dms.pyrfloat;
  result geometry;
--temp variables
  coordstep integer:=0;
  tempi integer := 0;
  y numeric;
  x numeric;
  geom text:='LINESTRING(';

BEGIN

percentages:=dms.pyrint_percentages(dms.pyrint_bucketing(raw_data, 'Big groups'::dms.pyrages));

  coordstep:= round(100/array_length(percentages.what_xy,1));
  tempi:=coordstep;


  FOREACH y IN ARRAY percentages.what_xy
  LOOP

    geom:=geom|| '-' || y || ' ' ||tempi ||',';
    
    tempi:=tempi+coordstep;

  END LOOP;

  --Add an aditional vertex for visual appeal
  --geom := geom||'0 100,';


  FOREACH x IN ARRAY dms.array_reverse(percentages.what_xx)
  LOOP

    tempi:=tempi-coordstep;

    geom:=geom||  x ||' '||tempi ||',';
    
    

  END LOOP;

  --Add an aditional vertex for visual appeal
  geom:=regexp_replace(geom, ',$', '');
  geom := geom||')';

  result:=st_geomfromtext(geom,4326);

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
