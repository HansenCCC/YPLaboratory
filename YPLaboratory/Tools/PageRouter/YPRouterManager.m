//
//  YPRouterManager.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/20.
//

#import "YPRouterManager.h"
#import "YPPageRouterModuleCategoryHeader.h"

@interface YPRouterManager ()

@end

@implementation YPRouterManager

+ (instancetype)shareInstance {
    static YPRouterManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPRouterManager alloc] init];
    });
    return m;
}

- (NSArray *)allRouter {
    return @[];
}

- (YPPageRouter *)homeRouter {
    YPPageRouter *homeRouter = [[YPPageRouter alloc] init];
    homeRouter.title = @"ls_home_tabbar".yp_localizedString;
    homeRouter.type = YPPageRouterTypeTable;
//    homeRouter.useInsetGrouped = YES;
    return homeRouter;
}

- (NSArray <YPPageRouterModule *>*)getRoutersByModel:(YPPageRouter *)model {
    NSArray *dataList = @[];
    if ([model.title isEqualToString:@"ls_home_tabbar".yp_localizedString]) {
        dataList = [YPPageRouterModule HomeRouters];
    } else if ([model.title isEqualToString:@"ls_ui_component".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters];
    } else if ([model.title isEqualToString:@"ls_apple_internal_purchase".yp_localizedString]) {
        dataList = [YPPageRouterModule AppleInternalPurchase];
    } else if ([model.title isEqualToString:@"丰富多彩的 cell（UITableView）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_TableCells];
    } else if ([model.title isEqualToString:@"多样的选择框（UIPickerView）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_PickerView];
    } else if ([model.title isEqualToString:@"导航栏控制（UINavigationBar）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_NavigationBar];
    } else if ([model.title isEqualToString:@"普通提示框（YPAlertView）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_YPAlertView];
    } else if ([model.title isEqualToString:@"普通加载框（YPLoadingView）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_YPLoadingView];
    } else if ([model.title isEqualToString:@"ls_idea_box".yp_localizedString]) {
        dataList = [YPPageRouterModule IdeaRouters];
    } else if ([model.title isEqualToString:@"全栈日记".yp_localizedString]) {
        dataList = [YPPageRouterModule FullStackRouters];
    } else if ([model.title isEqualToString:@"ls_app_icon_build".yp_localizedString]) {
        dataList = [YPPageRouterModule IdeaRouters_IconBuild];
    } else if ([model.title isEqualToString:@"自定义弹框（YPPopupController）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_YPPopupController];
    } else if ([model.title isEqualToString:@"制作 App 图标".yp_localizedString]) {
        dataList = [YPPageRouterModule IdeaRouters_IconBuild_Setup];
    } else if ([model.title isEqualToString:@"轮播图（YPSwiperView）".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_YPSwiperView];
    } else if ([model.title isEqualToString:@"摄像机".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_MultifunctionalCamera];
    } else if ([model.title isEqualToString:@"系统字体".yp_localizedString]) {
        dataList = [YPPageRouterModule ComponentRouters_SystemFonts];
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    } else if ([model.title isEqualToString:@"".yp_localizedString]) {
        
    }
    return [dataList copy];
}

@end
