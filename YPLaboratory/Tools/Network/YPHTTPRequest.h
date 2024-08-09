//
//  YPHTTPRequest.h
//  WTPlatformSDK
//
//  Created by Hansen on 2022/12/15.
//

#import <Foundation/Foundation.h>
#import "YPHTTPResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WTHTTPMethodGET = 0,
    WTHTTPMethodPOST,
} WTHTTPMethod;

@protocol YPHTTPRequesting <NSObject>

- (BOOL)isNeedToken;
- (NSString *)host;
- (NSString *)path;
- (WTHTTPMethod)method;
- (NSDictionary *)parameters;
- (NSDictionary *)httpHeader;

@optional
- (NSTimeInterval)timeout;

@end

@interface YPHTTPRequest : NSObject <YPHTTPRequesting>

- (void)startWithSuccessHandler:(void (^)(YPHTTPResponse *response))successHandler
                 failureHandler:(void (^)(NSError *error))failureHandler;

@end

NS_ASSUME_NONNULL_END
