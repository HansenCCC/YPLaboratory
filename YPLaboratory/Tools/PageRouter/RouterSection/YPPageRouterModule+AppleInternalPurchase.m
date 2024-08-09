//
//  YPPageRouterModule+AppleInternalPurchase.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import "YPPageRouterModule+AppleInternalPurchase.h"

@implementation YPPageRouterModule (AppleInternalPurchase)

// 苹果内购相关
+ (NSArray *)AppleInternalPurchase {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝一口冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.content = @"1 CNY";
        element.extend = @"1_goods";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝 1 杯冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.extend = @"6_goods";
        element.content = @"6 CNY";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝 2 杯冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.extend = @"12_goods";
        element.content = @"12 CNY";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝 3 杯冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.extend = @"18_goods";
        element.content = @"18 CNY";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝 4.16 杯冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.extend = @"25_goods";
        element.content = @"25 CNY";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"请我喝 16.5 杯冰可乐".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.extend = @"99_goods";
        element.content = @"99 CNY";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"免费的支持".yp_localizedString;
        element.type = YPPageRouterTypeAppComment;
        element.content = @"🫶";
        [dataList addObject:element];
    }
    
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    section.headerTitle = @"如果你觉得对你有帮助，你想...".yp_localizedString;
    return @[section];
}

@end
