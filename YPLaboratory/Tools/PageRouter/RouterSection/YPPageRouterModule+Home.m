//
//  YPPageRouterModule+Home.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/3.
//

#import "YPPageRouterModule+Home.h"
#import "YPH5WebviewController.h"

@implementation YPPageRouterModule (Home)

+ (NSArray *)HomeRouters {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"UI 组件".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"网络".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"常见架构模式".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"常见算法".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"内购支付".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"数据库".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"App 图标制作".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"文件管理".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSString *path = NSHomeDirectory();
            YPFileBrowserController *browser = [[YPFileBrowserController alloc] initWithPath:path];
            YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:browser];
            [[UIViewController yp_topViewController] presentViewController:nav animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"摄像机".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"JS 和 OC 交互".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"模拟 mdos 攻击".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"获取设备信息".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"获取 WIFI 列表".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"获取蓝牙设备列表".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"Socket 的消息互传".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"调试日志".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSString *path = [YPLog logPath];
            YPFileBrowserController *browser = [[YPFileBrowserController alloc] initWithPath:path];
            YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:browser];
            [[UIViewController yp_topViewController] presentViewController:nav animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"触觉与音效反馈".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"技术交流群".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPH5WebviewController *vc = [[YPH5WebviewController alloc] init];
            vc.request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://chuizi.shop/app/1568656582/exchange/index.html"]];
            YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:vc];
            [[UIViewController yp_topViewController] presentViewController:nav animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"代码生成工具".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    YPPageRouterModule *section1 = [[YPPageRouterModule alloc] initWithRouters:dataList];
    NSMutableArray *dataList1 = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"项目依赖".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList1 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"检查更新".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPAppManager shareInstance] openAppStoreForApp];
        };
        [dataList1 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [NSString stringWithFormat:@"version-%@",[YPAppManager shareInstance].version];
        element.type = YPPageRouterTypeButton;
        [dataList1 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [NSString stringWithFormat:@"build-%@",[YPAppManager shareInstance].build];
        element.type = YPPageRouterTypeButton;
        [dataList1 addObject:element];
    }
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList1];
    return @[section1, section2];
}

@end
