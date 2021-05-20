//
//  KKNetworkBase.h
//  FanRabbit
//  网络请求基类
//  Created by 程恒盛 on 2019/6/3.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKBaseResponse.h"

/**
 目的：数据请求应该和ui划分开
 类作用：新网络请求接口使用该类的方法来实现，原先请求先不做改动
 
 */

//当前状态，废弃状态  无类使用
@interface KKNetworkBase : NSObject




//有网YES, 无网:NO
+ (BOOL)isNetwork;

/**
 POST请求
 @param url        地址
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;
/**
 GET请求
 @param url        地址
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;

#pragma mrk - 请求接口

/**
 POST请求
 @param url        地址拼接host
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)POST_HOST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;
/**
 GET请求
 @param url        地址拼接host
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)GET_HOST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;


@end


