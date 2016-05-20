FROM postgres:9.5
MAINTAINER Benito Zaragozí <benizar@gmail.com>

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2+dfsg-1.pgdg80+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

# pg_popyramids install
RUN apt-get update
RUN apt-get install -y build-essential checkinstall ca-certificates git postgresql-server-dev-9.5

# copy and compile pg_popyramids
COPY /ext/ /pg_popyramids/

RUN cd pg_popyramids &&\ 
	make &&\ 
	make install &&\
	cd .. &&\
	rm -Rf pg_popyramids

# clean packages
#RUN apt-get remove -y build-essential checkinstall ca-certificates git postgresql-server-dev-9.5

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-pg_popyramids.sh /docker-entrypoint-initdb.d/pg_popyramids.sh
