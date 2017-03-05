# shanhh-jekyll

[![Build Status](https://travis-ci.org/danshan/shanhh-jekyll.svg?branch=master)](https://travis-ci.org/danshan/shanhh-jekyll)

启动完成如下任务:

1. 将项目中的静态文件push到七牛的cdn

2. 通过 serve 的方式启动 jekyll

```yaml
shanhh-jekyll:
  image: daocloud.io/danshan/shanhh-jekyll:latest
  privileged: false
  restart: always
  ports:
  - 4000:4000
  volumes:
  - /root/workspace/tools/qshell:/opt/tools/qshell:ro
  environment:
  - QINIU_SECRET_KEY=
  - QINIU_ACCESS_KEY=
```
