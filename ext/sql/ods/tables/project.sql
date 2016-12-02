


--DROP FUNCTION IF EXISTS ods.search_project_by_term(search text);
--DROP TABLE IF EXISTS ods.person;


CREATE SEQUENCE ods.project_id_seq;

CREATE TABLE ods.project (
	id             integer NOT NULL DEFAULT nextval('ods.project_id_seq') PRIMARY KEY,

	creator_id     integer NOT NULL references ods.person(id),
	provider_id    integer NOT NULL references ods.provider(id),

	longname       text DEFAULT 'Default project '||nextval('ods.project_id_seq') NOT NULL UNIQUE,
	shortname      text DEFAULT 'def_proj_'||nextval('ods.project_id_seq') NOT NULL UNIQUE,
	description    text DEFAULT 'No comments.' NOT NULL,
  	tags           text[] DEFAULT '{untagged}' NOT NULL,

	loaded_at      timestamp DEFAULT now() NOT NULL,
	updated_at     timestamp DEFAULT now() NOT NULL,
	refdate        timestamp DEFAULT now() NOT NULL,

	CONSTRAINT name_length       CHECK (char_length(longname) < 200),
	CONSTRAINT shortname_length  CHECK (char_length(shortname) < 20),
	CONSTRAINT description_length   CHECK (char_length(description) < 2000)
);

ALTER SEQUENCE ods.project_id_seq OWNED BY ods.project.id;


/*
* METADATA COMMENTS
*/
COMMENT ON TABLE ods.project IS 'A project uploaded by a user.';
COMMENT ON COLUMN ods.project.id IS 'The primary key for the project.';


/*
* SAMPLE DATA. DELETE THIS WHEN YOUR DATABASE IS IN PRODUCTION
* TODO: clean function.
*/
INSERT INTO ods.project(creator_id, provider_id) VALUES (1, 1);


/*
* FUNCTIONS for ods.project
*/
create function ods.search_project_by_term(search text) returns setof ods.project as $$
  select project.*
  from ods.project as project
  where project.longname ilike ('%' || search || '%') or 
project.shortname ilike ('%' || search || '%') or 
project.description ilike ('%' || search || '%')

$$ language sql stable;

comment on function ods.search_project_by_terms(text) is 'Returns projects containing a given search term.';
