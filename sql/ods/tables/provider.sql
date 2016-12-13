


--DROP FUNCTION IF EXISTS ods.search_provider_by_term(search text);
--DROP TABLE IF EXISTS ods.provider;


CREATE SEQUENCE ods.provider_id_seq;

CREATE TABLE ods.provider (
	id             integer NOT NULL DEFAULT nextval('ods.provider_id_seq') PRIMARY KEY,

	longname       text DEFAULT 'Default provider '||nextval('ods.provider_id_seq') NOT NULL UNIQUE,
	shortname      text DEFAULT 'def_prov_'||nextval('ods.provider_id_seq') NOT NULL UNIQUE,
	siteurl        text DEFAULT 'http://www.default.def' NOT NULL,
	description    text DEFAULT 'No description.' NOT NULL,
  	tags           text[] DEFAULT '{untagged}' NOT NULL,

	loaded_at      timestamp DEFAULT now() NOT NULL,
	updated_at     timestamp DEFAULT now() NOT NULL,

	CONSTRAINT longname_length      CHECK (char_length(longname) < 200),
	CONSTRAINT shortname_length     CHECK (char_length(shortname) < 20),
	CONSTRAINT description_length   CHECK (char_length(description) < 2000)
);

ALTER SEQUENCE ods.provider_id_seq OWNED BY ods.provider.id;


/*
* METADATA COMMENTS
*/
COMMENT ON TABLE ods.provider IS 'A provider.';
COMMENT ON COLUMN ods.provider.id IS 'The primary key for the provider.';


/*
* SAMPLE DATA. DELETE THIS WHEN YOUR DATABASE IS IN PRODUCTION
* TODO: clean function.
*/
INSERT INTO ods.provider DEFAULT VALUES;


/*
* FUNCTIONS for ods.provider
*/
create function ods.search_provider_by_term(search text) returns setof ods.provider as $$
  select provider.*
  from ods.provider as provider
  where provider.longname ilike ('%' || search || '%') OR
provider.shortname ilike ('%' || search || '%') OR
provider.siteurl ilike ('%' || search || '%') OR
provider.description ilike ('%' || search || '%')
$$ language sql stable;

comment on function ods.search_provider_by_term(text) is 'Returns providers containing a given search term.';
