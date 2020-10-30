1. Build a Spring Boot application backend image from backend Dockerfile\
    
    bring up a console and locate the 'docker-app-kata/backend' folder, then run the following command
    
    `docker build -t backend .`
    
    This will generate a docker image based off of the OpenJDK DockerHub Linux Alpine image, which contains a JRE for our application.
    It will also copy our built Spring Boot application files to the correct locations within the image. Bear in mind that you will
    need to build your application before creating your image, or your application files will not be up to date within the image.
    
    You should see something like this:
        
    `   $ docker build -t backend .
        [+] Building 13.4s (10/10) FINISHED
         => [internal] load .dockerignore                                                                                                                                               0.0s
         => => transferring context: 2B                                                                                                                                                 0.0s
         => [internal] load build definition from Dockerfile                                                                                                                            0.0s
         => => transferring dockerfile: 395B                                                                                                                                            0.0s
         => [internal] load metadata for docker.io/library/openjdk:8-jre-alpine                                                                                                         1.1s
         => [1/5] FROM docker.io/library/openjdk:8-jre-alpine@sha256:f362b165b870ef129cbe730f29065ff37399c0aa8bcab3e44b51c302938c9193                                                  11.5s
         => => resolve docker.io/library/openjdk:8-jre-alpine@sha256:f362b165b870ef129cbe730f29065ff37399c0aa8bcab3e44b51c302938c9193                                                   0.0s
         => => sha256:f362b165b870ef129cbe730f29065ff37399c0aa8bcab3e44b51c302938c9193 1.64kB / 1.64kB                                                                                  0.0s
         => => sha256:b2ad93b079b1495488cc01375de799c402d45086015a120c105ea00e1be0fd52 947B / 947B                                                                                      0.0s
         => => sha256:f7a292bbb70c4ce57f7704cc03eb09e299de9da19013b084f138154421918cb4 3.42kB / 3.42kB                                                                                  0.0s
         => => sha256:e7c96db7181be991f19a9fb6975cdbbd73c65f4a2681348e63a141a2192a5f10 2.76MB / 2.76MB                                                                                  1.5s
         => => sha256:f910a506b6cb1dbec766725d70356f695ae2bf2bea6224dbe8c7c6ad4f3664a2 238B / 238B                                                                                      0.1s
         => => sha256:b6abafe80f63b02535fc111df2ed6b3c728469679ab654e03e482b6f347c9639 54.94MB / 54.94MB                                                                               11.0s
         => => extracting sha256:e7c96db7181be991f19a9fb6975cdbbd73c65f4a2681348e63a141a2192a5f10                                                                                       0.1s
         => => extracting sha256:f910a506b6cb1dbec766725d70356f695ae2bf2bea6224dbe8c7c6ad4f3664a2                                                                                       0.0s
         => => extracting sha256:b6abafe80f63b02535fc111df2ed6b3c728469679ab654e03e482b6f347c9639                                                                                       0.4s
         => [internal] load build context                                                                                                                                               0.2s
         => => transferring context: 8.10MB                                                                                                                                             0.2s
         => [2/5] RUN addgroup -S toombs && adduser -S toombs -G toombs                                                                                                                 0.5s
         => [3/5] COPY build/dependency/BOOT-INF/lib /app/lib                                                                                                                           0.1s
         => [4/5] COPY build/dependency/META-INF /app/META-INF                                                                                                                          0.0s
         => [5/5] COPY build/dependency/BOOT-INF/classes /app                                                                                                                           0.0s
         => exporting to image                                                                                                                                                          0.1s
         => => exporting layers                                                                                                                                                         0.1s
         => => writing image sha256:b640d362ed11058926c2c2c60c5c961c270da3e78a2217814f6e7c23c8b8fa55                                                                                    0.0s
         => => naming to docker.io/library/backend    
    `
    
2. Verify that the image has been created
    
    `docker image list -a`
    
    You should see something like this:
    
    | REPOSITORY | TAG | IMAGE ID | CREATED | SIZE |
    | :---: | :---: | :---: | :---: | :---: |
    | backend | latest | b640d362ed11 | 12 minutes ago | 93MB |
    
