
/*
* Add comments
* TODO: Replace age_groups by specific breaks and columns to bucket
*/
CREATE OR REPLACE FUNCTION dms.spsh_bucketing(raw_data dms.spsh, age_groups text)
  RETURNS dms.spsh AS
$BODY$
DECLARE

result dms.spsh; -- Return a new spsh

BEGIN

result.col_a:=raw_data.col_a;
result.col_b:=raw_data.col_b;
result.col_c:=raw_data.col_c;


IF age_groups = 'Raw data' THEN
    result.col_a:=raw_data.col_a;
    result.col_b:=raw_data.col_b;
    result.col_c:=raw_data.col_c;
ELSIF age_groups = '5 years' THEN
    result.col_a:=dms.array_bucketing(result.col_a,20);
    result.col_b:=dms.array_bucketing(result.col_b,20);
    result.col_c:=dms.array_bucketing(result.col_c,20);
ELSIF age_groups = '10 years' THEN
    result.col_a:=dms.array_bucketing(result.col_a,10);
    result.col_b:=dms.array_bucketing(result.col_b,10);
    result.col_c:=dms.array_bucketing(result.col_c,10);
ELSIF age_groups = 'Big groups' THEN
    result.col_a:=dms.array_bucketing(result.col_a,3);
    result.col_b:=dms.array_bucketing(result.col_b,3);
    result.col_c:=dms.array_bucketing(result.col_c,3);
END IF;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
