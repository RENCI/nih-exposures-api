#!/usr/bin/env bash

# Local development sample data from 2011 only
# Production adaptation will vary significantly from this

source ../../database.cfg

# load form-ald2-aldx-alter-table.sql to backend container:
docker cp form-ald2-aldx-alter-table.sql ${DB_CONTAINER_NAME}:/alter-table.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f alter-table.sql

exit 0;
