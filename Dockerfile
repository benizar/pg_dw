FROM mdillon/postgis:9.6
MAINTAINER Benito Zaragozí <benizar@gmail.com>

# pg_popyramids install
RUN apt-get update
RUN apt-get install -y build-essential checkinstall postgresql-server-dev-9.6

# copy and compile pg_popyramids
COPY /ext/ /pg_popyramids/

RUN cd pg_popyramids &&\ 
	make &&\ 
	make install &&\
	cd .. &&\
	rm -Rf pg_popyramids

# clean packages
#RUN apt-get remove -y build-essential checkinstall postgresql-server-dev-9.6

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-pg_popyramids.sh /docker-entrypoint-initdb.d/pg_popyramids.sh



# add backup scripts
ADD /dbutils/backup.sh /usr/local/bin/backup  
ADD /dbutils/restore.sh /usr/local/bin/restore  
ADD /dbutils/list-backups.sh /usr/local/bin/list-backups  
ADD /dbutils/shell.sh /usr/local/bin/shell

# make them executable
RUN chmod +x /usr/local/bin/restore  
RUN chmod +x /usr/local/bin/list-backups  
RUN chmod +x /usr/local/bin/backup  
RUN chmod +x /usr/local/bin/shell
