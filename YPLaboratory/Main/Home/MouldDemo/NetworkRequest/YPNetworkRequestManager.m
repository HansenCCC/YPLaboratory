//
//  YPNetworkRequestManager.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPNetworkRequestManager.h"
#import "YPCustomHTTPRequest.h"
#import "YpApiRequestDao.h"

@implementation YPNetworkRequestManager

+ (instancetype)shareInstance {
    static YPNetworkRequestManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPNetworkRequestManager alloc] init];
        m.method = YPRequestMethodGET;
        m.body = @{}.yp_dictionaryToJsonStringNoSpace;
        m.headers = [YPCustomHTTPRequest defaultHeaders].yp_dictionaryToJsonStringNoSpace;
        m.urlString = @"https://my.chuizi.shop/api/v1/helloWorld";
        [[YpApiRequestDao get] openWithPath:@"api-request"];
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
