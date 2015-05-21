# Intro

This development environment eliminates the need for more than one dependency (e.g. PostgresQL, RVM, Ruby, etc) and leaves you with a single dependency to run all the XGS apps: Docker.

# Steps


## Install dependencies

Using your platform's package manager (e.g. apt-get or brew), install:

- docker
- docker-compose
- docker-machine


On Linux, alternatively install docker-compose with:

    curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

### Mac

If you are on a Mac, also install:

- [VirtualBox](https://www.virtualbox.org/)

...upon which you need to run these commands:

    docker-machine create --driver virtualbox devenv
    eval "$(docker-machine env devenv)" # add this line to your ~/.bash_profile

## 2. Clone this repo

**Mac users, note that you have to clone this somewhere in your home directory for the default /Users mount in Virtual Box to work.**

    git clone git@github.com:crossgovernmentservices/dev-env.git

## 3. Bootstrap

Run bootstrap to pull dependencies

    cd dev-env
    ./script/bootstrap

    # prepare docker-compose.yml
    # This script depends on ~/.xgsenv - ask an admin for a copy
    ./prep.sh

## 4. Start the apps 

    # from dev-env directory
    docker-compose build
    docker-compose up

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
