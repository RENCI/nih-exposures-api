## Database

For the purposes of this project the development database will be run locally using Docker.

PostgreSQL 9.6 + PostGIS 2.3

### Populate Sample Data

See [data-sample/README.md](../data-sample/README.md) for more information.


### Invoking the Database

Assumptions

- You are running on a platform where Docker and docker-compose is installed
- You are using an account that has rights to run Docker

From the `database/` directory:

```
./run-database.sh
```

Example:

```
$ ./run-database.sh
Building database
Step 1/11 : FROM centos:7
 ---> 328edcd84f1b
Step 2/11 : MAINTAINER Michael J. Stealey <michael.j.stealey@gmail.com>
 ---> Running in 51bea6198516
 ---> a1eb7c0796b4
...
Step 11/11 : CMD run
 ---> Running in d2d87b4af766
 ---> 8232889c9a9c
Removing intermediate container d2d87b4af766

Successfully built 8232889c9a9c
Successfully tagged database_database:latest
Creating database ...
Creating database ... done
```

### Remove the Database

Attempts to stop and remove any database related containers and images.

From the `database/` directory:

```
./remove-database.sh
```

Example:

```
$ ./remove-database.sh
Stopping database ... done
Going to remove database
Removing database ... done
Untagged: database_database:latest
Deleted: sha256:68b0712343560e626f948990e423d1ede0a8b7f907f08223a476db2116629bb8
Deleted: sha256:cffb428996a128eab7cce732f63031bae4e843d37bde82e2dbbba60b796cc628
Deleted: sha256:dab1367327df0e4b64c76a9a2b8f8180251271d65c83e0b271e1001138d2752e
Deleted: sha256:dcceab6321556d3480e206debcf49932419a333f60119f2ae70c9d0efdff9cf2
Deleted: sha256:6f4f46991a3a8999989c06fc2737f75ed5f0216fa211eb6c43f91d532ef3c80c
Deleted: sha256:ff31bdb873fc40c0f7dcad66b83bb2fa0da104e1473493b5e4b2cd0ce2e7ef6a
Deleted: sha256:2f9a7c8f8198c8eae3ddb4a17188e7d7b768587873753e2e3853b02819d64c5a
Deleted: sha256:97ce164447344f6317a23a71ae2fc1c83895b455d379f435329e5aa7bc44a87a
Deleted: sha256:8cad8239e1b2f9eb7e7f7aafd0cad26932e70f57a333e0a4fb691cc90c3053de
Deleted: sha256:d986464d83c0af4dc1871eeaf72ac0af5a645a78ff82f9f2cd0d1e5fd8d63dad
Deleted: sha256:52cf0469f1fd4810e941edc7f353c49b1243001ada8210018b6b31684e451efd
Deleted: sha256:d07be6756404b2caaa310f304ea72351cff7e48429d997e7f3d5a628968a1668
Untagged: centos:7
Untagged: centos@sha256:26f74cefad82967f97f3eeeef88c1b6262f9b42bc96f2ad61d6f3fdf544759b8
Deleted: sha256:328edcd84f1bbf868bc88e4ae37afe421ef19be71890f59b4b2d8ba48414b84d
Deleted: sha256:b362758f4793674edb79ec5c7192074b2eacf200c006e127069856484526ccf2
```
