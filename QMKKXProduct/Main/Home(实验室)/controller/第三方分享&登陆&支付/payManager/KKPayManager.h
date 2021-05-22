//
//  KKPayManager.h
//  QMKKXProduct
//  支付管理类，第三方行为管理
//  Created by Hansen on 6/15/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKAliPayModel.h"//支付包支付model
#import "KKWeChatPayModel.h"//微信支付model


/// 第三方支付、分享、登录已经移除，有点占内存，这里就删除SDK了。
@interface KKPayManager : NSObject

@end

//static NSString *KKWeChatAppID = @"wx0647716e2f53ac8b";//微信APPid  测试id为Bee APP的注册id
//static NSString *KKAliAppID = @"";//阿里APPid 暂无
//
//
//@interface KKPayManager : NSObject
//AS_SINGLETON(KKPayManager);
//
//#pragma mark - 支付宝相关
//
///// openurl的回调响应
///// @param openUrl url
//- (BOOL)aliPayHandleOpenURL:(NSURL *)openUrl;
//
///**
// 吊起支付宝oauth认证
//
//@param complete 回调  success只判断是否吊起客户端不做支付成功判断  info返回信息
//*/
//- (void)aliOauthComplete:(void(^)(BOOL success,id info))complete;
//
///**
// 吊起支付宝客户端支付
//
// @param model 请求参数
// @param complete 回调  success只判断是否吊起客户端不做支付成功判断  info返回信息
// */
//- (void)aliPayWithModel:(KKAliPayModel *)model complete:(void(^)(BOOL success,id info))complete;
//
//
//#pragma mark - 微信相关
//
///// openurl的回调响应
///// @param openUrl url
//- (BOOL)weChatHandleOpenURL:(NSURL *)openUrl;
//
///**
// 吊起微信客户端支付
//
// @param model 请求参数
// @param complete 回调  success只判断是否吊起客户端不做支付成功判断  info返回信息
// */
//- (void)weChatPayWithModel:(KKWeChatPayModel *)model complete:(void(^)(BOOL success,id info))complete;
//
///**
// 吊起微信oauth认证
// @param complete 回调  success只判断是否吊起客户端不做支付成功判断  info返回信息
// */
//- (void)weChatOauthComplete:(void(^)(BOOL success,id info))complete;
//
//
///**
// 吊起微信分享
// @param model 请求参数
// @param complete 回调  success只判断是否吊起客户端不做支付成功判断  info返回信息
// */
//- (void)weChatShareWithModel:(KKWeChatShareModel *)model complete:(void(^)(BOOL success,id info))complete;
//
//
///**
// 通过接口获取微信openid
//
// @param secret 秘钥
// @param code code
// @param complete 回调
// */
//- (void)weChatOauthGetOpenIDWithSecret:(NSString *)secret code:(NSString *)code complete:(void(^)(BOOL success,id info))complete;
//
//@end

