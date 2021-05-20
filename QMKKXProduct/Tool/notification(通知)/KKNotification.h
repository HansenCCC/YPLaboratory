//
//  KKNotification.h
//  Bee
//
//  Created by 程恒盛 on 2019/10/16.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

extern NSString *const kNSNotificationCenterLogging;//发送登录通知
extern NSString *const kNSNotificationCenterDidLogin;//登录成功
extern NSString *const kNSNotificationCenterFailedLogin;//登录失败
extern NSString *const kNSNotificationCenterLogout;//退出登录
extern NSString *const kNSNotificationCenterDidRegister;//注册成功
extern NSString *const kNSNotificationCenterFailedRegister;// 注册失败
extern NSString *const kNSNotificationCenterUserInfoUpdate;//用户信息更新

extern NSString *const kNSNotificationCenterUserClickPush;//用户点击通知栏
extern NSString *const kNSNotificationCenterQMKKXAuthLogin;//唤起QMKKX授权界面

//第三方支付相关
extern NSString *const kNSNotificationCenterQMKKXAliPay;//支付宝支付回调
extern NSString *const kNSNotificationCenterQMKKXAliLogin;//支付宝登录回调

extern NSString *const kNSNotificationCenterQMKKXWeChatPay;//微信支付回调
extern NSString *const kNSNotificationCenterQMKKXWeChatLogin;//微信登录回调
