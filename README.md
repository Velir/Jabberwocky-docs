# Jabberwocky-docs

These documents can be browsed at http://jabberwocky.rtfd.org/


# Building from source

If you have the necessary sphinx dependencies installed locally (http://www.sphinx-doc.org/en/stable/), then you can simply run the include make file with the 'html' param.

Otherwise, if you can't or simply don't wish to install sphinx et al., you can install docker on your machine at the following location: https://www.docker.com/products/docker-toolbox

With docker installed, you can use the provided 'docker.bat' to spin up a docker container on demand that will build the sources for you, and put the generated files into the /build/html folder in your project folder.

Just note that in order to execute the docker.bat script, you must first ensure that the VirtualBox boot2docker image is running on your machine.  If it is not, you can start it by running the "Docker Quickstart Terminal" program that ships as part of the Docker Toolbox.