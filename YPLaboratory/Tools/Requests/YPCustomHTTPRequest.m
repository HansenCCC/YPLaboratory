//
//  YPCustomHTTPRequest.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPCustomHTTPRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "YpApiRequestDao.h"
#import "YPNetworkRequestManager.h"

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
    
    int64_t apiId = 0;
    YpApiRequest *request = [[YpApiRequest alloc] init];
    request.startDate = [NSDate date];
    request.createdDate = request.startDate;
    request.updatedDate = request.startDate;
    request.url = requestStr;
    request.method = self.methodString;
    request.headers = self.headers.yp_dictionaryToJsonStringNoSpace;
    request.body = self.body.yp_dictionaryToJsonStringNoSpace;
    request.isLoading = YES;
    request.isEnable = YES;
    [[YpApiRequestDao get] insertYpApiRequest:request aRid:&apiId];
    request.id = apiId;
    [YPNetworkRequestManager shareInstance].lastRequest = request;
    void (^success)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            request.endDate = [NSDate date];
            request.isLoading = NO;
            request.success = YES;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                request.response = ((NSDictionary *)responseObject).yp_dictionaryToJsonStringNoSpace;
            } else if ([responseObject isKindOfClass:[NSArray class]]) {
                NSString *jsonString = ((NSArray *)responseObject).mj_JSONString;
                jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
                request.response = jsonString;
            } else if ([responseObject isKindOfClass:[NSString class]]) {
                request.response = (NSString *)responseObject;
            } else if ([responseObject isKindOfClass:[NSString class]]) {
                request.response = (NSString *)responseObject;
            } else if ([responseObject isKindOfClass:[NSData class]]) {
                NSString *responseString = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                if (responseString) {
                    request.response = responseString;
                } else {
                    request.response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSASCIIStringEncoding];
                }
            }
            [[YpApiRequestDao get] updateYpApiRequestByPrimaryKey:apiId aYpApiRequest:request];
            [YPNetworkRequestManager shareInstance].lastRequest = request;
            YPHTTPResponse *data = [[YPHTTPResponse alloc] init];
            data.responseData = responseObject;
            if (successHandler) {
                successHandler(data);
            }
        });
    };
        
    void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            request.endDate = [NSDate date];
            request.isLoading = NO;
            request.success = NO;
            if (error.userInfo[@"responseData"]) {
                NSData *responseData = error.userInfo[@"responseData"];
                NSString *errorResponseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                request.response = errorResponseString; // 或者做其他处理
            } else {
                request.response = [NSString stringWithFormat:@"%@", error];
            }
            [[YpApiRequestDao get] updateYpApiRequestByPrimaryKey:apiId aYpApiRequest:request];
            [YPNetworkRequestManager shareInstance].lastRequest = request;
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
    } else if ([self.methodString isEqualToString:@"HEAD"]) {
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
