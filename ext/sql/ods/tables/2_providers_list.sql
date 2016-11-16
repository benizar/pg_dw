

/*
* providers_list
*/
CREATE TABLE ods.providers_list (
	id serial PRIMARY KEY,
	longname text UNIQUE NOT NULL,
	shortname text UNIQUE NOT NULL,
	url text UNIQUE NOT NULL
);

-- INSERT INTO ods.providers_list (longname, shortname, url) VALUES ('Instituto Nacional de Estadística', 'INE (Spain)', 'www.ine.es');
