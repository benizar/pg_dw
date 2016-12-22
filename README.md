# pg_dw
A PostgreSQL extension for creating a minimalistic datawarehouse.

## Docker Compose
docker-compose build
docker-compose up
docker-compose down

## Dockerfiles
Instructions for installation and deployment are detailed in the Dockerfile. A ready to run version is available at Docker Hub. Just run it as:

    docker run -d -p 5433:5432 --name pg_dw -e POSTGRES_PASSWORD=postgres -d benizar/pg_dw

## Sample data
Several tables have initial values for testing purposes...

You can upload some sample data from these repositories:


## Future work
* New functionalities:
  * Log usage statistics (e.g. user/usage maps and bounding box statistics).
* Improve features:
  * In PostgreSQL 9.5 we can create customized range queries for big range groups.
  * Improve the pyramid classification methods.
* Data:
  * Compile a detailed list of available sources.
  * Import more and more Open Data
