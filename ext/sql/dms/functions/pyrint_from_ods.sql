
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_from_ods(raw_data ods.pyrint)
  RETURNS dms.pyrint AS
$BODY$
DECLARE

  result dms.pyrint;

BEGIN

result.what_age:=raw_data.what_age;
result.what_xy:=raw_data.what_xy;
result.what_xx:=raw_data.what_xx;

  RETURN result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
