
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_bucketing(raw_data dms.pyrint, age_groups dms.pyrages)
  RETURNS dms.pyrint AS
$BODY$
DECLARE

  total_pop bigint;
  result dms.pyrint;

BEGIN

result.what_age:=raw_data.what_age;
result.what_xy:=raw_data.what_xy;
result.what_xx:=raw_data.what_xx;

total_pop:=dms.pyrint_total_pop(raw_data);

IF age_groups = 'Raw data' THEN
    result.what_age:=raw_data.what_age;
    result.what_xy:=raw_data.what_xy;
    result.what_xx:=raw_data.what_xx;
ELSIF age_groups = '5 years' THEN
    result.what_age:=dms.array_bucketing(result.what_age,20);
    result.what_xy:=dms.array_bucketing(result.what_xy,20);
    result.what_xx:=dms.array_bucketing(result.what_xx,20);
ELSIF age_groups = '10 years' THEN
    result.what_age:=dms.array_bucketing(result.what_age,10);
    result.what_xy:=dms.array_bucketing(result.what_xy,10);
    result.what_xx:=dms.array_bucketing(result.what_xx,10);
ELSIF age_groups = 'Big groups' THEN
    result.what_age:=dms.array_bucketing(result.what_age,3);
    result.what_xy:=dms.array_bucketing(result.what_xy,3);
    result.what_xx:=dms.array_bucketing(result.what_xx,3);
END IF;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
