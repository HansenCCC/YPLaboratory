//
//  YPHTTPRequest.m
//  WTPlatformSDK
//
//  Created by Hansen on 2022/12/15.
//

#import "YPHTTPRequest.h"
#import "YPNetworking.h"
#import <AFNetworking/AFNetworking.h>

@interface YPHTTPRequest ()


@end

@implementation YPHTTPRequest

- (void)startWithSuccessHandler:(void (^)(YPHTTPResponse *response))successHandler
                 failureHandler:(void (^)(NSError *error))failureHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (self.method == WTHTTPMethodGET) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    manager.requestSerializer.timeoutInterval = self.timeout;
    NSDictionary *parameters = self.parameters;
    NSDictionary *headers = self.httpHeader;
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",self.host?:@"",self.path?:@""];
    yplog_msg(@"network -> begin -> URL:%@",requestStr);
    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            YPHTTPResponse *data = [[YPHTTPResponse alloc] init];
            data.responseData = responseObject;
            if (data.code == 0) {
                if (successHandler) {
                    successHandler(data);
                }
                yplog_suc(@"network -> success -> URL:%@",requestStr);
            } else {
                NSString *errorDomain = nil;
                if ([data.message isKindOfClass:[NSString class]]) {
                    NSDictionary *errorDic = [data.message yp_jsonStringToDictionary];
                    if ([errorDic isKindOfClass:[NSDictionary class]]) {
                        errorDomain = errorDic[@"sub_msg"];
                    }
                    if (errorDomain.length == 0 && [errorDic isKindOfClass:[NSDictionary class]]) {
                        errorDomain = errorDic[@"message"];
                    }
                }
                NSError *error = [NSError errorWithDomain:errorDomain.length?errorDomain:(data.message?:@"") code:data.code userInfo:nil];
                if (failureHandler) {
                    failureHandler(error);
                }
                yplog_err(@"network -> failure -> URL:%@ header:%@ Parameters:%@ error:%@",requestStr, headers.yp_dictionaryToJsonStringNoSpace, parameters.yp_dictionaryToJsonStringNoSpace, error.description);
            }
        });
    };
    void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failureHandler) {
                failureHandler(error);
            }
            yplog_err(@"network -> failure -> URL:%@ header:%@ Parameters:%@ error:%@",requestStr, headers.yp_dictionaryToJsonStringNoSpace, parameters.yp_dictionaryToJsonStringNoSpace, error.description);
        });
    };
    if (self.method == WTHTTPMethodGET) {
        [manager GET:requestStr parameters:parameters headers:headers progress:nil success:success failure:failure];
    } else if (self.method == WTHTTPMethodPOST) {
        [manager POST:requestStr parameters:parameters headers:headers progress:nil success:success failure:failure];
    } else {
        if (failureHandler) {
            NSError *error = [NSError errorWithDomain:@"Not support" code:201 userInfo:nil];
            failureHandler(error);
        }
    }
}

#pragma mark - YPHTTPRequesting

- (NSString *)host {
    return kYP_API_HOST;
}

- (NSString *)path {
    return nil;
}

- (WTHTTPMethod)method {
    return WTHTTPMethodPOST;
}

- (NSDictionary *)parameters {
    return nil;
}

- (NSDictionary *)httpHeader {
    NSString *version = [YPSettingManager sharedInstance].device.version?:@"";
    NSString *bundle = [YPSettingManager sharedInstance].device.bundleId?:@"";
    NSString *device = [YPSettingManager sharedInstance].device.iPhoneName?:@"";
    NSString *date = @([[NSDate date] timeIntervalSince1970] * 1000).stringValue;
    return @{
        @"version":version,
        @"bundle":bundle,
        @"device":device,
        @"date":date,
    };
}

- (NSTimeInterval)timeout {
    return 60.f;
}

- (BOOL)isNeedToken {
    return NO;
}

@end
