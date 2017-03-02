FROM danshan/shanhh-docker
MAINTAINER i@shanhh.com

EXPOSE 80

RUN mkdir /jekyll
ADD blog /jekyll/blog
ADD qiniu /jekyll/qiniu
WORKDIR /jekyll/blog
RUN jekyll build

RUN rm -rf /etc/nginx/sites-enabled/default
ADD nginx/shanhh.com /etc/nginx/sites-available/shanhh.com
RUN ln -s /etc/nginx/sites-available/shanhh.com /etc/nginx/sites-enabled/shanhh.com

ADD bin/entrypoint.sh /jekyll/entrypoint.sh


ENTRYPOINT ["/jekyll/entrypoint.sh"]