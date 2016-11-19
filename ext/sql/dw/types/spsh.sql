
/*
 *  Add comments
 */
CREATE TYPE ods.spsh AS
(
	name text, --spreadsheet name
	meta ods.spsh_meta[], --Required one item per column
	a_col anyelement[],
	b_col anyelement[],
	c_col anyelement[]
);


CREATE TYPE ods.spsh_meta AS
(
	clabel text, --column name
	ctype text --column data type (text, int, float, int4range, etc) that can be queries if necessary
);
