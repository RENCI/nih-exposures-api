#!/usr/bin/env bash

# Local development sample data from 2011 only
# Production adaptation will vary significantly from this

source ../../database.cfg

# load cmaq-sample-2011.csv and cmaq_sample.sql to backend container:
docker cp cmaq-sample-2011.csv ${DB_CONTAINER_NAME}:/cmaq-sample.csv
docker cp cmaq-sample.sql ${DB_CONTAINER_NAME}:/cmaq-sample.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-sample.sql

exit 0;
