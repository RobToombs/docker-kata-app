1. Build a frontend Http server image from the frontend Dockerfile\
    
    Bring up a console and locate the 'docker-app-kata/frontend' folder, then run the following command
    
    `docker build -t frontend .`
        
    This will generate a docker image based off of the latest Linux Alpine image. It will then update
    the Alpine Linux package management packages, add the Lighttp server packages, and copy our built
    frontend Elm application to the correct server locations.  Bear in mind that you will need to build your application
    before creating your image, or your application files will not be up to date within the image.
    
    You should see something like this:
        
    `   $ docker build -t frontend .
        [+] Building 3.7s (10/10) FINISHED
         => [internal] load .dockerignore                                                                                                                                          0.0s
         => => transferring context: 2B                                                                                                                                            0.0s
         => [internal] load build definition from Dockerfile                                                                                                                       0.0s
         => => transferring dockerfile: 346B                                                                                                                                       0.0s
         => [internal] load metadata for docker.io/library/alpine:latest                                                                                                           0.7s
         => [internal] load build context                                                                                                                                          0.1s
         => => transferring context: 75.51kB                                                                                                                                       0.0s
         => [1/5] FROM docker.io/library/alpine:latest@sha256:c0e9560cda118f9ec63ddefb4a173a2b2a0347082d7dff7dc14272e7841a5b5a                                                     0.8s
         => => resolve docker.io/library/alpine:latest@sha256:c0e9560cda118f9ec63ddefb4a173a2b2a0347082d7dff7dc14272e7841a5b5a                                                     0.0s
         => => sha256:c0e9560cda118f9ec63ddefb4a173a2b2a0347082d7dff7dc14272e7841a5b5a 1.64kB / 1.64kB                                                                             0.0s
         => => sha256:d7342993700f8cd7aba8496c2d0e57be0666e80b4c441925fc6f9361fa81d10e 528B / 528B                                                                                 0.0s
         => => sha256:d6e46aa2470df1d32034c6707c8041158b652f38d2a9ae3d7ad7e7532d22ebe0 1.51kB / 1.51kB                                                                             0.0s
         => => sha256:188c0c94c7c576fff0792aca7ec73d67a2f7f4cb3a6e53a84559337260b36964 2.80MB / 2.80MB                                                                             0.6s
         => => extracting sha256:188c0c94c7c576fff0792aca7ec73d67a2f7f4cb3a6e53a84559337260b36964                                                                                  0.1s
         => [2/5] RUN apk update && apk upgrade                                                                                                                                    0.9s
         => [3/5] RUN apk add --update lighttpd                                                                                                                                    0.9s
         => [4/5] COPY ./web/conf/* /etc/lighttpd/                                                                                                                                 0.0s
         => [5/5] COPY ./web/html/* /var/www/html/                                                                                                                                 0.0s
         => exporting to image                                                                                                                                                     0.1s
         => => exporting layers                                                                                                                                                    0.1s
         => => writing image sha256:a678734c23fb2ee1270ba63a172069d80d753f375f9e2fe287fe09779a7fe614                                                                               0.0s
         => => naming to docker.io/library/frontend 
    `
    
2. Verify that the image has been created
    
    `docker image list -a`
    
    You should see something like this:
    
    | REPOSITORY | TAG | IMAGE ID | CREATED | SIZE |
    | :---: | :---: | :---: | :---: | :---: |
    | frontend | latest | a678734c23fb | 2 minutes ago | 11.5MB |
    
3. Create a Docker container from our new image

    `docker create --name kata-frontend-container -p 9000:80 frontend`
    
    This creates a container where the container's TCP port 80 will be mapped to port 9000 on the Docker host.
        
    The name of the container will be `kata-frontend-container` and it is generated from our `frontend` image.

    Once created, the container ID will be output like this:
    
    `$ docker create --name kata-frontend-container -p 9000:80 frontend`\
     `9ee34eaa87d3194c29ec2af4c40735d08a761f1c0ea2f69b1d8b7d04fbe566a5`

4. Verify that the container has been created

    `docker container list -a`
       
    You should see something like this:
    
    | CONTAINER ID | IMAGE | COMMAND | CREATED | STATUS | PORTS | NAMES |
    | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
    | 9ee34eaa87d3 | frontend | "lighttpd -D -f /etc…" | 36 seconds ago | Created |  | kata-frontend-container |
    
5. Start our frontend Http Server

    `docker start kata-frontend-container`
    
6. Verify that the container has started

    `docker container list -a`
    
    | CONTAINER ID | IMAGE | COMMAND | CREATED | STATUS | PORTS | NAMES |
    | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
    | 9ee34eaa87d3 | frontend | "lighttpd -D -f /etc…" | 5 minutes ago | Up 4 minutes | 0.0.0.0:9000->80/tcp | kata-frontend-container |
    
7. Open a browser and navigate to (http://localhost:9000/)

    Try clicking on 'Fetch New Dog!', and a picture of a dog will appear as well as a banner at the top of the page saying "Bad Status: 404". 
    Open up the network tab of your browser's developer tools, and click 'Fetch New Dog!' again. You should see a successful request made
    to "dog.ceo" API to obtain a random dog picture, and four failed request to our backend. This is because our Http server needs to be
    configured to send our API calls to our backend, our backend container must be up and running, AND these two containers need to know
    about each other! Let's do that now.
    
8. Set up our frontend container's Http server to redirect API calls to our backend container

    Navigate to the Lighttp configuration file located here: "docker-app-kata/frontend/web/conf/lighttpd.conf" and
    uncomment lines 24-26. If try starting up the container with these lines enabled and it can't connect to the backend,
    the container will error out and stop. To have these changes take effect, we would need to recreate our image and container,
    but we will do that in the next step.
