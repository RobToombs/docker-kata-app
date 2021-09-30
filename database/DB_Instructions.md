1. Build a postgres database image from database Dockerfile\
    
    Bring up a console and locate the 'docker-app-kata/database' folder, then run the following command
    
    `docker build -t postgres-db .`
    
    This will generate a docker image based off of the PostgresSQL DockerHub Linux Alpine image, which contains everything you'll need for a Postgres DB.
        
    You should see something like this:

    `    [+] Building 11.4s (5/5) FINISHED
         => [internal] load build definition from Dockerfile                                                                                     0.0s
         => => transferring dockerfile: 193B                                                                                                     0.0s
         => [internal] load .dockerignore                                                                                                        0.0s
         => => transferring context: 2B                                                                                                          0.0s
         => [internal] load metadata for docker.io/library/postgres:12.2-alpine                                                                  1.0s
         => [1/1] FROM docker.io/library/postgres:12.2-alpine@sha256:9ea72265275674225b1eaa2ae897dd244028af4ee7ef6e4e89fe474938e0992e           10.3s
         => => resolve docker.io/library/postgres:12.2-alpine@sha256:9ea72265275674225b1eaa2ae897dd244028af4ee7ef6e4e89fe474938e0992e            0.0s
         => => sha256:7421834e2eae283f829d3face39acba2e8ffbe24be756f7cabdfe778e7bfec57 1.99kB / 1.99kB                                           0.0s
         => => sha256:cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08 2.81MB / 2.81MB                                           1.2s
         => => sha256:e36a19831e31f1aa75ef228b7a788b936a99bd97f74d7a6967e4379bd807d680 115B / 115B                                               0.2s
         => => sha256:9ea72265275674225b1eaa2ae897dd244028af4ee7ef6e4e89fe474938e0992e 1.65kB / 1.65kB                                           0.0s
         => => sha256:b52a8a2ca21a6b2f35ce4b89cf728e4fa7d53206b2a18ab3fa1a285e0bfe4726 1.25kB / 1.25kB                                           0.1s
         => => sha256:ae192c4d3adaebbbf2f023e1e50eaadfabccb6b08c855ac13d6ce2232381a58a 7.64kB / 7.64kB                                           0.0s
         => => sha256:f4dcdeed24b7e79c441b7b6de4c85a6979201d6862a29e33455036c70756fcae 56.97MB / 56.97MB                                         8.9s
         => => sha256:e261f2444b0ab97ec8d198c446cda0c4b1236b0cdd1fe5ea129f99859be70938 8.21kB / 8.21kB                                           0.5s
         => => sha256:0ff301de3ecfeb2c06df11938a303b7e7f3d321b619a80b697f983127c4e5563 129B / 129B                                               0.8s
         => => sha256:1d858bf02c95335e7e85407bbdec4fe51d6d313be1ca3fe6079bc57652f4a982 164B / 164B                                               1.0s
         => => sha256:7958b7df2951ee799b326792148ebd316577984f499fb12d2c8a0d3ee2386624 4.26kB / 4.26kB                                           1.2s
         => => extracting sha256:cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08                                                0.1s
         => => extracting sha256:b52a8a2ca21a6b2f35ce4b89cf728e4fa7d53206b2a18ab3fa1a285e0bfe4726                                                0.0s
         => => extracting sha256:e36a19831e31f1aa75ef228b7a788b936a99bd97f74d7a6967e4379bd807d680                                                0.0s
         => => extracting sha256:f4dcdeed24b7e79c441b7b6de4c85a6979201d6862a29e33455036c70756fcae                                                1.0s
         => => extracting sha256:e261f2444b0ab97ec8d198c446cda0c4b1236b0cdd1fe5ea129f99859be70938                                                0.0s
         => => extracting sha256:0ff301de3ecfeb2c06df11938a303b7e7f3d321b619a80b697f983127c4e5563                                                0.0s
         => => extracting sha256:1d858bf02c95335e7e85407bbdec4fe51d6d313be1ca3fe6079bc57652f4a982                                                0.0s
         => => extracting sha256:7958b7df2951ee799b326792148ebd316577984f499fb12d2c8a0d3ee2386624                                                0.0s
         => exporting to image                                                                                                                   0.0s
         => => exporting layers                                                                                                                  0.0s
         => => writing image sha256:73c9e7144d062154c19861fda88413c80787566eb643b38f5563dbcac523b71f                                             0.0s
         => => naming to docker.io/library/postgres-db                                                                                           0.0s
    `
    
2. Verify that the image has been created
    
    `docker image list -a`
    
    You should see something like this:
    
    | REPOSITORY | TAG | IMAGE ID | CREATED | SIZE |
    | :---: | :---: | :---: | :---: | :---: |
    | postgres-db | latest | 73c9e7144d06 | 6 months ago | 152MB |
    
3. Create a Docker container from our new image

    `docker create -p 5432:5432 --name kata-postgres-container postgres-db`
    
    This creates a container where the container's TCP port 5432 will be mapped to port 5432 on the Docker host. For clarity, `-p 8080:80` would map TCP port 80 in the container to port 8080 on the Docker host.
    
    The name of the container will be `kata-postgres-container` and it is generated from our `postgres-db` image.

    Once created, the container ID will be output like this:
    
    `$ docker create -p 5432:5432 --name kata-postgres-container postgres-db`\
    `89084e24598bc456635ddfd89482f5c4cf7258572804dd0ffd96259d7736c673`
    
4. Verify that the container has been created

    `docker container list -a`
       
    You should see something like this:
    
    | CONTAINER ID | IMAGE | COMMAND | CREATED | STATUS | PORTS | NAMES |
    | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
    | 89084e24598b | postgres-db | "docker-entrypoint.s…" | 9 minutes ago | Created |  | kata-postgres-container |

5. Start our Postgres DB container

    `docker start kata-postgres-container`

6. Verify that the container has started

    `docker container list -a`
    
    | CONTAINER ID | IMAGE | COMMAND | CREATED | STATUS | PORTS | NAMES |
    | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
    | 89084e24598b | postgres-db | "docker-entrypoint.s…" | 9 minutes ago | Up About a minute | 0.0.0.0:5432->5432/tcp | kata-postgres-container |
    
7. Verify that you can connect to the postgres datasource using `psql`

    `docker exec -it postgres-db psql -U postgres`

    Use password: `admin` if prompted
    
    
8. Exit out of `psql`, stop the container using:

    `docker stop kata-postgres-container`
    
    and verify that you can no longer connect to the datasource:
    
    `$ psql -d postgres -U postgres`\
    `psql: error: could not connect to server: could not connect to server: Connection refused (0x0000274D/10061)`\
    `         Is the server running on host "localhost" (::1) and accepting`\
    `         TCP/IP connections on port 5432?`\
    `could not connect to server: Connection refused (0x0000274D/10061)`\
    `         Is the server running on host "localhost" (127.0.0.1) and accepting`\
    `         TCP/IP connections on port 5432?`\
    
