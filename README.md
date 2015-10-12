<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc/generate-toc again -->
**Table of Contents**

- [Intro](#intro)
- [Steps](#steps)
    - [Install dependencies](#install-dependencies)
        - [Mac](#mac)
    - [2. Clone this repo as 'xgs'](#2-clone-this-repo-as-xgs)
    - [3. Bootstrap](#3-bootstrap)
    - [4. Start the apps](#4-start-the-apps)
- [Deleting an image and its containers](#deleting-an-image-and-its-containers)
- [NGINX proxy](#nginx-proxy)
- [Deploy to AWS](#deploy-to-aws)

<!-- markdown-toc end -->


# Intro

This development environment eliminates the need for more than one dependency (e.g. PostgresQL, RVM, Ruby, etc) and leaves you with a single dependency to run all the XGS apps: Docker.

Also, scripts in this repo generally depend on **Python**, and Mac/\*nix should have  it installed.

```xgs``` is an abbreviation of Cross Government Services, although the domain name used for it is ```cstools```, which is Civil Service Tools. Naming things are difficult.

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

## 2. Clone this repo as 'xgs'

**Mac users, note that you have to clone this somewhere in your home directory for the default /Users mount in Virtual Box to work.**

    git clone git@github.com:crossgovernmentservices/dev-env.git xgs

## 3. Bootstrap

Run bootstrap to pull dependencies

    cd xgs
    ./script/bootstrap

    # install needed python libraries
    pip install -r requirements.txt

    # prepare docker-compose.yml
    # This script depends on ~/.xgsenv - ask an admin for a copy
    ./script/compose

## 4. Start the apps

    # from xgs directory
    docker-compose build
    docker-compose up

# Deleting an image and its containers

This is especially useful when an app's' dependencies change and the image requires a rebuild.

Run the script without arguments to see options, e.g.:

    ./script/docker-delete

# NGINX proxy

The development environment comes an nginx proxy built-in listening on port 80.

Add the snippet in [hosts](./hosts) to ```/etc/hosts```, and then go to any of those URLs in your web browser (provided the dev env is up).

(TODO not tested on Mac)

# Deploy to AWS

**Dependency**: the [Tutum CLI](https://github.com/tutumcloud/cli), which you can install with ```pip install tutum```.

Currently, deploying to production can only be done from a development machine:

    ./script/deploy-to-aws

It pushes the Docker images that ```docker-compose``` built during development, but to be sure that you're deploying the latest code, rebuild all images with this command beforehand:

    docker-compose build


Tutum is configured to auto-deploy all services when new Docker images are pushed.
