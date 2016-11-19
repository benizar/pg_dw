

/*
 *  TODO: Compare a shape with a list of predefined shapes and return its name
 */
CREATE OR REPLACE FUNCTION dms.match_shapes(shape geometry)
  RETURNS text AS
$BODY$
DECLARE

  --Predefined shapes 
  pyramid geometry;
  tornado geometry;
  star geometry;
  bell geometry;

  tempshape text;
  tempdistance double precision;
  result text;

BEGIN

  pyramid:=st_geomfromtext('LINESTRING(-30 33,-15 66,-5 99,5 99,15 66,30 33)');
  tornado:=st_geomfromtext('LINESTRING(-5 33,-15 66,-30 99,30 99,15 66,5 33)');
  star:=st_geomfromtext('LINESTRING(-12.5 33,-25 66,-12.5 99,12.5 99,25 66,12.5 33)');
  bell:=st_geomfromtext('LINESTRING(-20 33,-20 66,-10 99,10 99,20 66,20 33)');

  --Start by comparing a pyramid shape
  tempdistance:= st_hausdorffdistance(shape,pyramid);
  tempshape:='pyramid';
  
CASE
    WHEN st_hausdorffdistance(shape,tornado) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,tornado);
      tempshape:='tornado';
    WHEN st_hausdorffdistance(shape,star) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,star);
      tempshape:='star';
    WHEN st_hausdorffdistance(shape,bell) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,bell);
      tempshape:='bell';
    ELSE
      tempshape:='other';
        
END CASE;


  result:=tempshape;

  RETURN result;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


