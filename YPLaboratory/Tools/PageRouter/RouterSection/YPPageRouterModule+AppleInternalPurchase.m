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
        element.title = @"免费的支持".yp_localizedString;
        element.type = YPPageRouterTypeAppComment;
        element.content = @"感谢评论";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"拉起一元内购支付".yp_localizedString;
        element.type = YPPageRouterTypeAppInternalPurchase;
        element.content = @"1 CNY";
        element.extend = @"yp_pay_100";
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
