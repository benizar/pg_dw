--USAGE: SELECT * FROM stage.build_ranges('censo_ccaa_1991_join');

/*
* This function builds...
*/
CREATE OR REPLACE FUNCTION stage.build_ranges(table_name text)
  RETURNS text AS
$BODY$

DECLARE
colnum integer=0;
ranges_query text:='SELECT *, '; --Begin range query with a SELECT
j integer:=0; --Index for range values
step integer:=1;

BEGIN

--Get column count
EXECUTE E'select count(*) from information_schema.columns where table_name='||quote_literal(table_name)||';' INTO colnum;

--Determine whether a colnum is even or not
--Age groups are always paired (men/women+geometry column+ geoname column)
--We first remove any serial column created in the import
IF colnum % 2 = 1 THEN
    colnum:=colnum-1;
ELSE
    colnum:=colnum;
END IF;

-- Substract geoname and geometry columns from count
-- Substract redundant age group (0 <-> 100) to get a divisible number (e.g. 100, 20, etc)
colnum:=colnum-2;


-- Calculate step (e.g. yearly, quinquennial, etc)
step:=round(100/(colnum/2)::numeric);

RAISE NOTICE 'Age grouping (%)', step;
RAISE NOTICE 'Colnum (%)', colnum;

--Build range query
FOR i IN 0..(colnum-1)/2 LOOP

	-- Check if we are in the last iteration. Then, assign 100+.
	IF i < (colnum-1)/2 THEN

		-- While it is not the last iteration build ranges by step (e.g. 1, 4, etc)
		ranges_query:=concat(ranges_query,E'int4range( '||j::text||','||(j+step)::text||',''[)'') AS r_'||j::text||'_'||(j+step)::text||', ' );
		j:=j+step;
	
	ELSE
		--If its the last iteration, range will end with "100".
		ranges_query:=concat(ranges_query,E'int4range( '||j::text||','||'null'::text||',''[)'') AS r_'||j::text );
	END IF;

    
END LOOP;




--Close range query
ranges_query:=ranges_query||' FROM stage.'||table_name;




RETURN ranges_query;

END
$BODY$
LANGUAGE plpgsql 
