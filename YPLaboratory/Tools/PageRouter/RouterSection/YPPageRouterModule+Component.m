//
//  YPPageRouterModule+Component.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import "YPPageRouterModule+Component.h"
#import "YPPageRouterModule+Update.h"
#import "YPSwiperNormalTableViewCell.h"
#import "YPSwiperCardTableViewCell.h"
#import "YPAppUpdatePopupController.h"
#import "YPAppH5PopupController.h"
#import "YPH5WebviewController.h"
#import "YPQRCodeScanViewController.h"
#import "YPFaceTrackViewController.h"
#import "YPCameraViewController.h"
#import "YPSystemFontsTableViewCell.h"
#import "YPModuleNormalCell.h"
#import "YPModuleSwitchCell.h"
#import "YPModuleButtonCell.h"
#import "YPModuleImageCell.h"
#import "YPWaterfallFlowViewController.h"
#import "YPDiverseViewController.h"
#import "YPButtonViewController.h"
#import "YPPayInputViewController.h"
#import "YPDisableScreenCaptureViewController.h"
#import "YPSetAshViewController.h"
#import "YPRunLabelViewController.h"
#import "YPFloatingViewViewController.h"
#import "YPBarcodeAndQRCodeManager.h"
#import "YPBarcodeAndQRCodeCell.h"

@implementation YPPageRouterModule (Component)

