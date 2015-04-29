# Intro

This development environment eliminates the need for more than one dependency (e.g. PostgresQL, RVM, Ruby, etc) and leaves you with a single dependency to run all the XGS apps: Docker.

# Steps

1. Install [Docker and Compose](https://docs.docker.com/compose/install/) for your architecture (and feel free to try the [simple Python example](https://docs.docker.com/compose/) to gain more hands-on familiarity). Specifically for Mac OSX:
  1. Install latest boot2docker from https://github.com/boot2docker/osx-installer/releases
  2. Run these commands:

        ```
        boot2docker init
        boot2docker start
        eval "$(boot2docker shellinit)"
        # and to test that it all works:
        docker run hello-world
        # install docker-compose
        curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        ```

2. Clone this repo, and all apps into a working directory.

Note, when cloning [cgt](https://github.com/crossgovernmentservices/cgt) and [cgt prototypes](https://github.com/crossgovernmentservices/cgt_prototypes), use these directory names:

    ```
    git clone https://github.com/crossgovernmentservices/cgt xgs
    git clone https://github.com/crossgovernmentservices/cgt_prototypes xgs_prototypes
    ```

3. In the checkout directory of this repo, run the Docker script without any arguments, which will default it to bring the environment up.

    ```
    ./docker.sh
    ```

## Maslow steps

1. Create the database, otherwise - when loading the app in a browser - you will see this error:

![error no database](https://raw.githubusercontent.com/crossgovernmentservices/dev-env/master/doc/error-no-db.png)

    ./docker.sh run maslow db:setup

2. If you wish to create a user account for testing, run this command, replacing the name etc with your details:


    ```
    ./docker.sh run maslow bin/rake users\:create_first_user\["juan","email@example.org","yoursuperrandompassphrase"\]
    ```

## Maslow testing

1. Prepare the Maslow test database:

    ```
    ./docker.sh run maslow bin/rake db:test:prepare
    ```

2. Run the tests


    ```
    ./docker.sh run maslow bin/rake spec
    ```

# Local NGINX

1. Copy the server definition to your NGINX install, typically:

    ```
    sudo cp nginx.conf /etc/nginx/sites-available/xgs.local
    sudo ln -s /etc/nginx/sites-available/xgs.local /etc/nginx/sites-enabled/xgs.local
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
