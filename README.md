# pg_popyramids
A PostgreSQL extension for creating a popyramids database.

Dockerfile
------------
Instructions for installation and deployment are detailed in the Dockerfile. A ready to run version is available at Docker Hub. Just run it as:

    docker run -d -p 5433:5432 --name pg_popyramids -e POSTGRES_PASSWORD=postgres -d chichinabo/pg_popyramids

Sample data
------------
You can upload some sample data from the sample_data folder. Just execute any of the backups containing insert commands. For example, 'ine_prov_2011.sql' will be faster for a first test.

Future work
------------
* New functionalities:
  * Log usage statistics (e.g. user/usage maps and bounding box statistics).
* Improve features:
  * In PostgreSQL 9.5 we can create customized range queries for big range groups.
  * Improve the pyramid classification methods.
* Data:
  * Compile a detailed list of available sources.
  * Import more and more Open Data
