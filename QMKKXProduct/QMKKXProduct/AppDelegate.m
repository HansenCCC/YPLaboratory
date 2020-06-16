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
    [self setupAVOSCloud];
    [self IQKeyBoradConfig];
    [self setupConfig];//配置
    [self setRootViewController];
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
#pragma mark - iOS 9.0 以后  支付、分享、回调openURL相关
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    NSString *urlStr = url.absoluteString;
    if([urlStr.lowercaseString containsString:kQMKKXAuthLogin.lowercaseString]){
        //qmkkx跳转授权页面
        [[KKUser shareInstance] postNotificationToQMKKXAuthLogin:urlStr];
        return YES;
    }
    //第三方支付回调
    if ([url.host isEqualToString:@"safepay"]) {
        //支付跳转支付宝钱包进行支付，处理支付结果
        return [[KKPayManager sharedInstance] aliPayHandleOpenURL:url];
    }else if([url.host isEqualToString:@"pay"]||[url.host isEqualToString:@"oauth"]){
        //支付跳转微信钱包进行支付，处理支付结果
        return [[KKPayManager sharedInstance] weChatHandleOpenURL:url];
    }
    return YES;
}
@end
