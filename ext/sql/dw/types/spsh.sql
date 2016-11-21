
/*
*  Add comments
* Extend these types by using an extension (e.g. pg_popyramids)
*/
CREATE TYPE ods.spsh_meta AS
(
	clabel text, --column name
	ctype text --column data type (text, int, float, int4range, etc) that can be queries if necessary
);

CREATE TYPE ods.spsh AS
(
	name text, --spreadsheet name
	colmeta ods.spsh_meta[], --Required one item per column
	a anyarray,
	b anyarray,
	c anyarray
);



