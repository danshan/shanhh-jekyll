FROM danshan/shanhh-docker
MAINTAINER i@shanhh.com


ADD jekyll /opt/data/jekyll
ADD qiniu /opt/data/qiniu

ADD bin/entrypoint.sh /opt/data/entrypoint.sh

WORKDIR /opt/data/jekyll

EXPOSE 80
ENTRYPOINT ["/opt/data/entrypoint.sh"]