// UI 组件
+ (NSArray *)ComponentRouters {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"二维码生成".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"条形码生成".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"颜色选择".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIViewController *vc = nil;
            UIColor *selectedColor = [UIColor yp_blackColor];
            if (@available(iOS 14.0, *)) {
                vc = [YPColorPickerViewController popupPickerWithCompletion:^(UIColor *selectedColor) {
                    NSString *hexString = [UIColor yp_hexStringFromColor:selectedColor];
                    [YPAlertView alertText:[NSString stringWithFormat:@"您选择的颜色是 %@".yp_localizedString, hexString] duration:3.f];
                }];
                ((YPColorPickerViewController *)vc).selectedColor = selectedColor;
            } else {
                NSArray *colors = [UIColor yp_allColors];
                NSInteger index = [colors indexOfObject:[UIColor yp_hexStringFromColor:[UIColor yp_blackColor]]];
                vc = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                    NSString *hexString = colors[index];
                    [YPAlertView alertText:[NSString stringWithFormat:@"您选择的颜色是 %@".yp_localizedString, hexString] duration:3.f];
                }];
                ((YPColorPickerAlert *)vc).currentIndex = index;
            }
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"悬浮按钮".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPFloatingViewViewController *vc = [[YPFloatingViewViewController alloc] init];
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"打开App内网页".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPH5WebviewController *vc = [[YPH5WebviewController alloc] init];
            vc.request = [NSURLRequest requestWithURL:[NSURL URLWithString:[YPSettingManager sharedInstance].personalHomepage]];
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"使用 Safari 打开网页".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.extend = @"https://github.com/HansenCCC";
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"应用跳转".yp_localizedString message:[NSString stringWithFormat:@"是否跳转Safari显示具体详情？\n%@".yp_localizedString,router.extend] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"去 Safari 查看".yp_localizedString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:router.extend?:@""] options:@{} completionHandler:nil];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消".yp_localizedString style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航栏控制".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"瀑布流试图".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPWaterfallFlowViewController *vc = [[YPWaterfallFlowViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的表格视图".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPDiverseViewController *vc = [[YPDiverseViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的选择框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的按钮".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPButtonViewController *vc = [[YPButtonViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通提示框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通加载框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通进度条".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"自定义弹框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"自定义轮播图".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"单行输入框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPSingleLineInputViewController *vc = [[YPSingleLineInputViewController alloc] init];
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多行输入框".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"iOS 视频播放".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"TableView嵌入播放器（仿线程卡顿处理）".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"模拟新浪@人".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"模拟微信朋友圈".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"模拟支付宝输入密码".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPPayInputViewController *vc = [[YPPayInputViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"角标和红点".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"防 截屏|录屏 功能".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPDisableScreenCaptureViewController *vc = [[YPDisableScreenCaptureViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"下拉弹框".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"跑马灯效果".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPRunLabelViewController *vc = [[YPRunLabelViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"手持弹幕".yp_localizedString;
//        element.type = YPPageRouterTypeModule;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"App 公祭日置灰模式".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPSetAshViewController *vc = [[YPSetAshViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = router.title;
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"系统字体".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 丰富多彩的cell
+ (NSArray *)ComponentRouters_CollectionCells {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"一行一个".yp_localizedString;
        element.type = YPPageRouterTypeModule;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 多样的选择框
+ (NSArray *)ComponentRouters_PickerView {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"时分".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        NSString *format = @"HH:mm";
        element.placeholder = format;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSDate *date = [NSDate yp_DateWithString:router.content dateFormat:format];
            YPDatePickerAlert *alert = [YPDatePickerAlert popupWithDate:date?:[NSDate date] completeBlock:^(NSDate * _Nonnull date) {
                router.content = [date yp_StringWithDateFormat:format];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.datePickerMode = UIDatePickerModeTime;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"年月日".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        NSString *format = @"yyyy-MM-dd";
        element.placeholder = format;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSDate *date = [NSDate yp_DateWithString:router.content dateFormat:format];
            YPDatePickerAlert *alert = [YPDatePickerAlert popupWithDate:date?:[NSDate date] completeBlock:^(NSDate * _Nonnull date) {
                router.content = [date yp_StringWithDateFormat:format];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.datePickerMode = UIDatePickerModeDate;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"年月日分".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        NSString *format = @"yyyy-MM-dd HH:mm";
        element.placeholder = format;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSDate *date = [NSDate yp_DateWithString:router.content dateFormat:format];
            YPDatePickerAlert *alert = [YPDatePickerAlert popupWithDate:date?:[NSDate date] completeBlock:^(NSDate * _Nonnull date) {
                router.content = [date yp_StringWithDateFormat:format];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.datePickerMode = UIDatePickerModeDateAndTime;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"倒计时".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        NSString *format = @"HH:mm";
        element.placeholder = format;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSDate *date = [NSDate yp_DateWithString:router.content dateFormat:format];
            YPDatePickerAlert *alert = [YPDatePickerAlert popupWithDate:date?:[NSDate date] completeBlock:^(NSDate * _Nonnull date) {
                router.content = [date yp_StringWithDateFormat:format];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.datePickerMode = UIDatePickerModeCountDownTimer;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"字体选择".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"Font";
        NSArray *fonts = [UIFont familyNames];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [fonts indexOfObject:router.content];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:fonts completeBlock:^(NSInteger index) {
                router.content = fonts[index];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"颜色选择".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"Color";
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"性别选择".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"性别".yp_localizedString;
        NSArray *fonts = @[@"男".yp_localizedString,@"女".yp_localizedString,@"沃尔玛购物袋".yp_localizedString];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [fonts indexOfObject:router.content];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:fonts completeBlock:^(NSInteger index) {
                router.content = fonts[index];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"地址选择（省市区）".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"Address";
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 导航栏控制
+ (NSArray *)ComponentRouters_NavigationBar {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    UINavigationBar *navigationBar = [UIViewController yp_topViewController].navigationController.navigationBar;
    {
        if (@available(iOS 13.0, *)) {
            YPPageRouter *element = [[YPPageRouter alloc] init];
            element.title = @"导航滚动边缘变化（iOS 13）".yp_localizedString;
            element.type = YPPageRouterTypeSwitch;
            element.content = @(navigationBar.yp_enableScrollEdgeAppearance).stringValue;
            element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
                BOOL enableScrollEdgeAppearance = router.content.boolValue;
                navigationBar.yp_enableScrollEdgeAppearance = enableScrollEdgeAppearance;
                [navigationBar yp_configuration];
            };
            [dataList addObject:element];
        }
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航是否半透明".yp_localizedString;
        element.type = YPPageRouterTypeSwitch;
        element.content = @(navigationBar.yp_translucent).stringValue;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            BOOL translucent = router.content.boolValue;
            navigationBar.yp_translucent = translucent;
            [navigationBar yp_configuration];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航是否全透明".yp_localizedString;
        element.type = YPPageRouterTypeSwitch;
        element.content = @(navigationBar.yp_transparent).stringValue;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            BOOL transparent = router.content.boolValue;
            navigationBar.yp_transparent = transparent;
            [navigationBar yp_configuration];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航是否隐藏底部线条".yp_localizedString;
        element.type = YPPageRouterTypeSwitch;
        element.content = @(navigationBar.yp_hideBottomLine).stringValue;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            BOOL hideBottomLine = router.content.boolValue;
            navigationBar.yp_hideBottomLine = hideBottomLine;
            [navigationBar yp_configuration];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航主题色调".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [UIColor yp_hexStringFromColor:navigationBar.yp_tintColor];
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [self yp_reloadCurrentCell:cell];
                navigationBar.yp_tintColor = [UIColor yp_colorWithHexString:router.content];
                [navigationBar yp_configuration];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航背景颜色".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [UIColor yp_hexStringFromColor:navigationBar.yp_backgroundColor];
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [self yp_reloadCurrentCell:cell];
                navigationBar.yp_backgroundColor = [UIColor yp_colorWithHexString:router.content];
                [navigationBar yp_configuration];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航字体颜色".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [UIColor yp_hexStringFromColor:navigationBar.yp_titleColor];
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [self yp_reloadCurrentCell:cell];
                navigationBar.yp_titleColor = [UIColor yp_colorWithHexString:router.content];
                [navigationBar yp_configuration];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航字体大小".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = @(navigationBar.yp_titleFont.pointSize).stringValue;
        NSMutableArray *fontSizes = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i++) {
            [fontSizes addObject:@(i).stringValue];
        }
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [fontSizes indexOfObject:router.content];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:fontSizes completeBlock:^(NSInteger index) {
                router.content = fontSizes[index];
                [self yp_reloadCurrentCell:cell];
                UIFont *font = navigationBar.yp_titleFont;
                UIFontDescriptorSymbolicTraits traits = font.fontDescriptor.symbolicTraits;
                if (traits & UIFontDescriptorTraitBold) {
                    font = [UIFont boldSystemFontOfSize:router.content.intValue];
                } else {
                    font = [UIFont systemFontOfSize:router.content.intValue];
                }
                navigationBar.yp_titleFont = font;
                [navigationBar yp_configuration];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        BOOL isBold = NO;
        UIFont *font = navigationBar.yp_titleFont;
        UIFontDescriptorSymbolicTraits traits = font.fontDescriptor.symbolicTraits;
        if (traits & UIFontDescriptorTraitBold) {
            isBold = YES;
        } else {
            isBold = NO;
        }
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航字体是否加粗".yp_localizedString;
        element.type = YPPageRouterTypeSwitch;
        element.content = @(isBold).stringValue;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            BOOL isBold = router.content.boolValue;
            UIFont *font = navigationBar.yp_titleFont;
            if (isBold) {
                font = [UIFont boldSystemFontOfSize:font.pointSize];
            } else {
                font = [UIFont systemFontOfSize:font.pointSize];
            }
            navigationBar.yp_titleFont = font;
            [navigationBar yp_configuration];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"重置所有".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            [navigationBar yp_resetConfiguration];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf yp_reloadCurrentModuleControl];
            });
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 普通提示框
+ (NSArray *)ComponentRouters_YPAlertView {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通提示框(自动隐藏)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPAlertView alertText:router.title];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通提示框(自动隐藏 5s)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPAlertView alertText:router.title duration:5.f];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 普通进度条
+ (NSArray *)ComponentRouters_ProgressView {
    // 下面 block 用于模拟下载进度，读不懂逻辑的同学，我觉得这个并不重要。
    __block float _progress = 0;
    __block void (^autoIncrement)(void);
    __weak __block void (^weakAutoIncrement)(void);
    weakAutoIncrement = autoIncrement = ^{
        [[YPShakeManager shareInstance] lightShake];
        _progress += 0.002;
        NSString *text = [NSString stringWithFormat:@"%.2f%%", _progress * 100];
        [YPProgressView showProgress:_progress text:text];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_progress > 1) {
                [YPProgressView showProgress:1 text:@"下载完成"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[YPShakeManager shareInstance] longPressShake];
                    [YPProgressView hideProgress];
                    _progress = 0;
                });
            } else {
                if (weakAutoIncrement) {
                    weakAutoIncrement(); // 使用弱引用调用
                }
            }
        });
    };
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通进度条(圆线)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            if (autoIncrement) {
                autoIncrement();
            }
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通进度条(直线)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            if (autoIncrement) {
                autoIncrement();
            }
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 普通加载框
+ (NSArray *)ComponentRouters_YPLoadingView {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通加载框(自动隐藏)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPLoadingView showLoading];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [YPLoadingView hideLoading];
            });
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通提示框(带文字)".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [YPLoadingView showLoading:router.title];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [YPLoadingView hideLoading];
            });
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 自定义弹框
+ (NSArray *)ComponentRouters_YPPopupController {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"例如：时间选择弹框".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        NSString *format = @"yyyy-MM-dd HH:mm";
        element.placeholder = format;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSDate *date = [NSDate yp_DateWithString:router.content dateFormat:format];
            YPDatePickerAlert *alert = [YPDatePickerAlert popupWithDate:date?:[NSDate date] completeBlock:^(NSDate * _Nonnull date) {
                router.content = [date yp_StringWithDateFormat:format];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.datePickerMode = UIDatePickerModeDateAndTime;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"例如：单选弹框".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"Font";
        NSArray *fonts = [UIFont familyNames];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [fonts indexOfObject:router.content];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:fonts completeBlock:^(NSInteger index) {
                router.content = fonts[index];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"例如：颜色选择弹框".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"Color";
        NSArray *colors = [UIColor yp_allColors];
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView *cell) {
            NSUInteger currentIndex = [colors indexOfObject:router.content];
            YPColorPickerAlert *alert = [YPColorPickerAlert popupWithOptions:colors completeBlock:^(NSInteger index) {
                router.content = colors[index];
                [self yp_reloadCurrentCell:cell];
            }];
            alert.currentIndex = currentIndex;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"例如：内嵌 H5".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPAppH5PopupController *vc = [YPAppH5PopupController popupControllerWithStyle:YPPopupControllerStyleMiddle];
            vc.h5Title = @"内嵌 H5 弹框";
            vc.request = [NSURLRequest requestWithURL:[NSURL URLWithString:[YPSettingManager sharedInstance].personalHomepage]];
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"例如：更新弹框".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPAppUpdatePopupController *vc = [YPAppUpdatePopupController popupControllerWithStyle:YPPopupControllerStyleMiddle];
            vc.updateTitle = @"发现新的版本 v10.xxx".yp_localizedString;
            vc.updateContent = @"全新界面设计，更加现代化和直观..........".yp_localizedString;
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section,];
}

// 自定义轮播图
+ (NSArray *)ComponentRouters_YPSwiperView {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通轮播图".yp_localizedString;
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPSwiperNormalTableViewCell class];
        element.cellHeight = 200.f;
        element.extend = @[
            @"",
            @"",
            @"",
            @"",
        ];
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    section.headerTitle = @"普通轮播图".yp_localizedString;
    
    NSMutableArray *dataList2 = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"卡片轮播图".yp_localizedString;
        element.type = YPPageRouterTypeCustom;
        element.cellHeight = 200.f;
        element.cellClass = [YPSwiperCardTableViewCell class];
        element.extend = @[
            @"",
            @"",
            @"",
            @"",
        ];
        [dataList2 addObject:element];
    }
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList2];
    section2.headerTitle = @"卡片轮播图".yp_localizedString;
    
    return @[section, section2];
}

// 摄像机
+ (NSArray *)ComponentRouters_MultifunctionalCamera {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"二维码扫码".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPQRCodeScanViewController *vc = [[YPQRCodeScanViewController alloc] init];
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"人脸追踪".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPFaceTrackViewController *vc = [[YPFaceTrackViewController alloc] init];
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"注入 3D 模型".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"自定义相机（待完善）".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPCameraViewController *vc = [[YPCameraViewController alloc] init];
            [[UIViewController yp_topViewController] presentViewController:vc animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 系统字体
+ (NSArray *)ComponentRouters_SystemFonts {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        NSInteger index = 0;
        for (NSString *fontName in [UIFont familyNames]) {
            index ++;
            YPPageRouter *element = [[YPPageRouter alloc] init];
            element.title = [NSString stringWithFormat:@"ABC 123 你好"];
            element.content = fontName;
            element.type = YPPageRouterTypeCustom;
            element.cellClass = [YPSystemFontsTableViewCell class];
            element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = router.content?:@"";
                [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",router.content?:@"",@"字体已复制".yp_localizedString]];
                [[YPShakeManager shareInstance] longPressShake];
            };
            [dataList addObject:element];
        }
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

/// 角标
+ (NSArray *)ComponentRouters_Badge {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"显示未读数".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIView *displayLabel = [cell yp_findSubviewsOfClass:[UILabel class]].firstObject;
            if ([displayLabel yp_findSubviewsOfClass:[YPBadgeView class]].count == 0) {
                [YPBadgeView showBadgeToView:displayLabel badgeInteger:99];
            } else {
                [YPBadgeView hiddenBadgeToView:displayLabel];
            }
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"显示红点".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIView *displayLabel = [cell yp_findSubviewsOfClass:[UILabel class]].firstObject;
            if ([displayLabel yp_findSubviewsOfClass:[YPBadgeView class]].count == 0) {
                [YPBadgeView showBadgeToView:displayLabel];
            } else {
                [YPBadgeView hiddenBadgeToView:displayLabel];
            }
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    section.headerTitle = @"角标和红点".yp_localizedString;
    return @[section];
}

/// 震动反馈
+ (NSArray *)ComponentRouters_ShakeFeedback {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"轻微震动".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPShakeManager shareInstance] lightShake];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"中等震动".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPShakeManager shareInstance] mediumShake];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"高度震动".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPShakeManager shareInstance] heavyShake];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"连续震动".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            [[YPShakeManager shareInstance] longPressShake];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    section.headerTitle = @"常用的交互反馈";
    
    NSMutableArray *dataList2 = [[NSMutableArray alloc] init];
    NSDictionary *systemSounds = @{
        @"收到新邮件".yp_localizedString: @"1000",
        @"发送邮件成功".yp_localizedString: @"1001",
        @"警报音效".yp_localizedString: @"1005",
        @"短信收到音效1".yp_localizedString: @"1007",
        @"短信收到音效2".yp_localizedString: @"1008",
        @"短信收到音效3".yp_localizedString: @"1009",
        @"短信收到音效4".yp_localizedString: @"1010",
        @"短信收到音效5".yp_localizedString: @"1011",
        @"按键点击音效".yp_localizedString: @"1012",
        @"短信收到音效6".yp_localizedString: @"1015",
        @"PIN密码键盘点击".yp_localizedString: @"1152",
        @"锁屏音效".yp_localizedString: @"1200",
        @"解锁音效".yp_localizedString: @"1201",
        @"轻震动".yp_localizedString: @"1520",
        @"强震动".yp_localizedString: @"1521",
        @"按键音效".yp_localizedString: @"1050",
        @"系统音效".yp_localizedString: @"1051",
        @"低电量提示音".yp_localizedString: @"1057",
        @"发送推文音效".yp_localizedString: @"1102",
        @"拍照快门声".yp_localizedString: @"1108",
        @"开始录像音效".yp_localizedString: @"1157",
        @"夜深了".yp_localizedString: @"1158",
        @"倒计时音效".yp_localizedString: @"1306",
        @"胜利音效".yp_localizedString: @"1320",
        @"失败音效".yp_localizedString: @"1330",
        @"轻提示音".yp_localizedString: @"4095",
        @"消息发送音效".yp_localizedString: @"1256",
        @"消息接收音效".yp_localizedString: @"1257",
    };
    NSArray *sortedKeys = [[systemSounds allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *key in sortedKeys) {
        NSString *value = systemSounds[key];
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = key;
        element.extend = value;
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSString *shakeId = [NSString stringWithFormat:@"%@",router.extend];
            [[YPShakeManager shareInstance] shakeWithId:shakeId.longLongValue];
        };
        [dataList2 addObject:element];
    }
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList2];
    section2.headerTitle = @"其他的交互反馈";
    return @[section, section2];
}

