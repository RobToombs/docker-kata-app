The purpose of this project is to gain a little familiarity with creating, building, and dockerizing a web application.

I've supplied a pre-built application if you're only looking to play around with docker/docker-compose and don't want
to deal with builds and configurations.

At a bare minimum you should have docker and docker-compose installed on your machine: \
Docker: https://docs.docker.com/get-docker/ \
Docker Compose: https://docs.docker.com/compose/install/

(optional) If you want to be able to build it all yourself, you'll need: \
java (java 13.0.2 2020-01-14) \
node (v12.16.1) \
npm (6.14.8) \
elm (0.19.1) \
gradle (6.7) \
postgres (12.2) \
docker (version 19.03.13) \
docker-compose (version 1.27.4) \
some sort of IDE + terminal (I use IntelliJ and Cygwin)

-----------------------------------------------------------------------------------------------------------------------
1. To begin, we'll walk through the process of creating Docker images and containers for each layer of our application stack \

    Work your way through these three instruction files, then come back here!
    
    - database/DB_Instructions.md
    - backend/Backend_Instructions.md
    - frontend/Frontend_Instructions.md 

    Now you know how to set up the individual containers, it is time to connect them!

2. Stop and remove all active containers

    View running containers:
    
    `docker container list -a`
    
    To stop active containers:

    `docker stop kata-frontend-container` \
    `docker stop kata-backend-container` \
    `docker stop kata-postgres-container`
    
    To remove containers:
    
    `docker rm kata-frontend-container`
    `docker rm kata-backend-container`
    `docker rm kata-postgres-container`
    
3. Stop and remove the images we created earlier

    View created images:
    
    `docker image list -a`
    
    To remove images:
    
    `docker rmi frontend`
    `docker rmi backend`
    `docker rmi postgres-db`

4. Take a look at the docker-compose.yml file:

    By default, compose sets up a single network for our application. If you remember, our backend container was not able
    to talk to our postgres container, and our frontend container could not locate out backend container. You CAN set up a
    network through docker files, but it is easier to use compose.

    The `services` tag contains all the containers which are included in the compose file and acts as 
    their parent tag. `build` indicated which dockerfile should be used to create the container image. `ports` defines 
    which port we want to expose and which host port it should
    be exposed to. `links` define the alias names under which containers can be reached.

5. Create all images/containers, stop all old running containers and create them from scratch:

    `docker-compose up -d --force-recreate`
 
    This will create the images from our dockerfiles, the containers, and the container network in a single command.
    
    The `-d` flag starts the containers up in "detached mode", meaning the containers will run in the background. `--force-recreate`
    means that the containers will always be recreated even if their configuration and image has not changed.

6. Now check out `http://localhost:9000/`

     Click through the 'Fetch New Dog!', 'Like', and 'Dislike' buttons. You'll see that our frontend now makes successful
     calls to our backend application. Our backend application in turn makes successful calls to our container running
     the postgres DB.
     
     If you use `docker exec -it kata-postgres-container psql -U postgres` to log back into the postgres container, you can run `SELECT * FROM dog;` and verify DB content:
     
     `postgres=# SELECT * FROM dog;`
     
   | ID | BREED | CREATE_DATE_TIME | LIKED | UPDATE_DATE_TIME | URL |
   | :---: | :---: | :---: | :---: | :---: | :---: |
   | 1 | puggle | 2020-11-01 23:41:09.525 | t | 2020-11-01 23:41:12.273 | https://images.dog.ceo/breeds/puggle/IMG_153357.jpg |
   | 2 | ridgeback-rhodesian | 2020-11-01 23:41:12.473 | f | 2020-11-01 23:41:13.587 | https://images.dog.ceo/breeds/ridgeback-rhodesian/n02087394_310.jpg |
   | 3 | bulldog-french | 2020-11-01 23:41:13.803 | t | 2020-11-01 23:41:15.067 | https://images.dog.ceo/breeds/bulldog-french/n02108915_3640.jpg |
   | 4 | boxer | 2020-11-01 23:41:15.287 | f | 2020-11-01 23:41:16.612 | https://images.dog.ceo/breeds/boxer/n02108089_1575.jpg |
   | 5 | stbernard | 2020-11-01 23:41:16.826 | t | 2020-11-01 23:41:18.413 | https://images.dog.ceo/breeds/stbernard/n02109525_2648.jpg |


7. Stop and remove all containers/images:

    To stop and remove all the containers and images on your machine run this command:

    `docker-compose down --rmi all`
    
8. You're done!
