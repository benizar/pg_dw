# pg_dw
A PostgreSQL extension for creating a minimalistic datawarehouse.

## Docker Compose
docker-compose build
docker-compose up
docker-compose down

## Dockerfiles
Instructions for installation and deployment are detailed in the Dockerfile. A ready to run version is available at Docker Hub. Just run it as:

    docker run -d -p 5433:5432 --name pg_dw -e POSTGRES_PASSWORD=postgres -d benizar/pg_dw


## Future work
* New functionalities:
  * Log usage statistics (e.g. user/usage maps and bounding box statistics).
* Improve features:
  * Since PostgreSQL 9.5 we can create customized range queries for big range groups.
  * Improve classification methods.
* Data:
  * Compile a detailed list of available sources.
  * Import more and more data
