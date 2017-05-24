FROM danshan/shanhh-docker
#FROM nexus.wanda-itg.local:8443/danshan/shanhh-docker
MAINTAINER Dan Shan <i@shanhh.com>

RUN gem install --no-ri --no-rdoc jekyll-coffeescript

ADD jekyll /opt/data/jekyll
#ADD qiniu /opt/data/qiniu
#RUN mkdir -p /var/log/qiniu

#ADD bin/entrypoint.sh /opt/data/entrypoint.sh

ENV JEKYLL_ENV=production
WORKDIR /opt/data/jekyll

EXPOSE 4000
ENTRYPOINT ["jekyll", "serve", "--host=0.0.0.0"]
