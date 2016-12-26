
-- Test if an argument is an integer
CREATE FUNCTION adm.is_int(data_to_test text) RETURNS boolean AS $$
	SELECT data_to_test ~ '^[0-9]+$'
$$
LANGUAGE SQL IMMUTABLE;

COMMENT ON FUNCTION adm.is_int(data_to_test text) IS 'Test if a value is in fact an integer';
