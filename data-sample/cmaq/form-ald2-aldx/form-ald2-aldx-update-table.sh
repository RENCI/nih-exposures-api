#!/usr/bin/env bash

# Local development sample data from 2011 only
# Production adaptation will vary significantly from this

source ../../database.cfg

# load cmaq-update-2011.csv and form-ald2-aldx-update-table.sql to backend container:
docker cp cmaq-update-2011.csv ${DB_CONTAINER_NAME}:/cmaq-update.csv
docker cp form-ald2-aldx-update-table.sql ${DB_CONTAINER_NAME}:/update-table.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f update-table.sql

exit 0;
