# Docker commands cheat sheet

Command | Description
--- | ---
docker-machine ls | See if your development VM is up and running
docker-machine create --driver virtualbox devenv | Create a VirtualBox-backed VM called devenv
docker-machine start devenv | Start a VM called devenv if it is stopped
docker-compose run --service-ports xgsprototypes | Run an app called xgsprototypes (as defined in docker-compose.yml) and map its ports
docker-compose up --service-ports | run all apps defined in docker-compose.yml and map their ports

References:

https://docs.docker.com/machine/
https://docs.docker.com/compose/

