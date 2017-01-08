

--
-- http://dba.stackexchange.com/a/118964
-- SELECT maskunion('public', 'tiles_2015_10_', 'newtable');
--
CREATE OR REPLACE FUNCTION ods.maskunion(_schema text, _tblbase text, _target text)
  RETURNS void AS
$func$
DECLARE
   _safe_target text := quote_ident(_schema) || '.' || quote_ident(_target);
BEGIN
   -- EXECUTE 'DROP TABLE IF EXISTS ' || _safe_target;  -- possibly dangerous!
   -- safer alternative:
   IF to_regclass(_safe_target::cstring) IS NOT NULL THEN
      RAISE EXCEPTION 'Target already exists: >>%<<', _safe_target;
   END IF;

   EXECUTE (
      SELECT 'CREATE TABLE ' || _safe_target || ' AS TABLE '
          || string_agg(quote_ident(schemaname) || '.'
                     || quote_ident(tablename), ' UNION ALL TABLE ')
      FROM   pg_tables
      WHERE  schemaname = _schema
      AND    tablename LIKE (_tblbase || '%')
      ORDER  BY tablename  -- better retain order
   );
END
$func$
LANGUAGE plpgsql;



