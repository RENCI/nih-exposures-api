#!/usr/bin/env bash

# remove pre-existing database and deploy new
cd ../database/
./remove-database.sh
./run-database.sh
cd -
sleep 10s

# setup database
cd ../data-sample/
./setup-exposures-db.sh
cd -

# deploy cmaq-list
cd ../data-sample/cmaq/exposures-list/
./load-cmaq-list.sh
cd -

# deploy cmaq-exposures
cd ../data-sample/cmaq/exposures-data/
./load-cmaq-sample.sh
cd -

exit 0