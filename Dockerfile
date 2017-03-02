FROM danshan/shanhh-docker
MAINTAINER i@shanhh.com


ADD jekyll /opt/data/jekyll
ADD qiniu /jekyll/qiniu
WORKDIR /jekyll/blog
RUN jekyll build

RUN rm -rf /etc/nginx/sites-enabled/default
ADD nginx/shanhh.com /etc/nginx/sites-available/shanhh.com
RUN ln -s /etc/nginx/sites-available/shanhh.com /etc/nginx/sites-enabled/shanhh.com

ADD bin/entrypoint.sh /jekyll/entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/jekyll/entrypoint.sh"]