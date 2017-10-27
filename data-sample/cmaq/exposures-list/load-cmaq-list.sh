#!/usr/bin/env bash

# Local development sample data from 2011 only
# Production adaptation will vary significantly from this

source ../../database.cfg

# load cmaq-list.csv and cmaq-list.sql to backend container:
docker cp cmaq-list.csv ${DB_CONTAINER_NAME}:/cmaq-list.csv
docker cp cmaq-list.sql ${DB_CONTAINER_NAME}:/cmaq-list.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-list.sql

exit 0;
