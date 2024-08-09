//
//  YPHTTPVerifyPaymentRequest.h
//  YPPrompts
//
//  Created by Hansen on 2023/4/20.
//

#import <Foundation/Foundation.h>
#import "YPHTTPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPHTTPVerifyPaymentRequest : YPHTTPRequest

@property (nonatomic, strong) NSString *receiptData;

@end

NS_ASSUME_NONNULL_END
