
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.array_bucketing(age_groups int4range[], buckets integer)
  RETURNS int4range[] AS
$BODY$
DECLARE
  result_array int4range[];

--temp variables
  tempi integer := 0;
  xbucket integer := 0;
  prevbucket integer := 0;
  temprange int4range;
  x int4range;

BEGIN
  FOREACH x IN ARRAY age_groups
  LOOP
    xbucket:=width_bucket(tempi, 0, array_length(age_groups,1)-1, buckets); --All age groups are suposed to start at zero; Upper limit must be modified to get the correct ranges 
    
    IF xbucket != prevbucket THEN
      prevbucket:= xbucket;
      temprange:= x;
      --RAISE NOTICE 'Start new bucket = %',xbucket;
    ELSE
      --RAISE NOTICE 'xbucket = %',xbucket;
      temprange:=temprange+x;
    END IF;

    --RAISE NOTICE 'xrange = %',x;
    --RAISE NOTICE 'temprange = %',temprange;

    result_array[xbucket] := temprange;
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
