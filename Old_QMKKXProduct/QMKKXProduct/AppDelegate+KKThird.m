//
//  AppDelegate+KKThird.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/27.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate+KKThird.h"
#import <UserNotifications/UserNotifications.h>
#import <AdSupport/AdSupport.h>
#import <JPUSHService.h>
#import <Bugly/Bugly.h>
#import "KKPayManager.h"//支付管理

#define kJPushAppKey @"6d07b5c0eec2ef820228c45f"//极光推送key
#define kBuglyAppId @"e336771932"//apiiidapiiid

@interface AppDelegate (KKThird)<JPUSHRegisterDelegate,BuglyDelegate>

@end

@implementation AppDelegate (KKThird)
+ (void)load{
    //设置图片下载超时时间
    [SDWebImageDownloader sharedDownloader].downloadTimeout = 20.f;
}
//iq键盘配置
- (void)keyboardManagerConfig{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    //    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    //    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

#pragma mark - 推送相关
//注册通知
- (void)registerUserNotification {
    [self APNS_init];
}
#pragma mark - UNUserNotificationCenterDelegate
// app处在前台收到推送消息执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    completionHandler(UNNotificationPresentationOptionNone);
}
// ios 10以后系统，app处在后台，点击通知栏 app执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    completionHandler();
}
#pragma mark - application
//远程通知注册成功委托
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"注册deviceToken---%@",deviceToken);
    //Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//远程通知注册失败委托
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}
//收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//添加初始化APNs代码
- (void)APNS_init{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        [JPUSHService registerForRemoteNotificationTypes:types categories:nil];
#pragma clang diagnostic pop
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}
#pragma mark - JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler{
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        //to do
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterUserClickPush object:nil];
    completionHandler();  // 系统要求执行这个方法
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification NS_AVAILABLE_IOS(12.0){
    
}

//添加初始化JPush代码
- (void)jpushInitDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //极光推送
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
                          channel:[KKUser shareInstance].channel
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
}
#pragma mark - 网络监听
//监听网络测试
- (void)listenNetworkReachabilityStatus{
    // 实例化 AFNetworkReachabilityManager
    AFNetworkReachabilityManager * afManager = [AFNetworkReachabilityManager sharedManager];
    /**
     判断网络状态并处理
     @param status 网络状态
     AFNetworkReachabilityStatusUnknown             = 未知网络
     AFNetworkReachabilityStatusNotReachable        = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN    = 蜂窝网络（3g、4g、wwan）
     AFNetworkReachabilityStatusReachableViaWiFi    = wifi网络
     */
    WeakSelf
    [afManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"当前网络状态未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络已断开");
                [weakSelf showNetworkFailAlert];
                break;
            default:
                NSLog(@"网络已连接");
                break;
        }
    }];
    // 开始监听
    [afManager startMonitoring];
}
//展示网络异常alert弹框
- (void)showNetworkFailAlert{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc =  delegate.window.topViewController;
    if ([vc isKindOfClass:[KKUIBasePresentController class]]) {
        return;
    }
    WeakSelf
    NSString *title = @"提示";
    NSString *content = @"网络好像除了点问题，\n重新试试吧~";
    NSString *leftTitle = @"退出";
    NSString *rightTitle = @"重试";
    [KKAlertViewController showCustomWithTitle:title textDetail:content leftTitle:leftTitle rightTitle:rightTitle isOnlyOneButton:NO isShowCloseButton:NO canTouchBeginMove:NO complete:^(KKAlertViewController *controler, NSInteger index) {
        if (index == 0) {
            exit(0);
        }else if(index == 1){
            [controler dismissViewControllerCompletion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf listenNetworkReachabilityStatus];
            });
        }
    }];
}
#pragma mark - bugle
//三方bugle
- (void)buglyConfigure{
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
//此方法返回的数据，可在bugly平台中异常上报，具体异常信息的跟踪数据附件信息中的crash_attach.log中查看
- (NSString *)attachmentForException:(NSException *)exception{
    return [NSString stringWithFormat:@"exceptionInfo:\nname:%@\nreason:%@",exception.name,exception.reason];
}
#pragma mark - iOS 9.0 以后  支付、分享、回调openURL相关
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    NSString *urlStr = url.absoluteString;
    if([urlStr.lowercaseString containsString:kQMKKXAuthLogin.lowercaseString]){
        //qmkkx跳转授权页面
        [[KKUser shareInstance] postNotificationToQMKKXAuthLogin:urlStr];
        return YES;
    }
//    //第三方支付回调
//    if ([url.host isEqualToString:@"safepay"]) {
//        //支付跳转支付宝钱包进行支付，处理支付结果
//        return [[KKPayManager sharedInstance] aliPayHandleOpenURL:url];
//    }else if([url.host isEqualToString:@"pay"]||[url.host isEqualToString:@"oauth"]){
//        //支付跳转微信钱包进行支付，处理支付结果
//        return [[KKPayManager sharedInstance] weChatHandleOpenURL:url];
//    }
    return YES;
}
@end
