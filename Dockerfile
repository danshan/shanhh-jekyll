FROM danshan/shanhh-docker
MAINTAINER Dan Shan <i@shanhh.com>

ADD jekyll /opt/data/jekyll

ENV JEKYLL_ENV=production
WORKDIR /opt/data/jekyll

EXPOSE 4000
ENTRYPOINT ["jekyll", "serve", "--host=0.0.0.0"]
