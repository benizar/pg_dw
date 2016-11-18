

/*
* Create a data_pool child table
*/
CREATE OR REPLACE FUNCTION ods.create_data_child(t_name text)
  RETURNS VOID AS
$func$
BEGIN

EXECUTE format('CREATE TABLE IF NOT EXISTS %I () inherits (ods.data_pool);', 'ods.' || t_name);

END
$func$ LANGUAGE plpgsql;


