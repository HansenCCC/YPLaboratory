//
//  AppDelegate.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "AppDelegate.h"
#import "YPRootViewController.h"
#import "AppDelegate+YPThird.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[YPTrackingManager sharedInstance] initTrackSDK];
    [self jpushInitDidFinishLaunchingWithOptions:launchOptions];// 初始化极光push
    [self buglyInitConfigure];// 初始化bugly
    [self setupDatabase];// 初始化数据库
    [self addObserverNotification];
    [self checkInternalPurchasePayment];// 检验是否存在丢包情况
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    YPRootViewController *vc = [[YPRootViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
