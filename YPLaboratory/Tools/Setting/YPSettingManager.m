//
//  YPSettingManager.m
//  YPPrompts
//
//  Created by Hansen on 2023/4/20.
//

#import "YPSettingManager.h"
#import <StoreKit/StoreKit.h>

NSString *const kYPUserDefaultsServerVersionKey = @"kYPUserDefaultsServerVersionKey";// 服务版本
NSString *const kYPUserDefaultsForceUpdateKey = @"kYPUserDefaultsForceUpdateKey";// 是否强更
NSString *const kYPUserDefaultsAdvertisementKey = @"kYPUserDefaultsAdvertisementKey";// 广告json
NSString *const kYPUserDefaultsExtendKey = @"kYPUserDefaultsExtendKey";// 扩展

@interface YPSettingManager ()

@property (nonatomic, strong) YPLaboratoryDevice *device;

@end


@implementation YPSettingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YPSettingManager *sdk = nil;
    dispatch_once(&onceToken, ^{
        sdk = [[YPSettingManager alloc] init];
    });
    return sdk;
}

- (void)showComment {
    NSString *appid = [self appid];
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        // Fallback on earlier versions
        // 在 iOS 10.3 之前的版本中，您需要提供一个按钮，让用户在 App Store 中打开应用程序的评分页面
        NSString *reviewURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL] options:@{} completionHandler:nil];
    }
}

- (void)showAppstore {
    NSString *appId = [self appid];
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId]];
    if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
        [[UIApplication sharedApplication] openURL:appStoreURL options:@{} completionHandler:nil];
    }
}

#pragma mark - getters | setters

- (YPLaboratoryDevice *)device {
    if (!_device) {
        _device = [[YPLaboratoryDevice alloc] init];
    }
    return _device;
}

- (NSString *)serverVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kYPUserDefaultsServerVersionKey];
}

- (void)setServerVersion:(NSString *)serverVersion {
    [[NSUserDefaults standardUserDefaults] setObject:serverVersion forKey:kYPUserDefaultsServerVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)forceUpdate {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kYPUserDefaultsForceUpdateKey];
}

- (void)setForceUpdate:(BOOL)forceUpdate {
    [[NSUserDefaults standardUserDefaults] setBool:forceUpdate forKey:kYPUserDefaultsForceUpdateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)advertisement {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kYPUserDefaultsAdvertisementKey];
}

- (void)setAdvertisement:(NSString *)advertisement {
    [[NSUserDefaults standardUserDefaults] setObject:advertisement forKey:kYPUserDefaultsAdvertisementKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)extend {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kYPUserDefaultsExtendKey];
}

- (void)setExtend:(NSString *)extend {
    [[NSUserDefaults standardUserDefaults] setObject:extend forKey:kYPUserDefaultsExtendKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)canPopupUpdate {
    NSString *localVersion = self.device.version;
    NSString *serverVersion = self.serverVersion;
    NSComparisonResult result = [localVersion compare:serverVersion options:NSNumericSearch];
    if (result == NSOrderedAscending) {
        return YES;
    } else if (result == NSOrderedDescending) {
        return NO;
    } else {
        return NO;
    }
}

- (NSString *)appid {
    return @"1568656582";
}

- (NSString *)personalHomepage {
    return @"https://github.com/HansenCCC";
}

@end
