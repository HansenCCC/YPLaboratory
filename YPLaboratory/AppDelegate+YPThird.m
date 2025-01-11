//
//  AppDelegate+YPThird.m
//  YPChildStudy
//
//  Created by Hansen on 2023/1/1.
//

#import "AppDelegate+YPThird.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>
#import <Bugly/Bugly.h>
#import "YPPurchaseManager.h"
#import "YPHTTPVerifyPaymentRequest.h"

@interface AppDelegate () <BuglyDelegate>

@end

@implementation AppDelegate (YPThird)

#pragma mark - database

- (void)setupDatabase {

}

#pragma mark - Bugly

- (void)buglyInitConfigure {
    NSString *kBuglyAppId = @"e336771932";
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.unexpectedTerminatingDetectionEnable = NO; //非正常退出事件记录开关，默认关闭
    config.reportLogLevel = BuglyLogLevelWarn; //报告级别
    config.deviceIdentifier = [UIDevice currentDevice].identifierForVendor.UUIDString; //设备标识
    config.blockMonitorEnable = YES; //开启卡顿监控
    config.blockMonitorTimeout = 10; //卡顿监控判断间隔，单位为秒
    config.delegate = self;
#if DEBUG
    config.debugMode = NO; //SDK Debug信息开关, 默认关闭
    config.channel = @"debug";
#else
    config.channel = @"release";
#endif
    [Bugly startWithAppId:kBuglyAppId
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
}

- (NSString *)attachmentForException:(NSException *)exception {
    return [NSString stringWithFormat:@"🚀🚀🚀 exceptionInfo:\nname:%@\nreason:%@ 🚀🚀🚀",exception.name, exception.reason];
}

#pragma mark - notification

- (void)addObserverNotification {
    // 收到需要检查内购丢包情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needCheckInternalPurchasePayment:) name:kYPPurchaseNeedCheckInternalPurchasePayment object:nil];
}

#pragma mark - check pay

- (void)checkInternalPurchasePayment {
    __weak typeof(self) weakSelf = self;
    [[YPPurchaseManager sharedInstance] checkInternalPurchasePayment:^(NSString *checkPath, NSDictionary *payDic, NSError *error) {
        if (payDic.count > 0) {
            [weakSelf requestSendAppStoreBuyReceipt:payDic];
        }
    }];
}

- (void)needCheckInternalPurchasePayment:(NSNotification *)sender {
    __weak typeof(self) weakSelf = self;
    [[YPPurchaseManager sharedInstance] checkInternalPurchasePayment:^(NSString *checkPath, NSDictionary *payDic, NSError *error) {
        if (payDic.count > 0) {
            [weakSelf requestSendAppStoreBuyReceipt:payDic];
        }
    }];
}

- (void)requestSendAppStoreBuyReceipt:(NSDictionary *)payDic {
    YPHTTPVerifyPaymentRequest *request = [[YPHTTPVerifyPaymentRequest alloc] init];
    request.receiptData = payDic[@"receiptData"];
    [request startWithSuccessHandler:^(YPHTTPResponse * _Nonnull response) {
        if ([response.responseData[@"status"] intValue] == 0) {
            // 检验成功，用户已经支付了
            [[YPPurchaseManager sharedInstance] deleteByPaymentVoucher:payDic];
            [YPAlertView alertText:@"谢谢您的慷慨。\n祝您工作顺利，生活愉快！".yp_localizedString duration:4.f];
        }
    } failureHandler:^(NSError * _Nonnull error) {
        //
    }];
}

@end
