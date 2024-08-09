//
//  AppDelegate+YPThird.m
//  YPChildStudy
//
//  Created by Hansen on 2023/1/1.
//

#import "AppDelegate+YPThird.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>
#import <Bugly/Bugly.h>
#import "YPPurchaseManager.h"
#import "YPHTTPVerifyPaymentRequest.h"

@interface AppDelegate () <JPUSHRegisterDelegate, BuglyDelegate>

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


#pragma mark - JPUSH

- (void)jpushInitDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerUserNotification];
    //极光推送
    NSString *kJPushAppKey = @"6d07b5c0eec2ef820228c45f";
    NSString *kChannel = @"1000";
    NSInteger apsForProduction = 1;
# ifdef DEBUG
    apsForProduction = 0;
# endif
    [JPUSHService setLogOFF];
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey channel:kChannel apsForProduction:apsForProduction];
}

- (void)registerUserNotification {
    [self APNS_init];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)) {
    completionHandler();
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

- (void)APNS_init {
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    } else {
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        [JPUSHService registerForRemoteNotificationTypes:types categories:nil];
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    } else {
        //to do
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kYPNSNotificationCenterClickPush object:nil];
    completionHandler();
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification NS_AVAILABLE_IOS(12.0) {
    
}

#pragma clang diagnostic pop

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
            [YPAlertView alertText:@"谢谢您的慷慨。\n祝您工作顺利，生活愉快！" duration:4.f];
            NSString *productName = payDic[@"productName"]?:@"";
            NSString *orderId = [NSString stringWithFormat:@"%@",payDic[@"transactionId"]?:@""];
            NSInteger amount = [NSString stringWithFormat:@"%@",payDic[@"price"]].floatValue * 100;// 金额 分
            // 上报支付成功
            [[YPTrackingManager sharedInstance] uploadEvent:YPTrackingEventTypePaymentComplete event:@{
                @"orderId":orderId,
                @"productName":productName,
                @"amount":@(amount),
            }];
        }
    } failureHandler:^(NSError * _Nonnull error) {
        //
    }];
}

@end
