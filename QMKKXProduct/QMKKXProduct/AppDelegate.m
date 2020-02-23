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
//第三方传值或登录
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString *urlStr = url.absoluteString;
    if([urlStr.lowercaseString containsString:kQMKKXAuthLogin.lowercaseString]){
        //qmkkx跳转授权页面
        [[KKUser shareInstance] postNotificationToQMKKXAuthLogin:urlStr];
        return YES;
    }
    return YES;
}
@end
