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
#import "YPCustomHTTPRequest.h"
#import "YpApiRequestDao.h"
#import "YPRequestInstanceViewController.h"
#import "YPNetworkInfoCell.h"
#import "YPGetIPAddressRequest.h"

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
            [YPLoadingView showLoading];
            YPGetIPAddressRequest *request = [[YPGetIPAddressRequest alloc] init];
            [request startWithSuccessHandler:^(YPHTTPResponse * _Nonnull response) {
                [YPLoadingView hideLoading];
                NSString *addressIP = @"";
                NSString *localIP = [YPAppManager shareInstance].ipAddress;
                NSDictionary *data = response.responseData[@"data"];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    addressIP = data[@"ip"];
                }
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"获取本机 IP".yp_localizedString
                                                                               message:data.yp_dictionaryToJsonStringNoSpace
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction
                                  actionWithTitle:[NSString stringWithFormat:@"公网IP: %@".yp_localizedString, addressIP]
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = addressIP?:@"";
                    [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",addressIP?:@"",@"字体已复制".yp_localizedString]];
                }]];
                [alert addAction:[UIAlertAction
                                  actionWithTitle:[NSString stringWithFormat:@"本地IP: %@".yp_localizedString, localIP]
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = localIP?:@"";
                    [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",localIP?:@"",@"字体已复制".yp_localizedString]];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"关闭".yp_localizedString style:UIAlertActionStyleCancel handler:nil]];
                [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
            } failureHandler:^(NSError * _Nonnull error) {
                [YPLoadingView hideLoading];
                [YPAlertView alertText:[NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]];
            }];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"浏览器标识".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPLoadingView showLoading];
            [[YPAppManager shareInstance] requestUserAgent:^(NSString * _Nonnull userAgent) {
                [YPLoadingView hideLoading];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"浏览器标识".yp_localizedString
                                                                               message:userAgent
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction
                                  actionWithTitle:@"复制".yp_localizedString
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = userAgent?:@"";
                    [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",userAgent?:@"",@"字体已复制".yp_localizedString]];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"关闭".yp_localizedString style:UIAlertActionStyleCancel handler:nil]];
                [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
            }];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"即时通讯".yp_localizedString;
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
        element.title = @"文件下载[断点续传]".yp_localizedString;
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
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [weakSelf yp_reloadCurrentModuleControl];
            [YPLoadingView showLoading];
            YPCustomHTTPRequest *request = [[YPCustomHTTPRequest alloc] init];
            request.urlString = [YPNetworkRequestManager shareInstance].urlString;
            request.methodString = [YPNetworkRequestManager shareInstance].methodString;
            request.headers = [YPNetworkRequestManager shareInstance].headersDictionary;
            request.body = [YPNetworkRequestManager shareInstance].bodyDictionary;
            [request startWithSuccessHandler:^(YPHTTPResponse * _Nonnull response) {
                [YPLoadingView hideLoading];
                [[YPShakeManager shareInstance] mediumShake];
                [weakSelf yp_reloadCurrentModuleControl];
            } failureHandler:^(NSError * _Nonnull error) {
                [YPLoadingView hideLoading];
                [[YPShakeManager shareInstance] longPressShake];
                [weakSelf yp_reloadCurrentModuleControl];
            }];
        };
        [dataList addObject:element];
    }
    {
        NSInteger count = [[YpApiRequestDao get] selectYpApiRequestCount:@"isEnable=1"];
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [NSString stringWithFormat:@"历史记录 [%d]".yp_localizedString, count];
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPRequestInstanceViewController *vc = [[YPRequestInstanceViewController alloc] init];
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    
    NSMutableArray *dataList2 = [[NSMutableArray alloc] init];
    if ([YPNetworkRequestManager shareInstance].lastRequest) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.extend = [YPNetworkRequestManager shareInstance].lastRequest;
        element.type = YPPageRouterTypeCustom;
        // 计算合适的高度
        [YPNetworkInfoCell shareInstance].bounds = [UIScreen mainScreen].bounds;
        [YPNetworkInfoCell shareInstance].cellModel = element;
        element.cellHeight = [YPNetworkInfoCell shareInstance].cellHeight;
        element.cellClass = [YPNetworkInfoCell class];
        [dataList2 addObject:element];
    }
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList2];
    return @[section, section2];
}

+ (NSArray *)NetworkRouters_Request_Headers {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    NSDictionary *headersDictionary = [YPNetworkRequestManager shareInstance].headersDictionary;
    for (NSString *key in headersDictionary) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.title = key;
        element.content = headersDictionary[key];
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
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
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    NSDictionary *headersDictionary = [YPNetworkRequestManager shareInstance].bodyDictionary;
    for (NSString *key in headersDictionary) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
        element.title = key;
        element.content = headersDictionary[key];
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPNetworkRequestCell class];
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
