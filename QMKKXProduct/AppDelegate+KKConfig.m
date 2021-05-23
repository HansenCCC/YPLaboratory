//
//  AppDelegate+KKConfig.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate+KKConfig.h"

@implementation AppDelegate (KKConfig)

//获取配置（退出登录和重新登录需要重新请求）
- (void)setupConfig{
    //配置
    [[KKUser shareInstance] setupConfig];
}

#pragma mark - 校验内购
- (void)checkInternalPurchasePayment{
    WeakSelf
    [[KKApplePayManner sharedInstance] checkInternalPurchasePayment:^(NSString *checkPath, NSDictionary *payDic, NSError *error) {
        NSLog(@"%@",error);
        if (payDic.count > 0) {
            [weakSelf requestSendAppStoreBuyReceipt:payDic];
        }
    }];
}
//向服务端发送购买凭证 验证真实性和正确性
- (void)requestSendAppStoreBuyReceipt:(NSDictionary *)param{
#if QMKKXProductDEV//测试环境
    NSString *checkURL = @"https://sandbox.itunes.apple.com/verifyReceipt";
#elif QMKKXProduct//正式环境
    NSString *checkURL = @"https://buy.itunes.apple.com/verifyReceipt";
#endif
    //timeoutInterval需要长一点
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:checkURL.toURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    request.HTTPMethod = @"POST";
    NSString *receiptData = param[@"receiptData"];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}",receiptData];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = payloadData;
    NSURLSession *sessionPost = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sessionPost dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if ([result[@"status"] intValue] == 0) {
                    //支付成功 (通常需要校验：bid，product_id，purchase_date，status，in_app)
                    [[KKApplePayManner sharedInstance] deleteByPaymentVoucher:param];
                }
            }
        });
    }];
    [dataTask resume];
}
@end
