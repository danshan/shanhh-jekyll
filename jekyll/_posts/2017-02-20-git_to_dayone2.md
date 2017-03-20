---
layout: post
title: "利用 Day One 2 整理每天的编码工作"
date: 2016-11-03 17:48
description: "通过 Day One 2 提供的接口在每日同步当日的代码提交日志"
tags: [alfred, 2-factor]
image:
  feature: abstract-3.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/
---

每天的工作都离不开代码, 每周还要整理工作计划, 常常忘记了自己的工作内容.
同时, 如果涉及到多个项目的开发, 还往往有疏漏.

一个偶然的机会, 发现了 Day one 的自动添加日记功能 API, 可以自动将每日的工作整理入库.

<figure>
<img src="{{ site.cdn }}/files/2017/02/dayone1.png{{ site.img }}">
</figure>

第一步当然是安装 Day One 2的cli工具, 官方提供了支持文档 [Command Line Interface (CLI)](http://help.dayoneapp.com/command-line-interface-cli/)

安装只需一行命令

```bash
sudo /Applications/Day\ One.app/Contents/Resources/install_cli.sh
```

[Day One Tools](http://help.dayoneapp.com/day-one-tools/) 也提供了一些有用的玩法.

参考 @dduan 的 [git2dayone](https://github.com/dduan/git2dayone), 发现是基于 day one 1的, 所以基于这个脚本做了一定的修改.

{% highlight bash %}
#!/usr/bin/env sh

query=$1

if [ -n "$query" ]; then
    date=$query
else
    date=`date +%Y-%m-%d`
fi

workspaces='/Users/dan/workspace/wanda /Users/dan/workspace/personal /Users/dan/workspace/duitang'

for workspace in $workspaces
do
    repos=`ls $workspace/`

    for repoPath in $repos
    do
        cd $workspace/$repoPath
        logs=`git log --after "$date 00:00" --before "$date 23:59" --author "dan"`
        if [ -n "$logs" ]; then
            echo "Found logs @ $repoPath"
            echo "Commits for $repoPath\\n $logs" | /usr/local/bin/dayone2 -d="$date" -j="Workspace" new -t git
        fi
    done
done
{% endhighlight %}

这里看到我在平时工作可能涉及到三个workspace, 脚本会针对每个workspace中的每个git项目来导出当天的git commit log, 并保存到 Day One 2.

最基本的功能已经完成了, 下面要让脚本自动执行, 我所在的公司每天 17:30 下班, 所以我给自己写个 cron 任务

{% highlight bash %}
30 17 * * * /Users/dan/workspace/others/git2dayone/day_one_git_messages.sh
{% endhighlight %}

最后一步, 为了有的时候周末在家或者咖啡厅写代码, 可能不会触发 17:30 的job, 我需要添加一个方便的手动触发的功能.
这一次, 借助了 Alfred 的 workflow.

<figure>
<img src="{{ site.cdn }}/files/2017/02/dayone2.png{{ site.img }}">
</figure>
