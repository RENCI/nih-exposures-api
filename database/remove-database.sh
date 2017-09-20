#!/usr/bin/env bash

docker-compose stop database
docker-compose rm -f database
docker rmi -f database_database
docker rmi -f centos:7

exit 0;
