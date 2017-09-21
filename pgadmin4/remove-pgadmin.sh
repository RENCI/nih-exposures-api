#!/usr/bin/env bash

docker stop pgadmin
docker rm -fv pgadmin
docker rmi -f thajeztah/pgadmin4:latest

exit 0;