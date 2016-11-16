
/*
* backers_list
*/
CREATE TABLE ods.backers_list (
	id serial PRIMARY KEY,
	nickname text UNIQUE NOT NULL,
	firstname text NOT NULL,
	lastname text NOT NULL
);

-- INSERT INTO ods.backers_list (nickname, firstname, lastname) VALUES ('benizar', 'Benito','zaragozí');
