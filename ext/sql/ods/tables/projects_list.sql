
/*
* projects_list
*/
CREATE TABLE ods.projects_list (
	id serial PRIMARY KEY,
	longname text UNIQUE NOT NULL,
	shortname text UNIQUE NOT NULL,
	loadate date DEFAULT CURRENT_DATE NOT NULL,
	refdate date NOT NULL,

	backer_id integer NOT NULL REFERENCES ods.backers_list,
	provider_id integer NOT NULL REFERENCES ods.providers_list
);

-- INSERT INTO ods.projects_list (longname, shortname, loadate, refdate, bakers_id, providers_id) VALUES ('Estadística del Padrón Continuo a 1 de enero de 2015. Datos a nivel nacional, comunidad autónoma y provincia', 'padron_2015_ccaa', CURRENT_DATE, '2015-1-1', 1, 1);


