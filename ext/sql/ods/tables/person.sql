
--DROP FUNCTION IF EXISTS ods.search_person_by_term(search text);
--DROP FUNCTION IF EXISTS ods.person_full_name(person ods.person);
--DROP TABLE IF EXISTS ods.person;


CREATE SEQUENCE ods.person_id_seq;

CREATE TABLE ods.person (
	id             integer NOT NULL DEFAULT nextval('ods.person_id_seq') PRIMARY KEY,

	first_name     text DEFAULT 'Name'||nextval('ods.person_id_seq') NOT NULL,
	last_name      text DEFAULT 'Lastname'||nextval('ods.person_id_seq') NOT NULL,
	email        text DEFAULT 'name.lastname'||nextval('ods.person_id_seq')||'@default.def' NOT NULL,
	about          text DEFAULT 'No comments.' NOT NULL,
  	tags           text[] DEFAULT '{untagged}' NOT NULL,

	loaded_at      timestamp DEFAULT now() NOT NULL,
	updated_at     timestamp DEFAULT now() NOT NULL,

	CONSTRAINT first_name_length  CHECK (char_length(first_name) < 80),
	CONSTRAINT last_name_length   CHECK (char_length(last_name) < 80),
	CONSTRAINT about_length       CHECK (char_length(about) < 2000)
);

ALTER SEQUENCE ods.person_id_seq OWNED BY ods.person.id;


comment on table ods.person is 'A user of the datawarehouse.';
comment on column ods.person.id is 'The primary unique identifier for the person.';


/*
* SAMPLE DATA. DELETE THIS WHEN YOUR DATABASE IS IN PRODUCTION
* TODO: clean function.
*/
INSERT INTO ods.person DEFAULT VALUES;


/*
* ods.person_full_name(person ods.person)
*/
create OR REPLACE function ods.person_full_name(person ods.person) returns text as $$
  select person.first_name || ' ' || person.last_name
$$ language sql stable;


comment on function ods.person_full_name(ods.person) is 'A person’s full name which is a concatenation of their first and last name.';


/*
* ods.search_person_by_term(search text)
*/
create OR REPLACE function ods.search_person_by_term(search text) returns setof ods.person as $$
  select person.*
  from ods.person as person
  where person.first_name ilike ('%' || search || '%') or 
person.last_name ilike ('%' || search || '%') or 
person.email ilike ('%' || search || '%') OR
person.about ilike ('%' || search || '%')
$$ language sql stable;

comment on function ods.search_person_by_term(text) is 'Returns persons containing a given search term.';
