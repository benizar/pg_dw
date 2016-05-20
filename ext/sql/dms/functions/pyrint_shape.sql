
/*
 *  Add comments
 */
CREATE OR REPLACE FUNCTION dms.pyrint_shape(raw_data dms.pyrint)
  RETURNS dms.pyrshapes AS
$BODY$
DECLARE

  shape geometry;
  --Predefined shapes 
  pyramid geometry;
  tornado geometry;
  star geometry;
  bell geometry;

  tempshape dms.pyrshapes;
  tempdistance double precision;
  result dms.pyrshapes;

BEGIN

  shape:=dms.pyrint_geom(raw_data);

  pyramid:=st_geomfromtext('LINESTRING(-30 33,-15 66,-5 99,5 99,15 66,30 33)');
  tornado:=st_geomfromtext('LINESTRING(-5 33,-15 66,-30 99,30 99,15 66,5 33)');
  star:=st_geomfromtext('LINESTRING(-12.5 33,-25 66,-12.5 99,12.5 99,25 66,12.5 33)');
  bell:=st_geomfromtext('LINESTRING(-20 33,-20 66,-10 99,10 99,20 66,20 33)');

  --Start by comparing a pyramid shape
  tempdistance:= st_hausdorffdistance(shape,pyramid);
  tempshape:='pyramid'::dms.pyrshapes;
  
CASE
    WHEN st_hausdorffdistance(shape,tornado) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,tornado);
      tempshape:='tornado'::dms.pyrshapes;
    WHEN st_hausdorffdistance(shape,star) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,star);
      tempshape:='star'::dms.pyrshapes;
    WHEN st_hausdorffdistance(shape,bell) < tempdistance THEN
      tempdistance:= st_hausdorffdistance(shape,bell);
      tempshape:='bell'::dms.pyrshapes;
    ELSE
      tempshape:='other'::dms.pyrshapes;
        
END CASE;


  result:=tempshape;

  RETURN result;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
