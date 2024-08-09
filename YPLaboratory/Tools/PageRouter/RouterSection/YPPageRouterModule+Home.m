//
//  YPPageRouterModule+Home.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/3.
//

#import "YPPageRouterModule+Home.h"

@implementation YPPageRouterModule (Home)

+ (NSArray *)HomeRouters {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_idea_box".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_ui_component".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"常见架构模式".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"常见算法".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_apple_internal_purchase".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        element.useInsetGrouped = YES;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_network".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_database".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"调试日志".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"代码生成工具".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList addObject:element];
    }
    
    YPPageRouterModule *section1 = [[YPPageRouterModule alloc] initWithRouters:dataList];
    NSMutableArray *dataList2 = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_check_update".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList2 addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"ls_about_us".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList2 addObject:element];
    }
    YPPageRouterModule *section2 = [[YPPageRouterModule alloc] initWithRouters:dataList2];
    
    NSMutableArray *dataList3 = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"全栈日记".yp_localizedString;
        element.type = YPPageRouterTypeTable;
        [dataList3 addObject:element];
    }
    YPPageRouterModule *section3 = [[YPPageRouterModule alloc] initWithRouters:dataList3];
    
    return @[section1, section3, section2];
}

@end
