//
//  AppDelegate+KKConfig.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (KKConfig)
//获取配置（退出登录和重新登录需要重新请求）
- (void)setupConfig;
//校验内购
- (void)checkInternalPurchasePayment;
@end

