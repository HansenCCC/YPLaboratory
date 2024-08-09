//
//  AppDelegate.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+KKThird.h"
#import "AppDelegate+KKConfig.h"
#import "KKRootViewController.h"//root

//第三方支付回调
#import "KKPayManager.h"//支付管理

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self jpushInitDidFinishLaunchingWithOptions:launchOptions];//添加初始化JPush代码
    [self registerUserNotification];//注册通知
    [self listenNetworkReachabilityStatus];//网络监控
    [self keyboardManagerConfig];//键盘防遮盖输入框
    [self buglyConfigure];//bugle 闪退崩溃记录
    [self setupConfig];//配置
    [self checkInternalPurchasePayment];//校验内购支付是否存在丢单的订单
    [self setRootViewController];
    //关闭黑夜模式
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    //log
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"🚀🚀🚀\n文件存储地址：%@\n🚀🚀🚀",docuPath);
    
    NSLog(@"%d",(NO != nil));
    NSLog(@"%d",(YES != nil));
    
    return YES;
}
//设置根试图
- (void)setRootViewController{
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    [self.window makeKeyAndVisible];
    KKRootViewController *vc = [[KKRootViewController alloc] init];
    self.window.rootViewController = vc;
}
//指定页面禁止使用第三方键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier{
    NSArray *vcClass = @[
                         ];
    for (Class a in vcClass) {
        if ([self.window.topViewController isKindOfClass:a]) {
            return NO;
        }
    }
    return YES;
}
//屏幕朝向问题
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIViewController *vc = self.window.topViewController;
    //由vc控制
    UIInterfaceOrientationMask orientationMask = [vc supportedInterfaceOrientations];
    return orientationMask;
}
@end
