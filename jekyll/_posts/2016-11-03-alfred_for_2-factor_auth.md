---
layout: post
title: "利用 Alfred workflows 简化两步验证流程"
date: 2016-11-03 17:48
description: "利用 alfred 的 workflow 来快速完成两步验证的流程"
tags: [alfred, 2-factor]
image:
  feature: abstract-2.jpg
  credit: dargadgetz
  creditlink: http://www.dargadgetz.com/ios-7-abstract-wallpaper-pack-for-iphone-5-and-ipod-touch-retina/
---

为了安全性的问题, 我把能开通 [两步验证](https://www.google.com/intl/zh-CN/landing/2step/) 的帐号全部打开了. 比如:

* google
* evernote
* dropbox
* facebook
* coding.net
* 微软
* 坚果云
* 小米

然后利用 [Authy](https://www.authy.com/) 的 cloud 同步功能, 来在不同移动设备之间进行配置共享, 而且在桌面端, 还可以通过 [chrome 插件](https://chrome.google.com/webstore/detail/authy/gaedmjdfmmahhbjefcbgaolhhanlaolb?hl=en) 的方式共享配置非常方便.

移动端没什么问题, 但是在桌面客户端上, chrome 插件的使用还是比较麻烦. 
因为必须要用鼠标人为的点击一下对应的帐号, 还要在点一下 `Copy` 按钮, 更麻烦的是, 每次启动 authy 时, 都要输入一次 master 密码.
这个对于个人电脑来说感觉没有什么必要, 而且这个功能还无法取消.

对于严重的键盘党来说, 这几次窗口的切入和鼠标的切换完全不能忍.

网上搜索到了一个使用 [alfred workflows](https://www.alfredapp.com/workflows/) 的方式来输入两步验证码, 叫做 [Gauth: Google Authenticator (Time-Based Two-Factor Authentication)](http://www.alfredforum.com/topic/4062-gauth-google-authenticator-time-based-two-factor-authentication/).

装上去以后, 问题来了...按照文档的要求, 我需要提供如下信息

```
[google - bob@gmail.com]
secret = xxxxxxxxxxxxxxxxxx

[evernote - robert]
secret = yyyyyyyyyyyyyyyyyy
```

但是我倒哪里去拿到这个secret呢? 我们知道在初次启动二次校验的是可以通过二维码或者这个secret来关联, 但是一旦关联成功, 还怎么去查这个呢?
我在 mac 上定位到了 authy 的 chrome 插件的数据文件在 `/Users/Dan/Library/Application Support/Google/Chrome/Default/Extensions/gaedmjdfmmahhbjefcbgaolhhanlaolb/1.5.0_0/_metadata/verified_contents.json`, 但是没有用, 整个文件被加密了.

只能去翻源代码了. 最终的解决方案是:

找到业务逻辑代码 app.js, 在 `/Users/Dan/Library/Application Support/Google/Chrome/Default/Extensions/gaedmjdfmmahhbjefcbgaolhhanlaolb/1.5.0_0/js` 下

定位到有个 updateTokens function:

{% highlight javascript %}
    TokensView.prototype.updateTokens = function(tokenRows) {
      var app, element, i, len, results, tokenRow;
      results = [];
      for (i = 0, len = tokenRows.length; i < len; i++) {
        tokenRow = tokenRows[i];
        element = $(tokenRow);
        app = AppManager.get().find(element.attr('data-token-id'));
        element.find('.tokenCode').html(app.formatToken()(app.getOtp()));
        results.push(element.find('.tokenCodeString').html(app.getOtp()));
      }
      return results;
    };
{% endhighlight %}

这部分逻辑在每隔30秒更新token时触发, 我们这里动点手脚:

{% highlight javascript %}
results.push(element.find('.tokenCodeString').html(app.getOtp()));
results.push(element.find('.tokenCodeString').html(JSON.stringify(AppManager.get())));
{% endhighlight %}

加的这一行把整个 apps 列表的数据全部拉下来, 并保存到剪切板.

注意这个方法是在每次tokens更新时才调用, 所以如果刚刚打开authy, 要等它下次更新后, 再去点copy.

我们把剪切板中的数据弄出来, 可以看到每个网站解密后的数据. 

{% highlight javascript %}
    {
		"createdDate": 1471348752428,
		"otpGenerator": {},
		"uploadState": "uploaded",
		"uniqueId": "1453918",
		"name": "xxx@shanhh.com",
		"originalName": "Google:xxx@shanhh.com",
		"accountType": "google",
		"salt": "Pu1W9NpUkrlF4SILqQ8Z7ApYbgFw",
		"encryptedSeed": "eGgxm+go5dT6zIkstJDgEfJOh8TAEHKSVgSjskz4YkCgDaa",
		"decryptedSeed": "nryz4gnasdfa123fmn3xbddi5yjo4",
		"passwordTimestamp": 1456943408,
		"markedForDeletion": false,
		"deleteDate": null,
		"digits": 6
	}
{% endhighlight %}

其中 `decryptedSeed` 就是我们需要的 secret 了