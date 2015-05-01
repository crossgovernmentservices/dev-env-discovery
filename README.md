# Intro

This development environment eliminates the need for more than one dependency (e.g. PostgresQL, RVM, Ruby, etc) and leaves you with a single dependency to run all the XGS apps: Docker.

# Steps


## 1. Install Docker and docker-compose

Install [Docker and Compose](https://docs.docker.com/compose/install/) for your architecture (and feel free to try the [simple Python example](https://docs.docker.com/compose/) to gain more hands-on familiarity). Specifically for Mac OSX:
  1. Install latest boot2docker from https://github.com/boot2docker/osx-installer/releases
  2. Run these commands:

        boot2docker init
        boot2docker start
        eval "$(boot2docker shellinit)"
        # and to test that it all works:
        docker run hello-world
        # install docker-compose
        curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

## 2. Clone this repo

    git clone git@github.com:crossgovernmentservices/dev-env.git

## 3. Bootstrap

Run bootstrap to pull dependencies

    cd dev-env
    ./script/bootstrap

## 4. Start the apps 

    ./docker.sh


## 5. (optional) Set up environment for Docker

If you want to run Docker commands, add the Docker environment variables to your profile:

    boot2docker shellinit | grep "^export" >> ~/.bash_profile

# Local NGINX

If you'd like to proxy the apps  behind a "nice" name like http://xgs.local instead of the usual http://localhost:3000

1. Copy the server definition to your NGINX install, typically:

    ```
    sudo cp nginx.conf /etc/nginx/sites-available/xgs.local
    sudo ln -s /etc/nginx/sites-available/xgs.local \
               /etc/nginx/sites-enabled/xgs.local
    ```
2. Restart NGINX

    ```
    sudo service nginx restart
    ```

3. Add the snippet in [hosts](./hosts) to ```/etc/hosts```.

# App links 

| App | URL | without NGINX proxy |
| --- | --- | ------------------- |
| Maslow | http://maslow.xgs.local | http://localhost:3000 |
| Cross Government Services | http://xgs.local|http://localhost:3001 |
| Cross Government Services Prototypes | http://prototypes.xgs.local | http://localhost:3002 |
