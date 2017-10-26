#!/usr/bin/env bash

source ../../database.cfg

# load cmaq-2010-2011.csv and cmaq_sample.sql to backend container:
docker cp cmaq-sample-2011.csv ${DB_CONTAINER_NAME}:/cmaq-sample.csv
docker cp form-ald2-aldx-alter-table.sql ${DB_CONTAINER_NAME}:/alter-table.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f alter-table.sql

exit 0;
