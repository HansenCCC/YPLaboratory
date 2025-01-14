//
//  YPGetIPAddressRequest.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/14.
//

#import "YPGetIPAddressRequest.h"

@implementation YPGetIPAddressRequest

- (NSString *)host {
    return @"https://my.chuizi.shop/api/v1/helloWorld";
}

- (WTHTTPMethod)method {
    return WTHTTPMethodGET;
}

- (NSDictionary *)httpHeader {
    return @{
        @"content-type": @"application/json; charset=utf-8",
    };
}

@end
