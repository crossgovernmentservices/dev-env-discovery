# Intro

This development environment eliminates the need for more than one dependency (e.g. PostgresQL, RVM, Ruby, etc) and leaves you with a single dependency to run all the XGS apps: Docker.

# Steps

1. Install [Docker and Compose](https://docs.docker.com/compose/install/) for your architecture (and feel free to try the [simple Python example](https://docs.docker.com/compose/) to gain more hands-on familiarity).

2. Clone this repo, and all apps into a working directory.

3. In the checkout directory of this repo, run the Docker script without any arguments, which will default it to bring the environment up.

    ./docker.sh

4. Create the database, otherwise - when loading the app in a browser - you will see this error:

![error no database](https://raw.githubusercontent.com/crossgovernmentservices/dev-env/master/doc/error-no-db.png)

    ./docker.sh run maslow db:setup

5. If you wish to create a user account for testing, run this command, replacing the name etc with your details:

    ./docker.sh run maslow bin/rake users\:create_first_user\["juan","juan.uys@digital.cabinet-office.gov.uk","yoursuperrandompassphrase"\]