3. Create a Docker container from our new image

    `docker create -p 8080:8080 --name kata-backend-container backend`
    
    This creates a container where the container's TCP port 8080 will be mapped to port 8080 on the Docker host.
    
    The name of the container will be `kata-backend-container` and it is generated from our `backend` image.

    Once created, the container ID will be output like this:
    
    `$ docker create -p 8080:8080 --name kata-backend-container backend`\
     `bf82adeb1d9fc52e30190aa365f31f7a3d5a46c343481e15d3625ab0c9a7cb6e`

4. Verify that the container has been created

    `docker container list -a`
       
    You should see something like this:
    
    | CONTAINER ID | IMAGE | COMMAND | CREATED | STATUS | PORTS | NAMES |
    | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
    | bf82adeb1d9f | backend | "java -cp app:app/li…" | 4 hours ago | Created |  | kata-backend-container |
    
5. Start our Spring Boot backend application

    `docker start kata-backend-container`
    
    --- Trouble Shooting! ---
    
    So your container built fine, but won't start? Run this command to allow you to fetch logs from containers that failed to start:
    
    `docker events&`
    
    Next, use this command to grab the startup logs from the failing container:
    
    `docker logs <INSERT CONTAINER ID HERE!>`
    
    And you'll see something like this if you originally built your application with Java 11, but are trying to run it on a Java 8 JRE like I initially did....
    
    `$ docker logs bf82adeb1d9fc52e30190aa365f31f7a3d5a46c343481e15d3625ab0c9a7cb6e`\
    `Error: A JNI error has occurred, please check your installation and try again
    Exception in thread "main" java.lang.UnsupportedClassVersionError: com/toombs/backend/BackendApplication has been compiled by a more recent version of the Java Runtime (class file v
    ersion 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
            at java.lang.ClassLoader.defineClass1(Native Method)
            at java.lang.ClassLoader.defineClass(ClassLoader.java:763)
            at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
            at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
            at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
            at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
            at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
            at java.security.AccessController.doPrivileged(Native Method)
            at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
            at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
            at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:495)`
            
6. Chances are that your container did not start, and your console looks like this:

    `Rob@DESKTOP-CLI963P /cygdrive/c/Users/Rob/workspace/docker-app-kata/backend`\
    `$ docker start kata-backend-container
    2020-10-27T21:08:28.096468400-04:00 network connect 1703645018b5d5f60a373377813d34c748a7fdcbcfede3d76c3750a972b7e925 (container=b94a1faf3ec0c21d786a7123fd14b4d00688d5b624c25a3579f5d
    592b20ac990, name=bridge, type=bridge)
    kata-backend-container
    2020-10-27T21:08:28.259103600-04:00 container start b94a1faf3ec0c21d786a7123fd14b4d00688d5b624c25a3579f5d592b20ac990 (image=backend, name=kata-backend-container)`
    
    `Rob@DESKTOP-CLI963P /cygdrive/c/Users/Rob/workspace/docker-app-kata/backend`\
    `$ 2020-10-27T21:08:30.880918300-04:00 container die b94a1faf3ec0c21d786a7123fd14b4d00688d5b624c25a3579f5d592b20ac990 (exitCode=1, image=backend, name=kata-backend-container)
    2020-10-27T21:08:30.997422100-04:00 network disconnect 1703645018b5d5f60a373377813d34c748a7fdcbcfede3d76c3750a972b7e925 (container=b94a1faf3ec0c21d786a7123fd14b4d00688d5b624c25a3579
    f5d592b20ac990, name=bridge, type=bridge)`

    If you take a peek at the startup logs, you'll most likely see the application sputter out when it attempts to connect to the database:
    
    `Unable to obtain connection from database (jdbc:postgresql://kata-postgres-container/postgres) for user 'postgres': The connection attempt failed.`\
    `SQL State  : 08001`\
    `Error Code : 0`\
    `Message    : The connection attempt failed.`
    
    This issue occurs because our backend application lives in a separate container from the database it is trying to communicate 
    with, but can't locate it. We can resolve this problem by creating a docker bridge network, and assigning it to the containers
    but we will instead resolve it using Docker Compose later. Don't worry about this for now.
    
    
