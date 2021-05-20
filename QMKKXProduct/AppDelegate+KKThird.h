//
//  AppDelegate+KKThird.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/27.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (KKThird)

//添加初始化JPush代码
- (void)jpushInitDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
//注册通知
- (void)registerUserNotification;
//监听网络测试
- (void)listenNetworkReachabilityStatus;
//iq键盘配置
- (void)keyboardManagerConfig;
//bugle崩溃监控
- (void)buglyConfigure;
@end