/// 二维码生成
+ (NSArray *)ComponentRouters_QRCodeMaker {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"文本".yp_localizedString;
        element.placeholder = @"字母、数字、符号".yp_localizedString;
        element.content = [YPBarcodeAndQRCodeManager shareInstance].codeText?:@"";
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            vc.maxLength = 1500;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPBarcodeAndQRCodeManager shareInstance].qrImage = nil;
                [YPBarcodeAndQRCodeManager shareInstance].codeText = text;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"尺寸".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.content = [YPBarcodeAndQRCodeManager shareInstance].size;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSArray *items = [YPBarcodeAndQRCodeManager shareInstance].sizes;
            NSInteger index = [items indexOfObject:[YPBarcodeAndQRCodeManager shareInstance].size];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:items completeBlock:^(NSInteger index) {
                [YPBarcodeAndQRCodeManager shareInstance].qrImage = nil;
                [YPBarcodeAndQRCodeManager shareInstance].size = items[index];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            }];
            alert.currentIndex = index;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        //L (低)：大约能纠正 7% 的错误。
        //M (中)：大约能纠正 15% 的错误。
        //Q (高)：大约能纠正 25% 的错误。
        //H (最高)：大约能纠正 30% 的错误。
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"容错级别".yp_localizedString;
        element.type = YPPageRouterTypeNormal;
        element.placeholder = @"L、M、Q、H";
        element.content = [YPBarcodeAndQRCodeManager shareInstance].faultTolerant;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSArray *items = [YPBarcodeAndQRCodeManager shareInstance].faultTolerants;
            NSInteger index = [items indexOfObject:[YPBarcodeAndQRCodeManager shareInstance].faultTolerant];
            YPPickerAlert *alert = [YPPickerAlert popupWithOptions:items completeBlock:^(NSInteger index) {
                [YPBarcodeAndQRCodeManager shareInstance].qrImage = nil;
                [YPBarcodeAndQRCodeManager shareInstance].faultTolerant = items[index];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            }];
            alert.currentIndex = index;
            [[UIViewController yp_topViewController] presentViewController:alert animated:YES completion:nil];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"开始生成".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            if ([YPBarcodeAndQRCodeManager shareInstance].codeText.length == 0) {
                [YPAlertView alertText:@"请输入文本"];
                return;
            }
            if ([YPBarcodeAndQRCodeManager shareInstance].size.length == 0) {
                [YPAlertView alertText:@"请选择尺寸"];
                return;
            }
            if ([YPBarcodeAndQRCodeManager shareInstance].faultTolerant.length == 0) {
                [YPAlertView alertText:@"请选择容错级别"];
                return;
            }
            NSString *text = [YPBarcodeAndQRCodeManager shareInstance].codeText;
            NSString *faultTolerant = [YPBarcodeAndQRCodeManager shareInstance].faultTolerant;
            NSString *size = [YPBarcodeAndQRCodeManager shareInstance].size;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [UIImage yp_imageWithQRCodeString:text
                                                              size:CGSizeMake(size.integerValue, size.integerValue)
                                                   correctionLevel:faultTolerant];
                if (image) {
                    [YPBarcodeAndQRCodeManager shareInstance].qrImage = image;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[YPShakeManager shareInstance] longPressShake];
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            });
        };
        [dataList addObject:element];
    }
    if ([YPBarcodeAndQRCodeManager shareInstance].qrImage) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"保存到相册".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIImage *image = [YPBarcodeAndQRCodeManager shareInstance].qrImage;
            [UIImage yp_saveImageToAlbum:image completion:^(BOOL success, NSError * _Nonnull error) {
                [[YPShakeManager shareInstance] longPressShake];
                if (success) {
                    [YPAlertView alertText:@"保存到相册成功"];
                } else {
                    [YPAlertView alertText:@"保存到相册失败"];
                }
            }];
        };
        [dataList addObject:element];
    }
    if ([YPBarcodeAndQRCodeManager shareInstance].qrImage) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [YPBarcodeAndQRCodeManager shareInstance].codeText;
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPBarcodeAndQRCodeCell class];
        element.cellHeight = MIN([UIScreen mainScreen].bounds.size.width, 500.f);
        element.extend = [YPBarcodeAndQRCodeManager shareInstance].qrImage;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

