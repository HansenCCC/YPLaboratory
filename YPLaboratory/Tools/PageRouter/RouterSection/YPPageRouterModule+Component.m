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

@implementation YPPageRouterModule (Component)

// UI 组件
+ (NSArray *)ComponentRouters {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"打开一个网页".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            YPH5WebviewController *vc = [[YPH5WebviewController alloc] init];
            vc.request = [NSURLRequest requestWithURL:[NSURL URLWithString:[YPSettingManager sharedInstance].personalHomepage]];
            [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
        };
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"导航栏控制".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"瀑布流试图".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPWaterfallFlowViewController";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的表格视图".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPDiverseViewController";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的选择框".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"多样的按钮".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPButtonViewController";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通提示框".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"普通加载框".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"自定义弹框".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"自定义轮播图".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"单行输入框".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        element.placeholder = element.title;
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
        element.type = YPPageRouterTypeTable;
        element.placeholder = element.title;
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
//        element.type = YPPageRouterTypeTable;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"TableView嵌入播放器（仿线程卡顿处理）".yp_localizedString;
//        element.type = YPPageRouterTypeTable;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"模拟新浪@人".yp_localizedString;
//        element.type = YPPageRouterTypeTable;
//        [dataList addObject:element];
//    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"模拟微信朋友圈".yp_localizedString;
//        element.type = YPPageRouterTypeTable;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"模拟支付宝输入密码".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPPayInputViewController";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"角标和红点".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"防 截屏|录屏 功能".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPDisableScreenCaptureViewController";
        [dataList addObject:element];
    }
//    {
//        YPPageRouter *element = [[YPPageRouter alloc] init];
//        element.title = @"下拉弹框".yp_localizedString;
//        element.type = YPPageRouterTypeTable;
//        [dataList addObject:element];
//    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"跑马灯效果".yp_localizedString;
        element.type = YPPageRouterTypePush;
        element.extend = @"YPRunLabelViewController";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"手持弹幕".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"App 公祭日置灰模式".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"系统字体".yp_localizedString;
        element.type = YPPageRouterTypeTable;
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
        element.type = YPPageRouterTypeTable;
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
        element.content = format;
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
        element.content = format;
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
        element.content = format;
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
        element.content = format;
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
        element.content = @"Font";
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
        element.content = @"Color";
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
        element.content = @"Gender";
        NSArray *fonts = @[@"男",@"女",@"沃尔玛购物袋"];
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
        element.content = @"Address";
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

// 导航栏控制
+ (NSArray *)ComponentRouters_NavigationBar {
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
                [self yp_reloadCurrentModuleControl];
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
        element.content = format;
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
        element.content = @"Font";
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
        element.content = @"Color";
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
            vc.updateTitle = @"发现新的版本 v10.xxx";
            vc.updateContent = @"全新界面设计，更加现代化和直观..........";
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
        element.type = YPPageRouterTypeTableCell;
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
        element.type = YPPageRouterTypeTableCell;
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
            element.title = [NSString stringWithFormat:@"1234567890"];
            element.content = fontName;
            element.type = YPPageRouterTypeTableCell;
            element.cellClass = [YPSystemFontsTableViewCell class];
            element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = router.content?:@"";
                [YPAlertView alertText:[NSString stringWithFormat:@"'%@' %@",router.content?:@"",@"字体已复制".yp_localizedString]];
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

@end
