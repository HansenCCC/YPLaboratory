//
//  YPPageRouterModule+Network.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPPageRouterModule+Network.h"
#import "YPPageRouterModule+Update.h"
#import "YPNetworkRequestManager.h"

@implementation YPPageRouterModule (Network)

+ (NSArray *)NetworkRouters {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"网络请求".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"IP 地址获取".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"WebSocket".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"PING".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"域名解析".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"端口扫描".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"网络诊断".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"网络测速".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"文件下载[断点续传]".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"DNS 缓存".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"SSL/TLS 验证".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

+ (NSArray *)NetworkRouters_Request {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"URL".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPNetworkRequestManager shareInstance].urlString?:@"";
        element.placeholder = @"输入URL，需以http或https开头".yp_localizedString;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            vc.maxLength = 1000;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPNetworkRequestManager shareInstance].urlString = text;
                [weakSelf yp_reloadCurrentModuleControl];
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Method".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPNetworkRequestManager shareInstance].methodString;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSArray *items = [YPNetworkRequestManager shareInstance].methods;
            NSInteger currentIndex = [items indexOfObject:[YPNetworkRequestManager shareInstance].methodString];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:items completeBlock:^(NSInteger index) {
                NSString *methodString = items[index];
                NSInteger currentIndex = [items indexOfObject:methodString];
                [YPNetworkRequestManager shareInstance].method = currentIndex;
                router.content = methodString;
                [weakSelf yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Headers".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPNetworkRequestManager shareInstance].headers?:@"";
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            vc.maxLength = 10000;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPNetworkRequestManager shareInstance].headers = text;
                [weakSelf yp_reloadCurrentModuleControl];
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Body".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPNetworkRequestManager shareInstance].body?:@"";
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            vc.maxLength = 10000;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPNetworkRequestManager shareInstance].body = text;
                [weakSelf yp_reloadCurrentModuleControl];
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"发送请求".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"历史记录".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
