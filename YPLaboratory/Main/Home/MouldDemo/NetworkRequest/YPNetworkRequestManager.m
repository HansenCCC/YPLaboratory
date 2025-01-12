//
//  YPNetworkRequestManager.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPNetworkRequestManager.h"

@implementation YPNetworkRequestManager

+ (instancetype)shareInstance {
    static YPNetworkRequestManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPNetworkRequestManager alloc] init];
        m.method = YPRequestMethodGET;
        m.body = @"{}";
        m.headers = @"{}";
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

@end
