#!/usr/bin/env bash

# Local development sample data from 2011 only
# Production adaptation will vary significantly from this

source ../../database.cfg

# create cmaq-functions.sql file
cat cmaq-indices.sql > cmaq-functions.sql
echo '' >> cmaq-functions.sql
echo '\di;' >> cmaq-functions.sql
echo '' >> cmaq-functions.sql
cat cmaq-grid-size.sql >> cmaq-functions.sql
cat cmaq-o3-pmij-stats-row.sql >> cmaq-functions.sql
echo '' >> cmaq-functions.sql
echo '\df cmaq*;' >> cmaq-functions.sql
echo '' >> cmaq-functions.sql

# load cmaq-functions.sql to backend container:
docker cp cmaq-functions.sql ${DB_CONTAINER_NAME}:/cmaq-functions.sql

# ingest sample data into cmaq table
docker exec -u postgres ${DB_CONTAINER_NAME} psql ${DB_NAME} -f cmaq-functions.sql

# wait for indices to populate
echo "The postgres functions can now be used to populate statistical information"

exit 0;
