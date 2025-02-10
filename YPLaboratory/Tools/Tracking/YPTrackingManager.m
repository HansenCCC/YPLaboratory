//
//  YPTrackingManager.m
//  YPPrompts
//
//  Created by Hansen on 2023/4/24.
//

#import "YPTrackingManager.h"
#import <sys/utsname.h>
#import <TapTapCoreSDK/TapTapCoreSDK.h>

@implementation YPTrackingManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YPTrackingManager *sdk = nil;
    dispatch_once(&onceToken, ^{
        sdk = [[YPTrackingManager alloc] init];
    });
    return sdk;
}

- (void)initTrackSDK {
    NSString *channelId = @"iOS_Lab";
    NSString *clientId = @"fqccakk6l9bjfab1fa";
    NSString *clientToken = @"LxI0WiysC6S6obeEKT6S3g4axS4gbHP7chN78emf";
    NSString *version = [YPAppManager shareInstance].version?:@"";
    NSDictionary *eventProperties = [self eventProperties];
    
    TapTapSdkOptions *options = [[TapTapSdkOptions alloc] init];
    options.clientId = clientId;
    options.clientToken = clientToken;
    options.overrideBuiltInParameters = false;
    options.enableAdvertiserIDCollection = false;
    options.enableAutoIAPEvent = true;
    options.channel = channelId;
    options.gameVersion = version;
    options.properties = eventProperties;
    options.region = TapTapRegionTypeOverseas;
#ifdef DEBUG
//    options.enableLog = YES;
#endif
    [TapTapSDK initWithOptions:options];
}

- (void)uploadEvent:(YPTrackingEventType)type event:(NSDictionary *)event {
    NSMutableDictionary *tempEvent = [[NSMutableDictionary alloc] init];
    if (event.count) {
        [tempEvent addEntriesFromDictionary:event];
    }
    NSString *name = @"";
    switch (type) {
        case YPTrackingEventTypeUnknown: {
            /// 未知埋点
            name = @"lab_unknown";
        }
            break;
    }
    [TapTapEvent logEvent:[NSString stringWithFormat:@"#%@",name] properties:tempEvent];
}

- (NSDictionary *)eventProperties {
    NSString *version = [YPAppManager shareInstance].version?:@"";
    NSString *bundle = [YPAppManager shareInstance].bundleID?:@"";
    NSString *appid = [YPAppManager shareInstance].appID?:@"";
    NSString *deviceIdentifier = self.deviceIdentifier?:@"";
    NSString *device = [YPAppManager shareInstance].deviceName?:@"";
    return @{
        @"#tv_app_appid":appid,
        @"#tv_app_bundle":bundle,
        @"#tv_app_version":version,
        @"#tv_app_udid":deviceIdentifier,
        @"#tv_app_device": device,
    };
}

#pragma mark - deviceIdentifier

- (NSString *)udid {
    return [self deviceIdentifier];
}

- (NSString *)deviceIdentifier {
    NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
    NSString *deviceIdentifierKeychainServiceName = [NSString stringWithFormat:@"%@.woodfish.deviceIdentifier", bundleIdentifier];
    NSString *savedDeviceIdentifier = [YPKeychain loadObjectForKey:deviceIdentifierKeychainServiceName];
    NSString *savedDeviceIdentifierDeviceOnly = [YPKeychain loadDeviceOnlyObjectForKey:deviceIdentifierKeychainServiceName];
    if (savedDeviceIdentifier.length) {
        //如果之前存在 不是 this device only 的 key, 则删除
        [YPKeychain deleteObjectForKey:deviceIdentifierKeychainServiceName];
    }
    if (savedDeviceIdentifierDeviceOnly.length && !([savedDeviceIdentifierDeviceOnly rangeOfString:@"00000000"].length > 0)) {
        //存在 this device only 的 key, 返回。
        return savedDeviceIdentifierDeviceOnly;
    }
    
    NSString *identifier = self.p_deviceIdentifier;
    if (savedDeviceIdentifier.length && !([savedDeviceIdentifier rangeOfString:@"00000000"].length > 0)) {
        //需要将之前的 not this device only 的 key 存储，并返回。
        identifier = savedDeviceIdentifier;
    }
    [YPKeychain saveDeviceOnlyObject:identifier forKey:deviceIdentifierKeychainServiceName];
    return identifier;
}

- (NSString *)p_deviceIdentifier {
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
    NSString *identifier = [NSString stringWithFormat:@"%@+%@", uuid.UUIDString, bundleIdentifier];
    return identifier.yp_md5.localizedUppercaseString;
}

@end
