//
//  YPPageRouterModule+Network.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPPageRouterModule+Network.h"
#import "YPPageRouterModule+Update.h"
#import "YPNetworkRequestManager.h"
#import "YPNetworkRequestCell.h"
#import "YPModuleTableViewController.h"

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
        element.title = @"获取本机 IP".yp_localizedString;
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
        element.type = YPPageRouterTypeModule;
        element.content = @([YPNetworkRequestManager shareInstance].headersDictionary.count).stringValue;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"Body".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        element.content = @([YPNetworkRequestManager shareInstance].bodyDictionary.count).stringValue;
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

+ (NSArray *)NetworkRouters_Request_Headers {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    NSDictionary *headersDictionary = [YPNetworkRequestManager shareInstance].headersDictionary;
    for (NSString *key in headersDictionary) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.title = key;
        element.content = headersDictionary[key];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [weakSelf yp_reloadCurrentCell:cell];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [weakSelf yp_reloadCurrentCell:cell];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"添加字段".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[UIViewController yp_topViewController].view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *vc = [UIViewController yp_topViewController];
                if ([vc isKindOfClass:[YPModuleTableViewController class]]) {
                    YPPageRouterModule *section = [(YPModuleTableViewController *)vc dataList].firstObject;
                    NSArray *dataList = section.routers;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    for (YPPageRouter *model in dataList) {
                        if (model.cellClass == [YPNetworkRequestCell class]) {
                            if (model.title.length > 0) {
                                dic[model.title] = model.content?:@"";
                            }
                        }
                    }
                    [YPNetworkRequestManager shareInstance].headers = dic.yp_dictionaryToJsonStringNoSpace;
                }
                [self yp_reloadCurrentModuleControl];
            });
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

+ (NSArray *)NetworkRouters_Request_Body {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    NSDictionary *headersDictionary = [YPNetworkRequestManager shareInstance].bodyDictionary;
    for (NSString *key in headersDictionary) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.title = key;
        element.content = headersDictionary[key];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [weakSelf yp_reloadCurrentCell:cell];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [weakSelf yp_reloadCurrentCell:cell];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"保存/添加字段".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[UIViewController yp_topViewController].view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *vc = [UIViewController yp_topViewController];
                if ([vc isKindOfClass:[YPModuleTableViewController class]]) {
                    YPPageRouterModule *section = [(YPModuleTableViewController *)vc dataList].firstObject;
                    NSArray *dataList = section.routers;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    for (YPPageRouter *model in dataList) {
                        if (model.cellClass == [YPNetworkRequestCell class]) {
                            if (model.title.length > 0) {
                                dic[model.title] = model.content?:@"";
                            }
                        }
                    }
                    [YPNetworkRequestManager shareInstance].body = dic.yp_dictionaryToJsonStringNoSpace;
                }
                [self yp_reloadCurrentModuleControl];
            });
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
