#!/bin/sh

docker build -t jekyll .
docker stop jekyll
docker rm jekyll
docker run -it -d --name jekyll -p 4000:4000 -t jekyll
docker logs -f jekyll
