# Readers' Haven Library
Static 5-page library website, built with Parcel and served by Nginx in a Docker container.

## Run with Docker
docker image build -t <dockerhub-hammad19m/readers-haven:test .
docker image build -t hammad19m/readers-haven:test .
docker container run -d --name haven-test -p 8081:80 hammad19mreaders-haven:test