/// 条形码生成
+ (NSArray *)ComponentRouters_BRCodeMaker {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"文本".yp_localizedString;
        element.placeholder = @"字母、数字、符号".yp_localizedString;
        element.content = [YPBarcodeAndQRCodeManager shareInstance].brCodeText?:@"";
        element.type = YPPageRouterTypeNormal;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPMultiLineInputViewController *vc = [[YPMultiLineInputViewController alloc] init];
            vc.text = router.content;
            vc.title = router.title;
            vc.placeholder = router.placeholder;
            vc.maxLength = 1500;
            vc.didCompleteCallback = ^(NSString * _Nonnull text) {
                [YPBarcodeAndQRCodeManager shareInstance].brImage = nil;
                [YPBarcodeAndQRCodeManager shareInstance].brCodeText = text;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            };
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"开始生成".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            if ([YPBarcodeAndQRCodeManager shareInstance].brCodeText.length == 0) {
                [YPAlertView alertText:@"请输入文本"];
                return;
            }
            NSString *text = [YPBarcodeAndQRCodeManager shareInstance].brCodeText;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [UIImage yp_imageWithBRCodeString:text];
                if (image) {
                    [YPBarcodeAndQRCodeManager shareInstance].brImage = image;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[YPShakeManager shareInstance] longPressShake];
                    [weakSelf yp_reloadCurrentModuleControl];
                });
            });
        };
        [dataList addObject:element];
    }
    if ([YPBarcodeAndQRCodeManager shareInstance].brImage) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"保存到相册".yp_localizedString;
        element.type = YPPageRouterTypeButton;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            UIImage *image = [YPBarcodeAndQRCodeManager shareInstance].brImage;
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            UIImage *finalImage = [UIImage imageWithData:imageData];
            [UIImage yp_saveImageToAlbum:finalImage completion:^(BOOL success, NSError * _Nonnull error) {
                [[YPShakeManager shareInstance] longPressShake];
                if (success) {
                    [YPAlertView alertText:@"保存到相册成功"];
                } else {
                    [YPAlertView alertText:@"保存到相册失败"];
                }
            }];
        };
        [dataList addObject:element];
    }
    if ([YPBarcodeAndQRCodeManager shareInstance].brImage) {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = [YPBarcodeAndQRCodeManager shareInstance].brCodeText;
        element.type = YPPageRouterTypeCustom;
        element.cellClass = [YPBarcodeAndQRCodeCell class];
        UIImage *image = [YPBarcodeAndQRCodeManager shareInstance].brImage;
        CGFloat height = [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
        element.cellHeight = MAX(height, 44.f);
        element.extend = image;
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
