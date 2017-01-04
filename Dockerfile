FROM benizar/postgis-ext
MAINTAINER Benito Zaragozí <benizar@gmail.com>

######################
# Versions and sources
######################
#from https://github.com/benizar/
ENV SOURCE https://github.com/benizar/
ENV DW https://github.com/benizar/pg_dw.git


##############
# Installation
##############

# Ensure the package repository is up to date
RUN apt-get update

################
# Install pg_adm
################
WORKDIR /install-ext
RUN git clone $DW
WORKDIR /install-ext/pg_dw
RUN make install


WORKDIR /install-ext
ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh


WORKDIR /
RUN rm -rf /install-ext


