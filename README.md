# ssh-server-on-docker-with-docker

Dockerized openssh-server and docker client. Can be used for many purposes like easily controling remote docker containers and configs with something like VS code.
Not meant to be exposed to the internet or untrusted networks.

Use the docker-compose.yml included in the repository for a template on how to deploy.
There's an abbreviation added to the fish shell to run docker-compose commands more easily. Specify with the COMPOSE_FILE environment variable the location of the file and instead of typing out "docker-compose -f /path/to/file.yml" in the shell you can instead just type dc.