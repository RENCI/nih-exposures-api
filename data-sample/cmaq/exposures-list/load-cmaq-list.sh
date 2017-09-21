#!/usr/bin/env bash

source ../../database.cfg

# load cmaq_sample.csv and cmaq_sample.sql to backend container:
#docker cp /projects/water/nc-collab/lisa_work/cmaq2011.csv database:/cmaq_sample.csv
docker cp cmaq-list.csv ${DB_CONTAINER_NAME}:/cmaq-list.csv
docker cp cmaq-list.sql ${DB_CONTAINER_NAME}:/cmaq-list.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-list.sql

exit 0;
