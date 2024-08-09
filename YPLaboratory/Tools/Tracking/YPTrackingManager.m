//
//  YPTrackingManager.m
//  YPPrompts
//
//  Created by Hansen on 2023/4/24.
//

#import "YPTrackingManager.h"
#import <TapDB/TapDB.h>
#import "YPSettingManager.h"
#import <sys/utsname.h>

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
    NSString *channelId = @"iOS";
    NSString *version = [YPSettingManager sharedInstance].device.version?:@"";
    NSString *appid = @"t2qk277be6vwwjkx";
    NSDictionary *eventProperties = [self eventProperties];
    [TapDB registerStaticProperties:eventProperties];
    [TapDB onStart:appid channel:channelId version:version properties:@{}];
    NSString *device = [TapDB getDeviceId];
    [TapDB setUser:device];
#ifdef DEBUG
    [TapDB enableLog:YES];
#endif
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
            name = @"prompt_unknown";
        }
            break;
        case YPTrackingEventTypeCopy: {
            /// 点击复制
            name = @"prompt_copy";
        }
            break;
        case YPTrackingEventTypeSafari: {
            /// 跳转Safari
            name = @"prompt_safari";
        }
            break;
        case YPTrackingEventTypePayment: {
            /// 点击支付
            name = @"prompt_payment";
        }
            break;
        case YPTrackingEventTypePaymentComplete: {
            /// 支付完成
            name = @"prompt_paymentcomplete";
            NSString *orderId = tempEvent[@"orderId"];// 订单号
            NSString *productName = tempEvent[@"productName"];// 产品名称
            NSInteger amount = [NSString stringWithFormat:@"%@",tempEvent[@"amount"]].intValue;// 金额 分
            [TapDB onChargeSuccess:orderId product:productName amount:amount currencyType:@"CNY" payment:@"Apple" properties:tempEvent];
            return;
        }
            break;
        case YPTrackingEventTypeCheckUpdate: {
            /// app 检查更新
            name = @"prompt_checkupdate";
        }
            break;
        default: {
            name = @"prompt_unknown";
        }
            break;
    }
    [TapDB trackEvent:[NSString stringWithFormat:@"#%@",name] properties:tempEvent];
}

- (NSDictionary *)eventProperties {
    NSString *version = [YPSettingManager sharedInstance].device.version?:@"";
    NSString *bundle = [YPSettingManager sharedInstance].device.bundleId?:@"";
    NSString *deviceIdentifier = self.deviceIdentifier?:@"";
    NSString *device = [YPSettingManager sharedInstance].device.iPhoneName?:@"";
    return @{
        @"#app_bundle":bundle,
        @"#app_version":version,
        @"#app_udid":deviceIdentifier,
        @"#app_device": device,
    };
}

#pragma mark - deviceIdentifier

- (NSString *)udid {
    return [self deviceIdentifier];
}

- (NSString *)deviceIdentifier {
    NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
    NSString *deviceIdentifierKeychainServiceName = [NSString stringWithFormat:@"%@.laboratory.deviceIdentifier", bundleIdentifier];
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
