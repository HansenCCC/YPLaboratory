//
//  KKUser.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKUserInfoModel.h"

@interface KKUser : NSObject
@property (readonly, nonatomic) BOOL isLogin;//判断是否登录
@property (readonly, nonatomic) NSString *token;//token
@property (readonly, nonatomic) NSString *version;//version
@property (readonly, nonatomic) NSString *appType;//1石器盒子，0夺宝盒子  目前暂时考虑检查更新
@property (readonly, nonatomic) NSString *iosType;//IOS下载包类型 1:企业 2:APPSTORE
@property (readonly, nonatomic) KKUserInfoModel *userModel;//用户登录信息

+ (instancetype)shareInstance;//标准初始化
//保存登录信息
- (void)saveUserModel;
//清空登录信息
- (void)cleanUserModel;

//发送需要登录通知
- (void)postNotificationToLogging;
//发送登录成功通知
- (void)postNotificationToDidLogin;
//发送登录失败通知
- (void)postNotificationToFailedLogin;
//发送注册成功通知
- (void)postNotificationToDidRegister;
//发送注册失败通知
- (void)postNotificationToFailedRegister;
@end
