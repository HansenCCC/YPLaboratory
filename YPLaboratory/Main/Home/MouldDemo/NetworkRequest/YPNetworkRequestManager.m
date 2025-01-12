//
//  YPNetworkRequestManager.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPNetworkRequestManager.h"
#import "YPCustomHTTPRequest.h"

@implementation YPNetworkRequestManager

+ (instancetype)shareInstance {
    static YPNetworkRequestManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPNetworkRequestManager alloc] init];
        m.method = YPRequestMethodGET;
        m.body = @{}.yp_dictionaryToJsonStringNoSpace;
        m.headers = [YPCustomHTTPRequest defaultHeaders].yp_dictionaryToJsonStringNoSpace;
        m.urlString = @"https://chuizi.shop";
    });
    return m;
}

- (NSString *)methodString {
    return self.methods[self.method];
}

- (NSArray <NSString*> *)methods {
    return @[
        @"GET",
        @"POST",
        @"PUT",
        @"DELETE",
        @"OPTIONS",
        @"HEAD",
    ];
}

- (NSDictionary *)headersDictionary {
    return self.headers.yp_jsonStringToDictionary;
}

- (NSDictionary *)bodyDictionary {
    return self.body.yp_jsonStringToDictionary;
}

@end
