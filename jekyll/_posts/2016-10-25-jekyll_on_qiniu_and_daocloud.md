---
layout: post
title: "利用DaoCloud在阿里云自动发布Jekyll"
date: 2016-10-25 17:48
description: "利用DaoCloud在阿里云自动发布Jekyll, 并利用七牛CDN来保存静态图片"
tags: [aliyun, qiniu, daocloud, jekyll]
image:
  feature: abstract-1.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/
---

很久没有更新 blog, 实在是懒得折腾. 前段时间利用闲暇功夫折腾了一下整个部署流程.

简单描述一下: 

1. 作者(也就是我), 通过github提交代码.
2. [DaoCloud](https://www.daocloud.io/) 监听到这次push, 并用最新的代码来生成 [docker](https://www.docker.com/) 镜像.
3. 把文章中的所有附件(图片, zip包)之类的上传到 [七牛云](https://www.qiniu.com/).
4. 把生成的 docker 镜像在 [阿里云](https://intl.aliyun.com/zh) 上进行部署.

以上流程中, 只有阿里云和域名需要付费, 而七牛和 DaoCloud 的使用是完全免费的.

具体步骤:

## 对接 DaoCloud 和web空间

如何购买阿里云的主机, 不是本文的考虑重点, 自己去弄好了.
我各人来说, 自己的需求非常简单, 就买了个华南区的ECS主机.

这里虽然以阿里云上的 Ubuntu 为例, 但实际上 DaoCloud 支持的空间很多, 目前已经涵盖了 ubuntu, centOS, windows, mac.

针对不同的对接方法可以在 daocloud 中的 **我的集群** -> **添加主机** 中查看不同环境的接入方案.

教程非常详细, 这里不过多介绍了.

## 使用七牛 CDN来管理静态资源




