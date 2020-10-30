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
1. To begin, we'll walk through the process of creating Docker images and containers for each layer of our web application stack \

    Start with 


database/DB_Instructions.md \
backend/Backend_Instructions.md \
frontend/Frontend_Instructions.md 

Create all images/containers, stop all old running containers and create them from scratch:

`docker-compose up -d --force-recreate`

Stop and remove all containers/images:

`docker-compose down --rmi all`