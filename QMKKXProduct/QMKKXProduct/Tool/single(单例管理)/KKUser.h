//
//  KKUser.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKUserInfoModel.h"
#import "KKDatabase.h"
#import <UIKit/UIKit.h>

@interface KKUser : NSObject
@property (readonly, nonatomic) BOOL isLogin;//判断是否登录
@property (readonly, nonatomic) NSString *token;//token
@property (readonly, nonatomic) NSString *version;//version
@property (readonly, nonatomic) NSString *platform;//平台来源 1：安卓 2：ios
@property (readonly, nonatomic) NSString *appType;//1石器盒子，0夺宝盒子  目前暂时考虑检查更新
@property (readonly, nonatomic) NSString *iosType;//IOS下载包类型 1:企业 2:APPSTORE
@property (readonly, nonatomic) NSString *startImg;//启动图片地址
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
//发送退出登录通知
- (void)postNotificationToLogout;
//发送注册成功通知
- (void)postNotificationToDidRegister;
//发送注册失败通知
- (void)postNotificationToFailedRegister;
//发送资料修改通知
- (void)postNotificationToUserInfoUpdate;
//发送qmkkx唤起授权界面
- (void)postNotificationToQMKKXAuthLogin:(NSString *)info;

//发送qmkkx支付宝支付回调
- (void)postNotificationToQMKKXAliPay:(id)info;
//发送qmkkx支付宝支付回调
- (void)postNotificationToQMKKXAliLogin:(id)info;
//发送qmkkx微信支付回调
- (void)postNotificationToQMKKXWeChatPay:(id)info;
//发送qmkkx微信登录回调
- (void)postNotificationToQMKKXWeChatLogin:(id)info;

#pragma mark - config
//获取配置（退出登录和重新登录需要重新请求）
- (void)setupConfig;


#pragma mark - webPush
//present webview
- (void)presentWebViewContoller:(UIViewController *)selfVC url:(NSString *)urlString complete:(void(^)(BOOL refresh))complete;
//present webview
- (void)presentWebViewContoller:(UIViewController *)selfVC title:(NSString *)title url:(NSString *)urlString complete:(void(^)(BOOL refresh))complete;


#pragma mark - 超链接打开操作
//超链接打开地址
- (BOOL)openURL:(NSURL*)url;
//是否能打开
- (BOOL)canOpenURL:(NSURL *)url;
//打开这款游戏
- (BOOL)openGameByGameId:(NSString*)gameId;
//是否安装这款游戏
- (BOOL)canOpenGameByGameid:(NSString *)gameId;

#pragma mark - 历史存储相关
@property (nonatomic, readonly) NSString *userActionTable;

/// 记录用户行为
/// @param jsonValue json
- (BOOL)savaUserActionWithJson:(NSString *)jsonValue;
@end
