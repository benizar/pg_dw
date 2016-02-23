
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_bucketing(pop_array integer[], buckets integer)
  RETURNS integer[] AS
$BODY$
DECLARE
  result_array integer[];

--temp variables
  tempi integer := 0;
  xbucket integer := 0;
  prevbucket integer := 0;
  tempsum integer :=0;
  x integer;

BEGIN
  FOREACH x IN ARRAY pop_array
  LOOP
    xbucket:=width_bucket(tempi, 0, array_length(pop_array,1)-1, buckets); --All age groups are suposed to start at zero
    
    IF xbucket != prevbucket THEN
      prevbucket:= xbucket;
      tempsum:=0;
      --RAISE NOTICE 'Start new bucket = %',xbucket;
      tempsum:=tempsum+x;
    ELSE
      --RAISE NOTICE 'xbucket = %',xbucket;
      tempsum:=tempsum+x;
    END IF;

    result_array[xbucket] := tempsum;
    tempi:=tempi+1;

  END LOOP;

  result_array:=array_remove(result_array,NULL);
  --Merge last and before last binds when we get an extra bucket (+100)
  IF (array_upper(result_array, 1)=buckets+1) THEN
    result_array[array_upper(result_array, 1)-1]:=result_array[array_upper(result_array, 1)-1]+result_array[array_upper(result_array, 1)];
    result_array[array_upper(result_array, 1)]:=NULL;
    result_array:=array_remove(result_array,NULL);
  END IF;

  RETURN result_array;
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE STRICT;
