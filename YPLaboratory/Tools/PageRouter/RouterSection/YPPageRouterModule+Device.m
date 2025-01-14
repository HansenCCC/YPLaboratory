//
//  YPPageRouterModule+Device.m
//  YPLaboratory
//
//  Created by Hansen on 2024/12/11.
//

#import "YPPageRouterModule+Device.h"
#import "YPPageRouterModule+Update.h"

@implementation YPPageRouterModule (Device)

+ (NSArray *)ComponentRouters_Device {
    void (^didSelectedCallback)(YPPageRouter *router, UIView *cell) = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = router.content?:@"";
        [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",router.content?:@"",@"字体已复制".yp_localizedString]];
        [[YPShakeManager shareInstance] longPressShake];
    };
    
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"应用名称".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].appName;
        element.didSelectedCallback = didSelectedCallback;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"版本号".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].version;
        element.didSelectedCallback = didSelectedCallback;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"build".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].build;
        element.didSelectedCallback = didSelectedCallback;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"BundleID".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].bundleID;
        element.didSelectedCallback = didSelectedCallback;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"AppID".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].appID;
        element.didSelectedCallback = didSelectedCallback;
        [dataList addObject:element];
    }
    NSMutableArray *dataList2 = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"设备型号".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].deviceName;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"设备符号".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].deviceString;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"系统名称".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].systemName;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"系统版本".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].systemVersion;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"电池电量".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = @([YPAppManager shareInstance].batteryLevel).stringValue;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"电池状态".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].batteryState;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"当前网络类型".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].networkType;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"运营商名称".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].carrierName;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"当前IP".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].ipAddress;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Wi-Fi名称".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].wifiSSID;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"User Agent".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].userAgent;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"UUID".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].deviceUUID;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"唯一标识(删不变)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPAppManager shareInstance].yp_deviceIdentifier;
        element.didSelectedCallback = didSelectedCallback;
        [dataList2 addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    section.headerTitle = @"InfoPlist";
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList2];
    section2.headerTitle = @"Device";
    return @[section, section2];
}

@end
