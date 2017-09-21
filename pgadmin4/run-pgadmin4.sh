#!/usr/bin/env bash

docker run -d -p 5050:5050 --name pgadmin thajeztah/pgadmin4:latest &
sleep 3s
echo "pgAdmin running at http://localhost:5050"

exit 0;