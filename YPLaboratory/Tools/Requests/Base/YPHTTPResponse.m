//
//  YPHTTPResponse.m
//  WTPlatformSDK
//
//  Created by Hansen on 2022/12/15.
//

#import "YPHTTPResponse.h"

NSString *const kYP_RESPONESE_CODE = @"code";
NSString *const kYP_RESPONESE_MESSAGE = @"msg";
NSString *const kYP_RESPONESE_TOKEN = @"token";
NSString *const kYP_RESPONESE_PKGTYPE = @"pkg_type";
NSString *const kYP_RESPONESE_VERSION = @"version";
NSString *const kYP_RESPONESE_PHONE_ATUO = @"phone_auto";

@implementation YPHTTPResponse

- (NSInteger)code {
    NSInteger unknow = 10000;
    if (!self.responseData || ![self.responseData isKindOfClass:[NSDictionary class]]) {
        return unknow;
    }
    NSInteger code = [NSString stringWithFormat:@"%@",self.responseData[kYP_RESPONESE_CODE]].integerValue;
    return code;
}

- (NSString *)message {
    if (!self.responseData || ![self.responseData isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSString *message = self.responseData[kYP_RESPONESE_MESSAGE];
    return message;
}

@end
