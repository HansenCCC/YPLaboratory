//
//  KKNetworkBase.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/3.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKNetworkBase.h"

static const NSTimeInterval kTimeoutInterval = 30.0;
static NSString *OK = @"success";

@implementation KKNetworkBase
+ (BOOL)isNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (void)initialize {
    [super initialize];
}

#pragma mrk - 请求接口
+ (void)POST_HOST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    url = [NSString stringWithFormat:@"%@%@",API_HOST,url];
    [self POST:url parameters:parameters success:success failure:failure];
}
+ (void)GET_HOST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    url = [NSString stringWithFormat:@"%@%@",API_HOST,url];
    [self GET:url parameters:parameters success:success failure:failure];
}

/**
 POST请求
 @param url        地址
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    [self POST:url timeoutInterval:kTimeoutInterval parameters:parameters success:success failure:failure];
}
/**
 GET请求
 @param url        地址
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    [self GET:url timeoutInterval:kTimeoutInterval parameters:parameters success:success failure:failure];
}

/**
 *  get
 *  @param  url                 地址
 *  @param  timeoutInterval     超时时间 默认30s
 *  @param  parameters          参数
 */
+ (void)GET:(NSString *)url timeoutInterval:(NSTimeInterval)timeoutInterval parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure {
    NSDictionary *dictionary = @{
                                 @"token":[KKUser shareInstance].token?:@"",
                                 };
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [data addEntriesFromDictionary:parameters];
    NSLog(@"*******************************************************");
    NSLog(@"Method:POST");
    NSLog(@"URL:%@",url);
    NSLog(@"Parameters:%@",data.mj_JSONString);
    NSLog(@"*******************************************************");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = timeoutInterval?:kTimeoutInterval;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //注册请求类型必须声明为json
    NSString *key = @"isUserAFJSONRequestSerializer";
    if ([data.allKeys containsObject:key]) {
        BOOL flag = [data objectForKey:key];
        if (flag) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
    }
    [manager GET:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        KKBaseResponse *response = [KKBaseResponse mj_objectWithKeyValues:responseObject];
        if ([response.status isEqualToString:OK]){
            if (success) {
                success(response);
            }
        }else {
            NSError *error = [NSError errorWithDomain:response.message?:@"" code:response.code userInfo:nil];
            if (failure) {
                failure([KKNetworkBase errorCatch:error]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([KKNetworkBase errorCatch:error]);
        }
    }];
}

/**
 *  post
 *  @param  url                 地址
 *  @param  timeoutInterval     超时时间 默认30s
 *  @param  parameters          参数
 */
+ (void)POST:(NSString *)url timeoutInterval:(NSTimeInterval)timeoutInterval parameters:(id)parameters success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure {
    NSDictionary *dictionary = @{
                                 @"token":[KKUser shareInstance].token?:@"",
                                 };
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [data addEntriesFromDictionary:parameters];
    NSLog(@"*******************************************************");
    NSLog(@"Method:POST");
    NSLog(@"URL:%@",url);
    NSLog(@"Parameters:%@",data.mj_JSONString);
    NSLog(@"*******************************************************");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = timeoutInterval?:kTimeoutInterval;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //注册请求类型必须声明为json
    NSString *key = @"isUserAFJSONRequestSerializer";
    if ([data.allKeys containsObject:key]) {
        BOOL flag = [data objectForKey:key];
        if (flag) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
    }
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        KKBaseResponse *response = [KKBaseResponse mj_objectWithKeyValues:responseObject];
        if ([response.status isEqualToString:OK]){
            if (success) {
                success(response);
            }
        }else {
            NSError *error = [NSError errorWithDomain:response.message?:@"" code:response.code userInfo:nil];
            if (failure) {
                failure([KKNetworkBase errorCatch:error]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([KKNetworkBase errorCatch:error]);
        }
    }];
}


#pragma mark - 错误信息
+ (NSError *)errorCatch:(NSError *)error {
    NSLog(@"**************************************************************************************************");
    NSLog(@"%@",[NSString stringWithFormat:@"错误码:%ld",(long)error.code]);
    NSLog(@"%@",[NSString stringWithFormat:@"错误信息:%@",error.userInfo]);
    NSLog(@"%@",[NSString stringWithFormat:@"domain:%@",error.domain]);
    NSLog(@"**************************************************************************************************");
    return error;
    
    //    if (error.code == -1001) {
    //        return [NSError errorWithDomain:@"请求超时,请稍后重试" code:HDErrorNetworkTimeOut userInfo:error.userInfo];
    //    } else if (error.code == -1002) {
    //        return [NSError errorWithDomain:@"url无法解析"  code:HDErrorNetworkUnsupportedURL userInfo:error.userInfo];
    //    } else if (error.code == -1004) {
    //        return [NSError errorWithDomain:@"无法连接到服务器,请稍后重试" code:HDErrorNetworkCouldNotConnectServer userInfo:error.userInfo];
    //    } else if (error.code == -1005) {
    //        return [NSError errorWithDomain:@"网络连接丢失,请稍后重试"  code:HDErrorNetworkConnectionLost userInfo:error.userInfo];
    //    } else if (error.code == -1009) {
    //        return [NSError errorWithDomain:@"无网络,请稍后重试" code:HDErrorNetworkNoNetwork userInfo:error.userInfo];
    //    } else if (error.code == -1011) {
    //        return [NSError errorWithDomain:@"请求无效"  code:HDErrorNetworkBadRequest userInfo:error.userInfo];
    //    } else if (error.code == 10402) {
    //        //        UIViewController *topVC = [KKNetworkBase topViewController];
    //        //        [KKNetworkBase tokenWillExpired:topVC];
    //        //        [[NSNotificationCenter defaultCenter] postNotificationName:ClearCollectDataSoureNotification object:nil];
    //        //        [[NSNotificationCenter defaultCenter] postNotificationName:HD_TOKEN_WILL_EXPIRED_NOTIFICATION_KEY object:nil];
    //        //        [[NSNotificationCenter defaultCenter] postNotificationName:HD_TOKEN_EXPIRED_NOTIFICATION_KEY object:nil];
    //        return [NSError errorWithDomain:@"登录信息过期，请重新登录" code:HDErrorNetworkTokenExpired userInfo:error.userInfo];
    //    } else if(error.code == 15024) {
    //        return [NSError errorWithDomain:error.domain code:HDErrorNetworkNoBusinessManList userInfo:error.userInfo];
    //    } else if (error.code == 20103) {
    //        return [NSError errorWithDomain:error.domain code:HDErrorNetworkMachineCodeNotRegistered userInfo:error.userInfo];
    //    } else if (error.code == 20105 || error.code == 20106) {
    //        return [NSError errorWithDomain:error.domain code:HDErrorNetworkPasswordError userInfo:error.userInfo];
    //    } else if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
    //        NSString *domain = [NSString stringWithFormat:@"错误码:%ld",(long)error.code];
    //        return [NSError errorWithDomain:domain code:error.code userInfo:error.userInfo];
    //    } else {
    //        return error;
    //    }
}
@end
