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
    //to du
    //首先服务验证  -> 验证成功，删除凭证
    [[KKApplePayManner sharedInstance] deleteByPaymentVoucher:param];
}
@end
