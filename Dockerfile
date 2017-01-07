FROM benizar/postgis-ext:9.6-2.3
MAINTAINER Benito Zaragozí <benizar@gmail.com>

######################
# Versions and sources
######################
#from https://github.com/benizar/
ENV SOURCE https://github.com/benizar/
ENV ADM https://github.com/benizar/pg_adm.git
ENV GEOHASH https://github.com/benizar/pg_geohash_extra.git
ENV BEDQUILT https://github.com/benizar/bedquilt-core.git
ENV DW https://github.com/benizar/pg_dw.git


################
# Install pg_adm
################
WORKDIR /install-ext
RUN git clone $ADM
WORKDIR /install-ext/pg_adm
RUN make install

#################
# Install geohash
#################
WORKDIR /install-ext
RUN git clone $GEOHASH
WORKDIR /install-ext/pg_geohash_extra
RUN make
RUN make install

#################
# Install postpic
#################
#RUN apt-get install -y libgraphicsmagick-dev
# Need to complete

#################
# Install bedquilt
#################
WORKDIR /install-ext
RUN git clone $BEDQUILT
WORKDIR /install-ext/bedquilt-core
RUN make install

################
# Install pg_dw
################
WORKDIR /install-ext
RUN git clone $DW
WORKDIR /install-ext/pg_dw
RUN make install


WORKDIR /install-ext
ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh


WORKDIR /
RUN rm -rf /install-ext

##################
# backup scripts #
##################

ADD /dbutils/backup.sh /usr/local/bin/backup
ADD /dbutils/restore.sh /usr/local/bin/restore
ADD /dbutils/list-backups.sh /usr/local/bin/list-backups
ADD /dbutils/shell.sh /usr/local/bin/shell

# make them executable
RUN chmod +x /usr/local/bin/restore
RUN chmod +x /usr/local/bin/list-backups
RUN chmod +x /usr/local/bin/backup
RUN chmod +x /usr/local/bin/shell

