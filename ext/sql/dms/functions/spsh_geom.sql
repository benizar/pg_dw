

/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.spsh_geom(raw_data dms.spsh)
  RETURNS geometry AS
$BODY$
DECLARE

  percentages dms.spsh;
  result geometry;
--temp variables
  coordstep integer:=0;
  tempi integer := 0;
  y numeric;
  x numeric;
  geom text:='LINESTRING(';

BEGIN

percentages:=dms.spsh_percentages(dms.spsh_bucketing(raw_data, 'Big groups'::dms.pyrages));

  coordstep:= round(100/array_length(percentages.col_b,1));
  tempi:=coordstep;


  FOREACH y IN ARRAY percentages.col_b
  LOOP

    geom:=geom|| '-' || y || ' ' ||tempi ||',';
    
    tempi:=tempi+coordstep;

  END LOOP;

  --Add an aditional vertex for visual appeal
  --geom := geom||'0 100,';


  FOREACH x IN ARRAY dms.array_reverse(percentages.col_c)
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


