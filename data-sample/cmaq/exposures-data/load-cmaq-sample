#!/usr/bin/env bash

source ../../database.cfg

# load cmaq_sample.csv and cmaq_sample.sql to backend container:
#docker cp /projects/water/nc-collab/lisa_work/cmaq2011.csv database:/cmaq_sample.csv
docker cp cmaq2011.csv ${DB_CONTAINER_NAME}:/cmaq-sample.csv
docker cp cmaq-sample.sql ${DB_CONTAINER_NAME}:/cmaq-sample.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-sample.sql

exit 0;
