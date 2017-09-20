#!/usr/bin/env bash

docker run -d -p 5050:5050 --name pgadmin thajeztah/pgadmin4:latest &

exit 0;