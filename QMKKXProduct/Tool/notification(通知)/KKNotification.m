//
//  KKNotification.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/16.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

#import "KKNotification.h"


NSString *const kNSNotificationCenterLogging = @"kNSNotificationCenterLogging";//发送登录通知
NSString *const kNSNotificationCenterDidLogin = @"kNSNotificationCenterDidLogin";//登录成功
NSString *const kNSNotificationCenterFailedLogin = @"kNSNotificationCenterFailedLogin";//登录失败
NSString *const kNSNotificationCenterLogout = @"kNSNotificationCenterFailedLogin";//登录退出登录
NSString *const kNSNotificationCenterDidRegister = @"kNSNotificationCenterDidRegister";//注册成功
NSString *const kNSNotificationCenterFailedRegister = @"kNSNotificationCenterFailedRegister";// 注册失败
NSString *const kNSNotificationCenterUserInfoUpdate = @"kNSNotificationCenterUserInfoUpdate";//用户信息更新

NSString *const kNSNotificationCenterUserClickPush = @"kNSNotificationCenterUserClickPush";//用户点击通知栏
NSString *const kNSNotificationCenterQMKKXAuthLogin = @"kNSNotificationCenterQMKKXAuthLogin";//唤起QMKKX授权界面

//第三方支付相关
NSString *const kNSNotificationCenterQMKKXAliPay = @"kNSNotificationCenterQMKKXAliPay";//支付宝支付回调
NSString *const kNSNotificationCenterQMKKXAliLogin = @"kNSNotificationCenterQMKKXAliLogin";//支付宝登录回调

NSString *const kNSNotificationCenterQMKKXWeChatPay = @"kNSNotificationCenterQMKKXWeChatPay";//微信支付回调
NSString *const kNSNotificationCenterQMKKXWeChatLogin = @"kNSNotificationCenterQMKKXWeChatLogin";//微信登录回调
