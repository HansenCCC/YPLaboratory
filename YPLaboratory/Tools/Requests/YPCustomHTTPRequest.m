//
//  YPCustomHTTPRequest.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPCustomHTTPRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation YPCustomHTTPRequest

+ (NSDictionary *)defaultHeaders {
    return [AFHTTPRequestSerializer serializer].HTTPRequestHeaders;
}

- (NSString *)host {
    return self.urlString;
}

- (NSString *)path {
    return @"";
}

- (NSDictionary *)parameters {
    return self.body;
}

- (NSDictionary *)httpHeader {
    return self.headers;
}

- (void)startWithSuccessHandler:(void (^)(YPHTTPResponse * _Nonnull))successHandler failureHandler:(void (^)(NSError * _Nonnull))failureHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = self.timeout;
    NSDictionary *parameters = self.parameters;
    NSDictionary *headers = self.httpHeader;
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",self.host,self.path];
    
    
    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            YPHTTPResponse *data = [[YPHTTPResponse alloc] init];
            data.responseData = responseObject;
            if (successHandler) {
                successHandler(data);
            }
        });
    };
        
    void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failureHandler) {
                failureHandler(error);
            }
        });
    };
    
    if ([self.methodString isEqualToString:@"GET"]) {
        [manager GET:requestStr parameters:parameters headers:headers progress:nil success:success failure:failure];
    } else if ([self.methodString isEqualToString:@"POST"]) {
        [manager POST:requestStr parameters:parameters headers:headers progress:nil success:success failure:failure];
    } else if ([self.methodString isEqualToString:@"PUT"]) {
        [manager PUT:requestStr parameters:parameters headers:headers success:success failure:failure];
    } else if ([self.methodString isEqualToString:@"DELETE"]) {
        [manager DELETE:requestStr parameters:parameters headers:headers success:success failure:failure];
    } else if ([self.methodString isEqualToString:@"DELETE"]) {
        [manager HEAD:requestStr parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task) {
            dispatch_async(dispatch_get_main_queue(), ^{
                YPHTTPResponse *data = [[YPHTTPResponse alloc] init];
                if (successHandler) {
                    successHandler(data);
                }
            });
        } failure:failure];
    }
}

@end
