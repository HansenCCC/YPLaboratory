# QMKKXProduct

#### QMKKXProduct 页面展示

<img src="http://i1.fuimg.com/737869/872ec7e077f65fec.png" width="400">

<img src="http://i1.fuimg.com/737869/01b801e066c1cb7c.png" width="400">

# QMKKXProduct 说明

#### 组件

* `<工作台>`

* `<UI组件>`
  - `常见首页样式`
  - `丰富多彩的cell(基于UITableView)`
     - `普通cell显示`
     - `可编辑cell`
     - `带switch开关 cell`
     - `自动适配高度cell（高性能）`
     - `仿朋友圈cell`
     - `评论cell`
  - `普通提示框(基于MBProgressHUD️)`
     - `普通提示框、成功、失败提示框（自动隐藏）`
     - `loading（自动隐藏）`
     - `进度条（圆形、水平、圆环）`
  - `自定义弹框(alert)` 
     - `普通提示框`
     - `普通提示框（带标题）`
     - `普通提示框（一个按钮）`
     - `普通提示框（两个按钮）`
     - `普通提示框（输入框）`
  - `输入选择框(基于UIPickerView)`
     - `时间选择`
     - `年份选择`
     - `倒计时选择`
     - `字体选择`
     - `颜色选择`
     - `性别选择`
     - `地址选择`
  - `导航栏配置(基于UINavigationBar)`
     - `当前控制器背景颜色`
     - `导航是否半透明`
     - `导航是否全透明`
     - `导航items颜色`
     - `导航背景颜色`
     - `导航是否显示底部线条`
     - `导航字体颜色`
     - `导航字体大小`
     - `导航字体是否加粗`
  - `轮播图(基于KKCarouselView)`
     - `无限循环自动播放`
     - `可自定制`
  - `摄像机模块(基于KKAVCaptureBaseSessionView)`
     - `二维码扫描`
     - `人脸追踪识别`
     - `自定义相机（待完善）`
     - `身份证拍照`
  - `iOS播放器`
     - `基于封装AVPlayer`
     - `基于AVPlayerViewController`
     - `基于MPMoviePlayerController`
     - `基于MPMoviePlayerViewController`
  - `TableView嵌入播放器(防线程卡顿处理)`
  - `仿新浪@人功能`
  - `仿微信朋友圈`
     - `发圈+朋友圈`
  - `角标和红点`
  - `标签(基于KKLabelsView)`
     - `局左对齐`
  - `网站(基于WKWebView)`
     - `加载本地HTML`
     - `加载网络HTML`
     - `js+wk相互传值`
  - `仿支付宝密码框`
  - `下拉选项弹框(基于KKDropdownBoxView)`
      - `配置box尺寸`
  - `仿微信图片查看器(基于KKImageBrowser)`
     - `1:1仿（下滑退出）`
  - `贪吃蛇`
     - `一个小游戏。（未完成）`
  - `跑马灯效果`
     - `机场寻人，跑马灯寻人`
  - `tableView自适应图片高度`
     - `根据图片尺寸，自适应cell高度`
  - `~~C语言绘图(基于Core Graphics)~~`
  - `~~OC语言绘图(基于UIBezierPath)~~`
  - `~~丰富多彩的cell(基于UICollectionView)~~`
  - `~~K线应用(搁置没时间)~~`
* `<APP图标制作>`
  - `填写图片地址，快速制作APP icon`
  - `可添加beta文字`
* `<网络图片下载>`
  - `使用iOS原生下载图片缓存`
  - `使用SDWebImage下载图片`
  - `了解SDWebImage缓存逻辑`
* `<数据库（基于FMDB）>`
  - `数据库的基本使用`
* `<第三方分享&登录&支付>`
  - `需要去对应平台注册APP`
* `<Apple安装协议&App之间相互打开和交互>`
  - `应用之间的传值、IPA安装协议`
* `<文件管理>`
  - `根据文件类型展示文件（没有继续去写复制、粘贴、删除。iOS意义不大）`
* `~~<Xcode自定义文件模板>~~`
* `~~<学习资料和资源(h5地址)>~~`
* `~~<IM即时通讯技术>~~`
* `<鸣谢支持>`

#### 有用到的第三方库
``` Object-C
pod 'AFNetworking', '4.0.1'
pod 'SDWebImage', '4.4.8'
pod 'SDWebImage/GIF', '4.4.8'
pod 'MJRefresh','3.5.0'
pod 'MJExtension', '3.2.4'
pod 'Masonry', '1.1.0'
pod 'IQKeyboardManager', '6.5.6'#键盘遮挡问题
pod 'TZImagePickerController', '3.5.8'#图片选择容器，用于用户反馈
pod 'MBProgressHUD', '1.2.0'
pod 'lottie-ios','2.5.3'
pod 'Bugly','2.5.71'#bug反馈
pod 'JCore','2.1.4-noidfa' 
pod 'JPush','3.2.4-noidfa'
```

#### 基础介绍
> •api
接口需要写在KKNetworkApi.h文件
网络请求调用KKNetworkBase.h里面的方法

> •font
普通字体font使用AdaptedFontSize
粗体字体font使用boldSystemFontOfSize

> •layout
布局配置间距使用宏：AdaptedWidth

> •color
颜色统一使用宏定义
例如KKColor_FFFFFF

> loading 
加载状态使用showLoading & hideLoading

> •error
显示报错showError

> •succes
显示成功showSuccessWithMsg

> •controller
新建UIViewController需要继承KKBaseViewController
新建NavigationController需要继承KKNavigationController

> •imageUrl
加载网络图片使用分类
UIImageView -> UIImageView+KExtension.h
UIButton    -> UIButton+KExtension.h

> •自定义xcode模板
MacOSX的系统文件模板位置
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/
用户自定义模板位置
~/Library/Developer/Xcode/Templates

#### 代码提交规范
> •feat：新功能（feature）
> •fix：修补bug
> •docs：文档（documentation）
> •style： 格式（不影响代码运行的变动）
> •refactor：重构（即不是新增功能，也不是修改bug的代码变动）
> •test：增加测试
> •chore：构建过程或辅助工具的变动


----------


# 自述

> 普通开发，15年8月份入坑做iOS，已经五六年了吧。
喜欢封装一些工具和研究一些东西，平时很少用轮子，是那种喜欢造轮子的人。
<img src="http://i1.fuimg.com/737869/899a0d9bb8d8716e.png" width="400">
GitHub更新的并不是很勤快，偷闲随机更新。
写QMKKXProduct发到GitHub，希望能帮到刚入坑iOS开发的小伙伴。项目是用Objective-C写的，如果是学习Swift的小伙伴也可以用来参考。
大部分都是一些常用UI，希望我代码的逻辑、风格、写法和规范能对您有所帮助。
钱不是存出来的，打工最多也就一套房子一套车。自己还是想搞点事情的。（这里是一条广告：所以呢，有问题可以联系我，有偿无偿都可以。）


----------


# 我
#### Created by 程恒盛 on 2019/10/24.
#### Copyright © 2019 力王. All rights reserved.
#### QQ:2534550460@qq.com  GitHub:https://github.com/HansenCCC  tel:13767141841
#### copy请标明出处，感谢，谢谢阅读
