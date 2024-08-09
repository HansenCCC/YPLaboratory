//
//  YPHTTPVerifyPaymentRequest.m
//  YPPrompts
//
//  Created by Hansen on 2023/4/20.
//

#import "YPHTTPVerifyPaymentRequest.h"

@implementation YPHTTPVerifyPaymentRequest

//生产验证：https://buy.itunes.apple.com/verifyReceipt
//沙盒验证：https://sandbox.itunes.apple.com/verifyReceipt
- (NSString *)host {
#if DEBUG
    return @"https://sandbox.itunes.apple.com/verifyReceipt";
#else
    return @"https://buy.itunes.apple.com/verifyReceipt";
#endif
}

- (NSDictionary *)parameters {
    return @{
        @"receipt-data":self.receiptData?:@"",
    };
}

- (NSString *)path {
    return @"";
}

@end
