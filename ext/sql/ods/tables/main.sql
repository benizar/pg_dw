
/*
* who_uploaded: Name or nick name of the person who uploaded the data.
* what_project: Full name of the census project.
* what_data: Data describing a population pyramid. It is an array of pyrint objects (e.g. population by age, sex and nationality would have one pyrint object for each nationality considered).
* where_geoname: A place name associated to the pyramid.
* where_boundary: A polygon describing the area represented in the pyramid.
* where_centroid: The where_boundary's centroid for mapping purposes.
* when_reference: Reference date for the census project.
* when_accessed: When data was downloaded from a public repository.
* whose_provider: Full name of the organization that collected the census data.
* Whose_url: Provider's main web page.
* pid: The unique pyramid identifier.
* what_variables: Population or variables describing complex population pyramids (e.g. population by age, sex and nationality).
* what_project_short: Short string describing the project's name. This is for layout purposes.
* whose_provider_short: Short string describing the provider's name. This is for layout purposes.
*/

CREATE TABLE ods.main
(
  pid serial NOT NULL,
  who_uploaded text NOT NULL,
  what_project text NOT NULL,
  what_project_short text NOT NULL,
  what_data ods.pyrint[] NOT NULL,
  what_variables ods.pyrvars[] NOT NULL,
  where_geoname text NOT NULL,
  where_boundary geometry NOT NULL,
  where_centroid geometry NOT NULL,
  when_reference date NOT NULL,
  when_accessed timestamp with time zone NOT NULL,
  whose_provider text NOT NULL,
  whose_provider_short text NOT NULL,
  whose_url text NOT NULL,

  CONSTRAINT main_pkey PRIMARY KEY (pid)
)
WITH (
  OIDS=FALSE
);

--TODO: Insert some nice sample data.

