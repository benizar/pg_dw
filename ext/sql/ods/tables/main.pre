
/*
* backer: Name or nick name of the person who uploaded the data.
* project: Full name of the census project.
* pyrdata: Data describing a population pyramid. It is an array of pyrint objects (e.g. population by age, sex and nationality would have one pyrint object for each nationality considered).
* geoname: A place name associated to the pyramid.
* boundary: A polygon describing the area represented in the pyramid.
* labelpoint: The boundary's point in polygon for mapping purposes (and geohashing).
* refdate: Reference date for the census project.
* loadate: When data was downloaded from a public repository.
* provider: Full name of the organization that collected the census data.
* url: Provider's main web page.
* pid: The unique pyramid identifier.
* pyrvars: Population or variables describing complex population pyramids (e.g. population by age, sex and nationality).
* project_id: Short string describing the project's name. This is for layout purposes.
* provider_id: Short string describing the provider's name. This is for layout purposes.
*/

CREATE TABLE ods.main
(
  pid serial NOT NULL,
  backer text NOT NULL,
  project text NOT NULL,
  project_id text NOT NULL,
  pyrdata ods.pyrint[] NOT NULL,
  pyrvariables ods.pyrvars[] NOT NULL,
  geoname text NOT NULL,
  boundary geometry NOT NULL,
  labelpoint geometry NOT NULL,
  refdate date NOT NULL,
  loadate timestamp with time zone NOT NULL,
  provider text NOT NULL,
  provider_id text NOT NULL,
  url text NOT NULL,

  CONSTRAINT main_pkey PRIMARY KEY (pid)
)
WITH (
  OIDS=FALSE
);

--TODO: Insert some nice sample data.

